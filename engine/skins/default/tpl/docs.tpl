<div id="docs" class="panel panel-default">
	<div class="panel-heading">
     {{ lang['docs'] }}
		<div class="panel-head-right">
			<a href="#" style="position: absolute;right: -8px;top: 2px;cursor: pointer;" class="btn2" title="{{ lang['full_screen'] }}" onclick="$('#docs').toggleClass('full-content');return false;"><i class="fa fa-arrows-alt fa-lg"></i></a>
		</div>
	</div>
<div class="panel-body" style="padding: 0;margin: 0;">
<section class="content" style="margin: 0;">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-3">
				<div class="docs__menu mx-2 my-5 py-4" style="border: 1px solid #ccc;">{{ menu }}</div>
			</div>
			<div class="col-md-9">
				<div class="docs__contents mx-2 my-5">
					{% if docs %}
					{{ docs }}
					{% else %}
					404
					{% endif %}
				</div>
			</div>
		</div>
	</div>
</section>
</div>
</div>