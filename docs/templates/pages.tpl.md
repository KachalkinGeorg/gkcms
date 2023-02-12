# Шаблон `pages.tpl`

Шаблон используется для генерации постраничной навигации (совместно с конфигурационным файлом <a href="variables.ini.html">variables.ini</a>).

Данный шаблон отвечает за генерацию разметки блока постраничной навигации.

## Доступные блоки / переменные

### Блоки:

- `flags` – блок переменных-флагов:
    - `previous_page` – содержимое блока отображается в случае, если имеется ссылка на предыдущую страницу;
    - `next_page` – содержимое блока отображается в случае, если имеется ссылка на следующую страницу;
- `previous_page` – блок, содержащий ссылку на предыдущую страницу;
- `next_page` – блок, содержащий ссылку на следующую страницу;
- `pages` – блок постраничной навигации.

### Переменные:

- `previous_page_url` – ссылка на предыдущую страницу, если такая страница есть;
- `next_page_url` – ссылка на следующую страницу, если такая страница есть.

### Доступные языковые переменные:

- `{{ lang['prevpage'] }}` – текст ссылки на предыдущую страницу;
- `{{ lang['nextpage'] }}` – текст ссылки на следующую страницу.


## Пример заполнения шаблона

```html
<div class="pagination">
	<ul>
		{% if (flags.previous_page) %}
			{{ previous_page }}
		{% endif %}

		{{ pages }}

		{% if (flags.next_page) %}
			{{ next_page }}
		{% endif %}
	</ul>
</div>
```