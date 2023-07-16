<form method="post" action="?mod=pm&action=reply&pmid={{ id }}">
	<input type="hidden" name="subject" value="{{ subject }}" />
	<input type="hidden" name="from" value="{{ from }}" />

	<div class="row">
		<div class="col-lg-8">
			<div class="card">
				<h5 class="card-header"><i class="fa fa-envelope-open-o"></i> {{ subject }}</h5>
				<div class="card-body">{{ message }}</div>
				<div class="card-footer text-center">
					<a href="javascript:history.go(-1)" class="btn btn-outline-dark">{{ lang.back }}</a> <button type="submit" class="btn btn-outline-success">{{ lang.reply }}</button>
				</div>
			</div>
		</div>

		<div class="col-lg-4">
			<div class="card mb-4">
				<div class="card-header">{{ lang.msgi_info }}</div>
				<div class="card-body">
					<div class="row mb-0" style="padding:10px">
						<div class="col-sm-6"><i class="fa fa-user-circle"></i> {{ lang.from }}:</div>
						<div class="col-sm-6"><a href="?mod=users&action=editForm&id={{ fromID }}" target="_blank" class="btn-sm btn-default">{{ fromName }}</a> (id: {{ fromID }})</div>
					</div>
					<div class="row mb-0" style="padding:10px">
						<div class="col-sm-6"><i class="fa fa-user-circle-o"></i> {{ lang.receiver }}:</div>
						<div class="col-sm-6"><a href="?mod=users&action=editForm&id={{ toID }}" target="_blank" class="btn-sm btn-default">{{ toName }}</a> (id: {{ toID }})</div>
					</div>
				</div>
			</div>
		</div>
		
	</div>
</form>