<form method="post" action="">

	<fieldset class="admGroup">
		<table class="table table-sm mb-0">
			<tr class="thead-dark"><th scope="col">Настройки форума</th></tr><br>
			<tr>
				<td width="70%">Выберите каталог из которого плагин будет брать шаблоны для отображения
				<small class="form-text text-muted"><b>Шаблон сайта</b> - плагин будет пытаться взять шаблоны из общего шаблона сайта; в случае недоступности - шаблоны будут взяты из собственного каталога плагина<br /><b>Плагин</b> - шаблоны будут браться из собственного каталога плагина</small>
				</td>
				<td width="30%">
					<div class="input-group">
						{{ localsource }}
						<div class="input-group-append">
							<a class="btn btn-outline-primary" data-toggle="popover" data-placement="top" data-trigger="focus" data-html="true" title="ШАБЛОН" data-content="Данные будут браться из самого плагина или из папки Вашей темы<br>по пути: default\plugins\forum\skins\имя скина форума\" tabindex="0">
								<i class="fa fa-question"></i>
							</a>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td width="70%">Выберите вид отображения форума<br/></td>
				<td width="30%">
					<div class="input-group">
						{{ display_main }}
						<div class="input-group-append">
							<a class="btn btn-outline-primary" data-toggle="popover" data-placement="top" data-trigger="focus" data-html="true" title="ОФОРМЛЕНИЕ" data-content="При выборе отдельная страница, форум будет использовать собственный main.tpl" tabindex="0">
								<i class="fa fa-question"></i>
							</a>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td width="70%">Выберите активный скин<br/>
					<small class="form-text text-muted">Выбранный скин будет использоваться при установке <b>Плагин</b> в предыдущем поле</small><br/>
				</td>
				<td width="30%">
					<div class="input-group">
						{{ localskin }}
					<div class="input-group-append">
						<a class="btn btn-outline-primary" data-toggle="popover" data-placement="top" data-trigger="focus" data-html="true" title="СКИН" data-content="Используйте разные скины Вашего форума. Выбранный скин можно использовать только с выбраным параметром ПЛАГИН" tabindex="0">
							<i class="fa fa-question"></i>
						</a>
					</div>
					</div>
				</td>
			</tr>
			<tr>
				<td width="70%">Время для редиректа<br/>
					<small class="form-text text-muted">Устанавливать в секундах...</small>
				</td>
				<td width="30%">
					<input name="redirect_time" type="text" placeholder="Введите секунды..." size="4" value="{{ redirect_time }}" class="form-control">
				</td>
			</tr>
			<tr>
				<td width="70%">Включить кто оналайн<br/></td>
				<td width="30%">{{ online }}</td>
			</tr>
			<tr>
				<td width="70%">Время в течении которого пользователь считается в сети<br/>
					<small class="form-text text-muted">Указывать в секундах</small>
				</td>
				<td width="30%">
					<input name="online_time" type="text" placeholder="Введите секунды..." size="10" value="{{ online_time }}" class="form-control">
				</td>
			</tr>
		</table>
			
		<table class="table table-sm mb-0">
			<tr class="thead-dark"><th scope="col">Мета Данные</th></tr><br>
			<tr>
				<td width="70%">Титл форума<br/></td>
				<td width="30%">
					<input name="forum_title" type="text" placeholder="Введите титл форума..." value="{{ forum_title }}" class="form-control">
				</td>
			</tr>
			<tr>
				<td width="70%">Описание (Description) форума<br/>
				<small class="form-text text-muted">Краткое описание, не более 200 символов.</small>
				</td>
				<td width="30%">
					<input name="forum_description" type="text" placeholder="Введите описание форума..." value="{{ forum_description }}" class="form-control">
				</td>
			</tr>
			<tr>
				<td width="70%">Ключевые (Keywords) слова<br/>
				<small class="form-text text-muted">Введите через запятую основные ключевые слова для вашего форума.</small>
				</td>
				<td width="30%">
					<input name="forum_keywords" type="text" placeholder="Введите ключевые слова форума..." value="{{ forum_keywords }}" class="form-control">
				</td>
			</tr>
		</table>
			
		<table class="table table-sm mb-0">
			<tr class="thead-dark"><th scope="col">Разное</th></tr><br>
			<tr>
				<td width="70%">Задайте имя кнопок Обсудить на форуме<br/>
					<small class="form-text text-muted">Данное имя будет определять публикацию к какой категории она принадлежит. При редактировании будет доступен пункт <b><i>Создать на форуме</i></b>, если активировать вторую кнопку <b>Обсудить на форуме</b>, то можно определить публикацию по какому тегу будет передоватьсяс ссылка на категорию форума<br>
					Теги для полной новости <b>(news.full.tpl)</b><br>
					<b>{topic_forum_url}</b> - определяется первой кнопкой<br>
					<b>{discus_forum_url}</b> - вторая кнопка
					</small>
				</td>
				<td width="30%">
					<div class="input-group mb-3">
						<div class="input-group-prepend input-group-append">
							<label class="input-group-text">1-</label>
						</div>
						<input type="text" name="forum_but1" value="{{ forum_but1 }}" class="form-control">
						<div class="input-group-prepend input-group-append">
							<label class="input-group-text">2-</label>
						</div>
						<input type="text" name="forum_but2" value="{{ forum_but2 }}" class="form-control">
					</div>
				</td>
			</tr>
			<tr>
				<td width="70%">Включить вторую кнопку Обсудить на форуме<br/>
					<small class="form-text text-muted">При активации:<br>
					<b>Да</b> - в полной новости будут доступны теги: {topic_forum_url} и {discus_forum_url}<br><b style="color: #ff00009e;">ВНИМАНИЕ!</b><br> При добавлении публикации выбрать можно только одно из кнопок, а при редактировании привязать новость к категории будет возможно к двум кнопкам<br>
					<b>Нет</b> - будет использоваться по умолчанию тег {topic_forum_url}
					</small>
				</td>
				<td width="30%">{{ forum_disc }}</td>
			</tr>
		</table>	
		<table class="table table-sm mb-0">
			<tr>
				<td width="70%">В течение какого времени пользователю разрешено редактировать своё сообщение:<br/>
					<small class="form-text text-muted">Указывается в минутах</small>
				</td>
				<td width="30%">
					<input name="edit_del_time" type="text" placeholder="Введите минуты..." value="{{ edit_del_time }}"/>
				</td>
			</tr>
			<tr>
				<td width="70%">Разрешить объединение комментариев<br/>
					<small class="form-text text-muted">Включение или отключение объединения сообщений в теме, добавляемых друг за другом от одного посетителя. Если данная настройка включена, то все сообщения, которые добавляет посетитель в течении суток к одной теме, будут объединены в одно, при условии что сообщения добавляются подряд и между ними нет сообщений других пользователей.</small>
				</td>
				<td width="30%">{{ compost }}</td>
			</tr>
			<tr>
				<td width="70%">Разрешить выводить текст о том, кто отредактировал пост.<br/>
					<small class="form-text text-muted">Данная настройка определяет вывод фразы о редактировании сообщения на страницах форума.</small>
				</td>
				<td width="30%">{{ editdate }}</td>
			</tr>
		</table>
	</fieldset>

	<fieldset class="admGroup">
		<table class="table table-sm mb-2">
			<tr class="thead-dark"><th scope="col">Постраничная навигация</th></tr><br>
			<tr>
				<td width="90%">Количество сообщений в теме<br/>
				<small class="form-text text-muted">Количество сообщений на одну страницу.</small>
				</td>
				<td width="10%">
					<input name="topic_per_page" type="text" title="Количество сообщений в теме" size="4" value="{{ topic_per_page }}"/>
				</td>
			</tr>
			<tr>
				<td width="90%">Количество найденых тем на одной странице<br/>
				<small class="form-text text-muted">Количество тем на одну страницу.</small>
				</td>
				<td width="10%">
					<input name="search_per_page" type="text" title="Количество найденых тем на одной странице" size="4" value="{{ search_per_page }}"/>
				</td>
			</tr>
			<tr>
				<td width="90%">Количество пользователей на странице<br/>
				<small class="form-text text-muted">Количество пользователей отображаемых на главной страницы.</small>
				</td>
				<td width="10%">
					<input name="user_per_page" type="text" title="Количество пользователей на странице" size="4" value="{{ user_per_page }}"/>
				</td>
			</tr>
			<tr>
				<td width="90%">Количество тем в разделе форума<br/>
				<small class="form-text text-muted">Количество тем в разделе форума.</small>
				</td>
				<td width="10%">
					<input name="forum_per_page" type="text" title="Количество тем в разделе форума" size="4" value="{{ forum_per_page }}"/>
				</td>
			</tr>
			<tr>
				<td width="90%">Количество сообщений в разделе репутации<br/>
				<small class="form-text text-muted">Количество сообщений репутаций на одну страницу.</small>
				</td>
				<td width="10%">
					<input name="reput_per_page" type="text" title="Количество тем в разделе форума" size="4" value="{{ reput_per_page }}"/>
				</td>
			</tr>
			<tr>
				<td width="70%">Количество сообщений для разных страниц форума<br/>
				<small class="form-text text-muted">Количество сообщений на одну страницу.</small>
				</td>
				<td width="30%">
					<input name="act_per_page" type="text" title="Количество тем в разделе форума" size="4" value="{{ act_per_page }}"/>
				</td>
			</tr>
			<tr>
				<td width="90%">Количество сообщейни в разделе спасибо<br/>
				<small class="form-text text-muted">Количество сообщений спасибо на одну страницу.</small>
				</td>
				<td width="10%">
					<input name="thank_per_page" type="text" title="Количество тем в разделе форума" size="4" value="{{ thank_per_page }}"/>
				</td>
			</tr>
			<tr>
				<td width="90%">Количество сообщений на страницк ответа<br/></td>
				<td width="10%">
					<input name="newpost_per_page" type="text" title="Количество тем в разделе форума" size="4" value="{{ newpost_per_page }}"/>
				</td>
			</tr>
			<tr>
				<td width="90%">Количество новостей<br/>
				<small class="form-text text-muted">Количество новостей на одну страницу.</small>
				</td>
				<td width="10%">
					<input name="news_per_page" type="text" title="Количество новостей" size="4" value="{{ news_per_page }}"/>
				</td>
			</tr>
			<tr>
				<td width="90%">Количество rss<br/>
				<small class="form-text text-muted">Количество rss на одну страницу.</small>
				</td>
				<td width="10%">
					<input name="rss_per_page" type="text" title="Количество новостей" size="4" value="{{ rss_per_page }}"/>
				</td>
			</tr>
			<tr>
				<td width="90%">Количество сообщений<br/>
				<small class="form-text text-muted">Количество сообщений на одну страницу.</small>
				</td>
				<td width="10%">
					<input name="list_pm_per_page" type="text" title="Количество новостей" size="4" value="{{ list_pm_per_page }}"/>
				</td>
			</tr>
		</table>
	</fieldset>

	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td width="100%" colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td width="100%" colspan="2" class="contentEdit" align="center">
				<button name="submit" type="submit" class="btn btn-outline-success"/>Сохранить</button>
			</td>
		</tr>
	</table>
</form>