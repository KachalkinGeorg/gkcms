<tr align="center" class="contRow1">
	<td>{{ forum_id }}</td>
	<td>|___<input type="text" name="position[{{ forum_id }}]" value="{{ pos }}" maxlength="5" size="5"/></td>
	<td>{{ forum_name }}<br/>
		<small><a href="{{ forum_link }}">{{ home_url }}{{ forum_link }}</a></small>
	</td>
	<td>{{ num_topic }}</td>
	<td>{{ num_post }}</td>
	<td>
		<a href="admin.php?mod=extra-config&plugin=forum&action=edit_forum&id={{ forum_id }}" title="Редактировать" ><i class="fa fa-pencil-square-o"></i></a>
		<a href="#" data-toggle="modal" data-target="#modal-{{ forum_id }}" title="удалить"><i style="color:#ed143d" class="fa fa-trash" aria-hidden="true"></i></a>
	</td>
</tr>
	<div id="modal-{{ forum_id }}" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="{{ forum_id }}-modal-label" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 id="{{ forum_id }}-modal-label" class="modal-title">Удалить под форум {{ forum_name }}</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i class="fa fa-times-circle"></i></span></button>
				</div>
				<div class="modal-body">
					Вы уверены, что хотите удалить раздел под форума {{ forum_name }}?<br>Данное действие необратимо!
				</div>
				<div class="modal-footer"> <a href="?mod=extra-config&plugin=forum&action=del_forum&id={{ forum_id }}" class="btn btn-outline-success">да</a> <button type="button" class="btn btn-outline-dark" data-dismiss="modal">отмена</button></div>
			</div>
		</div>
	</div>