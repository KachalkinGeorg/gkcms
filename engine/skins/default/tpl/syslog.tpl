<div id="collapseSysLogFilter" class="collapse">
	<div class="card mb-4">
	<div class="card-header">{{ lang['filter'] }}</div>
		<div class="card-body">
		<form action="{{ php_self }}" method="get">
			<input type="hidden" name="mod" value="syslog" />
	
			<table class="table table-sm mb-0">
				<tr>
					<td><label style="padding: .375rem 0rem .75rem 0rem;">{{ lang['sys_users'] }}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-user-o"></i></label>
							</div>
							<input name="name" id="name" type="text" value="{{name}}" autocomplete="off" placeholder="{{ lang['sys_users'] }}..." class="form-control" style="max-width:220px;"/> <span id="suggestLoader" style="width: 20px; visibility: hidden;"></span>
						</div>
					</td>
					<td><label style="padding: .375rem 0rem .75rem 0rem;">{{ lang['group'] }}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-users"></i></label>
							</div>
							<select name="status" class="custom-select" style="max-width:220px;"/>
								<option value="null" {% if fstatus == 'null' %}selected{% endif %}>{{ lang['all_group'] }}</option>
								<option value="0" {% if fstatus == '0' %}selected{% endif %}>0</option>
								<option value="1" {% if fstatus == '1' %}selected{% endif %}>1</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>				
					<td><label style="padding: .375rem 0rem .75rem 0rem;">{{ lang['date'] }}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-calendar"></i></label>
								<label class="input-group-text">с</label>
							</div>
							<input type="text" id="dr1" name="dr1" value="{{fDateStart}}" pattern="[0-9]{2}\.[0-9]{2}\.[0-9]{4}" placeholder="{{ "now" | date('d.m.Y') }}" autocomplete="off" style="max-width:188px;">
							<div class="input-group-prepend">
								<span class="input-group-text">по</span>
							</div>
							<input type="text" id="dr2" name="dr2" value="{{fDateEnd}}" pattern="[0-9]{2}\.[0-9]{2}\.[0-9]{4}" placeholder="{{ "now" | date('d.m.Y') }}" autocomplete="off" style="max-width:220px;">
						</div>
					</td>

					<td><label style="padding: .375rem 0rem .75rem 0rem;">{{ lang['per_page'] }}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-low-vision"></i></label>
							</div>
							<input type="number" name="rpp" value="{{ rpp }}" placeholder="{{ lang['per_page'] }}..." class="form-control" style="max-width:220px;"/>
						</div>
					</td>
				</tr>
			</table>
	
			<table class="table table-sm mb-0">
				<tr>
					<td><label style="padding: .375rem 0rem .75rem 0rem;">Plugin</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-puzzle-piece"></i></label>
							</div>
							{{catPlugins}}
						</div>
					</td>
					<td><label style="padding: .375rem 0rem .75rem 0rem;">Item</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-plug"></i></label>
							</div>
							{{catItems}}
						</div>
					</td>				
				</tr>
					
			</table>
			
			<div class="panel-footer" align="center" style="margin-left: -20px;margin-right: -20px;margin-bottom: -20px;">
				<button type="submit" class="btn btn-outline-primary">{{ lang['sortit'] }}</button>
			</div>
			</form>
		</div>
	</div>
</div>

<div class="panel panel-default">
  <div class="panel-heading">
  {{ lang['sys_log'] }}
		<div class="panel-head-right">
			<button type="button" class="btn2" data-toggle="collapse" data-target="#collapseSysLogFilter" aria-expanded="false" aria-controls="collapseSysLogFilter" title="{{ lang['filter'] }}">
				<i class="fa fa-filter"></i>
			</button>
		</div>
  </div>
<div class="panel-body">
	<div class="card">
		<table class="table table-sm mb-0">
		<thead>
			<tr>
				<th>ID</th>
				<th>Data</th>
				<th>IP</th>
				<th>Plugin</th>
				<th>Item</th>
				<th>DS</th>
				<th>Action</th>
				<th>User</th>
				<th>Status</th>
				<!-- <th>alist</th> -->
				<th>Text</th>
			</tr>
		</thead>
		<tbody>
		{% for entry in entries %}
			<tr>
				<td>{{ entry.id }}</td>
				<td>{{ entry.date }}</td>
				<td>{{ entry.ip }}</td>
				<td>{{ entry.plugin }}</td>
				<td>{{ entry.item }}</td>
				<td>{{ entry.ds }}</td>
				<td>{{ entry.action }}</td>
				<td><a href="admin.php?mod=users&action=editForm&id={{ entry.userid }}" target="_blank"/>{{ entry.username }}</a></td>
				<td>{{ entry.status }}</td>
				<!-- <td>{{ entry.alist }}</td> -->
				<td>{{ entry.stext }}</td>
			</tr>
		{% else %}
			<tr><td colspan="10"><p>{{ lang['no_sortit'] }}</p></td></tr>
		{% endfor %}
		</tbody>
		</table>
		
	</div>
	{% if pagesss %}
	<div class="panel-footer">
		<div class="row">
			<div class="col col-md-4"></div>
			<div class="col col-md-8 text-right">
				{{ pagesss }}
			</div>
			
		</div>
	</div>
	{% endif %}
	</div>
</div>
<script type="text/javascript">
	$('#dr1, #dr2').datetimepicker({
		format: "d.m.Y"
	});
</script>