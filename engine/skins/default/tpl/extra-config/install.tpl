<form method="post" action="{php_self}?mod=extra-config">
	<input type="hidden" name="plugin" value="{plugin}" />
	<input type="hidden" name="stype" value="{stype}" />
	<input type="hidden" name="action" value="commit" />

<div class="panel panel-default">
  <div class="panel-heading">
    {plugin}
  </div>
	<div class="panel-body">
	{install_text}
	</div>
	<div class="card-footer text-center">
		<button type="submit" class="btn btn-outline-success">{mode_commit}</button>
	</div>
</div>
</form>