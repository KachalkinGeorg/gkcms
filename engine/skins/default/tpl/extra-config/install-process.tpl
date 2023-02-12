<form action="{php_self}?mod=extras" method="get">
	<input type="hidden" name="mod" value="extras" />
	<input type="hidden" name="token" value="{token}" />
	<input type="hidden" name="enable" value="{plugin}" />
		
<div class="panel panel-default">
  <div class="panel-heading">
    {plugin}
		<div class="panel-head-right">
			{msg}
		</div>
  </div>
<div class="panel-body">
		<div class="table-responsive">
			<table class="table table-sm">
				<tbody>
					{entries}
				</tbody>
			</table>
		</div>
	</div>
		<div class="card-footer text-center">
			<a href="{php_self}?mod=extras" class="btn btn-outline-primary">{l_back}</a>
			{enable}
		</div>
	</div>
</form>