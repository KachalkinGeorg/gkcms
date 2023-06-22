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
				<button type="button" class="btn btn-outline-dark" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
{% endif %}

	<div class="row">
		<div class="col-lg-3 col-xs-6">
			<a href="admin.php?mod=news" class="small-box bg-info">
				<div class="inner">
				<script>
function scroll(val,el,timeout,step){
var i=0;
(function(){
if(i<=val){
setTimeout(arguments.callee,timeout);
document.getElementById(el).innerHTML=i;
i=i+step;
}else{
document.getElementById(el).innerHTML=val;
}
})();
}
scroll({{ news_draft + news_unapp + news }},'shethik-cifra',1,2);
</script>
					<h3><div id="shethik-cifra"></div></h3>
					<p>{{ lang['news'] }}</p>
				</div>
				<i class="fa fa-newspaper-o"></i>
			</a>
		</div>
		<div class="col-lg-3 col-xs-6">
			<a href="admin.php?mod=images" class="small-box bg-success">
				<div class="inner">
					<script>
function scroll(val,el,timeout,step){
var i=0;
(function(){
if(i<=val){
setTimeout(arguments.callee,timeout);
document.getElementById(el).innerHTML=i;
i=i+step;
}else{
document.getElementById(el).innerHTML=val;
}
})();
}
scroll({{ images }},'images',1,10);
</script>
					<h3><div id="images"></div></h3>
					<p>{{ lang['images'] }}</p>
				</div>
				<i class="fa fa-picture-o"></i>
			</a>
		</div>
		<div class="col-lg-3 col-xs-6">
			<a href="admin.php?mod=files" class="small-box bg-warning">
				<div class="inner">
					<script>
function scroll(val,el,timeout,step){
var i=0;
(function(){
if(i<=val){
setTimeout(arguments.callee,timeout);
document.getElementById(el).innerHTML=i;
i=i+step;
}else{
document.getElementById(el).innerHTML=val;
}
})();
}
scroll({{ files }},'files',1,2);
</script>
					<h3><div id="files"></div></h3>
					<p>{{ lang['files'] }}</p>
				</div>
				<i class="fa fa-file-text-o"></i>
			</a>
		</div>
		<div class="col-lg-3 col-xs-6">
			<a href="admin.php?mod=users" class="small-box bg-danger">
				<div class="inner">
					<script>
function scroll(val,el,timeout,step){
var i=0;
(function(){
if(i<=val){
setTimeout(arguments.callee,timeout);
document.getElementById(el).innerHTML=i;
i=i+step;
}else{
document.getElementById(el).innerHTML=val;
}
})();
}
scroll({{ users }},'users',1,2);
</script>
					<h3><div id="users"></div></h3>
					<p>{{ lang['users'] }}</p>
				</div>
				<i class="fa fa-user"></i>
			</a>
		</div>
	</div>
	
<div class="row">
	<div class="col-md-6 mb-3">
		<div class="panel panel-default">
			<h5 class="panel-heading font-weight-light">{{ lang['server'] }}</h5>
			<div class="panel-body">
			<table class="table table-sm mb-0">
				<tbody>
					<tr>
						<td>{{ lang['os'] }}</td>
						<td>{{ php_os }}</td>
					</tr>
					<tr>
						<td>{{ lang['php_version'] }}</td>
						<td>{{ php_version }}</td>
					</tr>
					<tr>
						<td>{{ lang['mysql_version'] }}</td>
						<td>{{ mysql_version }}</td>
					</tr>
					<tr>
						<td>{{ lang['pdo_support'] }}</td>
						<td>{{ pdo_support }}</td>
					</tr>
					<tr>
						<td>{{ lang['gd_version'] }}</td>
						<td>{{ gd_version }}</td>
					</tr>
				</tbody>
			</table>
			</div>
		</div>
	</div>

	<div class="col-md-6 mb-3">
		<div class="panel panel-default">
			<h5 class="panel-heading font-weight-light">Next Generation CMS</h5>
			<div class="panel-body">
			<table class="table table-sm mb-0">
				<tbody>
					<tr>
						<td>{{ lang['current_version'] }}</td>
						<td>{{ currentVersion }}</td>
					</tr>
					<tr>
						<td>{{ lang['last_version'] }}</td>
						<td><span id="syncLastVersion">loading..</span></td>
					</tr>
					<tr>
						<td>{{ lang['git_version'] }}</td>
						<td><span id="syncGKVersion">loading..</span></td>
					</tr>
				</tbody>
			</table>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-md-6 mb-3">
		<div class="panel panel-default">
			<h5 class="panel-heading font-weight-light">{{ lang['size'] }}</h5>
			<div class="panel-body">
			<table class="table table-sm mb-0">
				<thead>
					<tr>
						<th>{{ lang['group'] }}</th>
						<th>{{ lang['amount'] }}</th>
						<th>{{ lang['volume'] }}</th>
						<th>{{ lang['permissions'] }}</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>{{ lang['group_images'] }}</td>
						<td>{{ image_amount }}</td>
						<td>{{ image_size }}</td>
						<td>{{ image_perm }}</td>
					</tr>
					<tr>
						<td>{{ lang['group_files'] }}</td>
						<td>{{ file_amount }}</td>
						<td>{{ file_size }}</td>
						<td>{{ file_perm }}</td>
					</tr>
					<tr>
						<td>{{ lang['group_photos'] }}</td>
						<td>{{ photo_amount }}</td>
						<td>{{ photo_size }}</td>
						<td>{{ photo_perm }}</td>
					</tr>
					<tr>
						<td>{{ lang['group_avatars'] }}</td>
						<td>{{ avatar_amount }}</td>
						<td>{{ avatar_size }}</td>
						<td>{{ avatar_perm }}</td>
					</tr>
					<tr>
						<td>{{ lang['group_backup'] }}</td>
						<td>{{ backup_amount }}</td>
						<td>{{ backup_size }}</td>
						<td>{{ backup_perm }}</td>
					</tr>
					<tr>
						<td colspan="2">{{ lang['allowed_size'] }}</td>
						<td colspan="2">{{ allowed_size }}</td>
					</tr>
					<tr>
						<td colspan="2">{{ lang['mysql_size'] }}</td>
						<td colspan="2">{{ mysql_size }}</td>
					</tr>
					<tr>
						<td>{{ lang['cache.size'] }}</td>
						<td id="cacheFileCount">-</td>
						<td id="cacheSize">-</td>
						<td class="text-right">
							<div class="btn-group btn-group-sm" role="group">
								<button type="button" onclick="return getCacheSize();" class="btn btn-outline-primary">{{ lang['cache.calculate'] }}</button>
								<button type="button" onclick="return clearCache();" class="btn btn-outline-primary">{{ lang['cache.clean']}}</button>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			</div>
		</div>
	</div>

	<div class="col-md-6 mb-3">
		<div class="panel panel-default">
			<h5 class="panel-heading font-weight-light">{{ lang['system'] }}</h5>
			<div class="panel-body">
			<table class="table table-sm mb-0">
				<tbody>
					<tr>
						<td>{{ lang['all_cats'] }}</td>
						<td>{{ categories }}</td>
					</tr>
					<tr>
						<td>{{ lang['all_news'] }}</td>
						<td>
							<a href="{{ php_self }}?mod=news&status=1">{{ news_draft }}</a> / <a href="{{ php_self }}?mod=news&status=2">{{ news_unapp }}</a> / <a href="{{ php_self }}?mod=news&status=3">{{ news }}</a>
						</td>
					</tr>
					<tr>
						<td>{{ lang['all_comments'] }}</td>
						<td>{{ comments }} {% if (pluginIsActive('show_comments')) %}&nbsp;[<a href="{{ php_self }}?mod=extra-config&plugin=show_comments">{{ lang['show_comments'] }}</a>]{% endif %}</td>
					</tr>
					<tr>
						<td>{{ lang['all_users'] }}</td>
						<td>{{ users }}</td>
					</tr>
					<tr>
						<td>{{ lang['all_users_unact'] }}</td>
						<td>{{ users_unact }}</td>
					</tr>
					<tr>
						<td>{{ lang['all_images'] }}</td>
						<td>{{ images }}</td>
					</tr>
					<tr>
						<td>{{ lang['all_files'] }}</td>
						<td>{{ files }}</td>
					</tr>
				</tbody>
			</table>
			</div>
		</div>
	</div>
</div>

<div class="panel panel-default">
	<h5 class="panel-heading font-weight-light">{{ lang['note'] }}</h5>

	<div class="panel-body">
		<form method="post" action="{{ php_self }}?mod=statistics">
			<input type="hidden" name="action" value="save" />

			<textarea name="note" rows="6" cols="70" class="form-control mb-3" style="background-color: lightyellow;" placeholder="{{ lang['no_notes'] }}">{{ admin_note }}</textarea>

			<button type="submit" class="btn btn-outline-success">{{ lang['save_note'] }}</button>
		</form>
	</div>
</div>

<!-- Не понятно, что это и откуда. -->
<style>
	#modalmsgDialog {
		position: absolute;
		left: 0;
		top: 0;
		width: 100%;
		height: 100%;
		display: none;
	}

	#modalmsgWindow {
		margin: 5px;
		padding: 5px;
		border: 1px solid #CCCCCC;
		background-color: #F0F0F0;
		width: 400px;
		position: absolute;
		left: 40%;
		top: 40%;
	}

	#modalmsgWindowText {
		background-color: #FFFFFF;
	}

	#modalmsgWindowButton {
		background-color: #FFFFFF;
		text-align: center;
		padding: 5px;
	}
</style>

<script type="text/javascript">
	function showModal(text) {
		document.getElementById('modalmsgDialog').style.display = 'block';
		document.getElementById('modalmsgWindowText').innerHTML = text;
	}

	function _modal_close() {
		document.getElementById('modalmsgDialog').style.display = 'none';
	}
</script>

<div id="modalmsgDialog" onclick="_modal_close();">
	<span id="modalmsgWindow">
		<div id="modalmsgWindowText"></div>
		<div id="modalmsgWindowButton">
			<input type="button" value="OK" />
		</div>
	</span>
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
				});
		return false;
	}

	function clearCache() {
		$("#cacheFileCount").html('-');
		$("#cacheSize").html('-');
		post('admin.statistics.cleanCache', {'token':'{{ token }}'}, false)
				.then(function(response) {
					getCacheSize();
				});
		return false;
	}

	function coreVersionSync() {
		post('admin.statistics.coreVersionSync', {'token':'{{ token }}'}, false)
				.then(function(response) {
				});
		return false;
	}
</script>
<script>
	$(function () {
		var reqReleas = "{{ gkreleas }}";
		requestJSON(reqReleas, function (json) {
			if (json.message == "Not Found") {
				$('#syncLastVersion').html("No Info Found");
			} else {
				var currentVersion = '{{ currentVersion }}';
				var engineVersionBuild = '{{ engineVersionBuild }}';
				var publish = json.published_at;
				if (currentVersion >= json.tag_name && engineVersionBuild >= publish.split('T')[0]) {
					$('#needUpdate').html('{{ lang['update_no_cms'] }}');
				} else {
					$('#needUpdate').html('{{ lang['update_cms'] }}');
				}
				$('#syncLastVersion').html('<a href="' + json.zipball_url + '">' + json.tag_name + '</a> [ ' + json.published_at.slice(0, 10) + ' ]');
			}
		});

		var reqCommit = "{{ gkcommits }}";
		requestJSON(reqCommit, function (json) {
			if (json.message == "Not Found") {
				$('#syncGKVersion').html("No Info Found");
			} else {
				$('#syncGKVersion').html('<i class="fa fa-git-square"></i> <a href="' + json[0].html_url + '" target="_blank">' + json[0].sha.slice(0, 7) + '</a> \
                <b><i class="fa fa-github"></i></b> <a href="'+ json[0].committer.html_url + '" target="_blank">' + json[0].committer.login + '</a> [ ' +
					json[0].commit.author.date.slice(0, 10) + ' ]');
				/*$('#syncGKVersion').html('<a href="#" id="compare">{{ lang['update_git'] }}</a> [ '+json[0].commit.author.date.slice(0, 10) + ' ]');*/
			}
		});

		coreVersionSync();

		function requestJSON(url, callback) {
			$.ajax({
				url: url,
				beforeSend: function (jqXHR) {
					jqXHR.overrideMimeType("application/json; charset=UTF-8");
					// Repeat send header ajax
					jqXHR.setRequestHeader("X-Requested-With", "XMLHttpRequest");
				},
			})
				.done(function (data, textStatus, jqXHR) {
					if (typeof (data) == 'object') {
						callback.call(null, data);
					} else {
						$.notify({ message: '{{ lang['bad_done'] }}' }, { type: 'danger' });
					}
				})
				.catch(function (jqXHR) {
					if (0 === jqXHR.status || jqXHR.status >= 400)
						$.notify({ message: '{{ lang['bad_server'] }}' }, { type: 'danger' });
						$('#syncLastVersion').html("{{ lang['bad_info'] }}");
						$('#syncGKVersion').html("{{ gknotfound }}");
				});
		}
	});
</script>