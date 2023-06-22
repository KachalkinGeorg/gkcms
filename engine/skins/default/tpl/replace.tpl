<div class="alert alert-info">
{{ lang['info'] }}<br><br>
</div>

<div class="panel panel-default">
	<div class="panel-heading">
     {{ lang['replace'] }}
	</div>
	<div class="panel-body">

	<form action="{{ php_self }}" method="get">
	<table class="table table-striped">
      <tr>
        <td class="col-xs-6 col-sm-6 col-md-7">
		  <h6 class="media-heading text-semibold">{{ lang['area'] }}</h6>
		  <span class="text-muted text-size-small hidden-xs">{{ lang['area.descr'] }}</span>
		</td>
        <td class="col-xs-6 col-sm-6 col-md-5">
			<select name="area" style="width: 42%;">{{ area }}</select>
        </td>
      </tr>

      <tr>
        <td class="col-xs-6 col-sm-6 col-md-7">
		  <h6 class="media-heading text-semibold">{{ lang['source'] }}</h6>
		</td>
        <td class="col-xs-6 col-sm-6 col-md-5">
			<input name="source" type="text" placeholder="{{ lang['plac_text'] }}" value="{{ source }}" class="form-control" />
        </td>
      </tr>

      <tr>
        <td class="col-xs-6 col-sm-6 col-md-7">
		  <h6 class="media-heading text-semibold">{{ lang['destination'] }}</h6>
		</td>
        <td class="col-xs-6 col-sm-6 col-md-5">
			<input name="dest" type="text" placeholder="{{ lang['plac_text'] }}" value="{{ dest }}" class="form-control" />
        </td>
      </tr>
	  
	</table>
	

	<div class="panel-footer" align="center" style="margin-left: -20px;margin-right: -20px;margin-bottom: -20px;">
		<input type="hidden" name="mod" value="replace" />
		<input type="hidden" name="action" value="commit">
		<button type="submit" class="btn btn-outline-success">{{ lang['send'] }}</button>
	</div>

	</form>

	</div>
</div>

<div class="stickers stickers-warning stickers-styled-left">
{{ lang['danger'] }}<br><br>
</div>