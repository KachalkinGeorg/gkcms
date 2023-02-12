# Шаблон `lostpassword.entries.tpl`

Данный шаблон отвечает за показ стандартного поля ввода (*название*, *описание*, *HTML-код*) в шаблоне восстановления пароля.

Более детально о восстановлении паролей можно прочитать в описании шаблона [lostpassword.tpl](templates/lostpassword.tpl.md).

## Доступные блоки/переменные

### Переменные:

- `title` – название поля ввода.
- `descr` – описание поля ввода.
- `input` – код *HTML* поля ввода.

## Пример заполнения шаблона

В примере показан минимально набор для полнофункциональной работы:

```html
{title} ({descr}): {input}
```