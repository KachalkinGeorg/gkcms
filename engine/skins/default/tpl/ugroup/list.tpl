<div class="panel panel-default">
	<div class="panel-heading">
		{{ lang['user_groups'] }}
		<div class="panel-head-right">
			<div class="col text-right">
				{% if (flags.canAdd) %}
					<form method="get" action="">
						<input type="hidden" name="mod" value="ugroup" />
						<input type="hidden" name="action" value="addForm" />

						<button type="submit" class="btn2" data-placement="top" data-popup="tooltip" data-original-title="{{ lang['add_group'] }}" title="{{ lang['add_group'] }}"><i class="fa fa-plus-circle"></i> {{ lang['add_group'] }}</button>
					</form>
				{% endif %}
			</div>
		</div>
	</div>
	<div class="panel-body">
	<div class="table-responsive">
		<table class="table table-sm mb-0">
			<thead>
				<tr >
					<th>#</th>
					<th>{{ lang['identifier'] }}</th>
					<th>{{ lang['name'] }}</th>
					<th nowrap><center>{{ lang['users_in_group'] }}</center></th>
					<th><center>{{ lang['action'] }}</center></th>
				</tr>
			</thead>
			<tbody id="admCatList">
				{% for entry in entries %}
				<tr>
					<td>{{ entry.id }}</td>
					<td>{{ entry.identity }}</td>
					<td>{{ entry.name }}</td>
					<td align="center">{{ entry.count }}</td>
					<td align="center">
						<div class="btn-group btn-group-sm" role="group">
							{% if (entry.flags.canEdit) %}
							<a href="{{ php_self }}?mod=ugroup&action=editForm&id={{ entry.id }}" class="btn btn-outline-primary" data-placement="left" data-popup="tooltip" data-original-title="{{ lang['edit'] }}" title="{{ lang['edit'] }}"><i class="fa fa-pencil"></i></a>
							{% endif %}
							{% if (entry.flags.canDelete) %}
							<a href="{{ php_self }}?mod=ugroup&action=delete&id={{ entry.id }}&token={{ token }}" class="btn btn-outline-danger" data-placement="left" data-popup="tooltip" data-original-title="{{ lang['delete'] }}" title="{{ lang['delete'] }}"><i class="fa fa-trash"></i></a>
							{% endif %}
						</div>
					</td>
				</tr>
				{% endfor %}
			</tbody>
		</table>
	</div>
	</div>
</div>