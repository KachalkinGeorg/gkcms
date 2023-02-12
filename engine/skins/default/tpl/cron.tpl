<div class="alert alert-info">
	{{ lang.cron['title#desc'] }}
</div>

<form action="{{ php_self }}?mod=cron" method="post">
	<input type="hidden" name="token" value="{{ token }}" />
	<input type="hidden" name="mod" value="cron" />
	<input type="hidden" name="action" value="commit" />

	<div class="panel panel-default mb-3">
		<div class="panel-heading">
		{{ lang.cron.name }}
			<div class="panel-head-right">
			<button type="button" class="btn2" data-toggle="modal" data-target="#legendModal">
				<i class="fa fa-question"></i>
			</button>
			</div>
		</div>
		
		<div class="panel-body">
		<div class="table-responsive">
			<table class="table table-sm">
				<thead>
					<tr>
						<th>Plugin</th>
						<th>Handler</th>
						<th>Min</th>
						<th>Hour</th>
						<th>Day</th>
						<th>Month</th>
						<th>D.O.W.</th>
					</tr>
				</thead>
				<tbody>
					{% for entry in entries %}
					<tr>
						<td>
							<input name="data[{{ entry.id }}][plugin]" value="{{ entry.plugin }}" class="form-control" />
						</td>
						<td>
							<input name="data[{{ entry.id }}][handler]" value="{{ entry.handler }}" class="form-control" />
						</td>
						<td>
							<input name="data[{{ entry.id }}][min]" value="{{ entry.min }}" class="form-control" />
						</td>
						<td>
							<input name="data[{{ entry.id }}][hour]" value="{{ entry.hour }}" class="form-control" />
						</td>
						<td>
							<input name="data[{{ entry.id }}][day]" value="{{ entry.day }}" class="form-control" />
						</td>
						<td>
							<input name="data[{{ entry.id }}][month]" value="{{ entry.month }}" class="form-control" />
						</td>
						<td>
							<input name="data[{{ entry.id }}][dow]" value="{{ entry.dow }}" class="form-control" />
						</td>
					</tr>
					{% endfor %}
				</tbody>
			</table>
		</div>
		</div>

		<div class="card-footer text-center">
			<button type="submit" class="btn btn-outline-success">{{ lang.cron['commit_change'] }}</button>
		</div>
	</div>
</form>

<div id="legendModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="legendModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				{{ lang.cron['legend'] }}
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-secondary" data-dismiss="modal">{{ lang.cron.cansel }}</button>
			</div>
		</div>
	</div>
</div>