<div class="content-wrapper">
  <div class="row mb-2">
	<div class="col-sm-6 d-none d-md-block" style="margin: 10px;">
		<h1 class="m-0 text-dark">{{ lang.done['inform'] }}</h1>
	</div>
  </div>
	<ol class="breadcrumb-header">
		<li class="breadcrumb-item"><a href="admin.php"><i class="fa fa-home"></i> {{ lang.done['home'] }}</a></li>
		<li class="breadcrumb-item active" aria-current="page"><i class="fa fa-info-circle" aria-hidden="true"></i> {{ lang.done['info'] }}</li>
		<li class="breadcrumb-elements">
			<a href="#" class="dropdown-toggle legitRipple" data-toggle="dropdown"><i class="fa fa-cog" aria-hidden="true"></i> {{ lang.done['setting'] }}</a>
			<ul class="dropdown-menu dropdown-menu-right">
				<li><a class="dropdown-item" href="?mod=statistics"><i class="fa fa-bar-chart"></i>{{ lang.done['statistics'] }}</a></li>
				<li class="divider"></li>
				<li><a class="dropdown-item" href="?mod=configuration"><i class="fa fa-cogs"></i>{{ lang.done['configuration'] }}</a></li>
			</ul>
		</li>
	</ol>
</div>

<div class="content">

<div class="alert alert-info alert-styled-left alert-arrow-left alert-component message_box" style="padding:0px">
  <h4>{{ lang.done['done'] }}</h4>
  <div class="panel-body">
		<table width="100%">
		    <tbody><tr>
		        <td height="80" class="text-center">{{ lang.done['commited'] }}<br><br><a href="{{ php_self }}?mod=news&action=add" class="btn btn-light">{{ lang.done['adds'] }}</a>  <a href="{{ php_self }}?mod=news&action=edit&id={{id}}" class="btn btn-light">{{ lang.done['edits'] }}</a>  <a href="{{ link }}" target="_blank" class="btn btn-light">{{ lang.done['view'] }}</a></td>
		    </tr>
		</tbody></table>
	</div>
	
</div>
</div>