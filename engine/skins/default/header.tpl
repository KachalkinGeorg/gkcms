<!DOCTYPE html>
<html lang="{{ lang['langcode'] }}">
<head>
	<meta charset="{{ lang['encoding'] }}" />
	<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no" />
	<link rel="shortcut icon" type="icon" href="{{ tpl_url }}/images/favicon.ico" />
	<title>{{ home_title }} - {{ lang['admin_panel'] }}</title>
	<link href="{{ skins_url }}/public/css/app.css" rel="stylesheet" />
	<script src="{{ skins_url }}/public/js/manifest.js" type="text/javascript"></script>
	<script src="{{ skins_url }}/public/js/vendor.js" type="text/javascript"></script>
	<script src="{{ skins_url }}/public/js/app.js" type="text/javascript"></script>
	<script src="{{ skins_url }}/functions.js"></script>
	<script src="{{ home }}/lib/notify.js"></script>
</head>

<body>
<div id="loading-layer" class="col-md-3 alert alert-dark" role="alert">
	<i class="fa fa-spinner fa-pulse mr-2"></i> {{ lang['loading'] }}
</div>

<nav class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
	<a href="{{ php_self }}" class="navbar-brand col-md-3 col-lg-2 mr-0 px-3"><i class="fa fa-laptop"></i>  {{ lang['admin_panel'] }}</a>
	<button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-toggle="collapse" data-target="#menu-content" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
		
	<div class="btn-group ml-auto mr-2 py-1 " role="group" aria-label="Button group with nested dropdown">
		<div class="btn-group">
			<a href="{{ home }}" class="btn btn-outline-light btn-sm" title="{{ lang['mainpage'] }}" style="border-color: #f0f8ff00;" target="_blank">
				<i class="fa fa-globe fa-lg"></i>
			</a>
		</div>
		<div class="btn-group">
			<button type="button" class="btn btn-outline-primary btn-sm" id="full_screen" title="Полноэкранный режим"  style="border-color: #f0f8ff00;">
				<i class="fa fa-expand fa-lg"></i>
			</button>
		</div>
		<div class="btn-group">
			<button type="button" class="btn btn-outline-danger dropdown-toggle btn-sm" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="border-color: #f0f8ff00;">
				<i class="fa fa-bell-o fa-lg"></i>
				<span class="badge badge-danger">{{ unnAppLabel }}</span>
			</button>
			<ul class="dropdown-menu dropdown-menu-right">
				<li><span class="dropdown-item"><i class="fa fa-exclamation"></i> {{ unnAppText }}</span></li>
				<li class="dropdown-divider"></li>
					{{ unapproved1 }}
					{{ unapproved2 }}
					{{ unapproved3 }}
				<li><a class="dropdown-item" href="{{ php_self }}?mod=pm" title="{{ lang['pm_t'] }}"><i class="fa fa-envelope-o"></i> {{ newpmText }}</a></li>
			</ul>
		</div>
				
		<div class="btn-group">
			<button type="button" class="btn btn-outline-success dropdown-toggle btn-sm" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="border-color: #f0f8ff00;">
				<i class="fa fa-plus fa-lg"></i>
			</button>
			<ul class="dropdown-menu dropdown-menu-right">
				<li><a class="dropdown-item" href="{{ php_self }}?mod=news&action=add"><i class="fa fa-file-text-o"></i> {{ lang['head_add_news'] }}</a></li>
				<li><a class="dropdown-item" href="{{ php_self }}?mod=categories&action=add"><i class="fa fa-folder-open-o"></i> {{ lang['head_add_cat'] }}</a></li>
				<li><a class="dropdown-item" href="{{ php_self }}?mod=static&action=addForm"><i class="fa fa-file-text"></i> {{ lang['head_add_stat'] }}</a></li>
				<li><a class="dropdown-item" href="{{ php_self }}?mod=users" class="add_form"><i class="fa fa-user-plus"></i> {{ lang['head_add_user'] }}</a></li>
			</ul>
		</div>
		<div class="btn-group">
			<button type="button" class="btn btn-outline-primary dropdown-toggle btn-sm" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="border-color: #f0f8ff00;">
				<i class="fa fa-user-o fa-lg"></i>
			</button>
			<ul class="dropdown-menu dropdown-menu-right">
				<span class="dropdown-item dropdown-header">
					<a href="#" title="{{ users }}"><img src="{{ skin_UAvatar }}" class="img-circle" alt="{{ users }}" width="40" height="40"></a> {{ users }}
				</span>
				<li class="divider"></li>
				<li><a href="#" class="dropdown-item"><i class="fa fa-address-card-o mr-2"></i> {{ skin_UStatus }}</a></li>
				<li class="dropdown-divider"></li>
				<li><a class="dropdown-item" href="?mod=users&action=editForm&id={{ user_id }}"><i class="fa fa-user-o"></i> {{ lang['loc_profile'] }}</a></li>
				<li class="dropdown-divider"></li>
				<li><a class="dropdown-item" href="{{ php_self }}?action=logout"><i class="fa fa-sign-out"></i> {{ lang['logout'] }}</a></li>
			</ul>
		</div>
</nav>

<div class="container-fluid">
	<div class="container-page">
		<div class="nav-side-menu">
		
		<div class="menu-list">
			
				<ul id="menu-content" class="menu-content collapse out">
				
			<div class="sidebar-user">
				<div class="sidebar-user-content">
					<img src="{{ skin_UAvatar }}" class="img-circle" alt="{{ users }}">
					<h6>{{ users }}</h6>
					<span class="text-size-small">{{ skin_UStatus }}</span>
				</div>
				<li class="user-menu collapsed">
					<a href="#" data-toggle="collapse" data-target="#user-content" ><span>Аккаунт</span> <i class="caret"></i></a>
				</li>
				<ul class="navigation navigation-wrapper collapse" id="user-content">
					{{ unapproved1 }}
					{{ unapproved2 }}
					{{ unapproved3 }}
					<li><a class="navigation-item" href="{{ php_self }}?mod=pm" title="{{ lang['pm_t'] }}"><i class="fa fa-envelope-o"></i> {{ newpmText }}</a></li>
					<li><a class="navigation-item" href="?mod=users&action=editForm&id={{ user_id }}"><i class="fa fa-user-o"></i> {{ lang['loc_profile'] }}</a></li>
					<li><a class="navigation-item" href="{{ php_self }}?action=logout"><i class="fa fa-sign-out"></i> {{ lang['logout'] }}</a></li>
					<li class="dropdown-divider"></li>
				</ul>
			</div>
			
					<li class="nav-header"><span>Список разделов</span></li>
					<li class="nav-header"><a href="{{ home }}" target="_blank"><i class="fa fa-external-link"></i> {{ lang['mainpage'] }}</a></li>
					{%
						set showContent = global.mod == 'news'
							or global.mod == 'categories'
							or global.mod == 'static'
							or global.mod == 'images'
							or global.mod == 'files'
							or global.mod == 'lastcomments'
					%}						
					<li class="nav-header next-menu collapsed {{ h_active_options ? 'active' : '' }}">
						<a href="#" data-toggle="collapse" data-target="#nav-content" ><span><i class="fa fa-newspaper-o"></i>{{ lang['news_a'] }}</span> <i class="arrow"></i></a>
					</li>
					<ul class="sub-menu collapse {{ showContent ? 'show' : ''}}" id="nav-content">
						{% if (perm.editnews) %}<li><a href="{{ php_self }}?mod=news">{{ lang['news.edit'] }}</a></li>{% endif %}
						{% if (perm.categories) %}<li><a href="{{ php_self }}?mod=categories">{{ lang['news.categories'] }}</a></li>{% endif %}
						{% if (perm.static) %}<li><a href="{{ php_self }}?mod=static">{{ lang['static'] }}</a></li>{% endif %}
						{% if (perm.addnews) %}<li><a href="{{ php_self }}?mod=news&action=add">{{ lang['news.add'] }}</a></li>{% endif %}
						{% if (perm.lastcomments) %}<li><a href="{{ php_self }}?mod=lastcomments">{{ lang['lastcomments'] }}</a></li>{% endif %}
						<li><a href="{{ php_self }}?mod=images">{{ lang['images'] }}</a></li>
						<li><a href="{{ php_self }}?mod=files">{{ lang['files'] }}</a></li>
					</ul>
					{%
						set showUsers = global.mod == 'users'
							or global.mod == 'ipban'
							or global.mod == 'ugroup'
							or global.mod == 'perm'
							or global.mod == 'rules'
					%}
					<li class="nav-header next-menu collapsed {{ h_active_userman ? 'active' : '' }}">
						<a href="#" data-toggle="collapse" data-target="#nav-users"><span><i class="fa fa-users"></i> {{ lang['userman'] }}</span> <i class="arrow"></i></a>
					</li>
					<ul class="sub-menu collapse {{ showUsers ? 'show' : '' }}" id="nav-users">
						{% if (perm.users) %}<li><a href="{{ php_self }}?mod=users">{{ lang['users'] }}</a></li>{% endif %}
						{% if (perm.ipban) %}<li><a href="{{ php_self }}?mod=ipban">{{ lang['ipban_m'] }}</a></li>{% endif %}
						<li><a href="{{ php_self }}?mod=ugroup">{{ lang['ugroup'] }}</a></li>
						<li><a href="{{ php_self }}?mod=perm">{{ lang['uperm'] }}</a></li>
						{% if (perm.rules) %}<li><a href="{{ php_self }}?mod=rules">{{ lang['rules'] }}</a></li>{% endif %}
					</ul>
					{%
						set showService = global.mod == 'configuration'
							or global.mod == 'options'
							or global.mod == 'dbo'
							or global.mod == 'rewrite'
							or global.mod == 'cron'
							or global.mod == 'newsletter'
							or global.mod == 'statistics'
							or global.mod == 'replace'
					%}
					<li class="nav-header next-menu collapsed {{ h_active_system ? 'active' : '' }}">
						<a href="#" data-toggle="collapse" data-target="#nav-service"><span><i class="fa fa-cog"></i> {{ lang['system'] }}</span> <i class="arrow"></i></a>
					</li>
					<ul class="sub-menu collapse {{ showService ? 'show' : '' }}" id="nav-service">
						{% if (perm.options) %}<li><a href="{{ php_self }}?mod=options">{{ lang['options_all'] }}</a></li>{% endif %}
						{% if (perm.configuration) %}<li><a href="{{ php_self }}?mod=configuration">{{ lang['configuration'] }}</a></li>{% endif %}
						{% if (perm.dbo) %}<li><a href="{{ php_self }}?mod=dbo">{{ lang['options_database'] }}</a></li>{% endif %}
						{% if (perm.rewrite) %}<li><a href="{{ php_self }}?mod=rewrite">{{ lang['rewrite'] }}</a></li>{% endif %}
						{% if (perm.cron) %}<li><a href="{{ php_self }}?mod=cron">{{ lang['cron_m'] }}</a></li>{% endif %}
						{% if (perm.newsletter) %}<li><a href="{{ php_self }}?mod=newsletter">{{ lang['newsletter'] }}</a></li>{% endif %}
						<li><a href="{{ php_self }}?mod=statistics">{{ lang['statistics'] }} </a></li>
						{% if (perm.replace) %}<li><a href="{{ php_self }}?mod=replace">{{ lang['replace'] }}</a></li>{% endif %}
					</ul>
					<li class="nav-header {{ h_active_extras ? 'active' : '' }} ">
						<a href="{{ php_self }}?mod=extras"><i class="fa fa-puzzle-piece"></i>{{ lang['extras'] }}</a>
					</li>
					{% if (perm.templates) %}<li class="nav-header {{ h_active_templates ? 'active' : '' }} "><a href="{{ php_self }}?mod=templates"><i class="fa fa-th-large"></i>{{ lang['templates_m'] }}</a></li>{% endif %}
					<li class="dropdown-divider"></li>
					<li class="nav-header"><a href="{{ php_self }}?mod=docs"><i class="fa fa-book" aria-hidden="true"></i> Документация</a></li>
					<li class="nav-header"><a href="https://ngcms.ru/forum/" target="_blank"><i class="fa fa-comments-o" aria-hidden="true"></i> Форум поддержки</a></li>
					<li class="nav-header"><a href="https://ngcms.ru/" target="_blank"><i class="fa fa-globe fa-lg"></i>Официальный сайт</a></li>
					<li class="nav-header"><a href="https://github.com/vponomarev/ngcms-core" target="_blank"><i class="fa fa-github"></i> Github</a></li>
				</ul>
			</div>
		</div>
		
		<main role="main" id="adminDataBlock" class="side-body">