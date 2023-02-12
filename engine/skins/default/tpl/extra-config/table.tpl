<form method="post" action="{php_self}?mod=extra-config" name="form">
	<input type="hidden" name="token" value="{token}" />
	<input type="hidden" name="plugin" value="{plugin}" />
	<input type="hidden" name="action" value="commit" />

{no_active}
<div class="panel panel-default">
  <div class="panel-heading">
    {plugin}
  </div>
		<div class="panel-body">
		<table class="table table-sm extra-config">
			<tbody>
				{entries}
			</tbody>
		</table>
		</div>
		
		<div class="card-footer text-center">
			<button type="submit" class="btn btn-outline-success">{l_commit_change}</button>
		</div>
	</div>
</form>