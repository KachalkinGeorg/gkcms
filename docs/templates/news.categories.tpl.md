# Шаблон `news.categories.tpl`

В отличии от старого варианта, этот шаблон отвечает за генерацию полного меню, а не строки меню.

Данный шаблон используется для удобной генерации меню категорий взамен старого шаблона `categories.tpl`.

## Доступные блоки / переменные

Переменные:

- `entries` - массив категорий, каждый элемент массива содержит данные по одной категории:
    - `id` - ID категории
    - `cat` - наименование категории
    - `link` - ссылка для перехода в категорию
    - `mark` - маркер для категории данного уровня (берётся из `variables.ini` - блок [`category_tree`], параметр `mark.level.<УРОВЕНЬ>`, а при отсутствии – `mark.default`)
    - `level` - уровень вложенности категории (0 - в корне)
    - `counter` - кол-во постов в категории
    - `icon` - ссылка на иконку категории
    - `closeToLevel` - переменная определена если данная категория закрывает собой какой-либо уровень вложенности, переменная содержит уровень *к которому* закрывается данная категория
    - `flags` - блок переменных-флагов:
        - `active` - принимает значение `true` (1) в случае, если сейчас пользователь находится именно в этой категории
        - `counter` - принимает значение `true` (1) в случае, если в настройке CMS разрешено отображение счетчика новостей в категории
        - `hasChildren` - принимает значение `true` (1) в случае, если у данной категории есть подкатегории
        - `closeLevel_X` - принимает значение `true` (1) в случае, если данная категория закрывает собой уровень вложенности `X`

### Совместимость со старым шаблонизатором

Далеко не всем нравится синтаксис TWIG, поэтому для наиболее сложных в восприятии созданы элементы-синонимы.

- `[entries]..[/entries]` - повторяющийся блок (для каждой категории)
- `[flags.active]..[/flags.active]` - условный блок, содержимое активно если пользователь сейчас находится в этой категории
- `[!flags.active]..[/!flags.active]` - условный блок, содержимое активно если пользователь сейчас не находится в этой категории
- `[flags.counter]..[/flags.counter]` - условный блок, содержимое активно если в настройке CMS разрешено отображение счетчика новостей в категории

## Пример заполнения шаблона

Меню категорий:

```html
{% for entry in entries %}
    <!-- Выводим маркер категории -->
    {{ entry.mark }}

    <!-- Если не стоит флаг `flags.active`, т.е. если эта категория - не текущая, то показываем ссылку -->
    <!-- В текущей категории показываем имя категории жирным шрифтом -->
    {% if (not entry.flags.active) %}
        <a href="{{ entry.link }}">
    {% else %}
        <b>
    {% endif %}

        {{ entry.cat }}

    {% if (not entry.flags.active) %}
        </a>
    {% else %}
        </b>
    {% endif %}

    <!-- Отображаем кол-во новостей в категории только в случае, если выставлен флаг `flags.counter` -->
    {% if (entry.flags.counter) %}
        [{{ entry.counter }}]
    {% endif %}
{% endfor %}
```

## Пример заполнения шаблона с вложенными уровнями через `<ul>..</ul>`

Меню категорий:

```html
{% for entry in entries %}
    <li>
    <!-- Если не стоит флаг `flags.active`, т.е. если эта категория - не текущая, то показываем ссылку -->
    <!-- В текущей категории показываем имя категории жирным шрифтом -->
    {% if (not entry.flags.active) %}
        <a href="{{ entry.link }}">
    {% else %}
        <b>
    {% endif %}

        {{ entry.cat }}

    {% if (not entry.flags.active) %}
        </a>
    {% else %}
        </b>
    {% endif %}

    <!-- Отображаем кол-во новостей в категории только в случае, если выставлен флаг `flags.counter` -->
    {% if (entry.flags.counter) %}
        [{{ entry.counter }}]
    {% endif %}

    <!-- Если у категории есть подкатегории, то открываем новый уровень вложенности -->
    {% if (entry.flags.hasChildren) %}
        <ul>
    {% else %}
        </li>
        <!-- Если после этой категории закрывается 1 или несколько уровней - выводим закрывающиеся </ul> -->
        {% if isSet(entry.closeToLevel) %}
            {% for i in (entry.closeToLevel+1) .. entry.level %}
                </ul></li>
            {% endfor %}
        {% endif %}
    {% endif %}
{% endfor %}
```

## Пример заполнения шаблона / режим совместимости

Меню категорий:

```html
[entries]
    <!-- Выводим маркер категории -->
    {{ entry.mark }}

    <!-- Если не стоит флаг `flags.active`, т.е. если эта категория - не текущая, то показываем ссылку -->
    <!-- В текущей категории показываем имя категории жирным шрифтом -->
    [!flags.active]<a href="{{ entry.link }}">[/!flags.active]

    [flags.active]<b>[/flags.active]

        {{ entry.cat }}

    [!flags.active]</a>[/!flags.active]

    [flags.active]</b>[/flags.active]

    <!-- Отображаем кол-во новостей в категории только в случае, если выставлен флаг `flags.counter` -->
    [flags.counter]
        [{{ entry.counter }}]
    [/flags.counter]
[/entries]
```
