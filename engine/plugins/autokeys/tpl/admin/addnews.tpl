<script>
$(function() {
	$('#newsKeywords').replaceWith('\
			<div class="input-group">\
				<input type="text" name="keywords" id="newsKeywords" value="'+$('#newsKeywords').val()+'" tabindex="7" class="form-control" maxlength="255" />\
				<div class="input-group-append"><span class="input-group-text" style="padding: 4px;">\
					<button type="button" id="autokeysArea" class="btn2" onclick="autokeysAjaxUpdate();" title="Генерировать ключевые слова"><i class="fa fa-refresh"></i></button>\
				</span></div>\
			</div>\
			<label class="control-label help-block"><input type="checkbox" id="autokeys_generate" name="autokeys_generate" value="1" {% if (flags.checked) %} checked="checked" {% endif %}class="check" /> Автоматическая генерация ключевых слов при сохранении новости</label>');
});

var autokeysAjaxUpdate = function() {
    if (form.ng_news_content.value == '' || form.title.value == '')
        return $.notify({message: '{{ lang.addnews['msge_preview'] }}'},{type: 'danger'});
    var url = '{{ admin_url }}/rpc.php';
    var method = 'plugin.autokeys.generate';
    var params = {'token': '{{ token }}', 'title': $('#newsTitle').val(), 'content': $('#ng_news_content').val()};
    $.reqJSON(url, method, params, function(json) {$("#newsKeywords").val(json.data);});
};
</script>