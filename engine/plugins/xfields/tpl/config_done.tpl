<div class="content-wrapper">
  <div class="row mb-2">
	<div class="col-sm-6 d-none d-md-block" style="margin: 10px;">
		<h1 class="m-0 text-dark">Дополнительные поля</h1>
	</div>
  </div>
	<ol class="breadcrumb-header">
		<li class="breadcrumb-item"><a href="admin.php"><i class="fa fa-home"></i> {l_home}</a></li>
		<li class="breadcrumb-item"><a href="{php_self}?mod=extras">{{ lang['extras'] }}</a></li>
		<li class="breadcrumb-item active" aria-current="page"><i class="fa fa-list-alt" aria-hidden="true"></i> {{ lang.xfconfig['editfield'] }} (<a href="?mod=extra-config&plugin=xfields&action=edit&section={{ sectionID }}&field={{ id }}">{{ id }}</a>)</li>
		<li class="breadcrumb-elements">
			<a href="#" class="dropdown-toggle legitRipple" data-toggle="dropdown"><i class="fa fa-cog" aria-hidden="true"></i> {{ lang['setting'] }}</a>
			<ul class="dropdown-menu dropdown-menu-right">
				<li><a class="dropdown-item" href="?mod=statistics"><i class="fa fa-bar-chart"></i>{{ lang['statistics'] }}</a></li>
				<li class="divider"></li>
				<li><a class="dropdown-item" href="?mod=configuration"><i class="fa fa-cogs"></i>{{ lang['configuration'] }}</a></li>
			</ul>
		</li>
	</ol>
</div>

<div class="content">

<div class="alert alert-success alert-styled-left alert-arrow-left alert-component message_box" style="padding:0px">
  <h4>{{ lang['done'] }}</h4>
  <div class="panel-body">
		<table width="100%">
		    <tbody><tr>
		        <td height="80" class="text-center">{{ lang.xfconfig['savedone'] }}<br><br><a href="javascript:history.go(-1)" class="btn btn-light">{{ lang['back'] }}</a> <a href="{php_self}?mod=extra-config&plugin={plugin}" class="btn btn-light">{{ lang['backed'] }}</a></td>
		    </tr>
		</tbody></table>
	</div>
	
</div>
</div>