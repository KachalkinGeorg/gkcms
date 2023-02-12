<div class="input-group mb-3">
	<input type="text" id="searchInput" class="form-control" placeholder="{{ lang['extras.search'] }}">
	<div class="input-group-append">
		<span class="input-group-text"><i class="fa fa-search"></i></span>
	</div>
</div>

<div class="navbar-default navbar-component">
<ul class="nav nav-tabs nav-fill mb-3 d-md-flex d-block">
	<li class="nav-item"><a href="#" class="nav-link active" data-filter="pluginEntryActive"><span data-toggle="tooltip" data-placement="top" title="{{ lang['list.active'] }}"><i class="fa fa-eye"></i> {{ lang['list.active'] }}</span> <span class="badge badge-light">{{ cntActive }}</span></a></li>
	<li class="nav-item"><a href="#" class="nav-link" data-filter="pluginEntryInactive"><span data-toggle="tooltip" data-placement="top" title="{{ lang['list.inactive'] }}"><i class="fa fa-eye-slash"></i> {{ lang['list.inactive'] }}</span> <span class="badge badge-light">{{ cntInactive }}</span></a></li>
	<li class="nav-item"><a href="#" class="nav-link" data-filter="pluginEntryUninstalled"><span data-toggle="tooltip" data-placement="top" title="{{ lang['list.needinstall'] }}"><i class="fa fa-download"></i> {{ lang['list.needinstall'] }}</span> <span class="badge badge-light">{{ cntUninstalled }}</span></a></li>
	<li class="nav-item"><a href="#" class="nav-link" data-filter="all"><span data-toggle="tooltip" data-placement="top" title="{{ lang['list.all'] }}"><i class="fa fa-cubes"></i> {{ lang['list.all'] }}</span> <span class="badge badge-light">{{ cntAll }}</span></a></li>
</ul>
</div>

<div class="panel panel-default">
  <div class="panel-card">
    Всего активных плагинов - {{ cntActive }}
  </div>
  <div class="media-bordered">

	<div class="row box-section" id="entryList">
	{% for entry in entries %}
	  <dd class="col-sm-6 media-list media-list-linked {{ entry.style }} all" id="plugin_{{ entry.id }}">
		<div class="media-link">
			<div class="media-left">{{ entry.icon }}</div>
			<div class="media-body" style="width: 100%;">
				<h6 class="media-heading text-semibold">{{ entry.url }}</h6>
				<span class="text-muted text-size-small">{{ entry.description }}</span><br>
				<span class="text-muted text-size-small">
					<i class="fa fa-user" aria-hidden="true"></i> {{ entry.author_url }}
				</span><br>
				<span class="text-muted text-size-small">
				{{ entry.info }} {{ entry.readme }} {{ entry.history }} 
				{% if entry.flags.isCompatible %}<i title="{{ lang['compatible1'] }}" class="fa fa-check-circle"></i>{% else %}<i title="{{ lang['compatible2'] }}" class="fa fa-circle"></i>{% endif %} | {{ entry.type }} - 
					<span style="color:#6c757d!important;text-shadow:0 0 1px rgb(0 0 0 / 50%);font-size: 10px;">
						{{ entry.id }} {{ entry.new }} - <span>v{{ entry.version }}</span>
					</span>
				</span>
			</div>
			<div class="media-right"><span style="font-size: 10px;display: flex;">{{ entry.link }} {{ entry.install }}</span></div>
		</div>
		<hr>
	  </dd>
	<div id="modal-{{ entry.id }}" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="{{ entry.id }}-modal-label" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 id="{{ entry.id }}-modal-label" class="modal-title">{{ entry.url }}</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i class="fa fa-times-circle"></i></span></button>
				</div>
				<div class="modal-body">
					{{ entry.information }}
				</div>
				<div class="modal-footer">{{ lang['author'] }} - {{ entry.author }}</div>
			</div>
		</div>
	</div>
	 {% endfor %}
	 </div>
	</div>
</div>

<script>
	function tabsSwitch(pill) {
		$(".nav-tabs li>a").removeClass('active');

		const newSelection = $(pill).addClass('active')
			.attr('data-filter');

		$('dd.all').show().not('.'+newSelection).hide();
	}

	$(document).ready(function() {
		$(".nav-tabs").on('click', 'li>a:not(.active)', function() {
			$("#searchInput").val('');
			tabsSwitch($(this));
		});

		// Default plugin list display: active plugins
		tabsSwitch($(".nav-tabs li>a[data-filter=pluginEntryActive]"));

		$("#searchInput").on('keyup', function(event) {
			tabsSwitch($('.nav-tabs li>a').eq(0));

			const filter = $('#searchInput').val().toUpperCase();

			$('#entryList').find('dd').each(function(index, element) {
				const plugin = $(element).find('div').first().text();

				if (plugin && plugin.toUpperCase().includes(filter)) {
					$(element).show();
				} else {
					$(element).hide();
				}
			});
		});
	});

	function ngPluginSwitch(plugin, state) {
		ngShowLoading();
		$.post('/engine/rpc.php', {
			json: 1,
			methodName: 'admin.extras.switch',
			rndval: new Date().getTime(),
			params: json_encode({
				'token': '{{ token }}',
				'plugin': plugin,
				'state': state,
			})
		}, function(data) {
			ngHideLoading();
			// Try to decode incoming data
			try {
				resTX = eval('(' + data + ')');
			} catch (err) {
				ngNotifySticker('{{ lang['rpc_jsonError '] }}' + data, {className: 'stickers-danger',sticked: 'true',closeBTN: true,});
			}
			if (!resTX['status']) {
				ngNotifySticker('Error [' + resTX['errorCode'] + ']: ' + resTX['errorText'], {className: 'stickers-danger',sticked: 'true',closeBTN: true,});
			} else {
				ngNotifySticker(resTX['errorText'], {className: 'stickers-danger',sticked: 'true',closeBTN: true,});
			}
		}, "text").error(function() {
			ngHideLoading();
			ngNotifySticker('{{ lang['rpc_httpError '] }}', {className: 'stickers-danger',sticked: 'true',closeBTN: true,});
		});
	}
</script>