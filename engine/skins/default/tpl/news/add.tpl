<!-- Оставляем эти скрипты и формы так как ими могут пользоваться плагины -->
<script type="text/javascript" src="{{ home }}/lib/ajax.js"></script>
<script type="text/javascript" src="{{ home }}/lib/libsuggest.js"></script>

<!-- Hidden SUGGEST div -->
<!-- <div id="suggestWindow" class="suggestWindow">
	<table id="suggestBlock" cellspacing="0" cellpadding="0" width="100%"></table>
	<a href="#" align="right" id="suggestClose">close</a>
</div> -->

<form name="DATA_tmp_storage" action="" id="DATA_tmp_storage">
	<input type="hidden" name="area" value=""/>
</form>

<form id="postForm" name="form" enctype="multipart/form-data" method="post" action="{{ php_self }}" target="_self">
	<input type="hidden" name="token" value="{{ token }}" />
	<input type="hidden" name="mod" value="news" />
	<input type="hidden" name="action" value="add" />
	<input type="hidden" name="action" value="adddone" />
	<input type="hidden" name="subaction" value="submit" />

	<div class="row">
		<!-- Left edit column -->
		<div class="col-lg-8">
			
<div class="panel panel-default mb-4">

	<div class="panel-heading" style="padding: 0px;margin-bottom: 0;">
	<ul class="nav nav-tabs nav-fill" role="tablist">
		<li class="nav-item"><a href="#tabmain" class="nav-link active" data-toggle="tab"><span data-toggle="popover" data-placement="top" data-trigger="hover focus" data-content="{{ lang.addnews['bar.maincontent'] }}"><i class="fa fa-home"></i> {{ lang.addnews['bar.maincontent'] }}</span></a></li>
		<li class="nav-item"><a href="#tabmeta" class="nav-link" data-toggle="tab"><span data-toggle="popover" data-placement="top" data-trigger="hover focus" data-content="Мета данные"><i class="fa fa-tag"></i> Мета данные</span></a></li>
		<li class="nav-item"><a href="#tabadditional" class="nav-link" data-toggle="tab"><span data-toggle="popover" data-placement="top" data-trigger="hover focus" data-content="{{ lang.addnews['bar.additional'] }}"><i class="fa fa-th-list"></i> {{ lang.addnews['bar.additional'] }}</span></a></li>
		<li class="nav-item"><a href="#tabacces" class="nav-link" data-toggle="tab"><span data-toggle="popover" data-placement="top" data-trigger="hover focus" data-content="{{ lang.addnews['bar.acces'] }}"><i class="fa fa-lock"></i> {{ lang.addnews['bar.acces'] }}</span></a></li>
	</ul>
		<div class="panel-head-right">
			<a href="#" style="position: absolute;right: -8px;top: -6px;cursor: pointer;" class="btn2" title="На весь экран" onclick="$('#postForm').toggleClass('full-content');return false;"><i class="fa fa-expand fa-lg"></i></a>
		</div>
	</div>

    <div class="panel-tab-content tab-content">
		<div class="tab-pane active" id="tabmain">
			<!-- MAIN CONTENT -->
			<div id="maincontent" class="panel-body">
			
				<div class="form-row mb-3">
				<label class="col-lg-3 col-form-label">{{ lang.addnews['title'] }}</label>
					<div class="col-lg-9">
					<div class="input-group">
						<input id="newsTitle" placeholder="Введите заголовок..." type="text" name="title" value="" tabindex="1" class="form-control" required />
						<div class="input-group-append">
						<span class="input-group-text"><a class="btn2" onclick="searchDouble();" title="Поиск дубликатов"><i class="fa fa-files-o"></i></a></span>
						<a class="btn btn-outline-primary" data-toggle="popover" data-placement="top" data-trigger="focus" data-html="true" title="ЗАГОЛОВОК" data-content="Заголовок новости обязателен к заполнению и может содержать не более 200 символов." tabindex="0">
							<i class="fa fa-question"></i>
						</a>
						</div>
					</div>
					<div id="searchDouble"></div>
					</div>
				</div>

				{% if not flags['altname.disabled'] %}
				<div class="form-row mb-3">
				<label class="col-lg-3 col-form-label">{{ lang.addnews['alt_name'] }}</label>
					<div class="col-lg-9">
						<input type="text" name="alt_name" value="" class="form-control" />
					</div>
				</div>
				{% endif %}
						
				<div class="form-row mb-3">
				<label class="col-lg-3 col-form-label">{{ lang.addnews['category'] }}
				{% if (flags.mondatory_cat) %}
					<span style="font-size: 16px; color: red;"><b>*</b></span>
				{% endif %}
				</label>
					<div class="col-lg-9">
						<div class="list">
							{{ mastercat }}
						</div>
					</div>
				</div>

                {% if (extends.main) %}
					{% for entry in extends.main %}
					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">{{ entry.title }}</label>
						<div class="col-lg-9">
							{{ entry.body }}
						</div>
					</div>
                    {% endfor %}
                 {% endif %}

				{% if (not flags.disableTagsSmilies) %}
					{{ quicktags }}
					<!-- SMILES -->
					<div id="modal-smiles" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="smiles-modal-label" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 id="smiles-modal-label" class="modal-title">Вставить смайл</h5>
									<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
								</div>
								<div class="modal-body">
									{{ smilies }}
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-outline-dark" data-dismiss="modal">Отмена</button>
								</div>
							</div>
						</div>
					</div>
				{% endif %}

				{% if (flags.edit_split) %}
					<div class="mb-3">
						<div id="container.content.short">
							<textarea id="ng_news_content_short" name="ng_news_content_short" onclick="changeActive('short');" onfocus="changeActive('short');" class="{{ editorClassName ? editorClassName : 'form-control' }}" rows="10"></textarea>
						</div>
					</div>
					{% if (flags.extended_more) %}
						<div class="form-row mb-3">
							<label class="col-lg-3 col-form-label">{{ lang.addnews['editor.divider'] }}</label>
							<div class="col-lg-9">
								<input type="text" name="content_delimiter" value="" class="form-control" />
							</div>
						</div>
					{% endif %}
					<div class="mb-3">
						<div id="container.content.full">
							<textarea id="ng_news_content_full" name="ng_news_content_full" onclick="changeActive('full');" onfocus="changeActive('full');" class="{{ editorClassName ? editorClassName : 'form-control' }}" rows="10"></textarea>
						</div>
					</div>
				{% else %}
					<div id="container.content" class="mb-3">
						<textarea id="ng_news_content" name="ng_news_content" class="{{ editorClassName ? editorClassName : 'form-control' }}" rows="10"></textarea>
					</div>
				{% endif %}
				
				{% if (flags.add_info) %}
				<div class="form-row mb-3">
					<label class="col-lg-3 col-form-label">{{ lang.addnews['info'] }}</label>
					<div class="col-lg-9">
						<textarea name="info" class="form-control" style="height: 180px;"></textarea>
					</div>
				</div>
				{% endif %}
						
				{% if (flags.add_scrin) %}
				<div class="form-row mb-3">
					<label class="col-lg-3 col-form-label">{{ lang.addnews['scrin'] }}</label>
					<div class="col-lg-9">
					{% include localPath(0)~"scrin.tpl" %}
						<textarea class="form-control form-scrin width-500" rows="3" onkeydown="checkKey(event, this.form)" name="scrin" id="scrin" placeholder="Загрузите картинки"></textarea>
						<br>
						<div class="btn btn-default btn-light btn-fileinput"><span><i class="fa fa-file-image-o"></i> Выбрать картинку ...</span>
							<input type="file" id="input_img" onchange="fileChange()" accept="image/*">
						</div>
					</div>
				</div>
				{% endif %}

				{% if (pluginIsActive('xfields')) %}
				<table class="table table-striped">
					{{ plugin.xfields[1] }}
				</table>
				{% endif %}
			</div>
		</div>
		
		<!-- Мета -->
		<div class="tab-pane" id="tabmeta" >
			<div id="meta" class="panel-body">
			{% if (flags.meta) %}

                {% if (extends.meta) %}
					{% for entry in extends.meta %}
					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">{{ entry.title }}</label>
						<div class="col-lg-9">
							{{ entry.body }}
						</div>
					</div>
                    {% endfor %}
                 {% endif %}
				 
				<div class="form-row mb-3">
				<label class="col-lg-3 col-form-label">{{ lang.addnews['description'] }}</label>
					<div class="col-lg-9">
						<textarea name="description" cols="80" class="form-control" maxlength="300"></textarea>
					</div>
				</div>

				<div class="form-row mb-3">
				<label class="col-lg-3 col-form-label">{{ lang.addnews['keywords'] }}</label>
					<div class="col-lg-9">
						<input type="text" name="keywords" id="newsKeywords" tabindex="7" class="form-control" maxlength="255" />
					</div>
				</div>

			{% endif %}
			</div>
		</div>
		
		<!-- ДОПОЛНИТЕЛЬНО -->
		<div class="tab-pane" id="tabadditional" >
			<div id="additional" class="panel-body">

				<div class="form-row mb-3">
					{% if (pluginIsActive('xfields')) %}
					<table class="table table table-striped">
						{{ plugin.xfields[0] }}
					</table>
					{% endif %}
					{% for entry in extends.additional %}
					<table class="table table table-striped">
						<tr class="thead-light">
							<th colspan="2">{{ entry.title }}</th>
						</tr>
						{{ entry.body }}
					</table>
                    {% endfor %}
				</div>
					
			</div>
		</div>
		
		<!-- ДОСТУП -->
		<div class="tab-pane" id="tabacces" >
			<div id="acces" class="panel-body">
				<div class="form-row mb-3">
					<label class="col-lg-9 col-form-label">{{ lang.addnews['acces_info'] }} <small class="form-text text-muted">{{ lang.addnews['acces_info#descr'] }}</small></label>
					<div class="col-lg-3">
						{{ usergrup }}
					</div>
				</div>
			</div>
		</div>
		
				
	</div> <!-- panel-tab-content -->
</div> <!-- panel panel-default -->
	

           <!-- PLUGIN WITH OWNER BLOCK -->
           {% if (extends.owner) %}
               {% for entry in extends.owner %}
                <div class="panel panel-default {% if(entry.table) %}panel-table{% endif %}">
                     <div id="owner-{{ loop.index }}" class="panel-heading">
                           <a href="#" data-toggle="collapse" data-target="#panel-owner-{{ loop.index }}" aria-expanded="false" aria-controls="panel-owner-{{ loop.index }}">{{ entry.title }}</a>
                      </div>
					<div class="panel-body" style="padding:0px">
						<div id="panel-owner-{{ loop.index }}" class="collapse" aria-labelledby="owner-{{ loop.index }}" data-parent="#attaches" style="padding:10px">
							<div class="form-row mb-3">
							<label class="col-lg-3 col-form-label">{{ entry.title }}</label>
								<div class="col-lg-9">
									{{ entry.body }}
								</div>
							</div>
						</div>
					</div>
                </div>
               {% endfor %}
           {% endif %}
					
			<!-- ATTACHES -->
			<div id="attaches" class="accordion mb-4">
				<div class="panel panel-default">
					<div id="headingTwo" class="panel-heading">
						<a href="#" class="btn-block collapsed" data-toggle="collapse" data-target="#collapseNewsAttaches" aria-expanded="false" aria-controls="collapseNewsAttaches">
							{{ lang.addnews['bar.attaches'] }}
						</a>
					</div>
					
					<div class="panel-body" style="padding:0px">
					<div id="collapseNewsAttaches" class="collapse" aria-labelledby="headingTwo" data-parent="#attaches" style="padding:10px">
						<!-- <span class="f15">{{ lang.addnews['attach.list'] }}</span> -->
						<table id="attachFilelist" class="table table-sm mb-0">
							<thead>
								<tr>
									<th>#</th>
									<th width="80">{{ lang.editnews['attach.date'] }}</th>
									<th>{{ lang.editnews['attach.filename'] }}</th>
									<th width="90">{{ lang.editnews['attach.size'] }}</th>
									<th width="40">{{ lang.addnews['attach_del'] }}</th>
								</tr>
							</thead>
							<tbody>
								<!-- <tr><td>*</td><td>New file</td><td colspan="2"><input type="file"/></td><td><input type="button" size="40" value="-"/></td></tr> -->
								<tr>
									<td colspan="5" class="text-right">
										<input type="button" value="{{ lang.editnews['attach.more_rows'] }}" class="btn btn-sm btn-primary" onclick="attachAddRow();" />
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Right edit column -->
		<div id="rightBar" class="col col-lg-4">
			{% if flags['multicat.show'] %}
			<div class="card mb-4">
				<div class="card-header">
					{{ lang['editor.extcat'] }}
					<div class="card-header-right">
						<a style="position: absolute;right: 4px;border-bottom-left-radius: 0;border-top-left-radius: 0;cursor: pointer;" class="btn-sm btn-default" data-toggle="popover" data-placement="top" data-trigger="focus" data-html="true" title="" data-content="Здесь Вы можете привязать публикацю в дополнительные категории" tabindex="0" data-original-title="КАТЕГОРИИ">
							<i class="fa fa-question"></i>
						</a>
					</div>
				</div>
				<div class="card-body">
					<div class="has-feedback" onclick="$('.cat-list').toggle();">
						<input id="catSelector" class="form-control" type="button" value="{{ lang['no_cat'] }}" hidefocus="" autocomplete="off" readonly="" style="white-space: pre-wrap;height: auto; text-align: left;">
						<span class="form-control-feedback"><span class="caret"></span></span>
					</div>
					<div class="cat-list" style="display: none;">{{ extcat }}</div>
				</div>
			</div>
			{% endif %}
			
			{% if (extends.sidebar) %}
				{% for entry in extends.sidebar %}
				<div class="card mb-4">
					<div class="card-header">{{ entry.title }}</div>
					<div class="card-body">
						{{ entry.body }}
					</div>
				</div>
				{% endfor %}
			{% endif %}

			{% if (pluginIsActive('forum')) %}
				{{ add_forum }}
			{% endif %}

			<div class="card mb-4">
				<div class="card-header">{{ lang['editor.configuration'] }}</div>
				<div class="card-body">
					<label class="col-form-label d-block">
						<input id="mainpage" type="checkbox" name="mainpage" value="1" {% if (flags.mainpage) %}checked {% endif %} {% if flags['mainpage.disabled'] %}disabled {% endif %} />
						{{ lang.addnews['mainpage'] }}
					</label>
	
					<label class="col-form-label d-block">
						<input id="pinned" type="checkbox" name="pinned" value="1" {% if (flags.pinned) %}checked {% endif %} {% if flags['pinned.disabled'] %}disabled {% endif %} />
						{{ lang.addnews['add_pinned'] }}
					</label>

					<label class="col-form-label d-block">
						<input id="catpinned" type="checkbox" name="catpinned" value="1" {% if (flags.catpinned) %}checked {% endif %} {% if flags['catpinned.disabled'] %}disabled {% endif %} />
						{{ lang.addnews['add_catpinned'] }}
					</label>

					<label class="col-form-label d-block">
						<input id="favorite" type="checkbox" name="favorite" value="1" {% if (flags.favorite) %}checked {% endif %} {% if flags['favorite.disabled'] %}disabled {% endif %} />
						{{ lang.addnews['add_favorite'] }}
					</label>

					<label class="col-form-label d-block">
						<input id="flag_HTML" type="checkbox" name="flag_HTML" value="1" {% if (flags['html']) %}checked {% endif %} {% if (flags['html.disabled']) %}disabled {% endif %} />
						{{ lang.addnews['flag_html'] }}
					</label>

					<label class="col-form-label d-block">
						<input id="flag_RAW" type="checkbox" name="flag_RAW" value="1" {% if (flags['raw']) %}checked {% endif %} {% if (flags['html.disabled']) %}disabled {% endif %} />
						{{ lang.addnews['flag_raw'] }}
					</label>
					
					<label class="col-form-label d-block">
						<input id="fixed" type="checkbox" name="fixed" value="1" />
						Зафиксировать новость
					</label>
					<label class="col-form-label d-block">
						<input id="robots" type="checkbox" name="robots" value="1"/>
						Запретить индексацию страницы для поисковиков
					</label>
					<label class="col-form-label d-block">
						<input id="nosearch" type="checkbox" name="nosearch" value="1" />
						Исключить из поиска по сайту
					</label>					
				</div>
			</div>

			{% if not flags['customdate.disabled'] %}
				<div class="card mb-4">
					<div class="card-header">{{ lang.addnews['custom_date'] }}</div>
					<div class="card-body">
						<label class="col-form-label d-block">
							<input type="checkbox" name="customdate" id="customdate" value="customdate" />
							<!-- setdate_custom -->
							{{ lang.editnews['date.setdate'] }}
						</label>

						<div class="form-group">
							<input id="cdate" type="text" name="cdate" value="" class="form-control" pattern="[0-9]{2}\.[0-9]{2}\.[0-9]{4} [0-9]{2}:[0-9]{2}" placeholder="{{ "now" | date('d.m.Y H:i') }}" autocomplete="off">
						</div>
					</div>
				</div>
			{% endif %}

			{% if (pluginIsActive('comments')) %}
				<div class="card mb-4">
					<div class="card-header">{{ lang['comments:mode.header'] }}</div>
					<div class="card-body">
						<select name="allow_com" class="custom-select">
							<option value="0" {{ plugin.comments['acom:0'] }}>{{ lang['comments:mode.disallow'] }}</option>
							<option value="1" {{ plugin.comments['acom:1'] }}>{{ lang['comments:mode.allow'] }}</option>
							<option value="2" {{ plugin.comments['acom:2'] }}>{{ lang['comments:mode.default'] }}</option>
						</select>
					</div>
				</div>
			{% endif %}
		</div>
	</div>

	<div class="row">
		<div class="col col-lg-8">
			<div class="row">
				<div class="col mt-4">
					<button type="button" class="btn btn-outline-success" title="{{ lang.addnews['preview'] }}" onclick="return preview();">
						<span class="d-none d-xl-block"><i class="fa fa-desktop"></i></span>
					</button>
				</div>
				<div class="col mt-4">
					<div class="input-group">
						<select name="approve" class="custom-select">
							{% if flags['can_publish'] %}
								<option value="1">{{ lang.addnews['publish'] }}</option>
							{% endif %}
							<option value="0">{{ lang.addnews['send_moderation'] }}</option>
							<option value="-1">{{ lang.addnews['save_draft'] }}</option>
						</select>
						<div class="input-group-append">
							<button type="submit" class="btn btn-outline-success" title="{{ lang.addnews['addnews'] }}" >
								<span class="d-xl-none"><i class="fa fa-floppy-o"></i></span>
								<span class="d-none d-xl-block"><i class="fa fa-floppy-o"></i> {{ lang.addnews['addnews'] }}</span>
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	{% if (pluginIsActive('xfields')) %}
		<!-- XFields [GENERAL] -->
		{{ plugin.xfields.general }}
		<!-- /XFields [GENERAL] -->
	{% endif %}
</form>

{% if (extends.css) %}
    {% for entry in extends.css %}
        {{ entry.body }}
    {% endfor %}
{% endif %}

{% if (extends.js) %}
    {% for entry in extends.js %}
        {{ entry.body }}
    {% endfor %}
{% endif %}

<script type="text/javascript">
function insertselcat(cat) {
    var ss = $('select[name=category] option:selected');
    if( ss.val() == 0 ) {
        $('input[name*=category_]').map(function() {$(this).prop('checked', false);});
    }
    var ctstring = $('input[name*=category_]:checked').map(function() {
        if( $.trim(ss.text()) != $.trim($(this).parent().text()) ) {
            return $(this).parent().text();
        } else {
            $(this).prop('checked', false);
        }
    }).get().join(", ") || "{{ lang['no_cat'] }}";
    $("#catSelector").val( ctstring.replace(/&amp;/g, '&') );
}

$('input[name*=category_], select[name=category]').on('click', function (e) {
    insertselcat();
});
</script>

<script type="text/javascript">
	// Global variable: ID of current active input area
	var currentInputAreaID = 'ng_news_content{{ flags.edit_split ? '_short' : '' }}';

	function preview() {
		var form = document.getElementById("postForm");

		if (form.querySelector('[name*=ng_news_content]').value == '' || form.title.value == '') {
			ngNotifySticker('{{ lang.addnews['msge_preview'] }}', {className: 'stickers-danger'});
			return false;
		}

		form['mod'].value = "preview";
		form.target = "_blank";
		form.submit();

		form['mod'].value = "news";
		form.target = "_self";

		return true;
	}

	function changeActive(name) {
		if (name == 'full') {
			document.getElementById('container.content.full').className = 'contentActive';
			document.getElementById('container.content.short').className = 'contentInactive';
			currentInputAreaID = 'ng_news_content_full';
		} else {
			document.getElementById('container.content.short').className = 'contentActive';
			document.getElementById('container.content.full').className = 'contentInactive';
			currentInputAreaID = 'ng_news_content_short';
		}
	}
</script>

<script type="text/javascript">
	// Restore variables if needed
	var jev = {{ JEV }};
	var form = document.getElementById('postForm');
	for (i in jev) {
		//try { alert(i+' ('+form[i].type+')'); } catch (err) {;}
		if (typeof(jev[i]) == 'object') {
			for (j in jev[i]) {
				//alert(i+'['+j+'] = '+ jev[i][j]);
				try {
					form[i + '[' + j + ']'].value = jev[i][j];
				} catch (err) {
					;
				}
			}
		} else {
			try {
				if ((form[i].type == 'text') || (form[i].type == 'textarea') || (form[i].type == 'select-one')) {
					form[i].value = jev[i];
				} else if (form[i].type == 'checkbox') {
					form[i].checked = (jev[i] ? true : false);
				}
			} catch (err) {
				;
			}
		}
	}
</script>

<script type="text/javascript">
	function attachAddRow() {
		var tbl = document.getElementById('attachFilelist');
		var lastRow = tbl.rows.length;
		var row = tbl.insertRow(lastRow - 1);

		// Add cells
		row.insertCell(0).innerHTML = '*';
		row.insertCell(1).innerHTML = '{{ lang.editnews['attach.new_file '] }}';

		// Add file input
		var el = document.createElement('input');
		el.setAttribute('type', 'file');
		el.setAttribute('name', 'userfile[' + (++attachAbsoluteRowID) + ']');
		el.setAttribute('size', '80');

		var xCell = row.insertCell(2);
		xCell.colSpan = 2;
		xCell.appendChild(el);

		el = document.createElement('button');
		el.setAttribute('type', 'button');
		el.setAttribute('onclick', 'document.getElementById("attachFilelist").deleteRow(this.parentNode.parentNode.rowIndex);');
		el.setAttribute('class', 'btn btn-sm btn-danger');
		el.innerHTML = '<i class="fa fa-trash"></i>';
		row.insertCell(3).appendChild(el);
	}

	// Add first row
	var attachAbsoluteRowID = 0;
	attachAddRow();
</script>
<script>
var searchDouble = function() {
    if ($.trim($('#newsTitle').val()).length < 4)
        return $.notify({message: '{{ lang.addnews['msge_title'] }}'},{type: 'danger'});
    var url = '/engine/rpc.php';
    var method = 'admin.news.double';
    var params = {'token': '{{ token }}','title': $('#newsTitle').val(),'mode': 'add',};
    $.reqJSON(url, method, params, function(json) {
        $('#searchDouble').html('');
        if (json.info) {
            $.notify({message:json.info},{type: 'info'});
        } else {
            var txt = '<ul class="alert alert-info list-unstyled alert-dismissible"><button type="button" class="close" data-dismiss="alert" >&times;</button>';
            $.each(json.data,function(index, value) {
                txt += '<li>#' +value.id+ ' &#9;&#9;<a href="'+value.url+'" target="_blank" class="alert-link">'+value.title +'</a></li>';
            });
            $('#searchDouble').html(txt+'</ul>');
        }
    });
};
</script>