<div class="navbar-default navbar-component">
<ul class="nav nav-tabs nav-fill mb-3 d-md-flex d-block">
	<li class="nav-item"><a href="#" class="nav-link {{active1}}" onmousedown="javascript:window.location.href='{{admin_url}}/admin.php?mod=extra-config&plugin=simple_title_pro'"><span data-toggle="tooltip" data-placement="top" title="Общие"><i class="fa fa-cog"></i> Главная</span></a></li>
	<li class="nav-item"><a href="#" class="nav-link {{active2}}" onmousedown="javascript:window.location.href='{{admin_url}}/admin.php?mod=extra-config&plugin=simple_title_pro&action=list_static'"><span data-toggle="tooltip" data-placement="top" title="Список статиков"><i class="fa fa-file-text-o"></i> Список статиков</span></a></li>
	<li class="nav-item"><a href="#" class="nav-link {{active3}}" onmousedown="javascript:window.location.href='{{admin_url}}/admin.php?mod=extra-config&plugin=simple_title_pro&action=list_cat'"><span data-toggle="tooltip" data-placement="top" title="Список категорий"><i class="fa fa-folder-open"></i> Список категорий</span></a></li>
	<li class="nav-item"><a href="#" class="nav-link {{active4}}" onmousedown="javascript:window.location.href='{{admin_url}}/admin.php?mod=extra-config&plugin=simple_title_pro&action=list_news'"><span data-toggle="tooltip" data-placement="top" title="Список новостей"><i class="fa fa-files-o"></i> Список новостей</span></a></li>
	<li class="nav-item"><a href="#" class="nav-link" onmousedown="javascript:window.location.href='{{admin_url}}/admin.php?mod=extra-config&plugin=simple_title_pro&action=clear_cache'"><span data-toggle="tooltip" data-placement="top" title="Очистить кэш"><i class="fa fa-exclamation"></i> Очистить кэш</span></a></li>
	<li class="nav-item"><a href="#" class="nav-link {{active6}}" onmousedown="javascript:window.location.href='{{admin_url}}/admin.php?mod=extra-config&plugin=simple_title_pro&action=about'"><span data-toggle="tooltip" data-placement="top" title="О плагине"><i class="fa fa-exclamation-circle"></i> О плагине</span></a></li>
</ul>
</div>

{% if (info.true) %}<tr>
	<td class="contentNav">
		<font color="red">
		{{info.print}}
		</font>
	</td>
</tr>{% endif %}
{% if (reklama.true) %}<tr>
	<td class="contentNav">
		<font color="blue">
		{{reklama.print}}
		</font>
	</td>
</tr>{% endif %}

<div class="panel panel-default">
  <div class="panel-heading">
     {{panel}}
  </div>
<div class="panel-body">
{{entries}}
</div>
</div>