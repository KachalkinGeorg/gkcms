			<div class="card mb-4">
				<div class="card-header">ИД форума
					<div class="card-header-right">
						<a class="btn2" data-toggle="popover" data-placement="top" data-trigger="focus" data-html="true" title="ИД ФОРУМ" data-content="Вы можете присвоить новость к форуму, для привязывания нужно знать ИД категории форума, например <strong>/plugin/forum/showtopic/?id=1</strong> где цифра <strong>1</strong> и есть ИД катеогории форума, его вписываем в данное поле и сохраняем публикацию. После повторного редактирования появится ссылка в этом пункте." tabindex="0">
							<i class="fa fa-question-circle fa-1x"></i>
						</a>
					</div>
				</div>
				<div class="card-body">
					<div class="input-group mb-3">
						<div class="input-group-prepend input-group-append">
							<label class="input-group-text" title="Кнопка {{ forum_but1 }}" style="width: 180px;">{{ forum_but1 }}</label>
						</div>
						<input type="text" name="tid" placeholder="Введите ИД категории форума..." value="{{ forum_tid }}" class="form-control" />
						{% if (forum_tid) %}<span class="input-group-text"><a href="/plugin/forum/showtopic/?id={{ forum_tid }}" title="Принадлежит категории {{ forum_topic }}" target="_blank"><i class="fa fa-external-link"></i></a></span>{% endif %}
					</div>
					{% for entry in entries_discus %}
					<div class="input-group mb-3">
						<div class="input-group-prepend input-group-append">
							<label class="input-group-text" title="Кнопка {{ entry.forum_but2 }}" style="width: 180px;">{{ entry.forum_but2 }}</label>
						</div>
						<input type="text" name="did" placeholder="Введите ИД категории форума..." value="{{ entry.forum_did }}" class="form-control" />
						{% if (entry.forum_did) %}<span class="input-group-text"><a href="/plugin/forum/showtopic/?id={{ entry.forum_did }}" title="Принадлежит категории {{ entry.forum_discus }}" target="_blank"><i class="fa fa-external-link"></i></a></span>{% endif %}
					</div>
					{% endfor %}
				</div>
			</div>