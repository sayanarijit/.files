<?php
$osicon = array("unix"=>"<i class='fa fa-terminal'></i> UNIX",
                "windows"=>"<i class='fa fa-windows'></i> Windows",
                "others"=>"<i class='fa fa-cube'></i> Others")
?>

<!-- Auto refresh -->
<?php if(in_array($step, array("precheck", "shutdown", "poweron")))  { ?>
  <meta http-equiv="refresh" content="30; URL=<?php echo base_url().'activity-monitor/'.$activity_title; ?>">
<?php ;}; ?>

<div class="right_col" role="main">
  <!-- Admin controls -->
  <div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
      <div class="x_panel">
        <div class="x_title">
          <h2>Admin controls </h2>
          <ul class="nav navbar-left panel_toolbox">
            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
          </ul>
          <div class="clearfix"></div>
        </div>
        <div class="x_content">
          <form method="post">
            <?php if(in_array($step,array("cancelled","postponed"))){ ?>
              <textarea required class="form-control" name="banner" placeholder="Update banner"><?php echo $banner; ?></textarea>
              <p>&nbsp</p>
              <button name="updatebanner" class="btn btn-block btn-dark" type="submit">
                <i class="fa fa-pencil-square-o"></i> Update banner
              </button>
              <p>&nbsp</p>
            <?php ;}; ?>
            <?php if(($step == "shutdown")&&(count($down) == count($hosts))){ ?>
              <button name="startpoweron" class="btn btn-primary" type="submit">
                <i class="fa fa-play"></i> Start power-on activity
              </button>
            <?php ;}; ?>
            <?php if($step != "postponed"){ ?>
              <button name="postpone" class="btn btn-default" type="submit">
                <i class="fa fa-pause"></i> Postpone
              </button>
            <?php ;}; ?>
            <?php if($step == "postponed"){ ?>
              <button name="startshutdown" class="btn btn-default" type="submit">
                <i class="fa fa-play"></i> Resume from shutdown
              </button>
              <button name="startpoweron" class="btn btn-default" type="submit">
                <i class="fa fa-play"></i> Resume from power-on
              </button>
            <?php ;}; ?>
            <button name="restart" class="btn btn-default" type="submit">
              <i class="fa fa-repeat"></i> Restart
            </button>
            <?php if($step != "cancelled"){ ?>
              <button name="cancel" class="btn btn-warning" type="submit">
                <i class="fa fa-ban"></i> Cancel
              </button>
            <?php ;}; ?>
            <button name="delete" class="btn btn-danger" type="submit">
              <i class="fa fa-trash"></i> Delete
            </button>
          </form>
        </div>
      </div>
    </div>
  </div>
  <!-- /Admin controls -->

  <?php if(in_array($step, array("postponed", "cancelled"))){ ?>
    <div class="row">
      <p>&nbsp;</p>
      <div class="jumbotron text-center">
        <p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
        <h1><i class="fa fa-exclamation-triangle red"></i> Activity <?php echo $step; ?></h1>
        <p><?php echo htmlspecialchars($banner); ?></p>
        <p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
      </div>
      <p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
    </div>
  <?php ;}else { ?>
    <!-- top tiles -->
    <div class="row tile_count">
      <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
        <span class="count_top"><i class="fa fa-desktop"></i> Total Hosts</span>
        <div class="count"><?php echo count($hosts); ?></div>
        <span class="count_bottom"><?php echo (count($ignored) > 0) ? count($ignored)." ignored" : "&nbsp;"; ?></span>
      </div>
      <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
        <span class="count_top"><i class="fa fa-thumbs-o-up"></i> Hosts up</span>
        <div class="count"><?php echo ($step == "precheck") ? "<i class='fa fa-spinner fa-spin'></i>" : count($up); ?></div>
        <span class="count_bottom">
          <?php echo ($step == "precheck") ? "..." : intval((count($up)*100)/count($hosts))."% of total hosts"; ?>
        </span>
      </div>
      <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
        <span class="count_top"><i class="fa fa-thumbs-o-down"></i> Hosts down</span>
        <div class="count"><?php echo ($step == "precheck") ? "<i class='fa fa-spinner fa-spin'></i>" : count($down); ?></div>
        <span class="count_bottom">
          <?php echo ($step == "precheck") ? "..." : intval((count($down)*100)/count($hosts))."% of total hosts"; ?>
        </span>
      </div>
      <?php foreach ($osicon as $os_type=>$icon) { if (!in_array($os_type, $os_types)) {continue;} ?>
        <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
          <span class="count_top"><?php echo $icon; ?> hosts</span>
          <div class="count"><?php echo count($consolidated[$os_type]); ?></div>
          <span class="count_bottom">
            <?php echo intval((count($consolidated[$os_type])*100)/count($hosts)); ?>% of total hosts
          </span>
        </div>
      <?php ;}; ?>
    </div>
    <!-- /top tiles -->

    <!-- overall_status -->
    <div class="row">
      <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="dashboard_graph">

          <div class="x_title">
            <h2><?php echo strtoupper(htmlspecialchars($activity_title)); ?></h2>
            <div class="clearfix"></div>
          </div>

          <div class="x_content">
            <div class="widget_summary">
              <div class="w_left w_25">
                <span>Step 1: Pre-activity scan</span>
              </div>
              <div class="w_center w_55">
                <div class="progress">
                  <?php $c = intval(((count($up)+count($down))*100)/count($hosts));?>
                  <div class="progress-bar bg-green" role="progressbar" style="width: <?php echo $c; ?>%;">
                    <span class="sr-only"><?php echo $c; ?>% complete</span>
                  </div>
                </div>
              </div>
              <div class="w_right w_20">
                <span><?php echo ($c == 100) ? '<i class="fa fa-check green"></i>' : $c."%" ; ?></span>
              </div>
              <div class="clearfix"></div>
            </div>

            <div class="widget_summary">
              <div class="w_left w_25">
                <span>Step 2: Shutdown hosts</span>
              </div>

              <?php if($step == "precheck") { ?>
                <div class="w_center w_55">
                  <div class="progress">
                    <div class="progress-bar bg-green" role="progressbar" style="width: 0%;">
                      <span class="sr-only">0% complete</span>
                    </div>
                  </div>
                </div>
                <div class="w_right w_20">
                  <span><i class="fa fa-pause"></i></span>
                </div>
              <?php }else if($step == "shutdown") { ?>
                <div class="w_center w_55">
                  <div class="progress">
                    <?php $c = intval((count($down)*100)/count($hosts)); ?>
                    <div class="progress-bar bg-green" role="progressbar" style="width: <?php echo $c; ?>%;">
                      <span class="sr-only"><?php echo $c; ?>% complete</span>
                    </div>
                  </div>
                </div>
                <div class="w_right w_20">
                  <span><?php echo ($c == 100) ? '<i class="fa fa-check green"></i>' : $c."%" ; ?></span>
                </div>
              <?php }else{ ?>
                <div class="w_center w_55">
                  <div class="progress">
                    <div class="progress-bar bg-green" role="progressbar" style="width: 100%;">
                      <span class="sr-only">100% complete</span>
                    </div>
                  </div>
                </div>
                <div class="w_right w_20">
                  <span class="green"><i class="fa fa-check green"></i></span>
                </div>
              <?php ;}; ?>
              <div class="clearfix"></div>
            </div>

            <div class="widget_summary">
              <div class="w_left w_25">
                <span>Step 3: Power-on hosts</span>
              </div>
              <?php if($step == "precheck") { ?>
                <div class="w_center w_55">
                  <div class="progress">
                    <div class="progress-bar bg-green" role="progressbar" style="width: 0%;">
                      <span class="sr-only">0% complete</span>
                    </div>
                  </div>
                </div>
                <div class="w_right w_20">
                  <span><i class="fa fa-pause"></i></span>
                </div>
              <?php }else if($step == "shutdown") { ?>
                <div class="w_center w_55">
                  <div class="progress">
                    <div class="progress-bar bg-green" role="progressbar" style="width: 0%;">
                      <span class="sr-only">0% complete</span>
                    </div>
                  </div>
                </div>
                <div class="w_right w_20">
                  <span><i class="fa fa-pause"></i></span>
                </div>
              <?php }else{ ?>
                <div class="w_center w_55">
                  <div class="progress">
                    <?php $c = intval((count($up)*100)/count($hosts)); ?>
                    <div class="progress-bar bg-green" role="progressbar" style="width: <?php echo $c; ?>%;">
                      <span class="sr-only"><?php echo $c; ?>% complete</span>
                    </div>
                  </div>
                </div>
                <div class="w_right w_20">
                  <span><?php echo ($c == 100) ? '<i class="fa fa-check green"></i>' : $c."%" ; ?></span>
                </div>
              <?php ;}; ?>
              <div class="clearfix"></div>
            </div>

            <div class="widget_summary">
              <div class="w_left w_25">
                <span>Step 4: Post validation</span>
              </div>
              <?php if($step == "precheck") { ?>
                <div class="w_center w_55">
                  <div class="progress">
                    <div class="progress-bar bg-green" role="progressbar" style="width: 0%;">
                      <span class="sr-only">0% complete</span>
                    </div>
                  </div>
                </div>
                <div class="w_right w_20">
                  <span><i class="fa fa-pause"></i></span>
                </div>
              <?php }else if($step == "shutdown") { ?>
                <div class="w_center w_55">
                  <div class="progress">
                    <div class="progress-bar bg-green" role="progressbar" style="width: 0%;">
                      <span class="sr-only">0% complete</span>
                    </div>
                  </div>
                </div>
                <div class="w_right w_20">
                  <span><i class="fa fa-pause"></i></span>
                </div>
              <?php }else{ ?>
                <div class="w_center w_55">
                  <div class="progress">
                    <?php $c = intval((count($validated)*100)/count($hosts)); ?>
                    <div class="progress-bar bg-green" role="progressbar" style="width: <?php echo $c; ?>%;">
                      <span class="sr-only"><?php echo $c; ?>% complete</span>
                    </div>
                  </div>
                </div>
                <div class="w_right w_20">
                  <span><?php echo ($c == 100) ? '<i class="fa fa-check green"></i>' : $c."%" ; ?></span>
                </div>
              <?php ;}; ?>

              <div class="clearfix"></div>
            </div>
          </div>
          <div class="clearfix"></div>
        </div>
      </div>

    </div>
    <!-- /overall_status -->
    <br />

    <!-- current step progress -->
    <?php if ($step == "precheck") { ?>
      <div class="row">
        <div class="jumbotron text-center">
          <h1><i class="fa fa-spinner fa-spin"></i></h1>
        </div>
      </div>
    <?php } elseif ($step == "complete") { ?>
      <div class="row">
        <div class="jumbotron text-center">
          <h1><i class="fa fa-check green"></i> Activity complete</h1>
          <p>Activity has been successfully completed</p>
        </div>
      </div>
    <?php } elseif ($step == "shutdown") { ?>
      <!-- Shutdown activity -->
      <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
          <div class="x_panel">
            <div class="x_title">
              <h2>Shutdown progress</a></h2>
              <div class="clearfix"></div>
            </div>
            <div class="x_content">

              <div class="col-xs-3">
                  <ul class="nav nav-tabs tabs-left">
                    <li class="active"><a href="#stats" data-toggle="tab" aria-expanded="true"><i class="fa fa-pie-chart"></i> Stats</a>
                    </li>
                    <?php foreach ($osicon as $os_type=>$icon) {
                      if (!in_array($os_type, $os_types)) {continue;}
                      echo '<li class=""><a href="#stats_'.$os_type.'" data-toggle="tab" aria-expanded="false">'.$icon.'</a></li>';
                    }; ?>
                  </ul>
              </div>

              <div class="col-xs-9">
                <!-- Tab panes -->
                <div class="tab-content">
                  <div class="tab-pane active" id="stats">
                    <?php $data = json_encode(array(count($down), count($up), count($ignored))); ?>
                    <canvas id="stats_canvas"></canvas>
                    <script>
                      var ctx = document.getElementById('stats_canvas').getContext('2d');
                      var chart = new Chart(ctx, {
                          type: 'pie',
                          data: {
                              labels: ["Completed", "Remaining", "Ignored"],
                              datasets: [{
                                  data: <?php echo $data; ?>,
                                  backgroundColor: ['#1ABB9C','#f5f5f5','#73879C',]
                              }]
                          }
                      });
                    </script>
                  </div>
                  <?php foreach ($os_types as $os_type) { ?>
                    <div class="tab-pane" id="stats_<?php echo $os_type; ?>">
                        <canvas id="stats_canvas_<?php echo $os_type; ?>"></canvas>
                        <?php
                          $data = json_encode(array(
                            count(array_intersect($consolidated[$os_type], $down, $hosts)),
                            count(array_intersect($consolidated[$os_type], $up, $hosts)),
                            count(array_intersect($consolidated[$os_type], $ignored))
                          ));
                        ?>
                        <script>
                          var ctx = document.getElementById('stats_canvas_<?php echo $os_type; ?>').getContext('2d');
                          var chart = new Chart(ctx, {
                              type: 'pie',
                              data: {
                                  labels: ["Completed", "Remaining", "Ignored"],
                                  datasets: [{
                                      data: <?php echo $data; ?>,
                                      backgroundColor: ['#1ABB9C','#f5f5f5','#73879C',]
                                  }]
                              }
                          });
                        </script>
                    </div>
                  <?php ;}; ?>
                </div>
              </div>

              <div class="clearfix"></div>

            </div>
          </div>
        </div>
      </div>
      <!-- Current step progress -->

      <!-- Table -->

      <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
          <div class="x_panel">
            <div class="x_title">
              <h2>Remaining hosts</a></h2>
              <div class="clearfix"></div>
            </div>

            <div class="x_content">

              <!-- start accordion -->
              <div class="accordion" id="accordion" role="tablist" aria-multiselectable="true">
                <?php foreach ($osicon as $os_type=>$icon) {
                  if (!in_array($os_type, $os_types)) {continue;}
                  if (count(array_intersect($consolidated[$os_type], $up, $hosts)) == 0){continue;}
                ;?>
                  <div class="panel">
                    <a class="panel-heading" role="tab" id="heading_<?php echo $os_type; ?>" data-toggle="collapse" data-parent="#accordion" href="#collapse_<?php echo $os_type; ?>" aria-expanded="false" aria-controls="collapse_<?php echo $os_type; ?>">
                      <h4 class="panel-title text-center"><?php echo $icon; ?></h4>
                    </a>
                    <div id="collapse_<?php echo $os_type; ?>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading_<?php echo $os_type; ?>" aria-expanded="false">
                      <div class="panel-body" style="overflow: auto">
                        <?php
                          $data = array();
                          $data["tabledata"] = array(array("Action", "Hostname", "Ping status", ""));
                          foreach (array_intersect($consolidated[$os_type], $up, $hosts) as $host) {
                            $btn = '<form method="post"><div class="btn-group btn-group-xs">';
                            $btn .=   '<button name="flashcheck" class="btn btn-info btn-xs" type="submit" value="'.$host.'">Flash check</button>';
                            $btn .=   '<button name="ignore" class="btn btn-danger btn-xs" type="submit" value="'.$host.'">Ignore</button>';
                            $btn .= '</div></form>';
                            $data["tabledata"][] = array($btn, $host, "up");
                          }
                          $data["tableid"] = "table_".$os_type;
                          $this->load->view("pages/table",$data);
                        ?>
                      </div>
                    </div>
                  </div>
                  <p>&nbsp;</p>
                <?php ;}; ?>
              </div>
              <!-- end of accordion -->

            </div>
          </div>
        </div>
      </div>
    <!-- Table -->
      <?php ;}else{ ?>
        <!-- Power-on activity -->
        <div class="row">
          <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
              <div class="x_title">
                <h2>Power-on progress</a></h2>
                <div class="clearfix"></div>
              </div>
              <div class="x_content">
                <div class="col-xs-3">
                    <ul class="nav nav-tabs tabs-left">
                      <li class="active"><a href="#stats" data-toggle="tab" aria-expanded="true"><i class="fa fa-pie-chart"></i> Stats</a>
                      </li>
                      <?php foreach ($osicon as $os_type=>$icon) {
                        if (!in_array($os_type, $os_types)) {continue;}
                        echo '<li class=""><a href="#stats_'.$os_type.'" data-toggle="tab" aria-expanded="false">'.$icon.'</a></li>';
                      }; ?>
                    </ul>
                </div>

                <div class="col-xs-9">
                  <!-- Tab panes -->
                  <div class="tab-content">
                    <div class="tab-pane active" id="stats">
                      <?php $data = json_encode(array(count($validated), count($issue), count($ignored))); ?>
                      <canvas id="stats_canvas"></canvas>
                      <script>
                        var ctx = document.getElementById('stats_canvas').getContext('2d');
                        var chart = new Chart(ctx, {
                            type: 'pie',
                            data: {
                                labels: ["Completed", "Remaining", "Ignored"],
                                datasets: [{
                                    data: <?php echo $data; ?>,
                                    backgroundColor: ['#1ABB9C','#f5f5f5','#73879C',]
                                }]
                            }
                        });
                      </script>
                    </div>
                    <?php foreach ($os_types as $os_type) { ?>
                      <div class="tab-pane" id="stats_<?php echo $os_type; ?>">
                          <canvas id="stats_canvas_<?php echo $os_type; ?>"></canvas>
                          <?php
                            $data = json_encode(array(
                              count(array_intersect($consolidated[$os_type], $hosts, $validated)),
                              count(array_intersect($consolidated[$os_type], $hosts, $issue)),
                              count(array_intersect($consolidated[$os_type], $ignored))
                            ));
                          ?>
                          <script>
                            var ctx = document.getElementById('stats_canvas_<?php echo $os_type; ?>').getContext('2d');
                            var chart = new Chart(ctx, {
                                type: 'pie',
                                data: {
                                    labels: ["Completed", "Remaining", "Ignored"],
                                    datasets: [{
                                        data: <?php echo $data; ?>,
                                        backgroundColor: ['#1ABB9C','#f5f5f5','#73879C',]
                                    }]
                                }
                            });
                          </script>
                      </div>
                    <?php ;}; ?>
                  </div>
                </div>

                <div class="clearfix"></div>

              </div>
            </div>
          </div>
        </div>
        <!-- Current step progress -->

        <!-- Table -->

        <div class="row">
          <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
              <div class="x_title">
                <h2>Remaining hosts</a></h2>
                <div class="clearfix"></div>
              </div>

              <div class="x_content">

                <!-- start accordion -->
                <div class="accordion" id="accordion" role="tablist" aria-multiselectable="true">
                  <?php foreach ($osicon as $os_type=>$icon) {
                    if (!in_array($os_type, $os_types)) {continue;}
                    if (count(array_intersect($consolidated[$os_type], $issue, $hosts)) == 0){continue;}
                  ;?>
                    <div class="panel">
                      <a class="panel-heading" role="tab" id="heading_<?php echo $os_type; ?>" data-toggle="collapse" data-parent="#accordion" href="#collapse_<?php echo $os_type; ?>" aria-expanded="false" aria-controls="collapse_<?php echo $os_type; ?>">
                        <h4 class="panel-title text-center"><?php echo $icon; ?></h4>
                      </a>
                      <div id="collapse_<?php echo $os_type; ?>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading_<?php echo $os_type; ?>" aria-expanded="false">
                        <div class="panel-body" style="overflow: auto">
                          <?php
                            $data = array();
                            if($os_type == "unix"){
                              $data["tabledata"] = array(array("Action", "Hostname", "Ping status", "SSH status", "Validation"));
                            }else{
                              $data["tabledata"] = array(array("Action", "Hostname", "Ping status", ""));
                            }
                            foreach (array_intersect($consolidated[$os_type], $issue, $hosts) as $host) {
                              $btn = '<form method="post"><div class="btn-group btn-group-xs">';
                              $btn .=   '<button name="flashcheck" class="btn btn-info btn-xs" type="submit" value="'.$host.' --postcheck">Flash check</button>';
                              $btn .=   '<button name="ignore" class="btn btn-danger btn-xs" type="submit" value="'.$host.'">Ignore</button>';
                              $btn .= '</div></form>';
                              if($os_type == "unix"){
                                if(($overall_status[$host] == 0)&&($ssh_status[$host] == "accessible")){
                                  $validation = json_encode([($precheck[$host]) ? json_decode($precheck[$host],JSON_PRETTY_PRINT) : [],
                                                            ($postcheck[$host]) ? json_decode($postcheck[$host],JSON_PRETTY_PRINT) : []]);
                                }elseif($overall_status[$host] == 0){
                                  $validation = "failed";
                                }else{
                                  $validation = "success";
                                }
                                $data["tabledata"][] = array($btn, $host, $ping_status[$host], $ssh_status[$host],
                                                             ($overall_status[$host] == 1) ? "success" : $validation
                                                            );
                              }else{
                                $data["tabledata"][] = array($btn, $host, "down");
                              }
                            }
                            $data["tableid"] = "table_".$os_type;
                            $this->load->view("pages/table",$data);
                          ?>
                        </div>
                      </div>
                    </div>
                    <p>&nbsp;</p>
                  <?php ;}; ?>
                </div>
                <!-- end of accordion -->

              </div>
            </div>
          </div>
        </div>
        <!-- Table -->
      <?php  }; ?>
      <!-- /current step progress -->
    </div>
  <?php ;}; ?>
</div>
