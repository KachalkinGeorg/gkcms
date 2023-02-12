<!-- Filter form: BEGIN -->
<div id="collapseUsersFilter" class="collapse">
	<div class="card mb-4">
		<div class="card-body">
			<form action="{{ php_self }}" method="get">
				<input type="hidden" name="mod" value="users" />
				<input type="hidden" name="action" value="list" />

				<div class="row">
					<!--Block 1-->
					<div class="col-lg-4">
						<div class="form-group">
							<label>{{ lang['name'] }}</label>
							<input type="text" name="name" value="{{ name }}" class="form-control" />
						</div>
					</div>

					<div class="col-lg-4">
						<div class="form-group">
							<label>{{ lang['mail'] }}</label>
							<input type="text" name="mail" value="{{ mail }}" class="form-control" />
						</div>
					</div>
					
					<!--Block 2-->
					<div class="col-lg-4">
						<div class="form-group">
							<label>{{ lang['group'] }}</label>
							<select name="group" class="custom-select">
								<option value="0">-- {{ lang['any'] }} --</option>
								{% for g in ugroup %}
								<option value="{{ g.id }}" {{ group == g.id ? 'selected' : ''}}>{{ g.name }}</option>
								{% endfor %}
							</select>
						</div>
					</div>

					<!--Block 3-->
					<div class="col-lg-4">
						<div class="form-group">
							<label>{{ lang['per_page'] }}&nbsp;</label>
							<input type="number" name="rpp" value="{{ rpp }}" class="form-control" />
						</div>

						<div class="form-group mb-0 text-right">
							<button type="submit" class="btn btn-outline-primary">{{ lang['sortit'] }}</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="panel panel-default">
  <div class="panel-heading">
  {{ lang['users_all'] }}
		<div class="panel-head-right">
			{% if flags.canModify %}
				<button type="button" class="btn2" data-toggle="modal" data-target="#adduserModal" title="{{ lang['adduser'] }}"><i class="fa fa-user-plus position-left"></i> {{ lang['adduser'] }}</button>
			{% endif %}
			<button type="button" class="btn2" data-toggle="collapse" data-target="#collapseUsersFilter" aria-expanded="false" aria-controls="collapseUsersFilter" title="{{ lang['filter'] }}">
				<i class="fa fa-filter"></i>
			</button>
		</div>
  </div>
<div class="panel-body">
<!-- Mass actions form: BEGIN -->
<form id="form_users" action="{{ php_self }}" method="get" name="form_users">
	<input type="hidden" name="token" value="{{ token }}" />
	<input type="hidden" name="mod" value="users" />
	<input type="hidden" name="name" value="{{ name }}" />
	<input type="hidden" name="how" value="{{ how_value }}" />
	<input type="hidden" name="sort" value="{{ sort_value }}" />
	<input type="hidden" name="page" value="{{ page_value }}" />
	<input type="hidden" name="per_page" value="{{ rpp }}" />

	<div class="card">

		<table class="table table-sm mb-0">
			<thead>
				<tr>
					<th width="5%">
						<a href="{{ sortLink['i']['link'] }}">#</a> {{ sortLink['i']['sign'] }}
					</th>
					<th width="20%">
						<a href="{{ sortLink['n']['link'] }}">{{ lang['name'] }}</a> {{ sortLink['n']['sign'] }}
					</th>
					<th width="20%">
						<a href="{{ sortLink['m']['link'] }}">{{ lang['mail'] }}</a> {{ sortLink['m']['sign'] }}
					</th>
					<th width="20%">
						<a href="{{ sortLink['r']['link'] }}">{{ lang['regdate'] }}</a> {{ sortLink['r']['sign'] }}
					</th>
					<th width="20%">
						<a href="{{ sortLink['l']['link'] }}">{{ lang['last_login'] }}</a> {{ sortLink['l']['sign'] }}
					</th>
					<th width="10%">
						<a href="{{ sortLink['p']['link'] }}">{{ lang['all_news2'] }}</a> {{ sortLink['p']['sign'] }}
					</th>
					{% if flags.haveComments %}
					<th width="10%">{l_listhead.comments}</th>
					{% endif %}
					<th width="15%">
						<a href="{{ sortLink['g']['link'] }}">{{ lang['groupName'] }}</a> {{ sortLink['g']['sign'] }}
					</th>
					<th width="5%">&nbsp;</th>
					<th width="5%">
						{% if flags.canModify %}
						<input type="checkbox" name="master_box" title="{l_select_all}" onclick="javascript:check_uncheck_all(form_users)" />
						{% endif %}
					</th>
				</tr>
			</thead>
			<tbody>
				{% for entry in entries %}
				<tr>
					<td>{{ entry.id }}</td>
					<td>
						{% if flags.canView %}
							<a href="{{ php_self }}?mod=users&action=editForm&id={{ entry.id }}">{{ entry.name }}</a>
						{% else %}
							{{ entry.name }}
						{% endif %}
					</td>
					<td>{{ entry.mail }}</td>
					<td>{{ entry.regdate }}</td>
					<td>{{ entry.lastdate }}</td>
					<td>
						{% if entry.cntNews > 0 %}
						<a href="{{ php_self }}?mod=news&aid={{ id }}">{{ entry.cntNews }}</a>
						{% else %}-{% endif %}
					</td>
					{% if flags.haveComments %}
					<td width="10%">
						{{ entry.cntComments ?: '-'}}
					</td>
					{% endif %}
					<td>{{ entry.groupName }}</td>
					<td>
						{% if entry.flags.isActive %}
							<i class="fa fa-check text-success" title="{{ lang['active'] }}"></i>
						{% else %}
							<i class="fa fa-times text-danger" title="{{ lang['unactive'] }}"></i>
						{% endif %}
					</td>
					<td>
						{% if (flags.canModify and flags.canMassAction) %}
							<input type="checkbox" name="selected_users[]" value="{{ entry.id }}" />
						{% endif %}
					</td>
				</tr>
				{% endfor %}
			</tbody>
		</table>

		<div class="card-footer">
			<div class="row">
				<div class="col-lg-6 mb-2 mb-lg-0">{{ pagination }}</div>

				<div class="col-lg-6">
					{% if flags.canModify %}
					<div class="input-group">
						<select name="action" class="custom-select">
							<option value="">-- {{ lang['action'] }} --</option>
							<option value="massActivate">{{ lang['activate'] }}</option>
							<option value="massLock">{{ lang['lock'] }}</option>
							<option value="" class="bg-light" disabled>===================</option>
							<option value="massDel">{{ lang['delete'] }}</option>
							<option value="massDelInactive">{{ lang['delete_unact'] }}</option>
							<option value="" class="bg-light" disabled>===================</option>
							<option value="massSetStatus">{{ lang['setstatus'] }} &raquo;</option>
						</select>
						<select name="newstatus" class="custom-select">
							<option value=""></option>
							{% for grp in ugroup|reverse %}
							<option value="{{ grp.id }}">{{ grp.id }} ({{ grp.name }})</option>
							{% endfor %}
						</select>

						<div class="input-group-append">
							<button type="submit" class="btn btn-outline-warning">{{ lang['submit'] }}</button>
						</div>
					</div>
					{% endif %}
				</div>
			</div>
		</div>
	</div>
</form>
<!-- Mass actions form: END -->

{% if flags.canModify %}
<div id="adduserModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="adduserModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form method="post" action="{{ php_self }}?mod=users">
				<input type="hidden" name="action" value="add" />
				<input type="hidden" name="token" value="{{ token }}" />

				<div class="modal-header">
					<h5 id="adduserModalLabel" class="modal-title">{{ lang.adduser }}</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>

				<div class="modal-body">
					<div class="form-group row">
						<label class="col-sm-4 col-form-label">{{ lang.name }}</label>
						<div class="col-sm-8">
							<input type="text" name="regusername" placeholder="Введите логин..." class="form-control" />
						</div>
					</div>
					
					<div class="form-group row">
						<label class="col-sm-4 col-form-label">{{ lang.alt_name }}</label>
						<div class="col-sm-8">
							<input type="text" name="regaltname" placeholder="Введите имя пользователя..." class="form-control" />
						</div>
					</div>
					
					<div class="form-group row">
						<label class="col-sm-4 col-form-label">{{ lang.gender }}</label>
						<div class="col-sm-8">
							<select name="reggender" class="custom-select">
								<option value="0">{{ lang.gender_0 }}</option>
								<option value="1">{{ lang.gender_1 }}</option>
								<option value="2">{{ lang.gender_2 }}</option>
							</select>
						</div>
					</div>
					
					<div class="form-group row">
						<label class="col-sm-4 col-form-label">{{ lang.password }}</label>
						<div class="col-sm-8">
							<input type="text" name="regpassword" class="form-control" />
						</div>
					</div>

					<div class="form-group row">
						<label class="col-sm-4 col-form-label">{{ lang.email }}</label>
						<div class="col-sm-8">
							<input type="email" name="regemail" class="form-control" />
						</div>
					</div>

					<div class="form-group row">
						<label class="col-sm-4 col-form-label">{{ lang.status }}</label>
						<div class="col-sm-8">
							<select name="reglevel" class="custom-select">
								{% for grp in ugroup %}
								<option value="{{ grp.id }}">{{ grp.id }} ({{ grp.name }})</option>
								{% endfor %}
							</select>
						</div>
					</div>
				</div>

				<div class="modal-footer">
					<button type="submit" class="btn btn-outline-success">{{ lang.adduser }}</button>
				</div>
			</form>
		</div>
	</div>
</div>
{% endif %}

{% if flags.canModify %}
<div id="add_edit_form" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<form method="post" action="admin.php?mod=users" class="form-horizontal">
				<input type="hidden" name="action" value="add">
				<input type="hidden" name="token" value="{{ token }}">
				
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4>{{ lang['adduser'] }}</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="regusername" class="col-sm-4">{{ lang['name'] }}</label>
						<div class="col-sm-8">
							<input type="text" name="regusername" id="regusername" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label for="regpassword" class="col-sm-4">{l_password}</label>
						<div class="col-sm-8">
							<input type="password" name="regpassword" id="regpassword" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label for="regemail" class="col-sm-4">{l_email}</label>
						<div class="col-sm-8">
							<input type="email" name="regemail" id="regemail" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label for="reglevel" class="col-sm-4">{l_status}</label>
						<div class="col-sm-8">
							<select name="reglevel" id="reglevel" class="form-control">
							{% for grp in ugroup %}
								<option value="{{ grp.id }}">{{ grp.id }} ({{ grp.name }})</option>
							{% endfor %}
							</select>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="cancel" class="btn btn-default" data-dismiss="modal">{{ lang['cancel'] }}</button>
					<button type="submit" class="btn btn-success">{l_adduser}</button>
				</div>
			</form>
		</div>
	</div>
</div>
{% endif %}

<script type="text/javascript">
	$(document).ready(function () {
		$('#form_users').on('input', function(event) {
			$(this.elements.newstatus).toggle(
				'massSetStatus' === $(this.elements.action).val()
			);
		})
		.on('submit', function(event) {
			event.preventDefault();

			var action = $(this.elements.action).val();
			var newstatus = $(this.elements.newstatus).val();

			if ('' == action) {
				return alert('Необходимо выбрать действие!');
			}

			if (('massSetStatus' == action) && !newstatus) {
				return alert(NGCMS.lang.msge_setstatus);
			}

			this.submit();
		})
		.trigger('input');
	});
</script>
</div></div>