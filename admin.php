<div class="right_col" role="main">
  <div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
      <div class="x_panel">
        <div class="x_title">
          <h2>Start an activity </h2>
          <div class="clearfix"></div>
        </div>
        <div class="x_content">
          <br>
          <form method="post" data-parsley-validate="" class="form-horizontal form-label-left" novalidate="">

            <div class="form-group">
              <label class="control-label col-md-3 col-sm-3 col-xs-12">Title <span class="required">*</span>
              </label>
              <div class="col-md-6 col-sm-6 col-xs-12">
                <input name="title" maxlength="80" type="text" required class="form-control col-md-7 col-xs-12">
              </div>
            </div>

            <div class="form-group">
              <label class="control-label col-md-3 col-sm-3 col-xs-12">Hosts <span class="required">*</span>
              </label>
              <div class="col-md-2 col-sm-2 col-xs-12">
                <textarea name="unix" rows=5 type="text" placeholder="UNIX hosts (ping + ssh)" class="form-control col-md-7 col-xs-12"></textarea>
              </div>
              <div class="col-md-2 col-sm-2 col-xs-12">
                <textarea name="windows" rows=5 type="text" placeholder="Windows hosts (only ping)" class="form-control col-md-7 col-xs-12"></textarea>
              </div>
              <div class="col-md-2 col-sm-2 col-xs-12">
                <textarea name="others" rows=5 type="text" placeholder="Other hosts (only ping)" class="form-control col-md-7 col-xs-12"></textarea>
              </div>
            </div>

            <div class="form-group">
              <label class="control-label col-md-3 col-sm-3 col-xs-12"></span>&nbsp;</label>
              <div class="col-md-6 col-sm-6 col-xs-12">
                <button name="startnew" type="submit" class="btn btn-block btn-primary">
                  <i class="fa fa-play"></i> Start monitoring</button>
              </div>
            </div>

          </form>
          <div class="clearfix"></div>
          <p>&nbsp;</p>
        </div>
      </div>
      <p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
      <p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
      <p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
    </div>
  </div>
</div>
