
<div class="alert alert-info">
{{ lang['em_descr'] }}
</div>
<div class="panel panel-default">
	<div class="panel-heading">
     {{ lang['em_title'] }}
	</div>
	<div class="panel-body">

		<form method="post">
			<div class="form-row mb-3">
				<label class="col-lg-4 col-form-label">{{ lang['method'] }}</label>
				<div class="col-lg-8">
					<select name="method" style="width: 18%;">{{ method }}</select>
				</div>
			</div>
			<div class="form-row mb-3">
				<label class="col-lg-4 col-form-label">{{ lang['group'] }}</label>
				<div class="col-lg-8">
					<select name="group" style="width: 18%;">{{ group }}</select>
				</div>
			</div>
			<div class="form-row mb-3">
				<label class="col-lg-4 col-form-label">{{ lang['subject'] }}</label>
				<div class="col-lg-8">
					<input type="text" placeholder="Введите тему..." name="subject" class="form-control" />
					<small class="form-text text-muted">{{ lang['subject#desc'] }}</small>
				</div>
			</div>
			<div class="form-row mb-3">
				<label class="col-lg-4 col-form-label">{{ lang['content'] }}</label>
				<div class="col-lg-8">
					{{ quicktags }}
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
					<textarea id="content" name="content" rows="10" cols="60" maxlength="3000" class="form-control"></textarea>
				</div>
			</div>

			<div class="panel-footer" align="center" style="margin-left: -20px;margin-right: -20px;margin-bottom: -20px;">
				<input type="hidden" name="action" value="save" />
				<button type="submit" class="btn btn-outline-success"><i class="fa fa-paper-plane-o"></i> {{ lang['send'] }}</button>
			</div>

		</form>
		
	</div>
</div>
