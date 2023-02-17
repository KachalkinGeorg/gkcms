<form name="form" id="postForm" method="post" action="{{ php_self }}?mod=rules" target="_self">
	<input type="hidden" name="id" value="{{ data.id }}" />
	<input type="hidden" name="action" value="edit" />

	<div id="maincontent" class="panel panel-default card mb-4">
		<div class="panel-heading">{{ lang['rules'] }}</div>
		<div class="panel-body">
			<div class="form-row mb-3">
				<label class="col-lg-3 col-form-label">{{ lang['title'] }}</label>
				<div class="col-lg-9">
					<input id="newsTitle" placeholder="Введите заголовок..." type="text" name="title" value="{{ data.title }}" class="form-control" />
				</div>
			</div>

			<div class="form-row mb-3">
				<label class="col-lg-3 col-form-label">{{ lang['alt_name'] }}</label>
				<div class="col-lg-9">
					<input type="text" name="alt_name" value="{{ data.alt_name }}" class="form-control" readonly/>
				</div>
			</div>

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
				<textarea id="rules" name="content" class="form-control" rows="10">{{ data.content }}</textarea>
			</div>

			{% if (flags.meta) %}
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
			<div class="panel-footer" align="center" style="margin-left: -20px;margin-right: -20px;margin-bottom: -20px;">
				<button type="submit" class="btn btn-outline-success">
					<span class="d-xl-none"><i class="fa fa-floppy-o"></i></span>
					<span class="d-none d-xl-block">{{ lang['do_editnews'] }}</span>
				</button>
			</div>
		</div>
	</div>
</form>

<div class="stickers stickers-info stickers-styled-left">
<b>При написании правил используются следующие теги:</b><br><br><b>%home%</b> - название сайта<br><b>%rules%</b> - вывод кнопок 'Принимаю' и 'Не принимаю' при регистрации (обязателен к написанию)<br>
</div>

<script type="text/javascript">
	var currentInputAreaID = 'rules';
</script>