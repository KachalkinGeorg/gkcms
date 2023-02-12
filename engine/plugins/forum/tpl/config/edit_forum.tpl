<form method="post" action="">
	<table class="table table-sm mb-2">
		{% for entry in list_error %}
			{{ entry }}
		{% endfor %}
		<tr>
			<td width="50%" class="contentEntry1">Отображение<br/>
				<small></small>
			</td>
			<td width="50%" class="contentEntry2">
				<select size=1 name="forum_parent">
					{% for entry in list_forum %}
						<option value="{{ entry.id }}" {% if (entry.id_set == entry.id) %}selected="selected"{% endif %}>{{ entry.title }}</option>
					{% endfor %}
				</select>
			</td>

		</tr>
		<tr>
			<td width="50%" class="contentEntry1">Название форума:<br/>
				<small></small>
			</td>
			<td width="50%" class="contentEntry2">
				<input type="text" size="80" placeholder="Введите название..." name="forum_name" value="{{ forum_name }}"/></td>
		</tr>
		<tr>
			<td width="50%" class="contentEntry1">Описание форума<br/>
				<small></small>
			</td>
			<td width="50%" class="contentEntry2">
				<textarea name="forum_description" cols="77" rows="4"/>{{ forum_description }}</textarea></td>
		</tr>
		<tr>
			<td width="50%" class="contentEntry1">Ключевые слова<br/>
				<small></small>
			</td>
			<td width="50%" class="contentEntry2">
				<textarea name="forum_keywords" cols="77" rows="4"/>{{ forum_keywords }}</textarea></td>
		</tr>
		<tr>
			<td width="50%" class="contentEntry1">Закрыть на пароль<br/>
				<small></small>
			</td>
			<td width="50%" class="contentEntry2">
				<input type="password" size="80" name="forum_lock_passwd" value="{{ forum_lock_passwd }}"/></td>
		</tr>
		<tr>
			<td width="50%" class="contentEntry1">Редирект<br/>
				<small></small>
			</td>
			<td width="50%" class="contentEntry2">
				<input type="password" size="80" name="forum_redirect_url" value="{{ forum_redirect_url }}"/></td>
		</tr>
		<br><tr class="thead-dark"><th scope="col">Права модератора</th></tr><br>
		<tr>
			<td width="50%" class="contentEntry1">Модераторы<br/>
				<small>Укажите логины пользователей через запятую</small>
			</td>
			<td width="50%" class="contentEntry2">
				<input type="text" size="80" name="forum_moderators" value="{{ forum_moderators }}"/></td>
		</tr>
		<tr>
			<td width="50%" class="contentEntry1">Создавать темы</td>
			<td width="50%" class="contentEntry2">{{ m_topic_send }}</td>
		</tr>
		<tr>
			<td width="50%" class="contentEntry1">Редактировать тему</td>
			<td width="50%" class="contentEntry2">{{ m_topic_modify }}</td>
		</tr>
		<tr>
			<td width="50%" class="contentEntry1">Закрывать тему</td>
			<td width="50%" class="contentEntry2">{{ m_topic_closed }}</td>
		</tr>
		<tr>
			<td width="50%" class="contentEntry1">Удалять тему</td>
			<td width="50%" class="contentEntry2">{{ m_topic_remove }}</td>
		</tr>
		<tr>
			<td width="50%" class="contentEntry1">Отвечать в темах</td>
			<td width="50%" class="contentEntry2">{{ m_post_send }}</td>
		</tr>
		<tr>
			<td width="50%" class="contentEntry1">Редактировать сообщения</td>
			<td width="50%" class="contentEntry2">{{ m_post_modify }}</td>
		</tr>
		<tr>
			<td width="50%" class="contentEntry1">Удалять сообщения</td>
			<td width="50%" class="contentEntry2">{{ m_post_remove }}</td>
		</tr>
	</table>
	
<div class="content">
<h2>Настройка прав</h2>
<br/>
	<ul class="nav nav-pills mb-3 d-md-flex d-block" role="tablist">
	{% for entry in list_group %}
		<li class="nav-item"><a href="#userTabs-{{ entry.group_id }}" class="nav-link {{ loop.first ? 'active' : '' }}" data-toggle="tab">{{ entry.group_name }}</a></li>
	{% endfor %}
	</ul>
	
	<div id="userTabs" class="tab-content">
		{% for entry in list_group %}
			<div id="userTabs-{{ entry.group_id }}" class="tab-pane {{ loop.first ? 'show active' : '' }}">
				<div class="alert alert-info">Управление правами группы пользователей: <b>{{ entry.group_name }}</b></div>
				<br/>
				<div class="pconf">

					<table class="table table-sm mb-2">
						<thead>
						<tr class="contHead">
							<td><strong>Действие</strong></td>
							<td><strong>Описание</strong></td>
							<td width="90"><strong>Доступ</strong></td>
							</td>
						</thead>
						<tr class="contentEntry1">
							<td>Просматривать форумы</td>
							<td>-</td>
							<td>
								{{ entry.forum_read }}
							</td>
						</tr>
						<tr class="contentEntry1">
							<td>Просматривать темы</td>
							<td>-</td>
							<td>
								{{ entry.topic_read }}
							</td>
						</tr>
						<tr class="contentEntry1">
							<td>Добавлять темы</td>
							<td>-</td>
							<td>
								{{ entry.topic_send }}
							</td>
						</tr>
						<tr class="contentEntry1">
							<td>Редактирова темы</td>
							<td>-</td>
							<td>
								{{ entry.topic_modify }}
							</td>
						</tr>
						<tr class="contentEntry1">
							<td>Редактировать свои темы</td>
							<td>-</td>
							<td>
								{{ entry.topic_modify_your }}
							</td>
						</tr>
						<tr class="contentEntry1">
							<td>Закрывать тему</td>
							<td>-</td>
							<td>
								{{ entry.topic_closed }}
							</td>
						</tr>
						<tr class="contentEntry1">
							<td>Закрывать свою тему</td>
							<td>-</td>
							<td>
								{{ entry.topic_closed_your }}
							</td>
						</tr>
						<tr class="contentEntry1">
							<td>Удалять темы</td>
							<td>-</td>
							<td>
								{{ entry.topic_remove }}
							</td>
						</tr>
						<tr class="contentEntry1">
							<td>Удалять свои темы</td>
							<td>-</td>
							<td>
								{{ entry.topic_remove_your }}
							</td>
						</tr>
						<tr class="contentEntry1">
							<td>Добавлять посты</td>
							<td>-</td>
							<td>
								{{ entry.post_send }}
							</td>
						</tr>
						<tr class="contentEntry1">
							<td>Редактировать посты</td>
							<td>-</td>
							<td>
								{{ entry.post_modify }}
							</td>
						</tr>
						<tr class="contentEntry1">
							<td>Редактировать свои посты</td>
							<td>-</td>
							<td>
								{{ entry.post_modify_your }}
							</td>
						</tr>
						<tr class="contentEntry1">
							<td>Удалять посты</td>
							<td>-</td>
							<td>
								{{ entry.post_remove }}
							</td>
						</tr>
						<tr class="contentEntry1">
							<td>Удалять свои посты</td>
							<td>-</td>
							<td>
								{{ entry.post_remove_your }}
							</td>
						</tr>
					</table>
					<br/>
				</div>
			</div>
		{% endfor %}
		</div>
	</div>

<!-- 	<script type="text/javascript">
		$(function () {
			$("#userTabs").tabs();
		});
	</script> -->
	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td width="100%" colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td width="100%" colspan="2" class="contentEdit" align="center">
				<button name="submit" type="submit" class="btn btn-outline-success"/>Сохранить форум</button></td>
		</tr>
	</table>
</form>