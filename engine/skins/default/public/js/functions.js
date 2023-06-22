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