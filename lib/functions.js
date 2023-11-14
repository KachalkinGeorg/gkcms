/* Меню */
function dropdownmenu(a,c,b,d){window.event?event.cancelBubble=!0:c.stopPropagation&&c.stopPropagation();c=$("#dropmenudiv");if(c.is(":visible"))return clearhidemenu(),c.fadeOut("fast"),!1;c.remove();$("body").append('<div id="dropmenudiv" style="display:none;position:absolute;z-index:100;width:165px;"></div>');c=$("#dropmenudiv");c.html(b.join(""));d&&c.width(d);b=$(document).width()-30;d=$(a).offset();b-d.left<c.width()&&(d.left-=c.width()-$(a).width());c.css({left:d.left+"px",top:d.top+$(a).height()+"px"});c.fadeTo("fast",.9);c.mouseenter(function(){clearhidemenu()}).mouseleave(function(){delayhidemenu()});$(document).one("click",function(){hidemenu()});return!1}function hidemenu(a){$("#dropmenudiv").fadeOut("fast")}function delayhidemenu(){delayhide=setTimeout("hidemenu()",1E3)}function clearhidemenu(){"undefined"!=typeof delayhide&&clearTimeout(delayhide)}

//
// Basic JS functions for NGCMS core
//
$(function() {

    $('.scrollTop').on('click', function(){
        return $('html, body').animate({ scrollTop: 0 }, 888);
    });

    // for bootstrap element
    $('input[type=checkbox]').each(function() {
        if ( $(this).prop('checked') == true ) {
            $(this).parent().addClass('active');
        } else {
            $(this).parent().removeClass('active');
        }
    });

    // Select/unselect all
    $('table .select-all').on('click', function() {
        $(this).parents('table').find('input:checkbox:not([disabled])').prop('checked', $(this).prop('checked'));
    });

    // Process spoilers
    $('.sp-head').on('click', function() {
        if ($(this).hasClass("expanded")) {
            $(this).removeClass("expanded");
            $(this).next('.sp-body').slideUp("fast");
        } else {
            $(this).addClass("expanded");
            $(this).next('.sp-body').slideDown("fast");
        }

    });

    // Reload captcha
    $('#img_captcha').on('click', function() {
        reload_captcha();
    });

});

// Reload captcha
function reload_captcha() {
    $('#img_captcha').attr('src', $('#img_captcha').attr('src').replace(/(rand=)[0\.?\d*]+/, '$1' + Math.random()));
}

//
// Function from PHP to Javascript Project: php.js
// URL: http://kevin.vanzonneveld.net/techblog/article/javascript_equivalent_for_phps_json_encode/
function json_encode(mixed_val)
{
    // http://kevin.vanzonneveld.net
    // +      original by: Public Domain (http://www.json.org/json2.js)
    // + reimplemented by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // *     example 1: json_encode(['e', {pluribus: 'unum'}]);
    // *     returns 1: '[\n    "e",\n    {\n    "pluribus": "unum"\n}\n]'

    /*
	 http://www.JSON.org/json2.js
	 2008-11-19
	 Public Domain.
	 NO WARRANTY EXPRESSED OR IMPLIED. USE AT YOUR OWN RISK.
	 See http://www.JSON.org/js.html
	 */

    var indent;
    var value = mixed_val;
    var i;

    var quote = function (string) {
        var escapable = /[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g;
        var meta = {    // table of character substitutions
            '\b': '\\b',
            '\t': '\\t',
            '\n': '\\n',
            '\f': '\\f',
            '\r': '\\r',
            '"': '\\"',
            '\\': '\\\\'
        };

        escapable.lastIndex = 0;
        return escapable.test(string) ?
            '"' + string.replace(escapable, function (a) {
                var c = meta[a];
                return typeof c === 'string' ? c :
                    '\\u' + ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
            }) + '"' :
            '"' + string + '"';
    }

    var str = function (key, holder) {
        var gap = '';
        var indent = '    ';
        var i = 0;          // The loop counter.
        var k = '';          // The member key.
        var v = '';          // The member value.
        var length = 0;
        var mind = gap;
        var partial = [];
        var value = holder[key];

        // If the value has a toJSON method, call it to obtain a replacement value.
        if (value && typeof value === 'object' &&
            typeof value.toJSON === 'function') {
            value = value.toJSON(key);
        }

        // What happens next depends on the value's type.
        switch (typeof value) {
            case 'string':
                return quote(value);

            case 'number':
                // JSON numbers must be finite. Encode non-finite numbers as null.
                return isFinite(value) ? String(value) : 'null';

            case 'boolean':
            case 'null':
                // If the value is a boolean or null, convert it to a string. Note:
                // typeof null does not produce 'null'. The case is included here in
                // the remote chance that this gets fixed someday.

                return String(value);

            case 'object':
                // If the type is 'object', we might be dealing with an object or an array or
                // null.
                // Due to a specification blunder in ECMAScript, typeof null is 'object',
                // so watch out for that case.
                if (!value) {
                    return 'null';
                }

                // Make an array to hold the partial results of stringifying this object value.
                gap += indent;
                partial = [];

                // Is the value an array?
                if (Object.prototype.toString.apply(value) === '[object Array]') {
                    // The value is an array. Stringify every element. Use null as a placeholder
                    // for non-JSON values.

                    length = value.length;
                    for (i = 0; i < length; i += 1) {
                        partial[i] = str(i, value) || 'null';
                    }

                    // Join all of the elements together, separated with commas, and wrap them in
                    // brackets.
                    v = partial.length === 0 ? '[]' :
                        gap ? '[\n' + gap +
                            partial.join(',\n' + gap) + '\n' +
                            mind + ']' :
                            '[' + partial.join(',') + ']';
                    gap = mind;
                    return v;
                }

                // Iterate through all of the keys in the object.
                for (k in value) {
                    if (Object.hasOwnProperty.call(value, k)) {
                        v = str(k, value);
                        if (v) {
                            partial.push(quote(k) + (gap ? ': ' : ':') + v);
                        }
                    }
                }

                // Join all of the member texts together, separated with commas,
                // and wrap them in braces.
                v = partial.length === 0 ? '{}' :
                    gap ? '{\n' + gap + partial.join(',\n' + gap) + '\n' +
                        mind + '}' : '{' + partial.join(',') + '}';
                gap = mind;
                return v;
        }
        return null;
    };

    // Make a fake root object containing our value under the key of ''.
    // Return the result of stringifying the value.
    return str('', {
        '': value
    });
}


function toggleSpoiler(s, shdr)
{
    var mode = 0;

    for (var i = 0; i <= s.childNodes.length; i++) {
        var item = s.childNodes[i];

        if (item.className == 'sp-body') {
            mode = (item.style.display == 'block') ? 0 : 1;
            item.style.display = mode ? 'block' : 'none';
            break;
        }
    }

    for (var i = 0; i <= shdr.childNodes.length; i++) {
        var item = shdr.childNodes[i];

        if (item.tagName == 'B') {
            item.className = (mode ? 'expanded' : '');
            break;
        }
    }
}


function addcat()
{

    if (document.getElementById('categories').value != '' && document.getElementById('catmenu').value != '') {
        document.getElementById('categories').value = document.getElementById('categories').value + ", " + document.getElementById('catmenu').value;
    } else if (document.getElementById('catmenu').value != '') {
        document.getElementById('categories').value = document.getElementById('catmenu').value;
    }
    document.getElementById('catmenu').options[document.getElementById('catmenu').selectedIndex] = null;

    if (document.getElementById('catmenu').options.length == 0) {
        document.getElementById('catmenu').disabled = true;
        document.getElementById('catbutton').disabled = true;
    }
}

function ShowOrHide(d1, d2)
{
    if (d1 != '') {
        DoDiv(d1); }
    if (d2 != '') {
        DoDiv(d2); }
}

function DoDiv(id)
{
    var item = null;
    if (document.getElementById) {
        item = document.getElementById(id);
    } else if (document.all) {
        item = document.all[id];
    } else if (document.layers) {
        item = document.layers[id];
    }
    if (!item) {
    } else if (item.style) {
        if (item.style.display == "none") {
            item.style.display = "";
        } else {
            item.style.display = "none";
        }
    } else {
        item.visibility = "show";
    }
}

function check_uncheck_all(area, prefix)
{
    var frm = area;
    var p = (prefix) ? prefix : '';
    for (var i = 0; i < frm.elements.length; i++) {
        var e = frm.elements[i];
        if ((e.type == "checkbox") && (e.name != "master_box") &&
            ((p.length == 0) || (e.name.substr(0, p.length) == p))
        ) {
            e.checked = frm.master_box.checked ? true : false;
        }
    }
}

function showpreview(image, name)
{
    if (image != "") {
        document.images[name].src = image;
    } else {
        document.images[name].src = "skins/images/blank.png";
    }
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

/* cookie style core */
function setCookie(name, value, days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime()+(days*24*60*60*1000));
        var expires = "; expires="+date.toGMTString();
    }
    else var expires = "";
    document.cookie = name+"="+value+expires+"; path=/";
}

function deleteCookie(name) {
    setCookie(name,"",-1);
}

function getCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

// ngShowLoading
function ngShowLoading() {
    var setX = ( $(window).width() - $("#loading-layer").width() ) / 2;
    var setY = ( $(window).height() - $("#loading-layer").height() ) / 2;

    $("#loading-layer").css( {
        left : setX + "px",
        top : setY + "px",
        position : 'fixed',
        zIndex : '99'
    });

    $("#loading-layer").fadeIn(0);
}

// ngHideLoading
function ngHideLoading() {
    $("#loading-layer").fadeOut('slow');
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

/* function insertimage(open) {
    insertext(open, ' ');
} */

function insertimage(text, area)
{
    var win = window.opener;
    var form = win.document.forms['form'];
    try {
        var xarea = win.document.forms['DATA_tmp_storage'].area.value;
        if (xarea != '') {
            area = xarea; }
    } catch (err) {
        ;
    }
    var control = win.document.getElementById(area);

    control.focus();

    // IE
    if (win.selection && win.selection.createRange) {
        sel = win.selection.createRange();
        sel.text = text = sel.text;
    } else {     // Mozilla
        if (control.selectionStart || control.selectionStart == "0") {
            var startPos = control.selectionStart;
            var endPos = control.selectionEnd;

            control.value = control.value.substring(0, startPos) + text + control.value.substring(startPos, control.value.length);
            //control.selectionStart = msgfield.selectionEnd = endPos + open.length + close.length;
        } else {
            control.value += text;
        } }
    control.focus();
}

/* Quote user */
var q_txt = '';

function copy_quote(q_name) {

    if (window.getSelection) {
        q_txt = window.getSelection();
    } else if (document.getSelection) {
        q_txt = document.getSelection();
    } else if (document.selection) {
        q_txt = document.selection.createRange().text;
    }

    if (q_txt == '') {
        q_txt = '[b]'+q_name+'[/b],';
    } else {
        q_txt = '[quote='+q_name+']'+q_txt+'[/quote]';
    }

}

function quote(q_name) {
    insertext(q_txt, ' ', 'content');
}

function confirmit(url, text)
{
    var agree = confirm(text);

    if (agree) {
        document.location = url;
    }
}

function emailCheck(emailStr)
{
    var emailPat = /^(.+)@(.+)$/
    var specialChars = "\\(\\)<>@,;:\\\\\\\"\\.\\[\\]"
    var validChars = "\[^\\s" + specialChars + "\]"
    var quotedUser = "(\"[^\"]*\")"
    var ipDomainPat = /^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/
    var atom = validChars + '+'
    var word = "(" + atom + "|" + quotedUser + ")"
    var userPat = new RegExp("^" + word + "(\\." + word + ")*$")
    var domainPat = new RegExp("^" + atom + "(\\." + atom + ")*$")

    var matchArray = emailStr.match(emailPat)
    if (matchArray == null) {
        return false
    }
    var user = matchArray[1]
    var domain = matchArray[2]

    if (user.match(userPat) == null) {
        return false
    }

    var IPArray = domain.match(ipDomainPat)
    if (IPArray != null) {
        for (var i = 1; i <= 4; i++) {
            if (IPArray[i] > 255) {
                return false
            }
        }
        return true
    }

    var domainArray = domain.match(domainPat)
    if (domainArray == null) {
        return false
    }

    var atomPat = new RegExp(atom, "g")
    var domArr = domain.match(atomPat)
    var len = domArr.length
    if (domArr[domArr.length - 1].length < 2 ||
        domArr[domArr.length - 1].length > 3) {
        return false
    }

    if (len < 2) {
        return false
    }

    return true;
}

function in_array(needle, haystack, argStrict)
{
    // http://kevin.vanzonneveld.net
    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: vlado houba
    // +   input by: Billy
    // +   bugfixed by: Brett Zamir (http://brett-zamir.me)
    // *     example 1: in_array('van', ['Kevin', 'van', 'Zonneveld']);
    // *     returns 1: true
    // *     example 2: in_array('vlado', {0: 'Kevin', vlado: 'van', 1: 'Zonneveld'});
    // *     returns 2: false
    // *     example 3: in_array(1, ['1', '2', '3']);
    // *     returns 3: true
    // *     example 3: in_array(1, ['1', '2', '3'], false);
    // *     returns 3: true
    // *     example 4: in_array(1, ['1', '2', '3'], true);
    // *     returns 4: false

    var key = '', strict = !!argStrict;

    if (strict) {
        for (key in haystack) {
            if (haystack[key] === needle) {
                return true;
            }
        }
    } else {
        for (key in haystack) {
            if (haystack[key] == needle) {
                return true;
            }
        }
    }

    return false;
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

//добавление размера Шрифта
function insertfortext(teg,val,field){
        try { var    msgfield = document.getElementById((field=='')?'content':field);
        } catch (err) {
            return false;
        }    
        var open ='['+teg+'="'+val+'"]';
        var close='[/'+teg+']';
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
    return true;
}

function futu_alert(header, text, close, className) {
		if (!document.getElementById('futu_alerts_holder')) {
			var futuAlertOuter = document.createElement('div');
			futuAlertOuter.className = 'futu_alert_outer';
			document.body.appendChild(futuAlertOuter);
			
			var futuAlertFrame = document.createElement('div');
			futuAlertFrame.className = 'frame';
			futuAlertOuter.appendChild(futuAlertFrame);
			
			var futuAlertsHolder = document.createElement('div');
			futuAlertsHolder.id = 'futu_alerts_holder';
			futuAlertsHolder.className = 'futu_alerts_holder';
			futuAlertFrame.appendChild(futuAlertsHolder);
		}
		var futuAlert = document.createElement('div');
		futuAlert.className = 'futu_alert ' + className;
		document.getElementById('futu_alerts_holder').appendChild(futuAlert);
		futuAlert.id = 'futu_alert';

		var futuAlertHeader = document.createElement('div');
		futuAlertHeader.className = 'futu_alert_header';
		futuAlert.appendChild(futuAlertHeader);
	
		futuAlertHeader.innerHTML = header;
		
		if (close) {
			var futuAlertCloseButton = document.createElement('a');
			futuAlertCloseButton.href = '#';
			futuAlertCloseButton.className = 'futu_alert_close_button';
			futuAlertCloseButton.onclick = function(ev) {
				if(!ev) {
					ev=window.event;
				}
				if (!document.all) ev.preventDefault(); else ev.returnValue = false;
				document.getElementById('futu_alerts_holder').removeChild(futuAlert);
			}
			futuAlert.appendChild(futuAlertCloseButton);
			
			var futuAlertCloseButtonIcon = document.createElement('img');
			futuAlertCloseButtonIcon.src = '/lib/btn_close.gif';
			futuAlertCloseButton.appendChild(futuAlertCloseButtonIcon);
		}
	
	
		var futuAlertText = document.createElement('div');
		futuAlertText.className = 'futu_alert_text';
		futuAlert.appendChild(futuAlertText);

		
		futuAlertText.innerHTML = text;
		
		futuAlert.style.position = 'relative';
		futuAlert.style.top = '0';
		futuAlert.style.display = 'block';

	
		if (!close) {
			/* addEvent("click",function(){
				document.getElementById('futu_alerts_holder').removeChild(futuAlert);
			}, document.getElementById('futu_alert'));*/
			setTimeout(function () { document.getElementById('futu_alerts_holder').removeChild(futuAlert); }, 3000);
			
		}
}