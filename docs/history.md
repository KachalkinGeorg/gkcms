ИСТОРИЯ
=======

Изменения от KachalkinGeorg

КРАТКОЕ СОДЕРЖАНИЕ

-  Был переделан parseclass для более корректно отображения, изменены не которые переменные, прописан в систему highslide для удалённых картинок, а также выведен данный пункт в настройках для изменения размера изображения для его отображения на сайте
-  Прописаны ajax preolader для сайта, а также в не которых плагинах, таких как комментарии, рейтинг, жалоба на новость и закладки пользователей.
-  Переделан стиль админки, добавлены не которые функции для визуализации, теперь админ панель имеет новый дизайн.
-  Проработана система уведомлений различных действий при:
	-  добавлении и редактировании или удалении новости, статьи, категории
	-  сохранении настроек
	-  а также при каких либо действий, будет выводится страница с уведомлением о том, что произошло (alert уведомления ни куда не ушли, также выводятся.)
	Данная реализация работает также со всеми плагинами!
-  Изменен плагин Форума, прописаны не которые настройки в админ панели.
-  Добавлена фиксация новости.
-  Добавлена мета тег robots для новости.
-  Добавлена функция Исключить из поиска по сайту.
-  Статус онлайн и оффлайн пользователя.
-  Запрет к просмотру публикаций групп пользователей.
И многое другое...

ПОДРОБНАЯ ЧАСТЬ:

<b>★</b> <a href="/engine/admin.php?mod=docs&amp;file=history/adminpanel.md">Админ панель</a>
<b>★</b> <a href="/engine/admin.php?mod=docs&amp;file=history/notif.md">Новые уведомления</a>
<b>★</b> <a href="/engine/admin.php?mod=docs&amp;file=history/plugin.md">Управления плагинами</a>
<b>★</b> <a href="/engine/admin.php?mod=docs&amp;file=history/temp.md">Управления шаблонами</a>
<b>★</b> <a href="/engine/admin.php?mod=docs&amp;file=history/setting.md">Новое в настройках скрипта</a>
<b>★</b> <a href="/engine/admin.php?mod=docs&amp;file=history/public.md">Публикации</a>
<b>★</b> <a href="/engine/admin.php?mod=docs&amp;file=history/global.md">Глобально</a>
<b>★</b> <a href="/engine/admin.php?mod=docs&amp;file=history/seo.md">seo</a>
<b>★</b> <a href="/engine/admin.php?mod=docs&amp;file=history/dev.md">Для разработчиков</a>

РАЗНОЕ

# Работа с highslide

	Для паботы highslide нужно в main.tpl после тега <head> прописать следующее:
## Пример заполнения шаблона
```html
	<script type="text/javascript" src="{{ home }}/engine/includes/highslide/highslide.js"></script>
	<link rel="stylesheet" type="text/css" href="{{ home }}/engine/includes/highslide/highslide.css" />
	<script type="text/javascript">
		hs.graphicsDir = '{{ home }}/engine/includes/highslide/graphics/';
		hs.wrapperClassName = 'wide-border';
		hs.headingEval = 'this.a.title';
		hs.align = 'center';
		hs.transitions = ['expand', 'crossfade'];
		hs.outlineType = 'rounded-white';
		hs.fadeInOut = true;
		//hs.dimmingOpacity = 0.75;

		// Add the controlbar
		hs.addSlideshow({
			//slideshowGroup: 'group1',
			interval: 5000,
			repeat: false,
			useControls: true,
			fixedControls: 'fit',
			overlayOptions: {
				opacity: .75,
				position: 'bottom center',
				hideOnMouseOut: true
			}
		});
	</script>
```
	При такой возможности появляются стрелки на изображениях.

# Работа с высплывающем уведомлением ALERT
Была добавлена функция вызову futu_alert не для админки, а для сайта, для его вызова в скрипте выполнения какой либо функции:
Если действие прошло удачно.
```html
futu_alert("Здесь заголовок", "Здесь текст сообщения", false, "save");
```
Если действие завершилось с ошибкой
```html
futu_alert("Здесь заголовок", "Здесь текст сообщения", false, "error");
```
В стили css прописать следующее:
```html
.futu_alert_outer {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	z-index: 9999;
}
.futu_alert_outer .frame {
	position: relative;
	z-index: 9999;
}
.futu_alerts_holder {
	position: absolute;
	left: 69%;
	top: 0;
	width: 30%;
	z-index: 9999;
}
.futu_alerts_holder .futu_alert {
	position: absolute;
	top: -1000px;
	background-color: #ffeba0;
	font: 1.2em Tahoma, sans-serif;
	border: 1px solid #ffffff;
	margin-left: 60px;
}
.futu_alerts_holder .futu_alert .futu_alert_header {
	font-size: 1.2em;
	margin: 10px 20px 0;
}
.futu_alerts_holder .futu_alert .futu_alert_text {
	font-size: 0.9em;
	margin: 10px 20px;
}
.futu_alerts_holder .futu_alert .futu_alert_close_button {
	position: absolute;
	padding: 10px;
	top: 0;
	right: 0;
	outline: none;
}
.futu_alerts_holder .message {
	color: #fff;
	background-color: #6690c9;
}

.futu_alerts_holder .error {
    color: #fff;
    background-color: #ff0000;
    border: 1px solid #ff0000;
}
.error:before {
    background-color: #7e2525;
    content: "\26A0";
    border-radius: 50%;
    border-left-style: solid;
    border-right-style: solid;
    width: 1.5em;
    height: 1.5em;
    top: 16px;
    transform: translateX(-50%);
    position: absolute;
    text-align: center;
    padding: 4px;
}
.futu_alerts_holder .save {
    color: #fff;
    background-color: #007a07;
    border: 1px solid #007a07;
}
.save:before {
    background-color: #1c538b;
    content: "\2139";
    border-radius: 50%;
    border-left-style: solid;
    border-right-style: solid;
    width: 1.5em;
    height: 1.5em;
    top: 16px;
    transform: translateX(-50%);
    position: absolute;
    text-align: center;
	padding: 4px;
}
```
ПРИМЕР ИСПОЛЬЗОВАНИЯ для сообщений:
открыть файл comments.form.tpl и найти строки
```html
if (resRX['status']) {
```
Заменить код на этот:

```html
					if (resRX['status']) {
						// Added successfully!
						form.content.value = '';
						futu_alert("Комментарий", "Вы добавили комментарий", false, "save");
						} else {
						futu_alert("Ошибка", "Комментарий не добавлен", false, "error");
					}
```

# Окно loading-layer
Прописана функция loading-layer для пользователей сайта. 
В стиль css прописать
```html
#loading-layer {display:none;padding:15px;border-radius:4px;border:1px solid #222;color:#fff;background-color:#444;z-index:99999!important;}#loading-layer i.fa{margin-right:8px;}
```
В main.tpl в самом в конце
```html
<div id="loading-layer"><i class="fa fa-spinner fa-pulse"></i>Пожалуйста, подождите . . .</div>
```

И там где нужно в плагине в его скрипте вставляем:
```html
ngShowLoading();
```
это для выполнения скриптовой загрузки

Для завершения скрипта, чтбы не было цикличного выполнения прописать:
```html
ngHideLoading();
```
Если в скрипте куда вставили нет завершения (onComplete), момента выполнения действия, то:
```html
		cajax.onComplete = function () {
		ngHideLoading();
		}
```


# Окно Popup
Была добавлена функция print_popup_dialog имеющих свой ID для вызова окна в пользовательской части сайта. Ее использовать могут, и плагины, и для вызова какой либо информации.
Пример использования для плагинов через $tVars
```html
$popup = print_popup_dialog('rdc'.$row['id'].'', 'Здесь заголовок окна', 'Здесь различная информация - текст');
$tvars['vars']['rang_news_dc'] = '<a href="#rdc'.$row['id'].'" class="popup-btn">кликни меня</a>'.$popup.'';
```
ИД номер ```html#rdc'.$row['id'].'``` и ```html'rdc'.$row['id'].''``` должны совподать между собой, где rdc может иметь любое другое имя, при таком раскладе ИД не будет путаться например вызов будет таким (rdc1) вместо (1)

Пример использования для обычного использования без ИД
вызов окна
```html
<a href="#show" class="popup-btn">кликни меня</a>
```
Само окно popup:
```html
<div id="show" class="popup">
	<div class="popup-wrapper">
		<div class="popup-inner">
			<div class="popup-header">
				<div class="popup-title">Здесь заголовок</div>
                <a href="#close" title="Закрыть" class="popup-close"><i class="fa fa-times-circle fa-2x"></i></a>
            </div>
            <div class="popup-text">Здесь содержания окна</div>
  		</div>
  	</div>	
</div>
```

В класс css своего стиля шаблона обязательно прописать:
```html
.popup {
	opacity: 0;
	background: rgb(102 102 102 / 36%);
	pointer-events: none;
 	position: fixed; 
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    z-index: 9999;
	transition: all 0.5s ease;
    margin: 0;
    padding: 0;
}
.popup:target {
    opacity: 1;
	pointer-events: auto;
    overflow-y: auto;
}
.popup-wrapper {
	margin:auto;
	margin-top:25vh;
}
.popup-inner {
    position: relative;
    background: #fff;
    border-radius: 0px;

}
.popup-header {
    padding: 10px;
    background:#000;
	position:relative;
}
.popup-title {
    text-align: center;
    padding: 10px;
    margin-left: 10px;
    margin-right: 10px;
}
.popup-close {
  position: absolute;
  font-size: 10px;
  cursor: pointer;
  right: 4px;
  top: 4px;
}
.popup-close:hover, .popup-close:focus {
    color: #fff;
    cursor: pointer;
}
.popup-text {
  padding: .5em 1em;
}

@media (min-width: 550px) {
  .popup-wrapper {
      max-width: 500px;
   }
}
/**end.Модальное окно**/
```

# Окно Profile

Добавлено Модальное окно при клике по профилю пользователя в системе и в таких плагинах как:
 - comments
 - uprofile

Вызов окна осуществляется:
```html
<a href="#{{ global.user.id }}" title="{{ lang['myprofile'] }}">
```
Где:
```html
{{ global.user.id }} - это ИД пользователя
```
Переменная вызова html разметки окна служит тег:
```html
{{ profile_show }}
```

# Свой шаблон групп пользователей
В плагин uprofile добавлена возможность активировать свой стиль для разных групп.
По умолчанию плагин использует общий вид, а при активации доступны файлы ```users_1.tpl``` до ```users_4.tpl``` и ```profile_1.tpl``` до ```profile_4.tpl``` где ```1-4``` это группы, если добавили несколько групп, больше чем установленно, то нужно будет создать users_x.tpl и profile_x.tpl где x номер группы

# Новые теги пользователей

```{{ alt_name }}``` - Имя пользователя
```{{ gender }}``` - Пол пользователя
Доступно в системе при создании и редактировании пользователя и в таких плагинах как:
uprofile 
auth_basic - при регистрации

# Изменения плагин auth_basic
Базовой регистрации пользователей
В настройках плагина были добавлены новые теги Имя пользователя и Пол пользователя, а также появилась возможность выбирать группу в которой пользователь будет находиться при регистрации. Таки группы как администратор с идентификатором ```1``` и до ```3``` с повышеными привилегиями доступ будет закрыт, выбор производится только от ```4``` группы и так далее вновь созданных.

# Картинка из полной новости в краткую
Появилась возможность вытащить картинку из полной новости в краткую для этого в файле news.short.tpl прописать: 

```html
{% if (news.embed.imgCount > 0) %}
<div style="float:left;">
<img src="{{ news.embed.images[0] }}"  title="{title}" alt="{{ news.title }}"  />
</div>
{% else %}
<div style="float:left;">
<img src="{{ tpl_url }}/images/no_image.gif" title="{title}" alt="{{ news.title }}"  />
</div>
{% endif %}
```

Возможно в дальнейшем будут изменения

© 2022-2022 Next Generation CMS
