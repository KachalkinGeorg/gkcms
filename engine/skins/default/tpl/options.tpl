<div class="panel panel-default">
  <div class="panel-card">{{ lang['setting_script'] }}</div>
  <div class="media-bordered">
	
	<div class="row box-section">
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=configuration">
			<div class="media-left"><i class="fa fa-wrench fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['configuration'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['configuration_d'] }}</span>
			</div>
		</a>
	  </div>
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=dbo">
			<div class="media-left"><i class="fa fa-database fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['dbo'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['dbo_d'] }}</span>
			</div>
		</a>
	  </div>
	</div>
	<div class="row box-section">
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=rewrite">
			<div class="media-left"><i class="fa fa-chain-broken fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['rewrite'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['rewrite_d'] }}</span>
			</div>
		</a>
	  </div>
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=cron">
			<div class="media-left"><i class="fa fa-tasks fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['cron'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['cron_d'] }}</span>
			</div>
		</a>
	  </div>
	</div>
	<div class="row box-section">
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=statistics">
			<div class="media-left"><i class="fa fa-bar-chart fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['statistics'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['statistics_d'] }}</span>
			</div>
		</a>
	  </div>

	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=replace">
			<div class="media-left"><i class="fa fa-exchange fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['replace'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['replace_d'] }}</span>
			</div>
		</a>
	  </div>
	</div>

	</div>
</div>

<div class="panel panel-default">
  <div class="panel-card">{{ lang['setting_user'] }}</div>
  <div class="media-bordered">

	<div class="row box-section">
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=users">
			<div class="media-left"><i class="fa fa-users fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['users'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['users_d'] }}</span>
			</div>
		</a>
	  </div>
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=ugroup">
			<div class="media-left"><i class="fa fa-address-book fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['ugroup'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['ugroup_d'] }}</span>
			</div>
		</a>
	  </div>
	</div>
	<div class="row box-section">
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=ipban">
			<div class="media-left"><i class="fa fa-user-times fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['ipban'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['ipban_d'] }}</span>
			</div>
		</a>
	  </div>

	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=perm">
			<div class="media-left"><i class="fa fa-id-badge fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['perm'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['perm_d'] }}</span>
			</div>
		</a>
	  </div>
	</div>
	<div class="row box-section">
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=rules">
			<div class="media-left"><i class="fa fa-book fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['rules'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['rules_d'] }}</span>
			</div>
		</a>
	  </div>
	  
		{% if (pluginIsActive('auth_basic')) %}
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=extra-config&plugin=auth_basic">
			<div class="media-left"><i class="fa fa-address-card fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['auth_basic'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['auth_basic_d'] }}</span>
			</div>
		</a>
	  </div>
		{% endif %}
	</div>
	<div class="row box-section">
		{% if (pluginIsActive('auth_social')) %}
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=extra-config&plugin=auth_social">
			<div class="media-left"><i class="fa fa-user fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['auth_social'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['auth_social_d'] }}</span>
			</div>
		</a>
	  </div>
		{% endif %}
		
		{% if (pluginIsActive('auth_loginza')) %}
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=extra-config&plugin=auth_loginza">
			<div class="media-left"><i class="fa fa-user fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['auth_loginza'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['auth_loginza_d'] }}</span>
			</div>
		</a>
	  </div>
		{% endif %}

		{% if (pluginIsActive('uprofile')) %}
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=extra-config&plugin=uprofile">
			<div class="media-left"><i class="fa fa-user-circle-o fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['uprofile'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['uprofile_d'] }}</span>
			</div>
		</a>
	  </div>
		{% endif %}
		
	</div> 
	</div>
</div>

<div class="panel panel-default">
  <div class="panel-card">{{ lang['setting_news'] }}</div>
  <div class="media-bordered">
  
	<div class="row box-section">
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=static">
			<div class="media-left"><i class="fa fa-file-text fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['static'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['static_d'] }}</span>
			</div>
		</a>
	  </div>
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=news">
			<div class="media-left"><i class="fa fa-newspaper-o fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['news'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['news_d'] }}</span>
			</div>
		</a>
	  </div>
	</div>
	<div class="row box-section">
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=news&action=add">
			<div class="media-left"><i class="fa fa-file-text-o fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['newsadd'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['newsadd_d'] }}</span>
			</div>
		</a>
	  </div>
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=categories">
			<div class="media-left"><i class="fa fa-folder-open fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['categories'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['categories_d'] }}</span>
			</div>
		</a>
	  </div>

	</div> 
	</div>
</div>

<div class="panel panel-default">
  <div class="panel-card">{{ lang['setting_prav'] }}</div>
  <div class="media-bordered">
  
	<div class="row box-section">
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=extras">
			<div class="media-left"><i class="fa fa-puzzle-piece fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['extras'] }} <span style="color: #66aeb1;">[{{ lang['extras_all'] }} {{ cntAll }}]</span></h6>
				<span class="text-muted text-size-small">{{ lang['extras_d'] }}</span>
			</div>
		</a>
	  </div>
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=images">
			<div class="media-left"><i class="fa fa-picture-o fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['images'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['images_d'] }}</span>
			</div>
		</a>
	  </div>
	</div>
	<div class="row box-section">
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=files">
			<div class="media-left"><i class="fa fa-file-archive-o fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['files'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['files_d'] }}</span>
			</div>
		</a>
	  </div>
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=templates">
			<div class="media-left"><i class="fa fa-paint-brush fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['templates'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['templates_d'] }}</span>
			</div>
		</a>
	  </div>
	</div>
	<div class="row box-section">
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=lastcomments">
			<div class="media-left"><i class="fa fa-commenting-o fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['lastcomments'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['lastcomments_d'] }}</span>
			</div>
		</a>
	  </div>
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=newsletter">
			<div class="media-left"><i class="fa fa-envelope-square fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['newsletter'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['newsletter_d'] }}</span>
			</div>
		</a>
	  </div>
	  
	</div> 
	</div>
</div>

<div class="panel panel-default">
  <div class="panel-card">{{ lang['setting_log'] }}</div>
  <div class="media-bordered">
	<div class="row box-section">
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=profillog">
			<div class="media-left"><i class="fa fa-info-circle fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['profillog'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['profillog_d'] }}</span>
			</div>
		</a>
	  </div>
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=loadlog">
			<div class="media-left"><i class="fa fa-info-circle fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['loadlog'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['loadlog_d'] }}</span>
			</div>
		</a>
	  </div> 
	</div>
	<div class="row box-section">
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=syslog">
			<div class="media-left"><i class="fa fa-info-circle fa-2x"></i></div>
			<div class="media-body">
				<h6 class="media-heading text-semibold">{{ lang['syslog'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['syslog_d'] }}</span>
			</div>
		</a>
	  </div>
	</div> 
	</div>
</div>

<div class="panel panel-default">
  <div class="panel-card">
    {{ lang['setting_plugin'] }}
		<div class="panel-head-right">
			<i class="fa fa-eye"></i> : {{ cntActive }} | <i class="fa fa-eye-slash"></i> : {{ cntInactive }}
		</div>
  </div>
  <div class="media-bordered">

	<div class="row box-section" id="entryList">
	{% for entry in entries %}
	  <dd class="col-sm-6 media-list media-list-linked all" id="plugin_{{ entry.id }}">
		<div class="media-link">
			<div class="media-left">{{ entry.icon }}</div>
			<div class="media-body" style="width: 100%;">
				<h6 class="media-heading text-semibold">{{ entry.url }}</h6>
				<span class="text-muted text-size-small">{{ entry.description }}</span><br>
				<span class="text-muted text-size-small">
				{{ entry.info }} {{ entry.readme }} {{ entry.history }} 
				{% if entry.flags.isCompatible %}<i title="{{ lang['compatible1'] }}" class="fa fa-check-circle"></i>{% else %}<i title="{{ lang['compatible2'] }}" class="fa fa-circle"></i>{% endif %} | {{ entry.type }} - 
					<span style="color:#6c757d!important;text-shadow:0 0 1px rgb(0 0 0 / 50%);font-size: 10px;">
						{{ entry.id }} {{ entry.new }} - <span>v{{ entry.version }}</span>
					</span>
				</span>
			</div>
		</div>
		<hr>
	  </dd>
	<div id="modal-{{ entry.id }}" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="{{ entry.id }}-modal-label">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 id="{{ entry.id }}-modal-label" class="modal-title">{{ entry.url }}</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span><i class="fa fa-times-circle"></i></span></button>
				</div>
				<div class="modal-body">
					{{ entry.information }}
				</div>
				<div class="modal-footer">{{ lang['author'] }} - {{ entry.author }}</div>
			</div>
		</div>
	</div>
	 {% endfor %}
	 </div>
	</div>
</div>