<tr align="center" class="contRow1">
	<td>{{ forum_id }}</td>
	<td><input type="text" name="position[{{ forum_id }}]" value="{{ pos }}" maxlength="5" size="5"/></td>
	<td>{{ forum_name }}<br/>
		<small><a href="{{ forum_link }}">{{ home_url }}{{ forum_link }}</a></small>
	</td>
	<td>{{ num_topic }}</td>
	<td>{{ num_post }}</td>
	<td>	
		<div class="btn-group btn-group-sm" role="group">
		<a class="btn btn-outline-primary" href="admin.php?mod=extra-config&plugin=forum&action=edit_section&id={{ forum_id }}" title="Редактировать"><i style="vertical-align: bottom;" class="fa fa-pencil"></i></a>
		<a class="btn btn-outline-danger" href="#" data-toggle="modal" data-target="#modal-{{ forum_id }}" title="удалить"><i style="vertical-align: bottom;" class="fa fa-trash-o"></i></a>
		<a class="btn btn-outline-info" href="admin.php?mod=extra-config&plugin=forum&action=send_forum&id={{ forum_id }}" title="добавить подраздел">
<span class="fa-stack" style="vertical-align: bottom;" >
<i class="fa fa-folder fa-stack-1x"></i>
<i class="fa fa-plus fa-stack-1x" style="color: white;font-size: 8px;"></i>
</span>
		</a>

		</div>
	</td>
</tr>
{{ entries.print }}
	<div id="modal-{{ forum_id }}" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="{{ forum_id }}-modal-label" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 id="{{ forum_id }}-modal-label" class="modal-title">Удалить раздел {{ forum_name }}</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i class="fa fa-times-circle"></i></span></button>
				</div>
				<div class="modal-body">
					Вы уверены, что хотите удалить раздел {{ forum_name }}?<br>Данное действие необратимо!
				</div>
				<div class="modal-footer"> <a href="?mod=extra-config&plugin=forum&action=del_section&id={{ forum_id }}" class="btn btn-outline-success">да</a> <button type="button" class="btn btn-outline-dark" data-dismiss="modal">отмена</button></div>
			</div>
		</div>
	</div>