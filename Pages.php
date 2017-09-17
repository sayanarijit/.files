$this->load->library('session');

$scriptpath = "/path/script.py";
$secret = "acbcd";

if (!isset($param1)||(empty($param1)))
{
  $titles = [];
  $qtitles = $this->db->distinct()->select("title")->get("dashboard_activity_monitor")->result_array();
  foreach ($qtitles as $value) {
    $titles[] = $value["title"];
  }

  # Enter Admin page
  if (isset($_POST)&&(!empty($_POST))){
    # Admin login
    if(isset($_POST["login"])){
      if(md5($_POST["username"].$_POST["password"]."$3cr31") == $secret){
        $_SESSION["username"] = "admin";
        $_SESSION["roles"][] = "activity-admin";
      }
    }
    # Start new activity
    if(isset($_POST["startnew"])){
      $activity_title = str_replace(" -", "-", preg_replace("/[^A-Za-z0-9 -]/"," ",$_POST["title"]));
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

      header("Location: ".base_url()."activity-monitor/".rawurlencode($_POST["title"]));
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
    // Flashcheck action
    if (isset($_POST["flashcheck"])&&(!empty($_POST["flashcheck"]))){
      $cmd = $scriptpath." -title ".$data["activity_title"]." -hosts ".$_POST["flashcheck"];
      // echo $cmd; die();
      shell_exec($cmd);
    }
    // Start shutdown activity action
    if (isset($_POST["startshutdown"])){
      $this->db->update("dashboard_activity_monitor",
                        array("step"=>"shutdown", "banner"=> null,
                        "ssh_status"=> null, "ignored"=>0),
                        array("title"=>$data["activity_title"]));
      $cmd = "sudo screen -d -m ".$scriptpath." -title ".$data["activity_title"];
      // echo $cmd; die();
      shell_exec($cmd);
    }
    // Start power-on activity action
    if (isset($_POST["startpoweron"])){
      $this->db->update("dashboard_activity_monitor",
                        array("step"=>"poweron", "banner"=> null,
                              "ssh_status"=>null, "ignored"=>0),
                        array("title"=>$data["activity_title"]));
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
      $this->db->update("dashboard_activity_monitor",
                        array("step"=>"precheck",
                              "ignored"=>0,
                              "banner"=>null,
                              "precheck"=>null,
                              "postcheck"=>null,
                              "ping_status"=>null,
                              "ssh_status"=>null,
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

  $data["hosts"] = array(); $data["ping_status "]= array(); $data["ssh_status"]= array();
  $data["precheck"] = array(); $data["postcheck"] = array(); $data["validated"] = array();
  $data["ignored"] = array(); $data["overall_status"] = array(); $data["os"] = array();
  $data["up"] = array(); $data["down"] = array(); $data["accessible"] = array(); $data["issue"] = array();
  $data["unix"] = array(); $data["windows"] = array(); $data["others"] = array(); $data["considered"] = array();
  $data["inaccessible"] = array(); $data["os_types"] = array(); $data["step"] = $data["report"][0]["step"];
  $data["banner"] = $data["report"][0]["banner"];

  foreach ($report as $r) {
    if ($r["ignored"]) {
      $data["ignored"][] = $r["hostname"];
      $data["consolidated"][$r["os"]][] = $r["hostname"];
      continue;
    }

    $data["hosts"][] = $r["hostname"];
    $data["os"][$r["hostname"]] = $r["os"];
    $data["ping_status"][$r["hostname"]] = $r["ping_status"];
    $data["ssh_status"][$r["hostname"]] = $r["ssh_status"];
    $data["precheck"][$r["hostname"]] = $r["precheck"];
    $data["postcheck"][$r["hostname"]] = $r["postcheck"];
    $data["overall_status"][$r["hostname"]] = $r["overall_status"];

    if($r["overall_status"] == 1){
      $data["validated"][] = $r["hostname"];
    }else{
      $data["issue"][] = $r["hostname"];
    }

    foreach ($r as $key => $value) {
      if(in_array($value, array("up","down","accessible","inaccessible","unix","windows","others"))){
        $data[$value][] = $r["hostname"];
        $data["consolidated"][$value][] = $r["hostname"];
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
