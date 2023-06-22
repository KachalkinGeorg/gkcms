<!-- Configuration errors -->
{% if (flags.confError) %}
<div class="alert alert-danger" role="alert">
	<h4 class="alert-heading mb-0">{{ lang['pconfig.error'] }}</h4>
</div>

<table class="table table-danger table-bordered">
	<thead>
		<tr>
			<th>{{ lang['perror.parameter'] }}</th>
			<th>{{ lang['perror.shouldbe'] }}</th>
			<th>{{ lang['perror.set'] }}</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Register Globals</td>
			<td>{{ lang['perror.off'] }}</td>
			<td>{{ flags.register_globals }}</td>
		</tr>
		<tr>
			<td>Magic Quotes GPC</td>
			<td>{{ lang['perror.off'] }}</td>
			<td>{{ flags.magic_quotes_gpc }}</td>
		</tr>
		<tr>
			<td>Magic Quotes Runtime</td>
			<td>{{ lang['perror.off'] }}</td>
			<td>{{ flags.magic_quotes_runtime }}</td>
		</tr>
		<tr>
			<td>Magic Quotes Sybase</td>
			<td>{{ lang['perror.off'] }}</td>
			<td>{{ flags.magic_quotes_sybase }}</td>
		</tr>
	</tbody>
</table>

<button type="button" class="btn btn-outline-danger" data-toggle="modal" data-target="#perror_resolve">{{ lang['perror.howto'] }}</button>

<div id="perror_resolve" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="perrorModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 id="perrorModalLabel" class="modal-title">{{ lang['perror.howto'] }}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			</div>

			<div class="modal-body">{{ lang['perror.descr'] }}</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-outline-dark" data-dismiss="modal">{{ lang['cancel'] }}</button>
			</div>
		</div>
	</div>
</div>
{% endif %}

<div class="panel panel-default">
  <div class="panel-card">
    {{ lang['site_link'] }}
  </div>
  <div class="media-bordered">
	
	<div class="row box-section">
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=configuration">
			<div class="media-left"><i class="fa fa-wrench fa-2x" aria-hidden="true"></i></div>
			<div class="media-body">
				<h6 class="media-heading  text-semibold">{{ lang['configuration'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['configuration_d'] }}</span>
			</div>
		</a>
	  </div>
	  
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=cron">
			<div class="media-left"><i class="fa fa-tasks fa-2x" aria-hidden="true"></i></div>
			<div class="media-body">
				<h6 class="media-heading  text-semibold">{{ lang['cron'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['cron_d'] }}</span>
			</div>
		</a>
	  </div>

	{% if (pluginIsActive('gsmg')) %}		
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=extra-config&plugin=gsmg">
			<div class="media-left"><i class="fa fa-sitemap fa-2x" aria-hidden="true"></i></div>
			<div class="media-body">
				<h6 class="media-heading  text-semibold">{{ lang['gsmg'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['gsmg_d'] }}</span>
			</div>
		</a>
	  </div>
	 {% endif %}
	 
	{% if (pluginIsActive('mapsite')) %}		
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=extra-config&plugin=mapsite">
			<div class="media-left"><i class="fa fa-sitemap fa-2x" aria-hidden="true"></i></div>
			<div class="media-body">
				<h6 class="media-heading  text-semibold">{{ lang['mapsite'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['mapsite_d'] }}</span>
			</div>
		</a>
	  </div>
	 {% endif %}
	 
	 {% if (pluginIsActive('turbo_yandex')) %}
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=extra-config&plugin=turbo_yandex">
			<div class="media-left"><i class="fa fa-rss-square fa-2x" aria-hidden="true"></i></div>
			<div class="media-body">
				<h6 class="media-heading  text-semibold">{{ lang['turbo_yandex'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['turbo_yandex_d'] }}</span>
			</div>
		</a>
	  </div>
	 {% endif %}
	 
	{% if (pluginIsActive('xfields')) %}		
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=extra-config&plugin=xfields">
			<div class="media-left"><i class="fa fa-list-alt fa-2x" aria-hidden="true"></i></div>
			<div class="media-body">
				<h6 class="media-heading  text-semibold">{{ lang['xfields'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['xfields_d'] }}</span>
			</div>
		</a>
	  </div>
	 {% endif %}

	 {% if (pluginIsActive('ads_pro')) %}
	  <div class="col-sm-6 media-list media-list-linked">
		<a class="media-link" href="?mod=extra-config&plugin=ads_pro">
			<div class="media-left"><i class="fa fa-television fa-2x" aria-hidden="true"></i></div>
			<div class="media-body">
				<h6 class="media-heading  text-semibold">{{ lang['ads_pro'] }}</h6>
				<span class="text-muted text-size-small">{{ lang['ads_pro_d'] }}</span>
			</div>
		</a>
	  </div>
	 {% endif %}
	 
	 </div>
	 
  </div>
</div>

<div class="panel panel-default">
		
	<div class="panel-heading" style="padding: 0px;margin-bottom: 0;">
		<ul class="nav nav-tabs nav-fill">
			<li class="nav-item"><a href="#server" data-toggle="tab" class="nav-link active"><span data-toggle="popover" data-placement="top" data-trigger="hover focus" data-content="{{ lang['system'] }}"><i class="fa fa-bar-chart position-left"></i> {{ lang['system'] }}</span></a></li>
			<li class="nav-item"><a href="#note" data-toggle="tab" class="nav-link"><span data-toggle="popover" data-placement="top" data-trigger="hover focus" data-content="{{ lang['note'] }}"><i class="fa fa-pencil-square-o position-left"></i> {{ lang['note'] }}</span></a></li>
			<li class="nav-item"><a href="#statauto" data-toggle="tab" class="nav-link"><span data-toggle="popover" data-placement="top" data-trigger="hover focus" data-content="{{ lang['server'] }}"><i class="fa fa-cog position-left"></i> {{ lang['server'] }}</span></a></li>
		</ul>
	</div>
	
	<div class="panel-body">
		<div class="tab-content">
		
		<div class="tab-pane show active" id="server">
			<table class="table table-sm mb-0">
				<tbody>
					<tr>
						<td class="col-md-3">{{ lang['site_regim'] }}</td>
						<td class="col-md-9">{{ offline }}</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['all_cats'] }}</td>
						<td class="col-md-9">{{ categories }}</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['all_news'] }}</td>
						<td class="col-md-9">
							<a href="{{ php_self }}?mod=news&status=1">{{ news_draft }}</a> / <a href="{{ php_self }}?mod=news&status=2">{{ news_unapp }}</a> / <a href="{{ php_self }}?mod=news&status=3">{{ news }}</a>
						</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['all_comments'] }}</td>
						<td class="col-md-9">{{ comments }}&nbsp;&nbsp;[<a href="{{ php_self }}?mod=lastcomments">{{ lang['showcomments'] }}</a>]</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['all_users'] }}</td>
						<td class="col-md-9">{{ users }}</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['all_users_unact'] }}</td>
						<td class="col-md-9">{{ users_unact }}</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['all_images'] }}</td>
						<td class="col-md-9">{{ images }}</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['all_files'] }}</td>
						<td class="col-md-9">{{ files }}</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['mysql_size'] }}</td>
						<td class="col-md-9">{{ mysql_size }}</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['max_upload'] }}</td>
						<td class="col-md-9">{{ maxupload }}</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['free_space'] }}</td>
						<td class="col-md-9">{{ freespace }}</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['cache.size'] }}</td>
						<td class="col-md-9"><div id="cacheFileCount">-</div> <div id="cacheSize">-</div></td>
					</tr>
				</tbody>   
			</table>
			<div class="panel-footer" style="margin-left: -20px;margin-right: -20px;margin-bottom: -20px;">
				<button type="button" onclick="return getCacheSize();" class="btn btn-outline-primary">{{ lang['cache.calculate'] }}</button>&nbsp;
				<button type="button" onclick="return clearCache();" class="btn btn-outline-primary"><i class="fa fa-trash"></i> {{ lang['cache.clean']}}</button>
			</div>
		</div>
		
		<div class="tab-pane has-padding" id="note">
			<form method="post" action="{{ php_self }}">
				<input type="hidden" name="action" value="save" />
				<textarea name="note" rows="6" cols="70" class="form-control mb-3" style="width:100%;height:200px;background-color: lightyellow;" placeholder="{{ lang['no_notes'] }}">{{ admin_note }}</textarea>
				<button type="submit" class="btn btn-outline-success"><i class="fa fa-floppy-o"></i> {{ lang['save_note'] }}</button>
			</form>
		</div>
		
		<div class="tab-pane" id="statauto">
			<table class="table table-sm mb-0">
				<tbody>
					<tr>
						<td class="col-md-3">{{ lang['os'] }}</td>
						<td class="col-md-9">{{ php_os }}</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['management'] }}</td>
						<td class="col-md-9">{{ os_version }}</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['allocated'] }}</td>
						<td class="col-md-9">{{ maxmemory }}</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['off_fun'] }}</td>
						<td class="col-md-9">{{ disabledfunctions }}</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['save_mode'] }}</td>
						<td class="col-md-9">{{ safemode }}</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['mod_rewrite'] }}</td>
						<td class="col-md-9">{{ mod_rewrite }}</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['php_version'] }}</td>
						<td class="col-md-9">{{ php_version }}</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['mysql_version'] }}</td>
						<td class="col-md-9">{{ mysql_version }}</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['pdo_support'] }}</td>
						<td class="col-md-9">{{ pdo_support }}</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['gd_version'] }}</td>
						<td class="col-md-9">{{ gd_version }}</td>
					</tr>
					<tr>
						<td class="col-md-3">{{ lang['gd'] }}</td>
						<td class="col-md-9">{{ gdversion }}</td>
					</tr>
				</tbody>   
			</table>
		</div>
		
		</div>
	</div>
</div>



<script type="text/javascript">
	function getCacheSize() {
		$("#cacheFileCount").html('-');
		$("#cacheSize").html('-');
		post('admin.statistics.getCacheSize', {'token':'{{ token }}'}, false)
				.then(function(response) {
					if (response.numFiles) {
						$("#cacheFileCount").html(response.numFiles);
						$("#cacheSize").html(response.size);
					}
				ngNotifySticker('{{ lang['cache.done'] }}', {className: 'stickers-success'});
				});
		return false;
	}

	function clearCache() {
		$("#cacheFileCount").html('-');
		$("#cacheSize").html('-');
		post('admin.statistics.cleanCache', {'token':'{{ token }}'}, false)
				.then(function(response) {
					getCacheSize();
					ngNotifySticker('{{ lang['cache.sucs'] }}', {className: 'stickers-success'});
				});
		return false;
	}
</script>