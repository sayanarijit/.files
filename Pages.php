<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Pages extends CI_Controller {

  function __construct()
  {
		// constructor
    parent::__construct();
  }

	public function view_page( $page = "home",$param1 = null,$param2 = null )
	{
		// Function to load a page

    $data['title'] = $page;

    $this->load->view('pages/header',$data);
    $this->load->view('pages/navbar',$data);
    $this->load->view('pages/scripts');

    if ($page == "home")
    {
      echo "yo";
    }
    else if($page == "activity-monitor")
    {
      $this->load->library('session');

      $scriptpath = "sudo /home/sayan/practice/validate.py";
      $secret = "abcd";

      if (!isset($param1)||(empty($param1)))
      {
        $titles = [];
        $qtitles = $this->db->distinct()->select("title")->get("dashboard_activity_monitor")->result_array();
        foreach ($qtitles as $value) {
          $titles[] = $value["title"];
        }

        # Enter Admin page
        if (isset($_POST)&&(!empty($_POST))){
          # Admin login action
          if(isset($_POST["login"])){
            if(md5($_POST["username"].$_POST["password"]."$3cr31") == $secret){
              $_SESSION["username"] = $_POST["username"];
              $_SESSION["roles"][] = "activity-admin";
            }
          }
          # Validate if admin
          if(!isset($_SESSION)||(!isset($_SESSION["roles"]))||(!in_array("activity-admin", $_SESSION["roles"]))){
            show_404();
          }
          # Start new activity action
          if(isset($_POST["startnew"])){
            $activity_title = str_replace(" -", "- ", preg_replace("/[^A-Za-z0-9-]/"," ",$_POST["title"]));
            if(in_array($activity_title, array_merge($titles, array(null,"","admin","login")))){
              show_error("Invalid title: ".$activity_title);
            }
            $hosts = array();
            foreach (array("unix","windows","others") as $os_type) {
              foreach (explode("\n", str_replace(" ","", $_POST[$os_type])) as $host){
                $host = strtolower(preg_replace("/[^A-Za-z0-9.-]/","", $host));
                if(empty($host)||(in_array($host, $hosts))) {continue;}
                $hosts[] = $host;
                $this->db->insert("dashboard_activity_monitor",
                                  array("os"=>$os_type,"hostname"=>$host,
                                        "title"=>$activity_title));
              }
            }
            if(count($hosts) == 0) {show_error("No hostname mentioned");}

            $cmd = "sudo screen -d -m ".$scriptpath." -title ".$activity_title;
            // echo $cmd; die();
            shell_exec($cmd);

            header("Location: ".base_url()."activity-monitor/".rawurlencode($activity_title));
            die();
          }
        }
        if(isset($_SESSION)&&(isset($_SESSION["roles"]))&&(in_array("activity-admin", $_SESSION["roles"]))){
          $this->load->view("pages/activity-monitor/admin.php");
        }else{
          $this->load->view("pages/activity-monitor/login");
        }

      }else{
        # Enter dashboard
        $data["activity_title"] = rawurldecode($param1);

        if (isset($_POST)&&(!empty($_POST))){
          # Validate if admin
          if(!isset($_SESSION)||(!isset($_SESSION["roles"]))||(!in_array("activity-admin", $_SESSION["roles"]))){
            show_404();
          }
          // Ignore action
          if (isset($_POST["ignore"])&&(!empty($_POST["ignore"]))){
            $this->db->update("dashboard_activity_monitor",
                              array("ignored"=>1),
                              array("title"=> $data["activity_title"],
                                    "hostname"=> $_POST["ignore"]));
          }
          // Add in scan action
          if (isset($_POST["addinscan"])&&(!empty($_POST["addinscan"]))){
            $this->db->update("dashboard_activity_monitor",
                              array("ignored"=>0),
                              array("title"=> $data["activity_title"],
                                    "hostname"=> $_POST["addinscan"]));
          }
          // Flashcheck action
          if (isset($_POST["flashcheck"])&&(!empty($_POST["flashcheck"]))){
            if((count(explode(" ",$_POST["flashcheck"])) > 0)
                ||(!in_array(explode(" ",$_POST["flashcheck"])[0],$hosts))
                ||(count(explode(";",$_POST["flashcheck"])) > 0)){
              show_404();
            }
            $cmd = $scriptpath." -title ".$data["activity_title"]." -hosts ".$_POST["flashcheck"];
            // echo $cmd; die();
            shell_exec($cmd);
          }
          // Start shutdown activity action
          if (isset($_POST["startshutdown"])){
            $this->db->update("dashboard_activity_monitor",
                              array("step"=>"shutdown", "banner"=>null,
                              "ping_status"=>null,"ssh_status"=>null,
                              "validation"=>null, "overall_status"=>0),
                              array("title"=>$data["activity_title"]));
            $this->db->update("dashboard_activity_monitor",
                              array("ignored"=>0),
                              array("title"=>$data["activity_title"],
                                    "ping_precheck"=>"up"));
            $cmd = "sudo screen -d -m ".$scriptpath." -title ".$data["activity_title"];
            // echo $cmd; die();
            shell_exec($cmd);
          }
          // Start power-on activity action
          if (isset($_POST["startpoweron"])){
            $this->db->update("dashboard_activity_monitor",
                              array("step"=>"poweron", "banner"=>null,
                                    "ping_status"=>null,"ssh_status"=>null,
                                    "validation"=>null, "overall_status"=>0),
                              array("title"=>$data["activity_title"]));
            $this->db->update("dashboard_activity_monitor",
                              array("ignored"=>0),
                              array("title"=>$data["activity_title"],
                                    "ping_precheck"=>"up"));
            $cmd = "sudo screen -d -m ".$scriptpath." -title ".$data["activity_title"]." --postcheck";
            // echo $cmd; die();
            shell_exec($cmd);
          }
          // Cancel action
          if (isset($_POST["cancel"])){
            $this->db->update("dashboard_activity_monitor",
                              array("step"=>"cancelled",
                                    "ignored"=>1,
                                    "banner"=>ucfirst($data["activity_title"])." has been cancelled"),
                              array("title"=>$data["activity_title"]));
          }
          // Postpone action
          if (isset($_POST["postpone"])){
            $this->db->update("dashboard_activity_monitor",
                              array("step"=>"postponed",
                                    "ignored"=>1,
                                    "banner"=>ucfirst($data["activity_title"])." has been posponed"),
                              array("title"=>$data["activity_title"]));
          }
          // Restart action
          if (isset($_POST["restart"])){
            $this->db->delete("dashboard_activity_monitor",
                              array("step"=>"precheck",
                                    "banner"=>null,
                                    "ping_precheck"=>null,
                                    "ssh_precheck"=>null,
                                    "ping_status"=>null,
                                    "ssh_status"=>null,
                                    "validation_precheck"=>null,
                                    "validation"=>null,
                                    "ignored"=>0,
                                    "overall_status"=>0),
                              array("title"=>$data["activity_title"]));
            $cmd = "sudo screen -d -m ".$scriptpath." -title ".$data["activity_title"];
            // echo $cmd; die();
            shell_exec($cmd);
          }
          // Delete action
          if (isset($_POST["delete"])){
            $this->db->delete("dashboard_activity_monitor",
                              array("title"=>$data["activity_title"]));
            header("Location: ".base_url()."activity-monitor");
            die();
          }
          // Update banner action
          if (isset($_POST["updatebanner"])){
            $this->db->update("dashboard_activity_monitor",
                              array("banner"=>$_POST["banner"]),
                              array("title"=>$data["activity_title"]));
            header("Location: ".base_url()."activity-monitor/".rawurlencode($data["activity_title"]));
            die();
          }
        }

        $report = $data["report"] = $this->db->get_where("dashboard_activity_monitor",
                                                        array("title"=>$data["activity_title"])
                                                        )->result_array();

        if(count($report) == 0){
          show_404();
        }

        foreach (array("up","down","accessible","inaccessible","unix", "ignored",
                        "windows","others","os_types", "validated") as $value) {
          $data[$value] = array();
          $data["consolidated"][$value] = array();
        }

        $data["step"] = $data["report"][0]["step"];
        $data["banner"] = $data["report"][0]["banner"];

        foreach ($report as $r) {

          $data["ping_status"][$r["hostname"]] = $r["ping_status"];
          $data["ssh_status"][$r["hostname"]] = $r["ssh_status"];
          $data["ping_status"][$r["hostname"]] = $r["ping_status"];
          $data["validation_precheck"][$r["hostname"]] = $r["validation_precheck"];
          $data["validation"][$r["hostname"]] = $r["validation"];
          $data["overall_status"][$r["hostname"]] = $r["overall_status"];
          $data["os"][$r["hostname"]] = $r["os"];
          $data["ping_precheck"][$r["hostname"]] = $r["ping_precheck"];
          $data["ssh_precheck"][$r["hostname"]] = $r["ssh_precheck"];
          $data["consolidated"][$r["os"]][] = $r["hostname"];

          if ($r["ignored"]) {
            $data["ignored"][] = $r["hostname"];
            continue;
          }

          $data["hosts"][] = $r["hostname"];

          if($r["overall_status"] == 1){
            $data["validated"][] = $r["hostname"];
          }else{
            $data["issue"][] = $r["hostname"];
          }

          foreach ($r as $key => $value) {
            if(in_array($value, array("up","down","accessible","inaccessible","unix","windows","others"))){
              if(!in_array($r["hostname"], $data[$value])){
                $data[$value][] = $r["hostname"];
              }
              if(!in_array($r["hostname"], $data["consolidated"][$value])){
                $data["consolidated"][$value][] = $r["hostname"];
              }
            }
          }
          if(!in_array($r["os"], $data["os_types"])){
            $data["os_types"][] = $r["os"];
          }
        }

        // If all hosts are ignored
        if((count($data["hosts"]) == 0)&&(!in_array($data["step"], array("postponed", "cancelled")))){
          $this->db->delete("dashboard_activity_monitor",
                            array("title"=>$data["activity_title"]));
          show_error("All hosts are ignored");
        }

        // Load view
        if(isset($_SESSION)&&(isset($_SESSION["roles"]))&&(in_array("activity-admin", $_SESSION["roles"]))){
          $this->load->view('pages/activity-monitor/dashboard-admin', $data);
        }else{
          $this->load->view('pages/activity-monitor/dashboard', $data);
        }
      }
    }else{
      show_404();
    }
    $this->load->view('pages/footer');
	}
}
