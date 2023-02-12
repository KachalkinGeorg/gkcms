<div class="panel panel-default">
  <div class="panel-heading">
     Ответить на письмо
  </div>
<div class="panel-body">
<form name="form" action="?mod=pm&action=send" method="post">
	<input type="hidden" name="sendto" value="{{ toID }}" />
	<input type="hidden" name="token" value="{{ token }}" />

	<div class="row">
		<!-- Left edit column -->
		<div class="col-lg-8">

			<!-- MAIN CONTENT -->
			<div id="maincontent" class="card">
				<div class="card-body">
					<div class="form-row mb-3">
						<label class="col-lg-4 col-form-label">
							{{ lang.from }}
						</label>
						<div class="col-lg-8">
							<input type="text" value="{{ fromID }} ({{ fromName }})" class="form-control" readonly />
						</div>
					</div>
					<div class="form-row mb-3">
						<label class="col-lg-4 col-form-label">
							{{ lang.receiver }}
						</label>
						<div class="col-lg-8">
							<input type="text" value="{{ toID }} ({{ toName }})" class="form-control" readonly />
						</div>
					</div>
					<div class="form-row mb-3">
						<label class="col-lg-4 col-form-label">{{ lang.title }}</label>
						<div class="col-lg-8">
							<input type="text" name="title" value="{{ title }}" class="form-control" maxlength="50"/>
						</div>
					</div>
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
									<button type="button" class="btn btn-outline-dark" data-dismiss="modal">Cancel</button>
								</div>
							</div>
						</div>
					</div>

					<div class="mb-3">
						<!-- {{ lang.content }} -->
						<textarea id="content" name="content" rows="10" cols="60" maxlength="3000" class="form-control" required></textarea>
					</div>
				</div>

				<div class="card-footer text-center">
					<button type="submit" class="btn btn-outline-success">{{ lang.send }}</button>
				</div>
			</div>
		</div>
	</div>
</form>
</div>
</div>