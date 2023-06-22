{% for entry in entries %}
	<tr>
		<td>{{ entry.level }}</td>
		<td>{{ entry.id }}</td>
		<td>
			{% if (entry.info) %}<i class="fa fa-info text-success"></i>{% endif %}
		</td>
		<td>
			{% if (flags.canView) %}
				<a href="?mod=categories&action=edit&catid={{ entry.id }}" data-placement="left" data-popup="tooltip" data-original-title="ID: {{ entry.id }}" title="ID: {{ entry.id }}">{{ entry.name }}</a>
			{% else %}
				{{ entry.name }}
			{% endif %}
		</td>
		<td>{{ entry.alt }}</td>
		<td nowrap align="center">
			{% if (entry.flags.showMain) %}
				<i class="fa fa-check-circle text-success" data-placement="left" data-popup="tooltip" data-original-title="{{ lang['yesa'] }}" title="{{ lang['yesa'] }}"></i>
			{% else %}
				<i class="fa fa-times-circle text-danger" data-placement="left" data-popup="tooltip" data-original-title="{{ lang['noa'] }}" title="{{ lang['noa'] }}"></i>
			{% endif %}
		</td>
		<td>{% if (entry.template == '') %}--{% else %}{{ entry.template }}{% endif %}</td>
		<td align="center">
			<a href="?mod=news&category={{ entry.id }}" data-placement="left" data-popup="tooltip" data-original-title="{{ lang['category.news'] }}" title="{{ lang['category.news'] }}">{% if (entry.news == 0) %}--{% else %}{{ entry.news }}{% endif %}</a>
		</td>
		<td class="text-right" nowrap>
			{% if (flags.canModify) %}
				<div class="btn-group btn-group-sm" role="group">
					<button type="button" onclick="categoryModifyRequest('up', {{ entry.id }});" data-placement="left" data-popup="tooltip" data-original-title="{{ lang['category.up'] }}" title="{{ lang['category.up'] }}" class="btn btn-outline-primary"><i class="fa fa-arrow-up"></i></button>
					<button type="button" onclick="categoryModifyRequest('down', {{ entry.id }});" data-placement="left" data-popup="tooltip" data-original-title="{{ lang['category.down'] }}" title="{{ lang['category.down'] }}" class="btn btn-outline-primary"><i class="fa fa-arrow-down"></i></button>
				</div>
			{% endif %}

			<div class="btn-group btn-group-sm" role="group">
				<a href="{{ entry.linkView }}" target="_blank" class="btn btn-outline-primary" data-placement="left" data-popup="tooltip" data-original-title="{{ lang['site.view'] }}" title="{{ lang['site.view'] }}"><i class="fa fa-external-link"></i></a>
			</div>

			{% if (flags.canModify) %}
				<div class="btn-group btn-group-sm" role="group">
					<button type="button" onclick="categoryModifyRequest('del', {{ entry.id }});" class="btn btn-outline-danger" data-placement="left" data-popup="tooltip" data-original-title="{{ lang['delete'] }}" title="{{ lang['delete'] }}"><i class="fa fa-trash"></i></button>
				</div>
			{% endif %}
		</td>
	</tr>
{% endfor %}