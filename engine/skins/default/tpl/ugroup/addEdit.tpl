<form action="{{ php_self }}?mod=ugroup" method="post">
	<input type="hidden" name="token" value="{{ token }}" />
	{% if (flags.editMode) %}
	<input type="hidden" name="action" value="edit" />
	<input type="hidden" name="id" value="{{ entry.id }}" />
	{% else %}
	<input type="hidden" name="action" value="add" />
	{% endif %}

	<div class="row">
		<!-- Left edit column -->
		<div class="col-lg-8">

			<!-- MAIN CONTENT -->
			<div id="maincontent" class="panel panel-default mb-4">
				<div class="panel-heading">{% if (flags.editMode) %} {{ lang['edit_group'] }} {% else %} {{ lang['add_group'] }} {% endif %}</div>
				<div class="panel-body">
				{% if (flags.editMode) %}
					<div class="form-row mb-3">
						<label class="col-lg-6 col-form-label">ID группы:</label>
						<div class="col-lg-6">
							<input type="text" readonly class="form-control-plaintext" value="{{ entry.id }}" />
						</div>
					</div>
				{% endif %}

					<div class="form-row mb-3">
						<label class="col-lg-6 col-form-label">{{ lang['identifier'] }}</label>
						<div class="col-lg-6">
						<div class="input-group">
							<input placeholder="Введите идентификатор..." type="text" name="identity" value="{{ entry.identity }}" class="form-control" />
							<div class="input-group-append">
							<a class="btn btn-outline-primary" data-toggle="popover" data-placement="right" data-trigger="focus" data-html="true" title="ИДЕНТИФИКАТОР" data-content="Идентификатор - это имя, которое идентифицирует (то есть маркирует порядковый ИД группы)" tabindex="0">
								<i class="fa fa-question"></i>
							</a>
							</div>
						</div>
						</div>
					</div>

					{% for eLang,eLValue in entry.langName %}
					<div class="form-row mb-3">
						<label class="col-lg-6 col-form-label">{{ lang['name_group_lang'] }} [{{ eLang }}]</label>
						<div class="col-lg-6">
							<input type="text" name="langname[{{ eLang }}]" value="{{ eLValue }}" class="form-control" />
						</div>
					</div>
					{% endfor %}
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col col-lg-8">
			<div class="row">
				{% if (flags.canModify) %}
					<div class="col-md-6 mb-4">
						<button type="button" class="btn btn-outline-dark" onclick="history.back();">
							{{ lang['cancel'] }}
						</button>
					</div>

					<div class="col-md-6 mb-4 text-right">
						<button type="submit" class="btn btn-outline-success">
							<span class="d-xl-none"><i class="fa fa-floppy-o"></i></span>
							<span class="d-none d-xl-block">{{ lang['save'] }}</span>
						</button>
					</div>
				{% endif %}
			</div>
		</div>
	</div>
</form>