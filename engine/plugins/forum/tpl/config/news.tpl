<table border="0" cellspacing="0" cellpadding="0" class="content" align="center">
	<tr align="left" class="contHead">
		<td width="10%" nowrap>#</td>
		<td width="60%">Заголовок</td>
		<td width="30%">Действие</td>
	</tr>
	{% for entry in entries %}
		<tr align="left">
			<td width="10%" class="contentEntry1">{{ entry.news_id }}</td>
			<td width="60%" class="contentEntry1">{{ entry.title }}</td>
			<td width="30%" class="contentEntry1">{{ entry.edit }} {{ entry.del }}</td>
		</tr>
	<div id="modal-{{ entry.news_id }}" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="{{ entry.news_id }}-modal-label" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 id="{{ entry.news_id }}-modal-label" class="modal-title">Удалить {{ entry.title }}</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i class="fa fa-times-circle"></i></span></button>
				</div>
				<div class="modal-body">
					Вы уверены, что хотите удалить новость {{ entry.title }}?<br>Данное действие необратимо!
				</div>
				<div class="modal-footer"> <a href="?mod=extra-config&plugin=forum&action=del_news&id={{ entry.news_id }}" class="btn btn-outline-success">да</a> <button type="button" class="btn btn-outline-dark" data-dismiss="modal">отмена</button></div>
			</div>
		</div>
	</div>
	{% else %}
		<tr align="left">
			<td width="10%" class="contentEntry1">Пусто</td>
			<td width="60%" class="contentEntry1">-</td>
			<td width="30%" class="contentEntry1">-</td>
		</tr>
	{% endfor %}
	<tr>
		<td width="100%" colspan="8">&nbsp;</td>
	</tr>
	<tfoot>
	<tr>
		<td colspan="8" class="contentEdit" align="right">
			<a class="btn btn-primary" href="{{ admin_url }}/admin.php?mod=extra-config&plugin=forum&action=new_news" />Добавить новость</a>
		</td>
	</tr>
	</tfoot>
	<tr>
		<td width="100%" colspan="8">&nbsp;</td>
	</tr>
	<tr>
		<td align="center" colspan="8" class="contentHead">{{ pagesss }}</td>
	</tr>
</table>