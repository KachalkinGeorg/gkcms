			<div class="card mb-4">
				<div class="card-header">Форум
					<div class="card-header-right">
						<a class="btn2" data-toggle="popover" data-placement="top" data-trigger="focus" data-html="true" title="ФОРУМ" data-content="Выбирете желаемый узел форума. Чтобы привязать публикацию к категории форума нужно выбрать из списка и нажать на кнопку <i><b>Создать на форуме</b></i>{% for entry in entries_discus %}, если активны кнопки между <b>{{ forum_but1 }}</b> и <b>{{ entry.forum_but2 }}</b>, выбрать будет нужно одно из них{% endfor %}, далее публикация продублируется в узле выбранного форума." tabindex="0">
							<i class="fa fa-question-circle fa-1x"></i>
						</a>
					</div>
				</div>
				<div class="card-body">
					<div style="overflow: auto;"><select name="forum_id" id="catmenu" class="custom-select">
						<option>Выберите узел форума</option>
							{{ options_forum }}
						</select>
					</div>
					
					{{ forum_create }}
					
					{% for entry in entries_discus %}
					<label class="col-form-label d-block">
						<select name="create_forum" class="custom-select">
							<option value="">Кнопка на форуме</option>
							<option value="1">- {{ forum_but1 }}</option>
							<option value="2">- {{ entry.forum_but2 }}</option>
						</select>
					</label>
					{% endfor %}
				</div>
			</div>