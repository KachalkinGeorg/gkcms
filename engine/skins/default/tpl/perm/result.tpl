<div class="alert {{ execResult ? 'alert-success' : 'alert-danger'}}">
	{{ lang['result'] }}: {{ execResult ? lang['success'] : lang['error'] }}
</div>

{% if updateList %}
<div class="panel panel-default mb-5">
	<div class="panel-heading">
		{{ lang['list_changes_performed'] }}
	</div>
	<div class="panel-body">
	<table class="table table-sm mb-0">
		<thead>
			<tr>
				<th>{{ lang['group'] }}</th>
				<th>ID</th>
				<th>{{ lang['name'] }}</th>
				<th nowrap>{{ lang['old_value'] }}</th>
				<th nowrap>{{ lang['new_value'] }}</th>
			</tr>
		</thead>
		<tbody>
			{% for entry in updateList %}
				<tr>
					<td>{{ GRP[entry.group]['title'] }}</td>
					<td>{{ entry.id }}</td>
					<td>{{ entry.title }}</td>
					<td>{{ entry.displayOld }}</td>
					<td>{{ entry.displayNew }}</td>
				</tr>
			{% endfor %}
		</tbody>
	</table>
	</div>
</div>
{% endif %}