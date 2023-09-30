<form action="{{ php_self }}" method="post">
	<input type="hidden" name="token" value="{{ token }}" />
	<input type="hidden" name="mod" value="configuration" />
	<input type="hidden" name="subaction" value="save" />
	<input type="hidden" name="action" value="done" />
	<input type="hidden" name="save" value="" />
	<input id="selectedOption" type="hidden" name="selectedOption" />

	<div class="navbar-default navbar-component">
	<ul class="nav nav-tabs nav-fill mb-3 d-md-flex d-block" role="tablist">
		<li class="nav-item"><a href="#userTabs-db" class="nav-link active" data-toggle="tab"><span data-toggle="popover" data-placement="top" data-trigger="hover focus" data-content="{{ lang['db'] }}"><i class="fa fa-database"></i> {{ lang['db'] }}</span></a></li>
		<li class="nav-item"><a href="#userTabs-security" class="nav-link" data-toggle="tab"><span data-toggle="popover" data-placement="top" data-trigger="hover focus" data-content="{{ lang['security'] }}"><i class="fa fa-shield"></i> {{ lang['security'] }}</span></a></li>
		<li class="nav-item"><a href="#userTabs-system" class="nav-link" data-toggle="tab"><span data-toggle="popover" data-placement="top" data-trigger="hover focus" data-content="{{ lang['syst'] }}"><i class="fa fa-cog"></i> {{ lang['syst'] }}</span></a></li>
		<li class="nav-item"><a href="#userTabs-news" class="nav-link" data-toggle="tab"><span data-toggle="popover" data-placement="top" data-trigger="hover focus" data-content="{{ lang['sn'] }}"><i class="fa fa-file-text-o"></i> {{ lang['sn'] }}</span></a></li>
		<li class="nav-item"><a href="#userTabs-users" class="nav-link" data-toggle="tab"><span data-toggle="popover" data-placement="top" data-trigger="hover focus" data-content="{{ lang['users'] }}"><i class="fa fa-user-circle-o"></i> {{ lang['users'] }}</span></a></li>
		<li class="nav-item"><a href="#userTabs-imgfiles" class="nav-link" data-toggle="tab"><span data-toggle="popover" data-placement="top" data-trigger="hover focus" data-content="{{ lang['files'] }}/{{ lang['img'] }}"><i class="fa fa-upload"></i> {{ lang['files'] }}/{{ lang['img'] }}</span></a></li>
		<li class="nav-item"><a href="#userTabs-cache" class="nav-link" data-toggle="tab"><span data-toggle="popover" data-placement="top" data-trigger="hover focus" data-content="{{ lang['cache'] }}"><i class="fa fa-bar-chart"></i> {{ lang['cache'] }}</span></a></li>
		<li class="nav-item"><a href="#userTabs-multi" class="nav-link" data-toggle="tab"><span data-toggle="popover" data-placement="top" data-trigger="hover focus" data-content="{{ lang['multi'] }}"><i class="fa fa-sitemap"></i> {{ lang['multi'] }}</span></a></li>
		<li class="nav-item"><a href="#userTabs-seo" class="nav-link" data-toggle="tab"><span data-toggle="popover" data-placement="top" data-trigger="hover focus" data-content="{{ lang['seo'] }}"><i class="fa fa-code"></i> {{ lang['seo'] }}</span></a></li>
	</ul>
	</div>

	<div id="userTabs" class="tab-content">
	
		<!-- ########################## DB TAB ########################## -->
		<div id="userTabs-db" class="tab-pane show active">
		<div class="panel panel-default">
		<div class="panel-heading">{{ lang['db'] }}</div>
		<div class="panel-body">{{ lang['db_connect'] }}</div>
		<div class="table-responsive">
			<!-- TABLE DB//Connection -->
			<table class="table table-striped">

				<tr>
					<td width="50%">{{ lang['dbtype'] }} <small class="form-text text-muted">{{ lang['example'] }} pdo</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[dbtype]', 'value' : config['dbtype'], 'id' : 'db_dbtype', 'values' : { 'mysqli' : lang['mysqli'], 'pdo' : lang['pdo'] } }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['dbhost'] }} <small class="form-text text-muted">{{ lang['example'] }} localhost</small></td>
					<td width="50%">
						<input id="db_dbhost" type="text" name="save_con[dbhost]" value="{{ config['dbhost'] }}" class="form-control" style="max-width:150px; text-align: center;"/>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['dbname'] }} <small class="form-text text-muted">{{ lang['example'] }} ng</small></td>
					<td width="50%">
						<input id="db_dbname" type="text" name="save_con[dbname]" value="{{ config['dbname'] }}" class="form-control" style="max-width:150px; text-align: center;"/>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['dbuser'] }} <small class="form-text text-muted">{{ lang['example'] }} root</small></td>
					<td width="50%">
						<input id="db_dbuser" type="text" name="save_con[dbuser]" value="{{ config['dbuser'] }}" class="form-control" style="max-width:150px; text-align: center;"/>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['dbpass'] }} <small class="form-text text-muted">{{ lang['example'] }} password</small></td>
					<td width="50%">
						<input id="db_dbpasswd" type="password" name="save_con[dbpasswd]" value="{{ config['dbpasswd'] }}" class="form-control" style="max-width:150px; text-align: center;"/>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['dbprefix'] }} <small class="form-text text-muted">{{ lang['example'] }} ng</small></td>
					<td width="50%">
						<input type="text" name="save_con[prefix]" value="{{ config['prefix'] }}" class="form-control" style="max-width:150px; text-align: center;"/>
					</td>
				</tr>
				<tr>
					<td width="50%">&nbsp;</td>
					<td width="50%">
						<button type="button" onclick="ngCheckDB();" class="btn btn-outline-primary">{{ lang['btn_checkDB'] }}</button>
					</td>
				</tr>
			</table>
		</div>
		<!-- END: TABLE DB//Connection -->

		<!-- TABLE DB//Backup -->
		<div class="panel-body">{{ lang['db_backup'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['auto_backup'] }} <small class="form-text text-muted">{{ lang['auto_backup_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[auto_backup]', 'value' : config['auto_backup'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['auto_backup_time'] }} <small class="form-text text-muted">{{ lang['auto_backup_time_desc'] }}</small></td>
					<td width="50%">
						<div class="input-group mb-3">
							<input type="text" name="save_con[auto_backup_time]" value="{{ config['auto_backup_time'] }}" class="form-control" maxlength="5" style="max-width:150px; text-align: center;"/>
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text">h</label>
							</div>
						</div>
					</td>
				</tr>
			</table>
			<!-- END: TABLE DB//Backup -->
		</div>
	</div></div>

		<!-- ########################## SECURITY TAB ########################## -->
		<div id="userTabs-security" class="tab-pane">
		<div class="panel panel-default">
		<div class="panel-heading">{{ lang['security'] }}</div>
		<div class="panel-body">{{ lang['logging'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['x_ng_headers'] }} <small class="form-text text-muted">{{ lang['x_ng_headers#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectNY({'name' : 'save_con[x_ng_headers]', 'value' : config['x_ng_headers'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['syslog'] }} <small class="form-text text-muted">{{ lang['syslog_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[syslog]', 'value' : config['syslog'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['load'] }} <small class="form-text text-muted">{{ lang['load_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[load_analytics]', 'value' : config['load_analytics'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['load_profiler'] }} <small class="form-text text-muted">{{ lang['load_profiler_desc'] }}</small></td>
					<td width="50%">
						<div class="input-group mb-3">
							<input type="text" name="save_con[load_profiler]" value="{{ config['load_profiler'] }}" class="form-control" style="max-width:150px; text-align: center;"/>
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text">s</label>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>	
		<div class="panel-body">{{ lang['security'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['iframe'] }} <small class="form-text text-muted">{{ lang['iframe#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectNY({'name' : 'save_con[iframe]', 'value' : config['iframe'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['flood_time'] }} <small class="form-text text-muted">{{ lang['flood_time_desc'] }}</small></td>
					<td width="50%">
						<div class="input-group">
							<input type="text" name="save_con[flood_time]" value="{{ config['flood_time'] }}" class="form-control" style="max-width:150px; text-align: center;"/>
							<div class="input-group-append">
							<a class="btn btn-outline-primary" data-toggle="popover" data-placement="top" data-trigger="focus" data-html="true" title="" data-content="{{ lang['flood_time_info'] }}" tabindex="0" data-original-title="{{ lang['flood_time'] }}">
								<i class="fa fa-question"></i>
							</a>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['use_captcha'] }} <small class="form-text text-muted">{{ lang['use_captcha_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[use_captcha]', 'value' : config['use_captcha'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['captcha_font'] }} <small class="form-text text-muted">{{ lang['captcha_font_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[captcha_font]', 'value' : config['captcha_font'], 'values' : list['captcha_font'] }) }}
					</td>
				</tr>
			</table>
		</div>	
		<div class="panel-body">{{ lang['different'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['use_crypto_salt'] }} <small class="form-text text-muted">{{ lang['use_crypto_salt_desc'] }}</small></td>
					<td width="50%">
						<div class="input-group mb-3">
							<input type="text" name="save_con[crypto_salt]" value="{{ config['crypto_salt'] }}" class="form-control" style="max-width:250px; text-align: center;"/>
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-hashtag"></i></label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['use_cookies'] }} <small class="form-text text-muted">{{ lang['use_cookies_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[use_cookies]', 'value' : config['use_cookies'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['use_sessions'] }} <small class="form-text text-muted">{{ lang['use_sessions_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[use_sessions]', 'value' : config['use_sessions'] }) }}
					</td>
				</tr>
<!-- 				<tr>
					<td width="50%">{{ lang['ssl_only'] }} <small class="form-text text-muted">{{ lang['ssl_only_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[ssl_only]', 'value' : config['ssl_only'] }) }}
					</td>
				</tr> -->
				<tr>
					<td width="50%">{{ lang['last_modif'] }} <small class="form-text text-muted">{{ lang['last_modif_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[last_modif]', 'value' : config['last_modif'] }) }}
					</td>
				</tr>			
				<tr>
					<td width="50%">{{ lang['sql_error'] }} <small class="form-text text-muted">{{ lang['sql_error_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[sql_error_show]', 'value' : config['sql_error_show'], 'values' : { 0 : lang['sql_error_0'], 1 : lang['sql_error_1'], 2 : lang['sql_error_2'] } }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['multiext_files'] }} <small class="form-text text-muted">{{ lang['multiext_files_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectNY({'name' : 'save_con[allow_multiext]', 'value' : config['allow_multiext'] }) }}
					</td>
				</tr>
			</table>
		</div>
			
		<div class="panel-body">{{ lang['debug_generate'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['debug'] }} <small class="form-text text-muted">{{ lang['debug_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[debug]', 'value' : config['debug'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['debug_queries'] }} <small class="form-text text-muted">{{ lang['debug_queries_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[debug_queries]', 'value' : config['debug_queries'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['debug_profiler'] }} <small class="form-text text-muted">{{ lang['debug_profiler_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[debug_profiler]', 'value' : config['debug_profiler'] }) }}
					</td>
				</tr>
			</table>
		</div>
	</div></div>
	
		<!-- ########################## SYSTEM TAB ########################## -->
		<div id="userTabs-system" class="tab-pane">
		<div class="panel panel-default">
		<div class="panel-heading">{{ lang['syst'] }}</div>
		<div class="panel-body">{{ lang['syst'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['home_url'] }} <small class="form-text text-muted">{{ lang['example'] }} http://server.com</small></td>
					<td width="50%">
						<input type="text" name="save_con[home_url]" value="{{ config['home_url'] }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['admin_url'] }} <small class="form-text text-muted">{{ lang['example'] }} http://server.com/engine</small></td>
					<td width="50%">
						<input type="text" name="save_con[admin_url]" value="{{ config['admin_url'] }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['home_title'] }} <small class="form-text text-muted">{{ lang['example'] }} NGCNS</small></td>
					<td width="50%">
						<input type="text" name="save_con[home_title]" value="{{ config['home_title']|escape }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['admin_mail'] }} <small class="form-text text-muted">{{ lang['admin_mail_desc'] }}</small></td>
					<td width="50%">
						<input type="text" name="save_con[admin_mail]" value="{{ config['admin_mail'] }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['lock'] }} <small class="form-text text-muted">{{ lang['lock_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectNY({'name' : 'save_con[lock]', 'value' : config['lock'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['lock_reason'] }} <small class="form-text text-muted">{{ lang['lock_reason_desc'] }}</small></td>
					<td width="50%">
						<textarea name="save_con[lock_reason]" rows="4">{{ config['lock_reason'] }}</textarea>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['lock_retry'] }} <small class="form-text text-muted">{{ lang['lock_retry_desc'] }}</small></td>
					<td width="50%">
						<div class="input-group mb-3">
							<input type="number" class="form-control" name="save_con[lock_retry]" value="{{ config['lock_retry'] }}" class="form-control" style="max-width:150px; text-align: center;"/>
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text">s</label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['theme'] }} <small class="form-text text-muted">{{ lang['theme_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[theme]', 'value' : config['theme'], 'values' : list['theme'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['lang'] }} <small class="form-text text-muted">{{ lang['lang_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[default_lang]', 'value' : config['default_lang'], 'values' : list['default_lang'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['use_gzip'] }} <small class="form-text text-muted">{{ lang['use_gzip_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[use_gzip]', 'value' : config['use_gzip'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['404_mode'] }} <small class="form-text text-muted">{{ lang['404_mode_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[404_mode]', 'value' : config['404_mode'], 'values' : { 0 : lang['404.int'], 1 : lang['404.ext'], 2 : lang['404.http'] } }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['libcompat'] }} <small class="form-text text-muted">{{ lang['libcompat_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[libcompat]', 'value' : config['libcompat'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">
						{{ lang['url_external_nofollow'] }} <small class="form-text text-muted">{{ lang['url_external_nofollow_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectNY({'name' : 'save_con[url_external_nofollow]', 'value' : config['url_external_nofollow'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['url_external_target_blank'] }} <small class="form-text text-muted">{{ lang['url_external_target_blank_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectNY({'name' : 'save_con[url_external_target_blank]', 'value' : config['url_external_target_blank'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['jsquery'] }} <small class="form-text text-muted">{{ lang['jsquery_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[jsquery]', 'value' : config['jsquery'], 'values' : { 0 : lang['jsq_0'], 1 : lang['jsq_1'], 2 : lang['jsq_2'], 3 : lang['jsq_3'] } }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['timezone'] }} <small class="form-text text-muted">{{ lang['timezone#desc'] }}</small></td>
					<td width="50%">
						<select id="timezone" name="save_con[timezone]" class="custom-select">
							{% for zone in list['timezoneList'] %}
							<option value="{{ zone }}" {% if (config['timezone'] == zone) %}selected {% endif %}>{{ zone }}</option>
							{% endfor %}
						</select>
					</td>
				</tr>
			</table>
		</div>
				
		<div class="panel-body">{{ lang['email_configuration'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">

				<tr>
					<td width="50%">{{ lang['mailfrom_name'] }} <small class="form-text text-muted">{{ lang['mailfrom_desc'] }}</small></td>
					<td width="50%">
						<div class="input-group">
							<input id="mail_fromname" type="text" placeholder="Введите имя..." name="save_con[mailfrom_name]" value="{{ config['mailfrom_name'] }}" class="form-control" />
							<div class="input-group-append">
							<a class="btn btn-outline-primary" data-toggle="popover" data-placement="top" data-trigger="focus" data-html="true" title="E-MAIL" data-content="{{ lang['mailfrom_quest'] }}" tabindex="0">
								<i class="fa fa-question"></i>
							</a>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['mailfrom'] }} <small class="form-text text-muted">{{ lang['example'] }} mailbot@server.com</small></td>
					<td width="50%">
						<input id="mail_frommail" type="text" placeholder="Введите имя..." name="save_con[mailfrom]" value="{{ config['mailfrom'] }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['mail_mode'] }}: <small class="form-text text-muted">{{ lang['mail_mode#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[mail_mode]', 'id' : 'mail_mode', 'value' : config['mail_mode'], 'values' : { 'mail' : 'mail', 'sendmail' : 'sendmail', 'smtp' : 'smtp' } }) }}
					</td>
				</tr>
			</table>
		</div>	
		<div class="panel-body useSMTP">{{ lang['smtp_config'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr class="useSMTP">
					<td width="50%">{{ lang['smtp_host'] }}: <small class="form-text text-muted">{{ lang['example'] }} smtp.mail.ru</small></td>
					<td width="50%">
						<input id="mail_smtp_host" type="text" name="save_con[mail][smtp][host]" value="{{ config['mail']['smtp']['host'] }}" class="form-control" style="max-width:150px; text-align: center;"/>
					</td>
				</tr>
				<tr class="useSMTP">
					<td width="50%">{{ lang['smtp_port'] }}: <small class="form-text text-muted">{{ lang['example'] }} 25</small></td>
					<td width="50%">
						<input id="mail_smtp_port" type="text" name="save_con[mail][smtp][port]" value="{{ config['mail']['smtp']['port'] }}" class="form-control" style="max-width:150px; text-align: center;"/>
					</td>
				</tr>
				<tr class="useSMTP">
					<td width="50%">{{ lang['smtp_auth'] }}: <small class="form-text text-muted">{{ lang['smtp_auth#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectNY({'name' : 'save_con[mail][smtp][auth]', 'id' : 'mail_smtp_auth', 'value' : config['mail']['smtp']['auth'] }) }}
					</td>
				</tr>
				<tr class="useSMTP">
					<td width="50%">{{ lang['smtp_secure'] }}: <small class="form-text text-muted">{{ lang['smtp_secure#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[mail][smtp][secure]', 'id' : 'mail_smtp_secure', 'value' : config['mail']['smtp']['secure'], 'values' : { '' : 'None', 'tls' : 'TLS', 'ssl' : 'SSL' } }) }}
					</td>
				</tr>
				<tr class="useSMTP">
					<td width="50%">{{ lang['smtp_auth_login'] }}: <small class="form-text text-muted">{{ lang['example'] }} email@mail.ru</small></td>
					<td width="50%">
						<input id="mail_smtp_login" type="text" name="save_con[mail][smtp][login]" value="{{ config['mail']['smtp']['login'] }}" class="form-control" style="max-width:250px; text-align: center;"/>
					</td>
				</tr>
				<tr class="useSMTP">
					<td width="50%">{{ lang['smtp_auth_pass'] }}: <small class="form-text text-muted">{{ lang['example'] }} mySuperPassword</small></td>
					<td width="50%">
						<input id="mail_smtp_pass" type="text" name="save_con[mail][smtp][pass]" value="{{ config['mail']['smtp']['pass'] }}" class="form-control" style="max-width:250px; text-align: center;"/>
					</td>
				</tr>
				<tr>
					<td width="50%"></td>
					<td width="50%">
						<div class="form-group row">
							<label class="col-sm-4 col-form-label">EMail:</label>
							<div class="col-sm-8">
							<div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-at"></i></span>
								<input id="mail_tomail" type="text" name="" value="" placeholder="EMail" class="form-control" />
							</div>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-sm-8 offset-sm-4">
								<button type="button" class="btn btn-block btn-outline-primary" onclick="ngCheckEmail(); return false;">{{ lang['btn_checkSMTP'] }}</button>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div></div>
	
		<!-- ########################## NEWS TAB ########################## -->
		<div id="userTabs-news" class="tab-pane">
		<div class="panel panel-default">
		<div class="panel-heading">{{ lang['sn'] }}</div>
		<div class="panel-body">{{ lang['sn'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['number'] }}</td>
					<td width="50%">
						<div class="input-group mb-3">
							<input type="text" placeholder="5..." name="save_con[number]" value="{{ config['number'] }}" class="form-control" style="max-width:150px; text-align: center;"/>
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-th-list"></i></label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['news_multicat_url'] }} <small class="form-text text-muted">{{ lang['news_multicat_url#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[news_multicat_url]', 'value' : config['news_multicat_url'], 'values' : { 0 : lang['news_multicat#0'], 1 : lang['news_multicat#1'] } }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['nnavigations'] }} <small class="form-text text-muted">{{ lang['nnavigations_desc'] }}</small></td>
					<td width="50%">
						<div class="input-group mb-3">
							<input type="text" placeholder="10..." name="save_con[newsNavigationsCount]" value="{{ config['newsNavigationsCount'] }}" class="form-control" style="max-width:150px; text-align: center;"/>
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-th-list"></i></label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['nnavigations_admin'] }} <small class="form-text text-muted">{{ lang['nnavigations_admin_desc'] }}</small></td>
					<td width="50%">
						<div class="input-group mb-3">
							<input type="text" placeholder="20..." name="save_con[newsNavigationsAdminCount]" value="{{ config['newsNavigationsAdminCount'] }}" class="form-control" style="max-width:150px; text-align: center;"/>
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-th-list"></i></label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['category_counters'] }} <small class="form-text text-muted">{{ lang['category_counters_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[category_counters]', 'value' : config['category_counters'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['news_view_counters'] }} <small class="form-text text-muted">{{ lang['news_view_counters#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[news_view_counters]', 'value' : config['news_view_counters'], 'values' : {1: lang['yesa'], 0: lang['noa'], 2: lang['news_view_counters#2'] } }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['news.edit.split'] }} <small class="form-text text-muted">{{ lang['news.edit.split#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[news.edit.split]', 'value' : config['news.edit.split'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['extended_more'] }} <small class="form-text text-muted">{{ lang['extended_more_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectNY({'name' : 'save_con[extended_more]', 'value' : config['extended_more'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['news_without_content'] }} <small class="form-text text-muted">{{ lang['news_without_content_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[news_without_content]', 'value' : config['news_without_content'] }) }}
					</td>
				</tr>
				{% if (pluginIsActive('comments')) %}
				<tr>
					<td width="50%">{{ lang['comments'] }} <small class="form-text text-muted">{{ lang['comments_d'] }}</small></td>
					<td width="50%">
						<a class="btn btn-light" href="?mod=extra-config&plugin=comments"><i class="fa fa-comments-o"></i> {{ lang['comments_n'] }}</a>
					</td>
				</tr>
				{% endif %}
				<tr>
					<td width="50%">{{ lang['news.add.info'] }} <small class="form-text text-muted">{{ lang['news.add.info#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[news.add.info]', 'value' : config['news.add.info'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['news.add.scrin'] }} <small class="form-text text-muted">{{ lang['news.add.scrin#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[news.add.scrin]', 'id' : 'scrinimg', 'value' : config['news.add.scrin'] }) }}
					</td>
				</tr>
			</table>
		</div>
		<div class="panel-body useScrin"><i class="fa fa-imdb"></i> {{ lang['scrin_info'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr class="useScrin">
					<td width="70%"><small class="form-text text-muted">{{ lang['scrin_key_api_info'] }}</small></td>
					<td width="10%"></td>
				</tr>
				<tr class="useScrin">
					<td width="50%">{{ lang['scrin_key_api'] }} <small class="form-text text-muted">{{ lang['scrin_key_api_desc'] }}</small></td>
					<td width="50%">
						<input type="text" name="save_con[scrin_api_key]" value="{{ config['scrin_api_key'] }}" class="form-control" />
					</td>
				</tr>
				<tr class="useScrin">
					<td width="50%">{{ lang['scrin_text'] }}</td>
					<td width="50%">
						<input type="text" name="save_con[scrin_text]" value="{{ config['scrin_text'] }}" class="form-control" />
					</td>
				</tr>
			</table>
		</div>
		<div class="panel-body"></div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['date_adjust'] }} <small class="form-text text-muted">{{ lang['date_adjust_desc'] }}</small></td>
					<td width="50%">
						<div class="input-group mb-3">
							<input type="text" name="save_con[date_adjust]" value="{{ config['date_adjust'] }}" class="form-control" style="max-width:100px; text-align: center;"/>
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-clock-o"></i></label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['timestamp_active'] }} <small class="form-text text-muted">{{ lang['date_help'] }}</small></td>
					<td width="50%">
						<input type="text" name="save_con[timestamp_active]" value="{{ config['timestamp_active'] }}" class="form-control" style="max-width:150px;"/>
						<small class="form-text text-muted">{{ lang['date_now'] }} {{ timestamp_active_now }}</small>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['timestamp_updated'] }} <small class="form-text text-muted">{{ lang['date_help'] }}</small></td>
					<td width="50%">
						<input type="text" name="save_con[timestamp_updated]" value="{{ config['timestamp_updated'] }}" class="form-control" style="max-width:150px;"/>
						<small class="form-text text-muted">{{ lang['date_now'] }} {{ timestamp_updated_now }}</small>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['smilies'] }} <small class="form-text text-muted">{{ lang['smilies_desc'] }} (<b>,</b>)</small></td>
					<td width="50%">
						<input type="text" name="save_con[smilies]" value="{{ config['smilies'] }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['use_smilies'] }} <small class="form-text text-muted">{{ lang['use_smilies_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[use_smilies]', 'value' : config['use_smilies'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['blocks_for_reg'] }} <small class="form-text text-muted">{{ lang['blocks_for_reg_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[blocks_for_reg]', 'value' : config['blocks_for_reg'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['use_bbcodes'] }} <small class="form-text text-muted">{{ lang['use_bbcodes_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[use_bbcodes]', 'value' : config['use_bbcodes'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['use_htmlformatter'] }} <small class="form-text text-muted">{{ lang['use_htmlformatter_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[use_htmlformatter]', 'value' : config['use_htmlformatter'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['default_newsorder'] }} <small class="form-text text-muted">{{ lang['default_newsorder_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[default_newsorder]', 'value' : config['default_newsorder'], 'values' : { 'id desc' : lang['order_id_desc'], 'id asc' : lang['order_id_asc'], 'postdate desc' : lang['order_postdate_desc'], 'postdate asc' : lang['order_postdate_asc'], 'editdate desc' : lang['order_editdate_desc'], 'editdate asc' : lang['order_editdate_asc'], 'title desc' : lang['order_title_desc'], 'title asc' : lang['order_title_asc'] } }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['template_mode'] }} <small class="form-text text-muted">{{ lang['template_mode#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[template_mode]', 'value' : config['template_mode'], 'values' : { 1 : lang['template_mode.1'], 2 : lang['template_mode.2'] } }) }}
					</td>
				</tr>
			</table>
		</div>

		<div class="panel-body">{{ lang['favorit_configuration'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['favorit_active'] }} <small class="form-text text-muted">{{ lang['favorit_active#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[favorit_active]', 'id' : 'favorit_active', 'value' : config['favorit_active'] }) }}
					</td>
				</tr>
			</table>
		</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr class="useFavorit">
					<td width="50%">{{ lang['favorit_number'] }} <small class="form-text text-muted">{{ lang['favorit_number#desc'] }}</small></td>
					<td width="50%">
						<input type="text" name="save_con[favorit_number]" value="{{ config['favorit_number'] }}" class="form-control" style="max-width:150px; text-align: center;"/>
					</td>
				</tr>
				<tr class="useFavorit">
					<td width="50%">{{ lang['favorit_maxlength'] }} <small class="form-text text-muted">{{ lang['favorit_maxlength#desc'] }}</small></td>
					<td width="50%">
						<input type="text" name="save_con[favorit_maxlength]" value="{{ config['favorit_maxlength'] }}" class="form-control" style="max-width:150px; text-align: center;"/>
					</td>
				</tr>
				<tr class="useFavorit">
					<td width="50%">{{ lang['favorit_count'] }} <small class="form-text text-muted">{{ lang['favorit_count#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[favorit_count]', 'value' : config['favorit_count'] }) }}
					</td>
				</tr>
				<tr class="useFavorit">
					<td width="50%">{{ lang['favorit_cache'] }} <small class="form-text text-muted">{{ lang['favorit_cache#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[favorit_cache]', 'value' : config['favorit_cache'] }) }}
					</td>
				</tr>
				<tr class="useFavorit">
					<td width="50%">{{ lang['favorit_cacheExpire'] }} <small class="form-text text-muted">{{ lang['favorit_cacheExpire#desc'] }}</small></td>
					<td width="50%">
						<input type="text" name="save_con[favorit_cacheExpire]" value="{{ config['favorit_cacheExpire'] }}" class="form-control" />
					</td>
				</tr>
			</table>
		</div>
				
	</div></div>
	
		<!-- ########################## USERS TAB ########################## -->
		<div id="userTabs-users" class="tab-pane">
			<!-- TABLE AUTH -->
		<div class="panel panel-default">
		<div class="panel-heading">{{ lang['users'] }}</div>
		<div class="panel-body">{{ lang['auth'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['remember'] }} <small class="form-text text-muted">{{ lang['remember_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[remember]', 'value' : config['remember'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['auth_module'] }} <small class="form-text text-muted">{{ lang['auth_module_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[auth_module]', 'value' : config['auth_module'], 'values' : list['auth_module'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['auth_db'] }} <small class="form-text text-muted">{{ lang['auth_db_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[auth_db]', 'value' : config['auth_db'], 'values' : list['auth_db'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['auth_user'] }} <small class="form-text text-muted">{{ lang['auth_user_d'] }}</small></td>
					<td width="50%">
						<small class="form-text text-muted">{{ lang['auth_user_n'] }}</small><br>
						{% if (pluginIsActive('auth_basic')) %}
							<a class="btn btn-light" href="?mod=extra-config&plugin=auth_basic"><i class="fa fa-address-card"></i> {{ lang['auth_basic_n'] }}</a>
						{% endif %}
						{% if (pluginIsActive('auth_vb')) %}
							<a class="btn btn-light" href="?mod=extra-config&plugin=auth_vb"><i class="fa fa-address-card"></i> {{ lang['auth_vb_n'] }}</a>
						{% endif %}
						{% if (pluginIsActive('auth_punbb')) %}
							<a class="btn btn-light" href="?mod=extra-config&plugin=auth_punbb"><i class="fa fa-address-card"></i> {{ lang['auth_punbb_n'] }}</a>
						{% endif %}
					</td>
				</tr>
			</table>
		</div>
		<!-- END: TABLE AUTH -->

		<div class="panel-body">{{ lang['users'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['users_selfregister'] }} <small class="form-text text-muted">{{ lang['users_selfregister_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[users_selfregister]', 'value' : config['users_selfregister'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['register_type'] }} <small class="form-text text-muted">{{ lang['register_type_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[register_type]', 'value' : config['register_type'], 'values' : { 0 : lang['register_extremly'], 1 : lang['register_simple'], 2 : lang['register_activation'], 3 : lang['register_manual'], 4 : lang['register_manual_confirm']  } }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['reg_rules'] }} <small class="form-text text-muted">{{ lang['reg_rules_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[reg_rules]', 'value' : config['reg_rules'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['user_aboutsize'] }} <small class="form-text text-muted">{{ lang['user_aboutsize_desc'] }}</small></td>
					<td width="50%">
						<div class="input-group mb-3">
							<input type="text" name="save_con[user_aboutsize]" value="{{ config['user_aboutsize'] }}" class="form-control" style="max-width:100px; text-align: center;"/>
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-ellipsis-h"></i></label>
							</div>
						</div>
					</td>
				</tr>
				{% if (pluginIsActive('uprofile')) %}
				<tr>
					<td width="50%">{{ lang['user_profile'] }} <small class="form-text text-muted">{{ lang['user_profile_d'] }}</small></td>
					<td width="50%">
						<a class="btn btn-light" href="?mod=extra-config&plugin=uprofile"><i class="fa fa-user-circle-o"></i> {{ lang['user_profile_n'] }}</a>
					</td>
				</tr>
				{% endif %}
				<tr>
					<td width="50%">{{ lang['users_on_of_line'] }} <small class="form-text text-muted">{{ lang['users_on_of_line_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[on_of_line]', 'value' : config['on_of_line'] }) }}
					</td>
				</tr>
			</table>
		</div>	
		
		<div class="panel-body">{{ lang['users.avatars'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['use_avatars'] }} <small class="form-text text-muted">{{ lang['use_avatars_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[use_avatars]', 'value' : config['use_avatars'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['avatars_gravatar'] }} <small class="form-text text-muted">{{ lang['avatars_gravatar_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[avatars_gravatar]', 'value' : config['avatars_gravatar'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['avatars_url'] }} <small class="form-text text-muted">{{ lang['example'] }} http://server.com/uploads/avatars</small></td>
					<td width="50%">
						<input type="text" name="save_con[avatars_url]" value="{{ config['avatars_url'] }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['avatars_dir'] }} <small class="form-text text-muted">{{ lang['example'] }} /home/servercom/public_html/uploads/avatars/</small></td>
					<td width="50%">
						<input type="text" name="save_con[avatars_dir]" value="{{ config['avatars_dir'] }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['avatar_wh'] }} <small class="form-text text-muted">{{ lang['avatar_wh_desc'] }}</small></td>
					<td width="50%">	
						<div class="input-group mb-3">
							<input type="number" name="save_con[avatar_wh]" value="{{ config['avatar_wh'] }}" class="form-control" style="max-width:80px; text-align: center;"/>
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text">px</label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['avatar_max_size'] }} <small class="form-text text-muted">{{ lang['avatar_max_size_desc'] }}</small></td>
					<td width="50%">
						<div class="input-group mb-3">
							<input type="number" name="save_con[avatar_max_size]" value="{{ config['avatar_max_size'] }}" class="form-control" style="max-width:80px; text-align: center;"/>
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text">kb</label>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>	
		
		<div class="panel-body">{{ lang['users.photos'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['use_photos'] }} <small class="form-text text-muted">{{ lang['use_photos_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[use_photos]', 'value' : config['use_photos'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['photos_url'] }} <small class="form-text text-muted">{{ lang['example'] }} http://server.com/uploads/photos</small></td>
					<td width="50%">
						<input type="text" name="save_con[photos_url]" value="{{ config['photos_url'] }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['photos_dir'] }} <small class="form-text text-muted">{{ lang['example'] }} /home/servercom/public_html/uploads/photos/</small></td>
					<td width="50%">
						<input type="text" name="save_con[photos_dir]" value="{{ config['photos_dir'] }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['photos_max_size'] }} <small class="form-text text-muted">{{ lang['photos_max_size_desc'] }}</small></td>
					<td width="50%">
						<div class="input-group mb-3">
							<input type="number" name="save_con[photos_max_size]" value="{{ config['photos_max_size'] }}" class="form-control" style="max-width:80px; text-align: center;"/>
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text">kb</label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['photos_thumb_size'] }} <small class="form-text text-muted">{{ lang['photos_thumb_size_desc'] }}</small></td>
					<td width="50%">
						<div class="input-group mb-3">
							<input type="number" name="save_con[photos_thumb_size_x]" value="{{ config['photos_thumb_size_x'] }}" class="form-control" style="max-width:80px; text-align: center;"/>
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text">x</label>
							</div>
							<input type="number" name="save_con[photos_thumb_size_y]" value="{{ config['photos_thumb_size_y'] }}" class="form-control" style="max-width:80px; text-align: center;"/>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div></div>
	
		<!-- ########################## IMAGES TAB ########################## -->
		<div id="userTabs-imgfiles" class="tab-pane">
		<div class="panel panel-default">
		<div class="panel-heading">{{ lang['files'] }}/{{ lang['img'] }}</div>
		<div class="panel-body">{{ lang['files'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['files_url'] }} <small class="form-text text-muted">{{ lang['example'] }} http://server.com/uploads/files</small></td>
					<td width="50%">
						<input type="text" name="save_con[files_url]" value="{{ config['files_url'] }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['files_dir'] }} <small class="form-text text-muted">{{ lang['example'] }} /home/servercom/public_html/uploads/files/</small></td>
					<td width="50%">
						<input type="text" name="save_con[files_dir]" value="{{ config['files_dir'] }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['attach_url'] }} <small class="form-text text-muted">{{ lang['example'] }} http://server.com/uploads/dsn</small></td>
					<td width="50%">
						<input type="text" name="save_con[attach_url]" value="{{ config['attach_url'] }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['attach_dir'] }} <small class="form-text text-muted">{{ lang['example'] }} /home/servercom/public_html/uploads/dsn/</small></td>
					<td width="50%">
						<input type="text" name="save_con[attach_dir]" value="{{ config['attach_dir'] }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['files_ext'] }} <small class="form-text text-muted">{{ lang['files_ext_desc'] }}</small></td>
					<td width="50%">
						<input type="text" name="save_con[files_ext]" value="{{ config['files_ext'] }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['files_max_size'] }} <small class="form-text text-muted">{{ lang['files_max_size_desc'] }}</small></td>
					<td width="50%">
						<div class="input-group mb-3">
							<input type="number" name="save_con[files_max_size]" value="{{ config['files_max_size'] }}" class="form-control" style="max-width:80px; text-align: center;"/>
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text">kb</label>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
			
		<div class="panel-body">{{ lang['img'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['images_url'] }} <small class="form-text text-muted">{{ lang['example'] }} http://server.com/uploads/images</small></td>
					<td width="50%">
						<input type="text" name="save_con[images_url]" value="{{ config['images_url'] }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['images_dir'] }} <small class="form-text text-muted">{{ lang['example'] }} /home/servercom/public_html/uploads/images/</small></td>
					<td width="50%">
						<input type="text" name="save_con[images_dir]" value="{{ config['images_dir'] }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['images_ext'] }} <small class="form-text text-muted">{{ lang['images_ext_desc'] }}</small></td>
					<td width="50%">
						<input type="text" name="save_con[images_ext]" value="{{ config['images_ext'] }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['images_max_size'] }} <small class="form-text text-muted">{{ lang['images_max_size_desc'] }}</small></td>
					<td width="50%">
						<div class="input-group mb-3">
							<input type="number" name="save_con[images_max_size]" value="{{ config['images_max_size'] }}" class="form-control" style="max-width:100px; text-align: center;"/>
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text">kb</label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['images_dim_action'] }} <small class="form-text text-muted">{{ lang['images_dim_action#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[images_dim_action]', 'value' : config['images_dim_action'], 'values' : { 0 : lang['images_dim_action#0'], 1 : lang['images_dim_action#1'] } }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['images_max_dim'] }} <small class="form-text text-muted">{{ lang['images_max_dim#desc'] }}</small></td>
					<td width="50%">
						<div class="input-group mb-3">
							<input type="number" name="save_con[images_max_x]" value="{{ config['images_max_x'] }}" class="form-control" style="max-width:80px; text-align: center;"/>
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text">x</label>
							</div>
							<input type="number" name="save_con[images_max_y]" value="{{ config['images_max_y'] }}" class="form-control" style="max-width:80px; text-align: center;"/>
						</div>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['images_size_quality'] }} <small class="form-text text-muted">{{ lang['images_size_quality#desc'] }}</small></td>
					<td width="50%">
						<input type="number" name="save_con[images_size_quality]" value="{{ config['images_size_quality'] }}" class="form-control" style="max-width:80px; text-align: center;"/>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['images_url_width'] }} <small class="form-text text-muted">{{ lang['images_url_width#desc'] }}</small></td>
					<td width="50%">
						<div class="input-group mb-3">
							<input type="number" name="save_con[images_url_w]" value="{{ config['images_url_w'] }}" class="form-control" style="max-width:80px; text-align: center;"/>
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text">kb</label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['images_lazy'] }} <small class="form-text text-muted">{{ lang['images_lazy#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[images_lazy]', 'value' : config['images_lazy'] }) }}
					</td>
				</tr>
			</table>
		</div>
		
		<!-- IMAGE transform control -->
		<div class="panel-body">{{ lang['img.thumb'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['thumb_mode'] }} <small class="form-text text-muted">{{ lang['thumb_mode_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[thumb_mode]', 'value' : config['thumb_mode'], 'values' : { 0 : lang['mode_demand'], 1 : lang['mode_forbid'], 2 : lang['mode_always'] } }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['thumb_size'] }} <small class="form-text text-muted">{{ lang['thumb_size_desc'] }}</small></td>
					<td width="50%">
						<div class="input-group mb-3">
							<input type="number" name="save_con[thumb_size_x]" value="{{ config['thumb_size_x'] }}" class="form-control" style="max-width:80px; text-align: center;"/>
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text">x</label>
							</div>
							<input type="number" name="save_con[thumb_size_y]" value="{{ config['thumb_size_y'] }}" class="form-control" style="max-width:80px; text-align: center;"/>
						</div>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['thumb_quality'] }} <small class="form-text text-muted">{{ lang['thumb_quality_desc'] }}</small></td>
					<td width="50%">
						<input type="number" name="save_con[thumb_quality]" value="{{ config['thumb_quality'] }}" class="form-control" style="max-width:150px; text-align: center;"/>
					</td>
				</tr>
			</table>
		</div>
		
		<div class="panel-body">{{ lang['img.shadow'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['shadow_mode'] }} <small class="form-text text-muted">{{ lang['shadow_mode_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[shadow_mode]', 'value' : config['shadow_mode'], 'values' : { 0 : lang['mode_demand'], 1 : lang['mode_forbid'], 2 : lang['mode_always'] } }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['shadow_place'] }} <small class="form-text text-muted">{{ lang['shadow_place_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[shadow_place]', 'value' : config['shadow_place'], 'values' : { 0 : lang['mode_orig'], 1 : lang['mode_copy'], 2 : lang['mode_origcopy'] } }) }}
					</td>
				</tr>
			</table>
		</div>
		
		<div class="panel-body">{{ lang['img.stamp'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['stamp_mode'] }} <small class="form-text text-muted">{{ lang['stamp_mode_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[stamp_mode]', 'value' : config['stamp_mode'], 'values' : { 0 : lang['mode_demand'], 1 : lang['mode_forbid'], 2 : lang['mode_always'] } }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['stamp_place'] }} <small class="form-text text-muted">{{ lang['stamp_place_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[stamp_place]', 'value' : config['stamp_place'], 'values' : { 0 : lang['mode_orig'], 1 : lang['mode_copy'], 2 : lang['mode_origcopy'] } }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['wm_image'] }} <small class="form-text text-muted">{{ lang['wm_image_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelect({'name' : 'save_con[wm_image]', 'value' : config['wm_image'], 'values' : list['wm_image'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['wm_image_transition'] }} <small class="form-text text-muted">{{ lang['wm_image_transition_desc'] }}</small></td>
					<td width="50%">
						<input type="number" name="save_con[wm_image_transition]" value="{{ config['wm_image_transition'] }}" class="form-control" style="max-width:80px; text-align: center;"/>
					</td>
				</tr>
				<!-- END: IMAGE transform control -->
			</table>
		</div>
	</div></div>
	
		<!-- ########################## MULTI TAB ########################## -->
		<div id="userTabs-multi" class="tab-pane">
		<div class="panel panel-default">
		<div class="panel-heading">{{ lang['multi'] }}</div>
		<div class="panel-body">{{ lang['multi_info'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%" valign=top>{{ lang['mydomains'] }} <small class="form-text text-muted">{{ lang['mydomains_desc'] }}</small></td>
					<td width="50%">
						<textarea cols="45" rows="6" name="save_con[mydomains]" class="form-control">{{ config['mydomains'] }}</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
			</table>
		</div>
				
		<div class="panel-body">{{ lang['multisite'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td colspan=2>
						<table class="table table-striped">
							<thead>
								<tr>
									<th>{{ lang['status'] }}</th>
									<th>{{ lang['title'] }}</th>
									<th>{{ lang['domains'] }}</th>
									<th>{{ lang['flags'] }}</th>
								</tr>
							</thead>
							<tbody>
								{% for MR in multiConfig %}
								<tr>
									<td>{% if (MR['active']) %}On{% else %}Off{% endif %}</td>
									<td>{{ MR['key'] }}</td>
									<td>{% for domain in MR['domains'] %}{{ domain }}
										{% else %}- {{ lang['not_specified'] }} -{% endfor %}</td>
									<td>&nbsp;</td>
								</tr>
								{% else %}
								<tr>
									<td colspan="4">- {{ lang['not_used'] }} -</td>
								</tr>
								{% endfor %}
							</tbody>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</div></div>
	
		<!-- ########################## SEO TAB ########################## -->
		<div id="userTabs-seo" class="tab-pane">
		<div class="panel panel-default">
		<div class="panel-heading">{{ lang['seo'] }}</div>
		<div class="panel-body">{{ lang['meta'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['separator'] }} <small class="form-text text-muted">{{ lang['separator_desc'] }}</small></td>
					<td width="50%">
						<input name="save_con[separator]" type="text" value="{{ config['separator'] }}" class="form-control" style="max-width: 40px;text-align: center;"/>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['meta'] }} <small class="form-text text-muted">{{ lang['meta_desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[meta]', 'value' : config['meta'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['description'] }} <small class="form-text text-muted">{{ lang['description_desc'] }}</small></td>
					<td width="50%">
						<input type="text" name="save_con[description]" value="{{ config['description'] }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['keywords'] }} <small class="form-text text-muted">{{ lang['keywords_desc'] }}</small></td>
					<td width="50%">
						<input type="text" name="save_con[keywords]" value="{{ config['keywords'] }}" class="form-control" />
					</td>
				</tr>
			</table>
		</div>
		
		<div class="panel-body">{{ lang['canonical_configuration'] }}</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['canonical'] }} <small class="form-text text-muted">{{ lang['canonical#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'id' : 'canonical', 'value' : '0' }) }}
					</td>
				</tr>
			</table>
		</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr class="useCanonical">
					<td width="50%">{{ lang['canonical_main'] }} <small class="form-text text-muted">{{ lang['canonical_main#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[canonical_main]', 'value' : config['canonical_main'] }) }}
					</td>
				</tr>
				<tr class="useCanonical">
					<td width="50%">{{ lang['canonical_news'] }} <small class="form-text text-muted">{{ lang['canonical_news#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[canonical_news]', 'value' : config['canonical_news'] }) }}
					</td>
				</tr>
				<tr class="useCanonical">
					<td width="50%">{{ lang['canonical_static'] }} <small class="form-text text-muted">{{ lang['canonical_static#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[canonical_static]', 'value' : config['canonical_static'] }) }}
					</td>
				</tr>
				<tr class="useCanonical">
					<td width="50%">{{ lang['canonical_cat'] }} <small class="form-text text-muted">{{ lang['canonical_cat#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[canonical_cat]', 'value' : config['canonical_cat'] }) }}
					</td>
				</tr>
				<tr class="useCanonical">
					<td width="50%">{{ lang['canonical_sub_cat'] }} <small class="form-text text-muted">{{ lang['canonical_sub_cat#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[canonical_sub_cat]', 'value' : config['canonical_sub_cat'] }) }}
					</td>
				</tr>
				<tr class="useCanonical">
					<td width="50%">{{ lang['canonical_registr'] }} <small class="form-text text-muted">{{ lang['canonical_registr#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[canonical_registr]', 'value' : config['canonical_registr'] }) }}
					</td>
				</tr>
				<tr class="useCanonical">
					<td width="50%">{{ lang['canonical_lostpas'] }} <small class="form-text text-muted">{{ lang['canonical_lostpas#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[canonical_lostpas]', 'value' : config['canonical_lostpas'] }) }}
					</td>
				</tr>
				<tr class="useCanonical">
					<td width="50%">{{ lang['canonical_search'] }} <small class="form-text text-muted">{{ lang['canonical_search#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[canonical_search]', 'value' : config['canonical_search'] }) }}
					</td>
				</tr>
				<tr class="useCanonical">
					<td width="50%">{{ lang['canonical_404'] }} <small class="form-text text-muted">{{ lang['canonical_404#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectYN({'name' : 'save_con[canonical_404]', 'value' : config['canonical_404'] }) }}
					</td>
				</tr>
			</table>
		</div>

	</div></div>
	
		<!-- ########################## CACHE TAB ########################## -->
		<div id="userTabs-cache" class="tab-pane">
		<div class="panel panel-default">
		<div class="panel-heading">{{ lang['cache'] }}</div>
		<div class="panel-body">Memcached</div>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td width="50%">{{ lang['memcached_enabled'] }} <small class="form-text text-muted">{{ lang['memcached_enabled#desc'] }}</small></td>
					<td width="50%">
						{{ mkSelectNY({'name' : 'save_con[use_memcached]', 'value' : config['use_memcached'] }) }}
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['memcached_ip'] }} <small class="form-text text-muted">{{ lang['example'] }} localhost</small></td>
					<td width="50%">
						<input id="memcached_ip" type="text" name="save_con[memcached_ip]" value="{{ config['memcached_ip'] }}" class="form-control" style="max-width:150px; text-align: center;"/>
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['memcached_port'] }} <small class="form-text text-muted">{{ lang['example'] }} 11211</small></td>
					<td width="50%">
						<input id="memcached_port" type="text" name="save_con[memcached_port]" value="{{ config['memcached_port'] }}" class="form-control" style="max-width:150px; text-align: center;" />
					</td>
				</tr>
				<tr>
					<td width="50%">{{ lang['memcached_prefix'] }} <small class="form-text text-muted">{{ lang['example'] }} ng</small></td>
					<td width="50%">
						<input id="memcached_prefix" type="text" name="save_con[memcached_prefix]" value="{{ config['memcached_prefix'] }}" class="form-control" style="max-width:80px; text-align: center;" />
					</td>
				</tr>
				<tr>
					<td width="50%">&nbsp;</td>
					<td width="50%">
						<input type="button" value="{{ lang['btn_checkMemcached'] }}" class="btn btn-outline-primary" onclick="ngCheckMemcached(); return false;" />
					</td>
				</tr>
			</table>
		</div>
	</div>
	</div></div>
	
	<div class="form-group my-3 text-center">
		<button type="submit" class="btn btn-outline-success">{{ lang['save'] }}</button>
	</div>
</form>

<script type="text/javascript">
	$("#scrinimg").on('change', toggleScrin)
		.trigger('change');

	function toggleScrin(event) {
		$(".useScrin").toggle("1" === $("#scrinimg option:selected").val());
	}

	$("#canonical").on('change', toggleCanonical)
		.trigger('change');

	function toggleCanonical(event) {
		$(".useCanonical").toggle("1" === $("#canonical option:selected").val());
	}

	$("#favorit_active").on('change', toggleFavorit)
		.trigger('change');

	function toggleFavorit(event) {
		$(".useFavorit").toggle("1" === $("#favorit_active option:selected").val());
	}
	
	$("#mail_mode").on('change', toggleSmtp)
		.trigger('change');

	function toggleSmtp(event) {
		$(".useSMTP").toggle("smtp" === $("#mail_mode option:selected").val());
	}

	// Check DB connection
	function ngCheckDB() {
		post('admin.configuration.dbCheck', {
			'token': '{{ token }}',
			'dbtype': $("#db_dbtype").val(),
			'dbhost': $("#db_dbhost").val(),
			'dbname': $("#db_dbname").val(),
			'dbuser': $("#db_dbuser").val(),
			'dbpasswd': $("#db_dbpasswd").val(),
		});
	}

	// Check MEMCached connection
	function ngCheckMemcached() {
		post('admin.configuration.memcachedCheck', {
			'token': '{{ token }}',
			'ip': $("#memcached_ip").val(),
			'port': $("#memcached_port").val(),
			'prefix': $("#memcached_prefix").val(),
		});
	}

	// Send test e-mail message
	function ngCheckEmail() {
		post('admin.configuration.emailCheck', {
			'token': '{{ token }}',
			'mode': $("#mail_mode").val(),
			'from': {
				'name': $("#mail_fromname").val(),
				'email': $("#mail_frommail").val(),
			},
			'to': {
				'email': $("#mail_tomail").val(),
			},
			'smtp': {
				'host': $("#mail_smtp_host").val(),
				'port': $("#mail_smtp_port").val(),
				'auth': $("#mail_smtp_auth").val(),
				'login': $("#mail_smtp_login").val(),
				'pass': $("#mail_smtp_pass").val(),
				'secure': $("#mail_smtp_secure").val(),
			},
		});
	}
</script>