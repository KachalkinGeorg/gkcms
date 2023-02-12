<form method="post" action="">

<div class="panel-flat">Настройки админки</div>
<div class="table-responsive">

  <table class="table table-striped">
	<tr>
        <td class="col-xs-6 col-sm-6 col-md-7"><h6 class="media-heading text-semibold">Количество записей в категории</h6>
		<span class="text-muted text-size-small">{{num_cat.error}}</span></td>
        <td class="col-xs-6 col-sm-6 col-md-5">
			<div class="input-group">
			<input name="num_cat" type="text" placeholder="Количество записей" value="{{num_cat.print}}" class="form-control" style="max-width: 160px;"/>
			<div class="input-group-append">
				<a class="btn btn-primary" data-toggle="popover" data-placement="top" data-trigger="focus" data-html="true" title="КАТЕГОРИИ" data-content="Задайте количество записей в списке категорий для вывода их на страницу." tabindex="0">
					<i class="fa fa-question"></i>
				</a>
			</div>
			</div>
		</td>
    </tr>

	<tr>
        <td class="col-xs-6 col-sm-6 col-md-7"><h6 class="media-heading text-semibold">Количество записей в новостях</h6>
		<span class="text-muted text-size-small">{{num_news.error}}</span></td>
        <td class="col-xs-6 col-sm-6 col-md-5">
			<div class="input-group">
			<input name="num_news" type="text" placeholder="Количество записей" value="{{num_news.print}}" class="form-control" style="max-width: 160px;"/>
			<div class="input-group-append">
				<a class="btn btn-primary" data-toggle="popover" data-placement="top" data-trigger="focus" data-html="true" title="НОВОСТИ" data-content="Задайте количество записей в списке новостей для вывода их на страницу." tabindex="0">
					<i class="fa fa-question"></i>
				</a>
			</div>
			</div>
		</td>
    </tr>

	<tr>
        <td class="col-xs-6 col-sm-6 col-md-7"><h6 class="media-heading text-semibold">Количество записей в Статистических страницах</h6>
		<span class="text-muted text-size-small">{{num_static.error}}</span></td>
        <td class="col-xs-6 col-sm-6 col-md-5">
			<div class="input-group">
			<input name="num_static" type="text" placeholder="Количество записей" value="{{num_static.print}}" class="form-control" style="max-width: 160px;"/>
			<div class="input-group-append">
				<a class="btn btn-primary" data-toggle="popover" data-placement="top" data-trigger="focus" data-html="true" title="СТАТИСТИЧЕСКАЯ СТРАНИЦА" data-content="Задайте количество записей в списке статистических страниц для вывода их на страницу." tabindex="0">
					<i class="fa fa-question"></i>
				</a>
			</div>
			</div>
		</td>
    </tr>

	<tr>
        <td class="col-xs-6 col-sm-6 col-md-7"><h6 class="media-heading text-semibold">Время жизни кэша</h6>
		<span class="text-muted text-size-small">Указывать в днях {{cache.error}}</span></td>
        <td class="col-xs-6 col-sm-6 col-md-5">
			<div class="input-group">
			<input name="cache" type="text" placeholder="Время жизни кэша" value="{{cache.print}}" class="form-control" style="max-width: 40px;text-align: center;"/>
			</div>
		</td>
    </tr>
	
	</table>
</div>
	
<div class="panel-flat">Настройки &lt;title&gt;&lt;/title&gt;</div>
<div class="table-responsive">

  <table class="table table-striped">
	<tr>
        <td class="col-xs-6 col-sm-6 col-md-7"><h6 class="media-heading text-semibold">Символ - разделитель</h6>
		<span class="text-muted text-size-small">{{separator.error}}Вы можете указать символ-разделитель, который будет использоваться в плагине для разделения разделов.<br />По умолчанию  <b>»</b> </span></td>
        <td class="col-xs-6 col-sm-6 col-md-5">
			<div class="input-group">
			<input name="separator" type="text" placeholder="символ" value="{{separator.print}}" class="form-control" style="max-width: 40px;text-align: center;"/>
			</div>
		</td>
    </tr>

	<tr>
        <td class="col-xs-6 col-sm-6 col-md-7"><h6 class="media-heading text-semibold">Заголовок в категории</h6>
		<span class="text-muted text-size-small">Теги для категории:<br /><b>%cat%</b> - имя категории<br /><b>%num%</b> - переменная<br /><b>%home%</b> - заголовок сайта<br />{{c_title.error}}</span></td>
        <td class="col-xs-6 col-sm-6 col-md-5">
			<div class="input-group">
			<input name="c_title" type="text" placeholder="заголовок" value="{{c_title.print}}" class="form-control"/>
			</div>
		</td>
    </tr>
	
	<tr>
        <td class="col-xs-6 col-sm-6 col-md-7"><h6 class="media-heading text-semibold">Заголовок в полной новости</h6>
		<span class="text-muted text-size-small">Теги в полной новости:<br /><b>%cat%</b> - имя категории<br /><b>%title%</b> - имя новости<br /><b>%home%</b> - заголовок сайта<br /><b>%num%</b> - переменная<br />{{n_title.error}}</span></td>
        <td class="col-xs-6 col-sm-6 col-md-5">
			<div class="input-group">
			<input name="n_title" type="text" placeholder="заголовок" value="{{n_title.print}}" class="form-control"/>
			</div>
		</td>
    </tr>

	<tr>
        <td class="col-xs-6 col-sm-6 col-md-7"><h6 class="media-heading text-semibold">Заголовок главной страницы</h6>
		<span class="text-muted text-size-small">Теги главной страницы:<br /><b>%home%</b> - заголовок сайта<br /><b>%num%</b> - переменная<br />{{m_title.error}}</span></td>
        <td class="col-xs-6 col-sm-6 col-md-5">
			<div class="input-group">
			<input name="m_title" type="text" placeholder="заголовок" value="{{m_title.print}}" class="form-control"/>
			</div>
		</td>
    </tr>

	<tr>
        <td class="col-xs-6 col-sm-6 col-md-7"><h6 class="media-heading text-semibold">Заголовок статической страницы</h6>
		<span class="text-muted text-size-small">Теги статической страницы<br /><b>%home%</b> - заголовок сайта<br /><b>%static%</b> - заголовок статической страницы<br />{{s_title.error}}</span></td>
        <td class="col-xs-6 col-sm-6 col-md-5">
			<div class="input-group">
			<input name="s_title" type="text" placeholder="заголовок" value="{{s_title.print}}" class="form-control"/>
			</div>
		</td>
    </tr>

	<tr>
        <td class="col-xs-6 col-sm-6 col-md-7"><h6 class="media-heading text-semibold">Заголовок остальных страниц</h6>
		<span class="text-muted text-size-small">Теги других страниц (профиль пользователя, личный профиль):<br /><b>%home%</b> - заголовок сайта<br /><b>%other%</b> - заголовок любой другой страницы<br /><b>%num%</b> - номер страницы<br /><b>%html%</b> - переменная<br />{{o_title.error}}</span></td>
        <td class="col-xs-6 col-sm-6 col-md-5">
			<div class="input-group">
			<input name="o_title" type="text" placeholder="заголовок" value="{{o_title.print}}" class="form-control"/>
			</div>
		</td>
    </tr>

	<tr>
        <td class="col-xs-6 col-sm-6 col-md-7"><h6 class="media-heading text-semibold">Страница неверного адреса</h6>
		<span class="text-muted text-size-small">Вывод дополнительной информацию о странице, которая не доступна. Доступные теги:<br /><b>%home%</b> - заголовок сайта<br /><b>%other%</b> - заголовок любой другой страницы<br />{{d_title.error}}</span></td>
        <td class="col-xs-6 col-sm-6 col-md-5">
			<div class="input-group">
			<input name="d_title" type="text" placeholder="заголовок" value="{{d_title.print}}" class="form-control"/>
			</div>
		</td>
    </tr>
	
	<tr>
        <td class="col-xs-6 col-sm-6 col-md-7"><h6 class="media-heading text-semibold">Дополнительная информация для страницы</h6>
		<span class="text-muted text-size-small">Вывод дополнительной информацию о странице (прим. имя тега)  - данных передадутся в переменную %html%<br />{{html_secure.error}}</span></td>
        <td class="col-xs-6 col-sm-6 col-md-5">
			<div class="input-group">
			<input name="html_secure" type="text" placeholder="заголовок" value="{{html_secure.print}}" class="form-control"/>
			</div>
		</td>
    </tr>
	</table>
</div>

<div class="panel-flat">Исключения</div>
<div class="table-responsive">

  <table class="table table-striped">

	<tr>
        <td class="col-xs-6 col-sm-6 col-md-7"><h6 class="media-heading text-semibold">Плагины исключения</h6>
		<span class="text-muted text-size-small">Список плагинов на которых работа плагина не распространяется<br />{{p_title.error}}</span></td>
        <td class="col-xs-6 col-sm-6 col-md-5">
			<div class="input-group">
			<input name="p_title" type="text" placeholder="плагины" value="{{p_title.print}}" class="form-control"/>
			<div class="input-group-append">
				<a class="btn btn-primary" data-toggle="popover" data-placement="top" data-trigger="focus" data-html="true" title="ИСКЛЮЧЕНИЯ" data-content="Каждый плагин указывается через запятую." tabindex="0">
					<i class="fa fa-question"></i>
				</a>
			</div>
			</div>
		</td>
    </tr>

	</table>
</div>

<div class="panel-flat">Переменные</div>
<div class="table-responsive">

  <table class="table table-striped">

	<tr>
        <td class="col-xs-6 col-sm-6 col-md-7"><h6 class="media-heading text-semibold">Переменная %html%</h6>
		<span class="text-muted text-size-small">Вывод дополнительной информацию о странице (прим. имя тега)  - данных передадутся в переменную %html%<br /> Доступные теги:<br /><b>%home%</b> - заголовок сайта<br /><b>%other%</b> - заголовок любой другой страницы<br />{{e_title.error}}</span></td>
        <td class="col-xs-6 col-sm-6 col-md-5">
			<div class="input-group">
			<input name="e_title" type="text" placeholder="заголовок" value="{{e_title.print}}" class="form-control"/>
			</div>
		</td>
    </tr>

	<tr>
        <td class="col-xs-6 col-sm-6 col-md-7"><h6 class="media-heading text-semibold">Переменная %num%</h6>
		<span class="text-muted text-size-small">Форматирование номера страницы (например, Страница 4 [Страница %count%] - где %count% номер страницы) - данных передадутся в переменную %num%<br />{{num_title.error}}</span></td>
        <td class="col-xs-6 col-sm-6 col-md-5">
			<div class="input-group">
			<input name="num_title" type="text" placeholder="заголовок" value="{{num_title.print}}" class="form-control"/>
			</div>
		</td>
    </tr>
	</table>
</div>

<div class="panel-footer" align="center" style="margin-left: -20px;margin-right: -20px;margin-bottom: -20px;">
	<input name="submit" type="submit"  value="Сохранить" class="btn btn-success" />
</div>

<!-- <tr>
	<td colspan=2>
		<fieldset class="admGroup">
		<legend class="title">Настройки &lt;title&gt;&lt;/title&gt;</legend>
			<table width="100%" border="0" class="content">






				<tr>
					<td class="contentEntry1" valign=top><br /><small>Ключи:<br /><b>%cat%</b> - имя категории<br /><b>%title%</b> - имя новости<br><b>%home%</b> - заголовок сайта<br /><b>%static%</b> - заголовок статической страницы<br /><b>%other%</b> - заголовок любой другой страницы<br><b>%s%</b> - Символ разделитель<br></small></td>
					<td class="contentEntry2" valign=top></td>
				</tr>
			</table>
		</fieldset>
	</td>
</tr> -->

</form>