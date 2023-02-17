<!-- Filter form: BEGIN -->
<div id="collapseStaticFilter" class="collapse">
	<div class="card mb-4">
	<div class="card-header">{{ lang['filter'] }}</div>
		<div class="card-body">
			<form action="{{ php_self }}" method="get" name="options_bar">
				<input type="hidden" name="mod" value="static" />

			<table class="table table-sm mb-0">
				<tr>				
					<td><label style="padding: .375rem 0rem .75rem 0rem;">{{ lang['per_page'] }}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-low-vision"></i></label>
							</div>
							<input type="number" name="per_page" value="{{ per_page }}" size="3" class="form-control" style="max-width:220px;vertical-align: text-bot;"/>
						</div>
					</td>
				</tr>	
			</table>
			
			<div class="panel-footer" align="center" style="margin-left: -20px;margin-right: -20px;margin-bottom: -20px;">
				<button type="submit" class="btn btn-outline-primary">{{ lang['do_show'] }}</button>
			</div>

			</form>
		</div>
	</div>
</div>

<!-- Mass actions form: BEGIN -->
<form action="{{ php_self }}?mod=static" method="post" name="static">
	<input type="hidden" name="token" value="{{ token }}" />


<div class="panel panel-default">
  <div class="panel-heading">
    {{ lang['static_title'] }}
	<div class="panel-head-right">
					{% if (perm.modify) %}
						<button type="button" class="btn2" onclick="document.location='?mod=static&action=addForm'; return false;" title="{{ lang['addstatic'] }}"><i class="fa fa-plus-circle" aria-hidden="true"></i> {{ lang['addstatic'] }}</button>
					{% endif %}
					<button type="button" class="btn2" data-toggle="collapse" data-target="#collapseStaticFilter" aria-expanded="false" aria-controls="collapseStaticFilter" title="{{ lang['filter'] }}">
						<i class="fa fa-filter"></i>
					</button>
	</div>
  </div>
<div class="panel-body">


		<div class="table-responsive">
			<table class="table table-sm mb-0">
				<thead>
					<tr>
						<th width="100">{{ lang['list.date'] }}</th>
						<th width="45%">{{ lang['title'] }}</th>
						<th nowrap>{{ lang['list.altname'] }}</th>
						<th>{{ lang['list.template'] }}</th>
						<th width="50">{{ lang['state'] }}</th>
						{% if (perm.modify) %}
							<th width="20">
								<input class="check" type="checkbox" name="master_box" title="{{ lang['select_all'] }}" onclick="javascript:check_uncheck_all(static)" />
							</th>
						{% endif %}
					</tr>
				</thead>
				<tbody>
					{% for entry in entries %}
						<tr>
							<td nowrap>{{ entry.date }}</td>
							<td nowrap>
								{% if (perm.details) %}
									<a title="ID: {{ entry.id }}" href="{{ php_self }}?mod=static&action=editForm&id={{ entry.id }}">
								{% endif %}
									{{ entry.title }}
								{% if (perm.details) %}</a>{% endif %}
								<br/>
								<small>{{ entry.url }}</small>
							</td>
							<td>{{ entry.alt_name }}</td>
							<td>{{ entry.template }}</td>
							<td>
								{{ entry.status }}
							</td>
							{% if (perm.modify) %}
								<td>
									<input name="selected[]" value="{{ entry.id }}" class="check" type="checkbox" />
								</td>
							{% endif %}
						</tr>
					{% else %}
						<tr>
							<td colspan="6"><p>- {{ lang['not_found'] }} -</p></td>
						</tr>
					{% endfor %}
				</tbody>
			</table>
		</div>
</div>
		<div class="card-footer">
			<div class="row">
				<div class="col-lg-6 mb-2 mb-lg-0">
					{{ pagesss }}
				</div>

				<div class="col-lg-6">
					{% if (perm.modify) %}
					<div class="input-group">
						<select name="action" class="custom-select">
							<option value="">-- {{ lang['action'] }} --</option>
							<option value="do_mass_delete">{{ lang['delete'] }}</option>
							<option value="do_mass_approve">{{ lang['approve'] }}</option>
							<option value="do_mass_forbidden">{{ lang['forbidden'] }}</option>
						</select>
						<div class="input-group-append">
							<button type="submit" class="btn btn-outline-warning">OK</button>
						</div>
					</div>
					{% endif %}
				</div>
			</div>
		</div>
	</div>
</form>