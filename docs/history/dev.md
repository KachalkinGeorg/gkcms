Для разработчиков
============================

В этом разделе буду пояснять возможности использования движка в создании или изменении плагинов.

# Плагины
Плагины поменяли свой дизайн добавились новые функции в движке и соответственно появились новые требования к ним.

### иконка для плагина
Чтобы появилась возможность отображения иконку у плагина (на страницы плагинов), надо в файле version прописать строку:
```html
Icon: <i class='fa fa-bookmark fa-2x'></i>
```
Или поместить в плагин файл изображения в формате png с разрешением 70х70 с именем logo (даный момент пока реализован на 50%)

### редирект

Для ридиректа страниц доступна системная функция function redirect($url) пример использования:
```html
default: redirect('?mod=extra-config&plugin=actors');
```
Где:
actors - Имя Вашего плагина.

# Использовании новых уведомлений

![](images/history/dev_1.jpg){.img-fluid}

ВАЖНО ЗНАТЬ!
Что в системе используются breadcrumb (Хлебные Крошки), уведомления и они взаимосвязаны между собой.

### Alert и ngNotifyWindow
Использования всплывающих уведомлений Alert и ngNotifyWindow в системе переделана функция msg, которая выполняет действия уведомлений. 

- Использования Alert:
В php:
```
return array('status' => 1, 'errorCode' => 0, 'info' => 'Дубликаты новостей не найдены!');
```
или
```
msg(array('type' => 'danger', 'title' => 'msge_save_error', 'message' => 'msge_save_error#desc'));
```
```
msg(['type' => 'info', 'text' => $lang['msge_mod']]);
```
Поддерживает:
type:
info ```-``` готово
error / danger ```-``` ошибка
warning ```-``` предупреждение

title:
Заголовок уведомления заключенный в тег ```<b>ЗДЕСЬ ЗАГОЛОВОК</b> <br>```
text:
Содержимое информации
info:
Дополнительная информация перед текстом будет ```<br /><i class="fa fa-exclamation"></i>```

- Использования ngNotifyWindow:
В php или js:
```
ngNotifySticker('ТЕКСТ ИНФОРМАЦИИ', {className: 'stickers-success'});
```
или
```
ngNotifySticker('ТЕКСТ ИНФОРМАЦИИ', {className: 'stickers-success', sticked: 'true', closeBTN: true});
```
Где: className:
stickers-info ```-``` инфо
stickers-danger ```-``` ошибка
stickers-success ```-``` готово
stickers-warning ```-``` предупреждение

sticked:
true ```-``` прикрепить
false ```-``` открепить

closeBTN:
true ```-``` отображать 
false ```-``` не отображать

- Другой метод вызова
При использования в php:
```
return ['status' => 1, 'errorCode' => 0, 'errorText' => $lang['dbcheck_ok']];
```
Где 
status ```0 -``` ошибка
status ```1 -``` готово
errorCode ```- от 1 до х``` выводит текст ```(Error [цифра]:)```

В js:
```
return $.notify({message: '{{ lang.news['msge_title'] }}'},{type: 'danger'});
```

P.S. ngNotifySticker эта замена окон alert

- Применения для сайта.
Пример:
```
msg(array("type" => "info", "text" => 'Предупреждения выписаны<br><a href=/>Вернуться</a><br>'));
```


### При совершении каких либо действий
ИСпользования системных уведомлений действий.
в php функция вызова
```html
print_msg( 'ИНФО', 'ЗАГОЛОВОК', 'ОПИСАНИЕ', 'ССЫЛКА' );
```
Системная функция ```print_msg``` имеет ряд характестик:
В строку ИНФО заполняем так:

- info - означает выполнено
- error - означает ошибку
- warning - означает предупреждение
- delete - означает удаление
- cache - означает очистку
- update - означает обновление
- success - означает применено

В строку ЗАГОЛОВОК указываем имя плагина
В строку ОПИСАНИЕ указываем описания действия исходя из строки ИНФО
В строку ССЫЛКА указываем действия например:
Использования одной кнопки (по умолчанию именуется кнопкой ВЕРНУТЬСЯ НАЗАД )
Принудительное использование напримере images и actors (имя плагина)
система: ```?mod=images```  плагин: ```?mod=extra-config&plugin=actors```
или
```javascript:history.go(-1)``` которая возвращает страницу назад

Пример:
```
return print_msg( 'info', 'Раздел аддонов', 'Настройки успешно сохранены!', 'javascript:history.go(-1)' );
```
Результат:
![](images/history/dev_1.0.jpg){.img-fluid}

Использования двух и более кнопок. (Использования array)
```array('?mod=extra-config&plugin=addon&action=cat_edit&id='.$id => 'Редактировать еще', '?mod=extra-config&plugin=addon&action=list_cat' => 'Вернуться назад' )```

Пример:
```
return print_msg( 'update', 'Раздел аддонов', 'Категория '.$cat_name.' успешно отредактирована!', array('?mod=extra-config&plugin=addon&action=cat_edit&id='.$id => 'Редактировать еще', '?mod=extra-config&plugin=addon&action=list_cat' => 'Вернуться назад' ) );
```
Результат:
![](images/history/dev_1.1.jpg){.img-fluid}

Таким образом мы получаем действия при совершении чего либо. Если же такого не будет, то система выдаст пустое окно.

### Использования breadcrumb
![](images/history/dev_1.2.jpg){.img-fluid}
breadcrumb глобальная функция и чтоб ее использовать, нужно ее прописывать в ```global``` например так:
```
function about()
{global $twig, $lang, $breadcrumb;

	$breadcrumb = breadcrumb('ИКОНКА<span class="text-semibold">ЗАГОЛОВОК</span>', 'ЗАГОЛОВОК' );
	
	здесь какие-то данные
}
```
breadcrumb может иметь такой вид:
```
$breadcrumb = breadcrumb('ИКОНКА<span class="text-semibold">ЗАГОЛОВОК 1</span>', 'ЗАГОЛОВОК 2' );
```
или такой
```
$breadcrumb = breadcrumb('ИКОНКА<span class="text-semibold">ЗАГОЛОВОК 1</span>', array('ССЫЛКА' => '<i class="fa fa-puzzle-piece btn-position"></i>НАЗВАНИЕ', 'ЗАГОЛОВОК 2' ) );
```
ГДЕ:
- ИКОНКА пример```<i class="fa fa-address-card btn-position"></i>``` btn-position должен быть
- ЗАГОЛОВОК ```1``` см. на скриншоте
- ЗАГОЛОВОК ```2``` см. на скриншоте
- ССЫЛКА использовать можно как одну, так и более, или не использовать совсем. Для двух и более используем ```array```




### использования модального окна

Для вызова модального окна была прописана системная функция function print_modal_dialog($id, $title, $text, $action)
ГДЕ:
$id - ИД окна
$title - Имя шапки окна
$text - Содержания внутри окна
$action - Действие

Как это работает:
Для вызова окна нужно прописать, если:
через $tVars (где del переменная шаблона на действие вызова окна)
```html
'del' => '<a href="#" data-toggle="modal" data-target="#modal-'.$row['id'].'" />Удалить</a>',
```
через tpl файл шаблона (где {id} переменная в $tVars)
```html
<a href="#" data-toggle="modal" data-target="#modal-{id}" />Удалить</a>
```
Для появления окна нужно прописать следующее:
В $tVars
```html
'modal' => print_modal_dialog('здесь указываем ИД', 
'Здесь заголовок окна', 
'Здесь содержания окна, какой небудь текст', 
'<a href="ссылка на действие" class="btn btn-outline-success">да</a>'),
```
Доступен тег:
{modal}

Пример в tpl файла
```html
<a href="#" data-toggle="modal" data-target="#modal-{id}" />Удалить</a>{modal}
```

### при использовании вызова окна профиля пользователя
```html
print_show_profile($userROW['id'], $userROW['name'], '');
$userROW['id'] - ИД пользователя
$userROW['name'] - Имя пользователя
'' - пока тестируется
```

### при использовании онлайн/оффлайн пользователя
```html
on_of_line($row['id']) - $row['id'] обязательный ИД пользователя
```
Используется тег:
```{line}``` в файле ```usermenu.tpl``` сайта

# Всплывающие подсказки popover
В шаблон админки встроена функция всплывающих подсказок popover
```html
	$(document).ready(function() {
		$('[data-toggle="popover"]').popover()
	});
 ```
Теперь данную функцию могут использовать плагины. Пример использования:
```html
<a class="btn btn-outline-primary" data-toggle="popover" data-placement="top" data-trigger="focus" data-html="true" title="ЗАГОЛОВОК" data-content="ЗДЕСЬ СОДЕРЖАНИЕ ПОДСКАЗКИ" tabindex="0">
	<i class="fa fa-question"></i>
</a>
```
```data-toggle="popover"``` - вызов подсказки
```data-placement="top"``` - направление подсказок ```(right, left, bottom, top)```
```title="ЗАГОЛОВОК"``` - Заголовок
```data-content="ЗДЕСЬ СОДЕРЖАНИЕ ПОДСКАЗКИ"``` - содержание подсказки

### Глобальные теги
Для использования разных шаблонов сайта, по мимо тега ``` {{ htmlvars }} ``` стал доступен важный тег ``` {{ headers }} ``` его наличие обязательно для подключения.
``` {{ headers }} ``` использует библиотеку подключения jQuery, а также таких скриптов системы как functions.js и ajax.js, которые раньше подключались не посредственно в самом шаблоне, и engine.css стиль - главный стиль для всех шаблонов, в нем уже включены стиль модульных окон и многое другое.
Теперь для их доступа используем один тег, пример его подключения:
```html
	<title>{{ titles }}</title>
	{{ htmlvars }}
	{{ headers }}
```
Рядом с ```{{ htmlvars }}``` или между тегами в main.tpl ``` <head> </head> ``` вставляем тег ``` {{ headers }} ```

# Подключения плагинов к шаблону админ панели (публикации)
Изменился способ подключения плагинов, которые используют шаблон админ панели. Для того, чтобы не использовать ручное подключение ( в add.tpl и edit.tpl) к примеру:
```
{% if (pluginIsActive('actors')) %}
	{{ plugin.actors }}
{% endif %}
```
Была добавлена переменная ```extends```, которая делает всю эту процедура. Но для этого сам плагин должен иметь такую возможность. Рассмотрим примеры старого подключения и нового:

Старое
```
		global $tpl;
		$tpath = locatePluginTemplates(array('actors_addnews'), 'actors', intval(pluginGetVariable('actors', 'localsource')));
		$tpl->template('actors_addnews', $tpath['actors_addnews']);
		$tpl->vars('actors_addnews', array('vars' => array('localPrefix' => localPrefix)));
		$tvars['plugin']['actors'] = $tpl->show('actors_addnews');

```
подключение через переменную ```$tvars``` в функцию ```function addNewsForm(&$tvars)``` означает, чтобы плагин отобразился нужно было его прописать тегом ```{{ plugin.actors }}``` файла ```add.tpl``` админ шаблона сайта.
Новое:
```
		global $twig, $lang;

        $ttvars = array(
            'localPrefix' => localPrefix,
			'admin_url' => admin_url,
            );

		$extends = 'main';

		$tpath = locatePluginTemplates(array('actors_addnews'), 'actors', pluginGetVariable('actors', 'localsource'));
        $tvars['extends'][$extends][] = [
			'title' => 'Список авторов',
			'body' => $twig->render($tpath['actors_addnews'].'/actors_addnews.tpl', $ttvars),
			];
```
подключение через ```$extends``` в функцию ```function addNewsForm(&$tvars)``` означает, что подкючать ничего не надо, плагин отобразится сам при его активации.
Переменная ```extends``` имеет ряд нескольких подключений, пример:
- ```$extends = 'main';``` - подключается к Основному содержанию
- ```$extends = 'meta';``` - подключается к Мета вкладки
- ```$extends = 'additional';``` - подключается к Дополнительно
- ```$extends = 'owner';``` - используется ниже основной части и имеет отдельную шапку от остального
- ```$extends = 'sidebar';``` - подключается к правой части и служит дополнительной информацией (виджет)
- ```$extends = 'js';``` - подключается как скрипт
- ```$extends = 'css';``` - подключается как стиль
Используется папка в ```$tpath``` ```admin``` путь до нее должен быть такой: ```tpl\admin\actors_addnews.tpl``` где ```actors_addnews.tpl``` файл в котором находится содержания вывода информации
В ```'body'``` находится основная информация
В ```'title'``` отвечает за заголовок
В ```$ttvars``` поддержка переменных файла ```actors_addnews.tpl```

# Подключения плагинов к шаблону админ панели (статистических страниц)

Так же как и с новостями была добавлена переменная ```extends``` которое имеет одно подключение
- ```$extends = 'main';``` - подключается к Основному содержанию статьи


© 2008-2022 Next Generation CMS
