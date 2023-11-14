function insertfortext(teg,val,field){
	try{
		var msgfield=document.getElementById((field=='')?'content':field);
		}
		catch(err){
			return false;
		}
	var open='['+teg+'="'+val+'"]';var close='[/'+teg+']';
	if(document.selection&&document.selection.createRange){
		msgfield.focus();
		sel=document.selection.createRange();
		sel.text=open+sel.text+close;
		msgfield.focus();
	}else if(msgfield.selectionStart||msgfield.selectionStart=="0"){
		var startPos=msgfield.selectionStart;
		var endPos=msgfield.selectionEnd;msgfield.value=msgfield.value.substring(0,startPos)+open+msgfield.value.substring(startPos,endPos)+close+msgfield.value.substring(endPos,msgfield.value.length);msgfield.selectionStart=msgfield.selectionEnd=endPos+open.length+close.length;msgfield.focus();
	}else{
		msgfield.value+=open+close;msgfield.focus();
	}
	return true;
}

function insertext(open, close, field) {
    msgfield = document.getElementById((field != '') ? field : 'content');

    // IE support
    if (document.selection && document.selection.createRange){
        msgfield.focus();
        sel = document.selection.createRange();
        sel.text = open + sel.text + close;
        msgfield.focus();
    }
    // Moz support
    else if (msgfield.selectionStart || msgfield.selectionStart == "0"){
        var startPos = msgfield.selectionStart;
        var endPos = msgfield.selectionEnd;

        msgfield.value = msgfield.value.substring(0, startPos) + open + msgfield.value.substring(startPos, endPos) + close + msgfield.value.substring(endPos, msgfield.value.length);
        msgfield.selectionStart = msgfield.selectionEnd = endPos + open.length + close.length;
        msgfield.focus();
    }
    // Fallback support for other browsers
    else {
        msgfield.value += open + close;
        msgfield.focus();
    }
    $('html, body').animate({ scrollTop: $(msgfield).offset().top-200 }, 888);
    return;
}

// Request JSON - new style ajax
$.reqJSON = function(url, method, params, callback, notPreload) {
    $.ajax({
        type: 'POST',
        url: url,
        cache: false,
        dataType: 'json',
        data: {
            json: 1,
            rndval: new Date().getTime(),
            methodName: method,
            reqReferer: window.location.href,
            params: JSON.stringify(params),
        },
        beforeSend: function(jqXHR) {
            if (!notPreload) {
                ngShowLoading();
            }
            jqXHR.overrideMimeType("application/json; charset=UTF-8");
            // Repeat send header ajax
            jqXHR.setRequestHeader("X-Requested-With", "XMLHttpRequest");
        },
    })
    .done(function(data, textStatus, jqXHR) {
        if (typeof(data) == 'object') {
            // this schema {"status": 1, "errorCode": 0, "errorText": ""}
            // if data.length > 3 => callback this
            if (data.status || Object.keys(data).length > 3) {
                callback.call(null, data);
            } else {
                $.notify({message:data.errorText},{type: 'danger'});
                //$.notify({message:'Error ['+data.errorCode+']: '+data.errorText},{type: 'danger'});
            }
        } else {
            data = $.parseJSON(data);
            if (typeof(data) == 'object') {
                callback.call(null, data);
            } else {
                $.notify({message: '<i><b>Bad reply from server</b></i>'},{type: 'danger'});
            }
        }
    })
    .always(function(jqXHR, textStatus, errorThrown) {
        ngHideLoading();
    })
    .catch(function(jqXHR, textStatus, exception) {
        if (jqXHR.status === 0) {
            $.notify({message: 'Not connect.n Verify Network.'},{type: 'danger'});
        } else if (jqXHR.status == 404) {
            $.notify({message: 'Requested page not found. [404]'},{type: 'danger'});
        } else if (jqXHR.status == 500) {
            $.notify({message: 'Internal Server Error [500].'},{type: 'danger'});
        } else if (exception === 'parsererror') {
            $.notify({message: 'Requested JSON parse failed.'},{type: 'danger'});
        } else if (exception === 'timeout') {
            $.notify({message: 'Time out error.'},{type: 'danger'});
        } else if (exception === 'abort') {
            $.notify({message: 'Ajax request aborted.'},{type: 'danger'});
        } else {
            $.notify({message: 'Uncaught Error.n ' + jqXHR.status + ': ' + jqXHR.statusText},{type: 'danger'});
        }
    });
}

/* DINAMIC TIME - cData (twig)*/
UsAgentLang = (navigator.language || navigator.systemLanguage || navigator.userLanguage).substr(0, 2).toLowerCase();

Lang = {}
// Выбираем нужную локализацию.
switch (UsAgentLang) {
    case 'ru' :
        Lang.Now = 'только что';
        Lang.Ago = 'назад';
        Lang.After = 'через';
        Lang.NameMonths = ['Января', 'Февраля', 'Марта', 'Апреля', 'Мая', 'Июня', 'Июля', 'Августa', 'Сентября', 'Октября', 'Ноября', 'Декабря'];
        Lang.NameMonthsMin = ['Янв', 'Фев', 'Мар', 'Апр', 'Май', 'Июн', 'Июл', 'Авг', 'Сен', 'Окт', 'Ноя', 'Дек'];
        Lang.NameWeekdays = ['Воскресенье', 'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота'];
        Lang.NameWeekdaysMin = ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'];
        Lang.DimensionTime = {
                'n' : ['месяцев', 'месяц', 'месяца', 'месяц'],
                'j' : ['дней', 'день', 'дня'],
                'G' : ['часов', 'час', 'часа'],
                'i' : ['минут', 'минуту', 'минуты'],
                's' : ['секунд', 'секунду', 'секунды']
        }
        break;
    default:
        Lang.Now = 'now';
        Lang.Ago = 'ago';
        Lang.After = 'after';
        Lang.NameMonths = ['January', 'February', 'Marth', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
        Lang.NameMonthsMin = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        Lang.NameWeekdays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
        Lang.NameWeekdaysMin = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
        Lang.DimensionTime = {
                'n' : ['months', 'month', 'months'],
                'j' : ['days', 'day', 'days'],
                'G' : ['hours', 'h', 'hours'],
                'i' : ['minutes', 'minute', 'minutes'],
                's' : ['seconds', 'second', 'seconds']
        }
        break;
}

// Выводит элемент даты с нужной размерностью, и в нужном склонении
function NiceDate(chislo, type) {
    var n;
    // Узнаем нужное склонение для временной единицы
    if (chislo >= 5 && chislo <= 20)
        n = 0;
    else if (chislo == 1 || chislo % 10 == 1)
        n = 1;
    else if ((chislo <= 4 && chislo >= 1) || (chislo % 10 <= 4 && chislo % 10 >= 1))
        n = 2;
    else
        n = 0;
        

    return chislo + ' ' + Lang.DimensionTime[type][n];

}

// Выводит двузначное число с ведущим нулем
function ZeroPlus(x) {
    if (x < 10)
        x = '0' + x;
    return x;
}
// Переводит в 12 часовой формат
function ToAM(x) {
    if (x > 12) 
        x -= 12;
    return x;
}

// Аналог функции date() из PHP
function ParseDateFormat(format, Time) {
    var DateInFormat = '';
    if (format.length === 0)
        return;
    for (var i = 0; i < format.length; i++) {
        switch (format[i]) {
            // Часы
            // 12 часовой
            case 'g' : DateInFormat += ToAM(Time.getUTCHours()); break; // без ведущего нуля
            case 'h' : DateInFormat += ZeroPlus(ToAM(Time.getUTCHours())); break; // C ведущим нулем
            // 24 часовой
            case 'G' : DateInFormat += Time.getUTCHours(); break; // без ведущего нуля
            case 'H' : DateInFormat += ZeroPlus(Time.getUTCHours()); break; // с ведущим нулём
            // Годы
            case 'Y' : DateInFormat += Time.getUTCFullYear(); break; // Четыре цифры
            case 'y' : DateInFormat += String(Time.getUTCFullYear()).substr(2); break; // Две цифры
            // Месяцы
            case 'm' : DateInFormat += ZeroPlus(Time.getUTCMonth() + 1); break; //Порядковый номер месяца с ведущим нулём
            case 'n' : DateInFormat += Time.getUTCMonth() + 1; break; // Порядковый номер месяца без ведущего нуля
            case 'F' : DateInFormat += Lang.NameMonths[Time.getUTCMonth()]; break; // Полное наименование месяца
            case 'M' : DateInFormat += Lang.NameMonthsMin[Time.getUTCMonth()]; break; // Сокращенное наименование месяца
            // Дни
            case 'd' : DateInFormat += ZeroPlus(Time.getUTCDate()); break;// День месяца
            case 'j' : DateInFormat += Time.getUTCDate(); break; // День месяца без в.н.
            // Дни недели
            case 'N' : DateInFormat += Time.getUTCDay() + 1; break; // Порядковый номер дня недели
            case 'D' : DateInFormat += Lang.NameWeekdaysMin[Time.getUTCDay()]; break; // Текстовое, сокращенное, представление дня недели
            case 'L' : DateInFormat += Lang.NameWeekdays[Time.getUTCDay()]; break; // Полное наименование дня недели
            // Минуты
            case 'i' : DateInFormat += ZeroPlus(Time.getUTCMinutes()); break; // с ведущим нулём
            // Секунды
            case 's' : DateInFormat += ZeroPlus(Time.getUTCSeconds()); break; // с ведущим нулём
            
            default : DateInFormat += format[i]; break;
        }
    }
    
    return DateInFormat;
}

// Выводит относительное время. А так же если check = true то просто делает проверку, относительную ли дату выводить
function OffsetDate(Time, Now, check) {
    
    if (check) {
        if (((new Date(Now - Time)) < (new Date(1970, 1))) || Time > Now)
            return true;
        else
            return false;
    }

    if (Time > Now)
        var OffsetTime = new Date(Time - Now);
    else
        var OffsetTime = new Date(Now - Time);
    
    var s = OffsetTime.getUTCSeconds(), // Секунды
         i = OffsetTime.getUTCMinutes(), // Минуты
         G = OffsetTime.getUTCHours(), // Часы
         j = OffsetTime.getUTCDate()-1, // Дни
         n = OffsetTime.getUTCMonth(), // Месяц
         output = '';
    
    // Если время пошло на месяцы то выводим только месяцы и дни(если не ноль)
    if (n) {
        output += NiceDate(n, 'n') + ' ';
        if (j) output += NiceDate(j, 'j') + ' ';
    // Если время пошло на дни то выводим только дни
    } else if (j) {
        output += NiceDate(j, 'j') + ' ';
    // Если время пошло на часы то выводим только часы и минуты(если не ноль)
    } else if (G) {
        output += NiceDate(G, 'G') + ' ';
    // Если время пошло на минуты то выводим только минуты и секунды(если не ноль)
    } else if (i) {
        output += NiceDate(i, 'i') + ' ';
    // Если времени прошло менее минуты то выводим секунды
    } else {
        output += Lang.Now;
        return output;
    }

    if (Time > Now)
        return Lang.After + '  ' + output;
    else
        return output + '  ' + Lang.Ago;

}

// Выводит дату в нужном формате
function FormatTime(el) {
    
    var format = el.data('type'),
        stime = Date.parse(el.attr('datetime')),
        Now = new Date(), // Объект текущей даты
        Time = new Date(stime), // Обьект указанного времени
        f = OffsetDate(Time, Now, true); // Проверка на тип выводимого времени(относительный или дата)
        
    // Выводим относительное время
    if (f)
        el.html(OffsetDate(Time, Now, false));
    else {
        // Здесь просто выводим в нужном формате...
        // Если эту дату(не относительную) мы уже обработали, то не трогаем её.
        if (!el.data('compiled')) {
            el.html(ParseDateFormat(format, Time));
            el.attr('data-compiled', 'true');
        }
    }
}

// Ищем даты на странице и изменяем их под клиента
function UpdateTime() {
    var BlockTime = $('time');
    $.each(BlockTime, function () {
        if ($(this).attr('data-type'))
            FormatTime($(this));
    });
}

// Первоначальная обработка времени.
$(function() {UpdateTime();});
// Динамическое обновление дат.
setInterval(UpdateTime, 10000);