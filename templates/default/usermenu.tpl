{% if (global.flags.isLogged) %}
	<div id="user-panel">
	
		{% if pluginIsActive('uprofile') %}<span class="none">
			<a href="#{{ global.user.id }}"><img class="avatar" src="{{ avatar_url }}" alt=""/></a></span>
		<a href="#{{ global.user.id }}"><span class="icon"></span>{{ lang['myprofile'] }}</a><!-- {line} -->{% endif %}
		{% if pluginIsActive('pm') %}<a href="{{ p.pm.link }}" title="Персональные Сообщения" style="text-align:center;">({{ p.pm.pm_unread }} / {{ p.pm.pm_all }})</a>{% endif %}
		[if-have-perm]<a href="{{ admin_url }}" target="_blank"><b>{{ lang['adminpanel'] }}</b></a>[/if-have-perm]
		<span class="none"><a href="{{ logout_link }}" title="{{ lang['logout'] }}" class="exit"></a></span>
	</div>
	{% if pluginIsActive('uprofile') %}{{ profile_show }}{% endif %}
{% else %}
	<script language="javascript">
		var set_login = 0;
		var set_pass = 0;
	</script>
	<div id="user-panel">
		<a href="#" id="login"><span class="icon icon-key"></span>{{ lang['login'] }}</a>
		<a href="{{ reg_link }}"><span class="icon icon-address"></span>{{ lang['registration'] }}</a>
	</div>
	<div id="dialog">
		<div class="bg"></div>
		<div class="dialog">
			<div class="dialog-clouse"></div>
			<div class="dialog-title">
				<img src="{{ tpl_url }}/img/logo.png" alt="">
			</div>
			<div class="dialog-message">
				{{ lang.theme['login_header'] }}
				<form name="login" method="post" action="{{ form_action }}" id="login">
					<input type="hidden" name="redirect" value="{{ redirect }}"/>
					<input type="text" name="username" placeholder="{{ lang['username'] }}:" class="input">
					<input type="password" name="password" placeholder="{{ lang['password'] }}:" class="input"><br>
					<input type="submit" value="{{ lang['login'] }}" class="btn">
					<a href="{{ lost_link }}" class="btn">{{ lang['lostpassword'] }}</a>
				</form>
			</div>
		</div>
	</div>
{% endif %}