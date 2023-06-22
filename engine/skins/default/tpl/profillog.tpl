<div id="collapseProfilLogFilter" class="collapse">
	<div class="card mb-4">
	<div class="card-header">{{ lang['filter'] }}</div>
		<div class="card-body">
		<form action="{{ php_self }}" method="get">
			<input type="hidden" name="mod" value="profillog" />
	
			<table class="table table-sm mb-0">
				<tr>				
					<td><label style="padding: .375rem 0rem .75rem 0rem;">{{ lang['date'] }}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-calendar"></i></label>
								<label class="input-group-text">{{ lang['dr1'] }}</label>
							</div>
							<input type="text" id="dr1" name="dr1" value="{{fDateStart}}" pattern="[0-9]{2}\.[0-9]{2}\.[0-9]{4}" placeholder="{{ "now" | date('d.m.Y') }}" autocomplete="off" style="max-width:188px;">
							<div class="input-group-prepend">
								<span class="input-group-text">{{ lang['dr2'] }}</span>
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

			<div class="panel-footer" align="center" style="margin-left: -20px;margin-right: -20px;margin-bottom: -20px;">
				<button type="submit" class="btn btn-outline-primary">{{ lang['sortit'] }}</button>
			</div>
			</form>
		</div>
	</div>
</div>

<div class="panel panel-default">
  <div class="panel-heading">
  {{ lang['profil_log'] }}
		<div class="panel-head-right">
			<button type="button" class="btn2" data-toggle="collapse" data-target="#collapseProfilLogFilter" aria-expanded="false" aria-controls="collapseProfilLogFilter" title="{{ lang['filter'] }}">
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
				<th>{{ lang['dt'] }}</th>
				<th>{{ lang['url'] }}</th>
				<th>{{ lang['user'] }}</th>
				<th>{{ lang['exectime'] }}</th>
				<th>{{ lang['memusage'] }}</th>
				<!-- <th>Text</th> -->
			</tr>
		</thead>
		<tbody>
		{% for entry in entries %}
			<tr>
				<td>{{ entry.id }}</td>
				<td>{{ entry.date }}</td>
				<td><a href="{{ entry.url }}" target="_blank"/>{{ entry.url }}</a></td>
				<td><a href="mod=users&action=editForm&id={{ entry.userid }}" target="_blank"/>{{ entry.username }}</a></td>
				<td>{{ entry.exectime }}</td>
				<td>{{ entry.memusage }}</td>
				<!-- <td>{{ entry.tracedata }}</td> -->
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