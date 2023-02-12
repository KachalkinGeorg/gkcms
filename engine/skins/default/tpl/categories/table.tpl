<!-- Info content -->
<form action="{{ php_self }}" method="get" name="categories">
	<input type="hidden" name="token" value="{{ token }}" />
	<input type="hidden" name="mod" value="categories" />
	<input type="hidden" name="action" value="add" />

	<div class="card">
		{% if (flags.canModify) %}
		<div class="panel panel-default">
			<div class="panel-heading">
				{{ lang['list'] }}
				<div class="panel-head-right"><button type="submit" class="btn2"><i class="fa fa-plus-circle position-left"></i> {{ lang['addnew'] }}</button></div>
			</div>

		{% endif %}
		<div class="panel-body">
		<div class="table-responsive">
			<table class="table table-sm mb-0">
				<thead>
					<tr>
						<th></th>
						<th>ID</th>
						<th></th>
						<th>{{ lang['title'] }}</th>
						<th nowrap>{{ lang['alt_name'] }}</th>
						<th>{{ lang['category.header.menushow'] }}</th>
						<th>{{ lang['category.header.template'] }}</th>
						<th>{{ lang['news'] }}</th>
						<th>{{ lang['action'] }}</th>
					</tr>
				</thead>
				<tbody id="admCatList">
					{% include localPath(0)~"entries.tpl" %}
				</tbody>
			</table>
		</div>
		</div>
	</div>
</form>

<script type="text/javascript">
	// Process RPC requests for categories
	function categoryModifyRequest(cmd, cid) {
		var rpcCommand = '';
		var rpcParams = [];

		switch (cmd) {
			case 'up':
			case 'down':
			case 'del':
				rpcCommand = 'admin.categories.modify';
				rpcParams = {
					'mode': cmd,
					'id': cid,
					'token': $('input[name="token"]').val()
				};
				break;
		}

		if (rpcCommand == '') {
			alert('No RPC command');

			return false;
		}

		post(rpcCommand, rpcParams, false)
			.then(function(response) {
				if (response.infoText) {
					ngNotifySticker(response.infoText, {
						className: response.infoCode ? 'alert-success' : 'alert-danger',
		                closeBTN: true
					});
				}

				document.getElementById('admCatList').innerHTML = response.content;
			});

		return false;
	}
</script>