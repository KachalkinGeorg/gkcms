<!-- Preload JS/CSS for plugins -->
{{ preloadRAW }}
<!-- /end preload -->
<form name="form" id="postForm" method="post" action="{{ php_self }}?mod=static" target="_self">
	<input type="hidden" name="token" value="{{ token }}" />
	{% if (flags.editMode) %}
		<input type="hidden" name="action" value="edit" />
		<input type="hidden" name="id" value="{{ data.id }}" />
	{% else %}
		<input type="hidden" name="action" value="add" />
	{% endif %}

	<div class="row">
		<!-- Left edit column -->
		<div class="col-lg-8">

			<!-- MAIN CONTENT -->
			<div id="maincontent" class="panel panel-default card mb-4">

			<div class="panel-heading">
				{% if (flags.editMode) %} {{ lang['static_title_edit'] }} - {{ data.title }} {% else %} {{ lang['static'] }} {% endif %}
			</div>
				<div class="panel-body">
					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">{{ lang['title'] }}</label>
						<div class="col-lg-9">
							{% if (flags.isPublished) %}
								<div class="input-group">
									<input type="text" name="title" value="{{ data.title }}" placeholder="Введите заголовок..." class="form-control" />
									<div class="input-group-append">
										<span class="input-group-text">
											<a href="{{ data.url }}" target="_blank">
												<i class="fa fa-external-link"></i>
											</a>
										</span>
										<a class="btn btn-primary" data-toggle="popover" data-placement="top" data-trigger="focus" data-html="true" title="ЗАГОЛОВОК" data-content="Заголовок новости обязателен к заполнению и может содержать не более 200 символов." tabindex="0">
											<i class="fa fa-question"></i>
										</a>
									</div>
								</div>
							{% else %}
						<div class="input-group">
							<input id="newsTitle" placeholder="Введите заголовок..." type="text" name="title" value="{{ data.title }}" class="form-control" />
							<div class="input-group-append">
							<a class="btn btn-outline-primary" data-toggle="popover" data-placement="top" data-trigger="focus" data-html="true" title="ЗАГОЛОВОК" data-content="Заголовок новости обязателен к заполнению и может содержать не более 200 символов." tabindex="0">
								<i class="fa fa-question"></i>
							</a>
							</div>
						</div>
							{% endif %}
						</div>
					</div>

					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">{{ lang['alt_name'] }}</label>
						<div class="col-lg-9">
							<input type="text" name="alt_name" value="{{ data.alt_name }}" class="form-control" />
						</div>
					</div>

					{% if (flags.isPublished) %}
						<div class="form-row mb-3">
							<label class="col-lg-3 col-form-label">{{ lang['url_static_page'] }}</label>
							<div class="col-lg-9">
								<input type="text" value="{{ data.url }}" class="form-control" readonly />
							</div>
						</div>
					{% endif %}

					{% if not(flags.disableTagsSmilies) %}
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
										<button type="button" class="btn btn-outline-dark" data-dismiss="modal">{{ lang['cansel'] }}</button>
									</div>
								</div>
							</div>
						</div>
					{% endif %}

					<div class="mb-3">
						<textarea id="content" name="content" class="{{ editorClassName ? editorClassName : 'form-control' }}" rows="10">{{ data.content }}</textarea>
					</div>

					{% if (flags.meta) %}
					
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
						
						<div class="form-row mb-3">
							<label class="col-lg-3 col-form-label">{{ lang['description'] }}</label>
							<div class="col-lg-9">
								<textarea name="description" cols="80" class="form-control">{{ data.description }}</textarea>
							</div>
						</div>

						<div class="form-row mb-3">
							<label class="col-lg-3 col-form-label">{{ lang['keywords'] }}</label>
							<div class="col-lg-9">
								<textarea name="keywords" cols="80" class="form-control">{{ data.keywords }}</textarea>
							</div>
						</div>
					{% endif %}
				</div>
			</div>
		</div>

		<!-- Right edit column -->
		<div id="rightBar" class="col col-lg-4">
			<div class="card mb-4">
				<div class="card-header">{{ lang['editor.configuration'] }}</div>
				<div class="card-body">
					<label class="col-form-label d-block">
						{% if (not flags.canPublish) or (not flags.canUnpublish) %}
							<input type="checkbox" name="flag_published" value="1" {{ data.flag_published ? 'checked' : '' }} disabled />
						{% else %}
							<input type="checkbox" name="flag_published" value="1" {{ data.flag_published ? 'checked' : '' }} />
						{% endif %}
						{{ lang['approve'] }}
					</label>

					<label class="col-form-label d-block">
						<input type="checkbox" name="flag_html" value="1" {{ data.flag_html ? 'checked' : '' }} />
						{{ lang['flag_html'] }}
					</label>

					<label class="col-form-label d-block">
						<input type="checkbox" name="flag_raw" value="1" {{ data.flag_raw ? 'checked' : '' }} />
						{{ lang['flag_raw'] }}
					</label>
				</div>
			</div>

			<div class="card mb-4">
				<div class="card-header">{{ lang['editor.template'] }}
					<div class="card-header-right">
						<a class="btn2" data-toggle="popover" data-placement="top" data-trigger="focus" data-html="true" title="ШАБЛОН" data-content="Для каждой статистической страницы существует свой шаблон.<br>Чтобы его выбрать создайте папку в шаблоне Вашего сайта с именим <b>static</b> в нем внутри два файла<br>default.tpl - шаблон<br>default.main.tpl - замена родного main.tpl для default.tpl<br>При выборе чекбокса {{ lang['flag_main'] }} будут активны эти два файла, в противном случая будет использоваться по умолчанию." tabindex="0">
							<i class="fa fa-question-circle fa-1x"></i>
						</a>
					</div>
				</div>
				<div class="card-body">
					<div class="form-group">
						<select name="template" class="custom-select">
							{% for t in templateList %}
								<option value="{{ t }}" {{ data.template == t ? 'selected' : '' }}>{{ t }}</option>
							{% endfor %}
						</select>
					</div>

					<label class="col-form-label d-block">
						<input type="checkbox" name="flag_template_main" value="1" {{ data.flag_template_main ? 'checked' : '' }} /> {{ lang['flag_main'] }}
					</label>
				</div>
			</div>

			<div class="card mb-4">
				<div class="card-header">{{ lang['postdate'] }}</div>
				<div class="card-body">
					<label class="col-form-label d-block">
						<input id="set_postdate" type="checkbox" name="set_postdate" value="1" />
						{{ lang['set_postdate'] }}
					</label>

					<div class="form-group mb-0">
						<input id="cdate" type="text" name="cdate" value="{{ data.cdate }}" class="form-control" pattern="[0-9]{2}\.[0-9]{2}\.[0-9]{4} [0-9]{2}:[0-9]{2}" placeholder="{{ "now" | date('d.m.Y H:i') }}" autocomplete="off">
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col col-lg-8">
			<div class="row">
				{% if (flags.editMode) %}
					{% if (flags.canModify) %}
						<div class="col-md-6 mb-4">
							<button type="button" class="btn btn-outline-danger" onclick="confirmit('{{ php_self }}?mod=static&token={{ token }}&action=do_mass_delete&selected[]={{ data.id }}', '{{ lang['sure_del'] }}')">
								<span class="d-xl-none"><i class="fa fa-trash"></i></span>
								<span class="d-none d-xl-block">{{ lang['delete'] }}</span>
							</button>
						</div>

						<div class="col-md-6 mb-4 text-right">
							<button type="submit" class="btn btn-outline-success">
								<span class="d-xl-none"><i class="fa fa-floppy-o"></i></span>
								<span class="d-none d-xl-block">{{ lang['do_editnews'] }}</span>
							</button>
						</div>
					{% endif %}
				{% else %}
					{% if (flags.canAdd) %}
					<div class="col-md-6 mb-4 text-right">
						<button type="submit" class="btn btn-outline-success">
							<span class="d-xl-none"><i class="fa fa-floppy-o"></i></span>
							<span class="d-none d-xl-block">{{ lang['addstatic'] }}</span>
						</button>
					</div>
					{% endif %}
				{% endif %}
			</div>
		</div>
	</div>
</form>

<form id="DATA_tmp_storage" name="DATA_tmp_storage" action="">
	<input type=hidden name="area" value=""/>
</form>

<script type="text/javascript">
	var currentInputAreaID = 'content';
</script>