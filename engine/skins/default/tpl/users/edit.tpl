<form action="{{ php_self }}?mod=users" method="post"  enctype="multipart/form-data">
	<input type="hidden" name="token" value="{{ token }}" />
	<input type="hidden" name="action" value="edit" />
	<input type="hidden" name="id" value="{{ id }}" />

	<div class="row">
		<!-- Left edit column -->
		<div class="col-lg-8">

			<!-- MAIN CONTENT -->
			<div id="maincontent" class="panel panel-default mb-4">
			<div class="panel-heading">
				<i class="fa fa-id-card-o"></i> {{ name }}
			</div>
				<div class="panel-body">
					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">
							<img src="{{ photo }}" style="max-width: 50%;" alt="{{ users }}">
						</label>
						<div class="col-lg-9">
							<i>{{ inform }}</i>
						</div>
					</div>
					<hr>
					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">{{ lang['groupName'] }}</label>
						<div class="col-lg-9">
							<div style="max-width:250px;"><select name="status" class="custom-select">
								{{ status }}
							</select></div>
						</div>
					</div>

					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">{{ lang['alt_name'] }}</label>
						<div class="col-lg-9">
						<div class="input-group mb-3">
							<input type="text" name="alt_name" value="{{ alt_name }}" placeholder="{{ lang['alt_name'] }}" maxlength="40" class="form-control" style="max-width:250px;" />
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-id-badge"></i></label>
							</div>
						</div>
						</div>
					</div>
					
					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">{{ lang['new_pass'] }}</label>
						<div class="col-lg-9">
						<div class="input-group mb-3">
							<input type="text" name="password" placeholder="*****" maxlength="40" class="form-control" style="max-width:250px;" />
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-ellipsis-h"></i></label>
							</div>
						</div>
						<small class="form-text text-muted">{{ lang['pass_left'] }}</small>
						</div>
					</div>

					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">{{ lang['email'] }}</label>
						<div class="col-lg-9">
						<div class="input-group mb-3">
							<input type="email" name="mail" value="{{ mail }}" placeholder="{{ lang['email'] }}" class="form-control" style="max-width:250px;" />
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-envelope-o"></i></label>
							</div>
						</div>
						</div>
					</div>

					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">{{ lang['gender'] }}</label>
						<div class="col-lg-9">
							<div style="max-width:250px;">{{ gender }}</div>
						</div>
					</div>
					
					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">{{ lang['site'] }}</label>
						<div class="col-lg-9">
						<div class="input-group mb-3">
							<input type="text" name="site" value="{{ site }}" placeholder="{{ lang['site'] }}" class="form-control" style="max-width:250px;" />
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-sitemap"></i></label>
							</div>
						</div>
						</div>
					</div>
					
					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">{{ lang['icq'] }}</label>
						<div class="col-lg-9">
						<div class="input-group mb-3">
							<input type="text" name="icq" value="{{ icq }}" placeholder="{{ lang['icq'] }}" maxlength="10" class="form-control" style="max-width:250px;" />
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-smile-o"></i></label>
							</div>
						</div>
						</div>
					</div>

					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">{{ lang['from'] }}</label>
						<div class="col-lg-9">
						<div class="input-group mb-3">
							<input type="text" name="where_from" value="{{ where_from }}" placeholder="{{ lang['from'] }}" maxlength="40" class="form-control" style="max-width:250px;" />
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-globe"></i></label>
							</div>
						</div>
						</div>
					</div>

					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">{{ lang['about'] }}</label>
						<div class="col-lg-9">
							<textarea name="info" class="form-control" rows="7" cols="60">{{ info }}</textarea>
						</div>
					</div>
					<hr>
					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">{{ lang['uplphoto'] }}</label>
						<div class="col-lg-9">
						{% if (flags.photoAllowed) %}
							{% if (flags.hasPhoto) %}
								<img src="{{ photo }}" style="max-width: 50%;" alt="{{ users }}">
								<input type="checkbox" name="delphoto" id="delphoto"/>&nbsp;{{ lang['del'] }}<br /><br />
							{% endif %}
							<div class="btn btn-default btn-light btn-fileinput"><span><i class="fa fa-user-circle-o"></i> {{ lang['uplphoto'] }}</span>
								<input type="file" name="newphoto" size="40" />
							</div>
							<br />
						{% else %}
							{{ lang['photos_denied'] }}
						{% endif %}
						</div>
					</div>
					<hr>
					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">{{ lang['uplavatar'] }}</label>
						<div class="col-lg-9">
						{% if (flags.avatarAllowed) %}
							{% if (flags.hasAvatar) %}
								<img src="{{ avatar }}" style="max-width: 50%;" alt="{{ users }}">
								<input type="checkbox" name="delavatar" id="delavatar" />&nbsp;{{ lang['del'] }}<br /><br />
							{% endif %}
							<div class="btn btn-default btn-light btn-fileinput"><span><i class="fa fa-user-circle"></i> {{ lang['uplavatar'] }}</span>
								<input type="file" name="newavatar" size="40" />
							</div>
							<br />
						{% else %}
							{{ lang['photos_denied'] }}
						{% endif %}
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Right edit column -->
		<div id="rightBar" class="col col-lg-4">
			<div class="card mb-4">

			<div class="user_bar user_bg">
				<div class="user_avatar">
					<img src="{{ avatar }}" class="img-circle" alt="{{ users }}">
					<h6>{{ name }}</h6>
					<span>{{ group }}</span>
				</div>
				<div class="user_content">
					<ul class="user_stats">
						<li><h4>{{ news }}<span class="sub-heading">Публикаций</span></h4></li>
						<li><h4>{{ com }}<span class="sub-heading">Комментариев</span></h4></li>
					</ul>
				</div>
			</div>
			<div class="row mb-0" style="padding:10px">
				<div class="col-sm-6">E-Mail</div>
				<div class="col-sm-6" style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;" data-original-title="{{ mail }}">{{ mail }}</div>
			</div>
			<div class="row mb-0" style="padding:10px">
				<div class="col-sm-6">{{ lang['regdate'] }}</div>
				<div class="col-sm-6">{{ regdate }}</div>
			</div>
			<div class="row mb-0" style="padding:10px">
				<div class="col-sm-6">{{ lang['last_login'] }}</div>
				<div class="col-sm-6">{{ last }}</div>
			</div>
			<div class="row mb-0" style="padding:10px">
				<div class="col-sm-6">Статус</div>
				<div class="col-sm-6"><span class="text-success">{{ line }}</span></div>
			</div>
			<div class="row mb-0" style="padding:10px">
				<div class="col-sm-6">{{ lang['last_ip'] }}</div>
				<div class="col-sm-6">{{ ip }} <a href="https://www.nic.ru/whois/?searchWord={{ ip }}" target="_blank" title="{{ lang['whois'] }}"><i class="fa fa-question-circle"></i></a></div>
			</div>
			<div class="row mb-0" style="padding:10px">
				<div class="col-sm-6">{{ lang['alt_name'] }}</div>
				<div class="col-sm-6">{{ alt_name }}</div>
			</div>

			</div>
		</div>
	</div>

	<div class="row">
		<div class="col col-lg-8">
			<div class="row">
				{% if (perm.modify) %}
					<div class="col-md-6 mb-4">
						<button type="button" class="btn btn-outline-dark" onclick="history.back();">
							{{ lang['cancel'] }}
						</button>
					</div>

					<div class="col-md-6 mb-4 text-right">
						<button type="submit" class="btn btn-outline-success">
							<span class="d-xl-none"><i class="fa fa-floppy-o"></i></span>
							<span class="d-none d-xl-block">{{ lang['save'] }}</span>
						</button>
					</div>
				{% endif %}
			</div>
		</div>
	</div>
</form>

{% if (pluginIsActive('xfields')) %}
<div class="row my-5">
	<div class="col-lg-8">
		<div class="panel panel-default">
			<div class="panel-heading">{{ lang['xf_prof'] }}</div>
			<div class="panel-body">
			<table class="table table-sm">
				<thead>
					<tr>
						<th>{{ lang['xf_id'] }}</th>
						<th>{{ lang['xf_pole'] }}</th>
						<th>{{ lang['xf_poletyp'] }}</th>
						<th>{{ lang['xf_block'] }}</th>
						<!-- <th>V</th> -->
						<th>{{ lang['xf_value'] }}</th>
					</tr>
				</thead>
				<tbody>
					{% for xFN,xfV in p.xfields.fields %}
					<tr>
						<td>{{ xFN }}</td>
						<td>{{ xfV.title }}</td>
						<td>{{ xfV.data.type }}</td>
						<td>{{ xfV.data.area }}</td>
						<!-- 	<td>{% if (xfV.data.type == "select") and (xfV.data.storekeys) %}<span style="font-color: red;"><b>{{ xfV.secure_value }}{% else %}&nbsp;{% endif %}</td> -->
						<td>{{ xfV.input }}</td>
					</tr>
					{% endfor %}
				</tbody>
			</table>
			</div>
		</div>
	</div>
</div>
{% endif %}