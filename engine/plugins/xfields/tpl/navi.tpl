<ul class="nav nav-pills mb-3 d-md-flex d-block" role="tablist">
	<li class="nav-item">
		<a href="?mod=extra-config&plugin=xfields&section=news" class="nav-link {{ 'news' == sectionID ? 'active' : '' }}">Новости: поля</a>
	</li>
	<li class="nav-item">
		<a href="?mod=extra-config&plugin=xfields&section=grp.news" class="nav-link {{ 'grp.news' == sectionID ? 'active' : '' }}">Новости: группы</a>
		</li>
	<li class="nav-item">
		<a href="?mod=extra-config&plugin=xfields&section=tdata" class="nav-link {{ 'tdata' == sectionID ? 'active' : '' }}">Новости: таблицы</a>
	</li>
	{% if (pluginIsActive('uprofile')) %}
	<li class="nav-item">
		<a href="?mod=extra-config&plugin=xfields&section=users" class="nav-link {{ 'users' == sectionID ? 'active' : '' }}">Пользователи: поля</a>
	</li>
	{% endif %}
</ul>