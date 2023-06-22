<form method="post" action="?mod=pm&action=reply&pmid={{ id }}">
	<input type="hidden" name="subject" value="{{ subject }}" />
	<input type="hidden" name="from" value="{{ from }}" />

	<div class="row">
		<div class="col-lg-8">
			<div class="card">
				<h5 class="card-header"><i class="fa fa-envelope-open-o"></i> {{ subject }}</h5>
				<div class="card-body">{{ message }}</div>
				<div class="card-footer text-center">
					<button type="submit" class="btn btn-outline-success">{{ lang.reply }}</button>
				</div>
			</div>
		</div>

		<div class="col-lg-4">
			<div class="card mb-4">
				<div class="card-header">{{ lang.msgi_info }}</div>
				<div class="card-body">
					<div class="row mb-0" style="padding:10px">
						<div class="col-sm-6">{{ lang.from }}:</div>
						<div class="col-sm-6">{{ fromName }} (id: {{ fromID }})</div>
					</div>
					<div class="row mb-0" style="padding:10px">
						<div class="col-sm-6">{{ lang.receiver }}:</div>
						<div class="col-sm-6">{{ toName }} (id: {{ toID }})</div>
					</div>
				</div>
			</div>
		</div>
		
	</div>
</form>