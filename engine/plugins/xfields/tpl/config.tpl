{% include 'plugins/xfields/tpl/navi.tpl' %}

{% if not(xfields|length) %}
<div class="alert alert-info">
	<h5>{{ lang['msgi_info'] }}</h5>
	<p>{{ lang.xfconfig['no_fields'] }}</p>
	<hr>
	<a href="?mod=extra-config&plugin=xfields&action=add&section={{ sectionID }}" class="alert-link- btn btn-outline-success">{{ lang.xfconfig['add'] }}</a>
</div>
{%else%}

<div class="panel panel-default">
	<div class="panel-heading">
		{{ section_name }}
		<div class="panel-head-right">
			<a href="?mod=extra-config&plugin=xfields&action=add&section={{ sectionID }}" class="btn2"><i class="fa fa-plus-circle"></i> {{ lang.xfconfig['add'] }}</a>
		</div>
	</div>
	<div class="panel-body">

	<div class="table-responsive">
		<table class="table table-sm mb-0">
			<thead>
				<tr>
					<th>ID поля</th>
					<th>Название поля</th>
					<th>Тип поля</th>
					<th>Возможные значения</th>
					<th>По умолчанию</th>
					<th>Обязательно</th>
					{% if (sectionID != 'tdata') %}
						<th>Блок</th>
					{% endif %}
					<th class="text-right">Действие</th>
				</tr>
			</thead>
			<tbody>
			{% for entry in xfields %}
				<tr class="{{ entry.flags.disabled ? 'bg-light' : '' }}">
					<td>
						<a href="{{ entry.link }}">{{ entry.name }}</a>
						{% if (sectionID == 'users') and (entry.flags.regpage ) %}
							<span title="{{ lang.xfconfig['show_regpage'] }}">[<b class="text-danger">R</b>]</span>
						{% endif %}
					</td>
					<td>{{ entry.title }}</td>
					<td>{{ entry.type }}</td>
					<td>{{ entry.options }}</td>
					<td>
						{% if (entry.flags.default) %}
							{{ entry.default }}
						{% else %}
							<span class="text-danger">не задано</span>
						{% endif %}
					</td>
					<td>
						{% if (entry.flags.required) %}
							<b class="text-danger">Да</b>
						{% else %}
							Нет
						{% endif %}
					</td>
					{% if (sectionID != 'tdata') %}
						<td>{{ entry.area }}</td>
					{% endif %}
					<td class="text-right" nowrap>
						<div class="btn-group btn-group-sm" role="group">
							<a href="{{ entry.linkup }}" class="btn btn-outline-primary"><i class="fa fa-arrow-up"></i></a>
							<a href="{{ entry.linkdown }}" class="btn btn-outline-primary"><i class="fa fa-arrow-down"></i></a>
						</div>

						<div class="btn-group btn-group-sm" role="group">
							<a href="{{ entry.link }}" class="btn btn-outline-primary" title="Редактировать"><i class="fa fa-pencil"></i></a>
						</div>

						<div class="btn-group btn-group-sm" role="group">
							<a href="#" data-toggle="modal" data-target="#modal-{{ entry.name }}" title="{{ lang.xfconfig['suretest'] }}" class="btn btn-outline-danger"><i class="fa fa-trash"></i></a>
						</div>
						{{ entry.modal }}
					</td>
				</tr>
			{% endfor %}
			</tbody>
		</table>
	</div>
</div>
</div>
{% endif %}