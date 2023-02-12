{{ notify }}
{{ breadcrumb }}
<div class="content">{{ main_admin }}</div>
		</main>
		<footer class="border-top mt-5">
			<p class="text-right text-muted py-4 my-0">2008-{{ year }} © <a href="http://ngcms.ru" target="_blank">Next Generation CMS</a></p>
		</footer>
	</div>

</div>
<script type="text/javascript">
{# Устанавливаем временную переменную, чтобы отловить ошибки JSON - декодирования.#}
{% set encode_lang = lang | json_encode(constant('JSON_PRETTY_PRINT') b-or constant('JSON_UNESCAPED_UNICODE')) %}
window.NGCMS = {
	admin_url: '{{ admin_url }}',
		home: '{{ home }}',
		lang: {{ encode_lang ?: '{}' }},
		langcode: '{{ lang['langcode'] }}',
	php_self: '{{ php_self }}',
		skins_url: '{{ skins_url }}'
	};
	$('#menu-content .sub-menu').on('show.bs.collapse', function () {
        $('#menu-content .sub-menu.show').not(this).removeClass('show');
    });
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$('[data-toggle="popover"]').popover();
		$('[data-toggle="tooltip"]').tooltip();
	});
	
    $('#full_screen').on('click',function() {
		if (!document.fullscreenElement) {
			document.documentElement.requestFullscreen();
		} else {
		if (document.exitFullscreen) {
			document.exitFullscreen();
		}
		}
        
    });
</script>
	</body>
</html>