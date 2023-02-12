<tr>
	<td>
		<a onmousedown="javascript:window.location.href='{admin_url}/admin.php?mod=extra-config&plugin=ads_pro&action=move_up&id={id}'" title="{l_ads_pro:button_up}" ><i class="fa fa-angle-up fa-2x" aria-hidden="true"></i></a>
		<a title="{l_ads_pro:button_down}" onmousedown="javascript:window.location.href='{admin_url}/admin.php?mod=extra-config&plugin=ads_pro&action=move_down&id={id}'"><i class="fa fa-angle-down fa-2x" aria-hidden="true"></i></a>
	</td>
	<td>{name}</td>
	<td>{description}</td>
	<td>{type}</td>
	<td>{state}</td>
	<td>{online}</td>
	<td>
		<a title="{l_ads_pro:button_edit}" href="{admin_url}/admin.php?mod=extra-config&plugin=ads_pro&action=edit&id={id}"/><i class="fa fa-pencil fa-lg" aria-hidden="true"></i></a>
		<a title="{l_ads_pro:button_dell}" href="#" data-toggle="modal" data-target="#modal-{id}"/><i class="fa fa-times fa-lg" aria-hidden="true"></i></a>
	</td>
</tr>
	<div id="modal-{id}" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="{id}-modal-label" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 id="{id}-modal-label" class="modal-title">Удалить блок {name}</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i class="fa fa-times-circle"></i></span></button>
				</div>
				<div class="modal-body">
					Вы уверены, что хотите удалит категорию {name}?<br>Данное действие необратимо!
				</div>
				<div class="modal-footer"> <a href="?mod=extra-config&plugin=ads_pro&action=dell&id={id}" class="btn btn-outline-success">да</a> <button type="button" class="btn btn-outline-dark" data-dismiss="modal">отмена</button></div>
			</div>
		</div>
	</div>