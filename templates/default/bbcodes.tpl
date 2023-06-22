<div class="bb-pane">
<span>
	<b id="b_b" class="bb-btn" onclick="insertext('[b]','[/b]', {{ area }})" title="{{ lang['tags.bold'] }}"></b>
	<b id="b_i" class="bb-btn" onclick="insertext('[i]','[/i]', {{ area }})" title="{{ lang['tags.italic'] }}"></b>
	<b id="b_u" class="bb-btn" onclick="insertext('[u]','[/u]', {{ area }})" title="{{ lang['tags.underline'] }}"></b>
	<b id="b_s" class="bb-btn" onclick="insertext('[s]','[/s]', {{ area }})" title="{{ lang['tags.crossline'] }}"></b>
	<span class="bb-sep"></span>
	<b id="b_left" class="bb-btn" onclick="insertext('[left]','[/left]', {{ area }})" title="Выравнивание по левому краю"></b>
	<b id="b_center" class="bb-btn" onclick="insertext('[center]','[/center]', {{ area }})" title="По центру"></b>
	<b id="b_right" class="bb-btn" onclick="insertext('[right]','[/right]', {{ area }})" title="Выравнивание по правому краю"></b>
	<span class="bb-sep"></span>
	<b id="b_emo" class="bb-btn" onclick="show_alert(this)" title="Смайлики" tabindex="-1"></b>
	<div class="modal">
	<div class="modal-close" onclick="this.parentNode.style.display='none';"><i class="fa fa-times-circle fa-2x" aria-hidden="true"></i></div>
	<div style="text-align: center;">Вставить смайлик</div>
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				<th onclick="insertext(':angry:','', {{ area }})"><img src="{{ skins_url }}/smilies/angry.png" alt="" style="margin: 10px; cursor: pointer;" border="0" height="15" width="15"></th>
				<th onclick="insertext(':biggrin:','', {{ area }})"><img src="{{ skins_url }}/smilies/biggrin.png" alt="" style="margin: 10px; cursor: pointer;" border="0" height="15" width="15"></th>
				<th onclick="insertext(':blush:','', {{ area }})"><img src="{{ skins_url }}/smilies/blush.png" alt="" style="margin: 10px; cursor: pointer;" border="0" height="15" width="15"></th>
				<th onclick="insertext(':confused:','', {{ area }})"><img src="{{ skins_url }}/smilies/confused.png" alt="" style="margin: 10px; cursor: pointer;" border="0" height="15" width="15"></th>
				<th onclick="insertext(':cool:','', {{ area }})"><img src="{{ skins_url }}/smilies/cool.png" alt="" style="margin: 10px; cursor: pointer;" border="0" height="15" width="15"></th>
			</tr>
			<tr>
				<th onclick="insertext(':crazy:','', {{ area }})"><img src="{{ skins_url }}/smilies/crazy.png" alt="" style="margin: 10px; cursor: pointer;" border="0" height="15" width="15"></th>
				<th onclick="insertext(':cry:','', {{ area }})"><img src="{{ skins_url }}/smilies/cry.png" alt="" style="margin: 10px; cursor: pointer;" border="0" height="15" width="15"></th>
				<th onclick="insertext(':kiss:','', {{ area }})"><img src="{{ skins_url }}/smilies/kiss.png" alt="" style="margin: 10px; cursor: pointer;" border="0" height="15" width="15"></th>
				<th onclick="insertext(':sad:','', {{ area }})"><img src="{{ skins_url }}/smilies/sad.png" alt="" style="margin: 10px; cursor: pointer;" border="0" height="15" width="15"></th>
				<th onclick="insertext(':shhh:','', {{ area }})"><img src="{{ skins_url }}/smilies/shhh.png" alt="" style="margin: 10px; cursor: pointer;" border="0" height="15" width="15"></th>
			</tr>
			<tr>
				<th onclick="insertext(':smile:','', {{ area }})"><img src="{{ skins_url }}/smilies/smile.png" alt="" style="margin: 10px; cursor: pointer;" border="0" height="15" width="15"></th>
				<th onclick="insertext(':surprise:','', {{ area }})"><img src="{{ skins_url }}/smilies/surprise.png" alt="" style="margin: 10px; cursor: pointer;" border="0" height="15" width="15"></th>
				<th onclick="insertext(':thinking:','', {{ area }})"><img src="{{ skins_url }}/smilies/thinking.png" alt="" style="margin: 10px; cursor: pointer;" border="0" height="15" width="15"></th>
				<th onclick="insertext(':tired:','', {{ area }})"><img src="{{ skins_url }}/smilies/tired.png" alt="" style="margin: 10px; cursor: pointer;" border="0" height="15" width="15"></th>
				<th onclick="insertext(':tongue:','', {{ area }})"><img src="{{ skins_url }}/smilies/tongue.png" alt="" style="margin: 10px; cursor: pointer;" border="0" height="15" width="15"></th>
			</tr>
			<tr>
				<th onclick="insertext(':undecide:','', {{ area }})"><img src="{{ skins_url }}/smilies/undecide.png" alt="" style="margin: 10px; cursor: pointer;" border="0" height="15" width="15"></th>
				<th onclick="insertext(':upset:','', {{ area }})"><img src="{{ skins_url }}/smilies/upset.png" alt="" style="margin: 10px; cursor: pointer;" border="0" height="15" width="15"></th>
				<th onclick="insertext(':wink:','', {{ area }})"><img src="{{ skins_url }}/smilies/wink.png" alt="" style="margin: 10px; cursor: pointer;" border="0" height="15" width="15"></th>
				<th onclick="insertext(':up:','', {{ area }})"><img src="{{ skins_url }}/smilies/up.png" alt="" style="margin: 10px; cursor: pointer;" border="0" height="15" width="15"></th>
				<th onclick="insertext(':down:','', {{ area }})"><img src="{{ skins_url }}/smilies/down.png" alt="" style="margin: 10px; cursor: pointer;" border="0" height="15" width="15"></th>
			</tr>
		</table>
	</div>
	<b id="b_url" class="bb-btn" onclick="insertext('[url=]','[/url]', {{ area }})" title="{{ lang['tags.link'] }}"></b>
	<b id="b_img" class="bb-btn" onclick="insertext('[img=]','[/img]', {{ area }})" title="Картинка"></b>
	<b id="b_color" class="bb-btn" onclick="show_alert(this)" title="{{ lang['tags.color'] }}" tabindex="-1"></b>
	<div class="modal">
    <div class="modal-close" onclick="this.parentNode.style.display='none';"><i class="fa fa-times-circle fa-2x" aria-hidden="true"></i></div>
    <div style="text-align: center;">{{ lang['tags.color'] }}</div>
		<dt class="bb_color" style="padding: 5px;">
			<a onclick="ShowOrHide('color');insertext('[color=#000000]','[/color]', {{ area }})" style="background:#000000;" title="000000"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#1b4a08]','[/color]', {{ area }})" style="background:#1b4a08;" title="1b4a08"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#37470b]','[/color]', {{ area }})" style="background:#37470b;" title="37470b"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#5d570c]','[/color]', {{ area }})" style="background:#5d570c;" title="5d570c"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#7a6301]','[/color]', {{ area }})" style="background:#7a6301;" title="7a6301"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#5d3b00]','[/color]', {{ area }})" style="background:#5d3b00;" title="5d3b00"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#562f06]','[/color]', {{ area }})" style="background:#562f06;" title="562f06"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#551600]','[/color]', {{ area }})" style="background:#551600;" title="551600"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#500700]','[/color]', {{ area }})" style="background:#500700;" title="500700"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#390b24]','[/color]', {{ area }})" style="background:#390b24;" title="390b24"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#250b43]','[/color]', {{ area }})" style="background:#250b43;" title="250b43"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#0c0941]','[/color]', {{ area }})" style="background:#0c0941;" title="0c0941"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#0e295b]','[/color]', {{ area }})" style="background:#0e295b;" title="0e295b"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#1c3f4d]','[/color]', {{ area }})" style="background:#1c3f4d;" title="1c3f4d"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#212121]','[/color]', {{ area }})" style="background:#212121;" title="212121"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#2b6516]','[/color]', {{ area }})" style="background:#2b6516;" title="2b6516"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#4f6516]','[/color]', {{ area }})" style="background:#4f6516;" title="4f6516"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#807b14]','[/color]', {{ area }})" style="background:#807b14;" title="807b14"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#a68a00]','[/color]', {{ area }})" style="background:#a68a00;" title="a68a00"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#825200]','[/color]', {{ area }})" style="background:#825200;" title="825200"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#764008]','[/color]', {{ area }})" style="background:#764008;" title="764008"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#731e00]','[/color]', {{ area }})" style="background:#731e00;" title="731e00"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#6f0b00]','[/color]', {{ area }})" style="background:#6f0b00;" title="6f0b00"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#4f1333]','[/color]', {{ area }})" style="background:#4f1333;" title="4f1333"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#350f5e]','[/color]', {{ area }})" style="background:#350f5e;" title="350f5e"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#100c57]','[/color]', {{ area }})" style="background:#100c57;" title="100c57"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#143a80]','[/color]', {{ area }})" style="background:#143a80;" title="143a80"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#265769]','[/color]', {{ area }})" style="background:#265769;" title="265769"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#404040]','[/color]', {{ area }})" style="background:#404040;" title="404040"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#3e8b20]','[/color]', {{ area }})" style="background:#3e8b20;" title="3e8b20"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#6e8b20]','[/color]', {{ area }})" style="background:#6e8b20;" title="6e8b20"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#b2a81b]','[/color]', {{ area }})" style="background:#b2a81b;" title="b2a81b"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#e8c202]','[/color]', {{ area }})" style="background:#e8c202;" title="e8c202"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#b57300]','[/color]', {{ area }})" style="background:#b57300;" title="b57300"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#a3590b]','[/color]', {{ area }})" style="background:#a3590b;" title="a3590b"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#a22a00]','[/color]', {{ area }})" style="background:#a22a00;" title="a22a00"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#9b0f00]','[/color]', {{ area }})" style="background:#9b0f00;" title="9b0f00"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#6e1a47]','[/color]', {{ area }})" style="background:#6e1a47;" title="6e1a47"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#481581]','[/color]', {{ area }})" style="background:#481581;" title="481581"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#19117c]','[/color]', {{ area }})" style="background:#19117c;" title="19117c"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#1b4fb0]','[/color]', {{ area }})" style="background:#1b4fb0;" title="1b4fb0"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#357993]','[/color]', {{ area }})" style="background:#357993;" title="357993"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#5e5e5e]','[/color]', {{ area }})" style="background:#5e5e5e;" title="5e5e5e"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#4cb228]','[/color]', {{ area }})" style="background:#4cb228;" title="4cb228"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#8bb228]','[/color]', {{ area }})" style="background:#8bb228;" title="8bb228"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#e2d724]','[/color]', {{ area }})" style="background:#e2d724;" title="e2d724"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#ffdd28]','[/color]', {{ area }})" style="background:#ffdd28;" title="ffdd28"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#e69100]','[/color]', {{ area }})" style="background:#e69100;" title="e69100"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#cf6e0e]','[/color]', {{ area }})" style="background:#cf6e0e;" title="cf6e0e"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#cd3600]','[/color]', {{ area }})" style="background:#cd3600;" title="cd3600"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#c21400]','[/color]', {{ area }})" style="background:#c21400;" title="c21400"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#8c2159]','[/color]', {{ area }})" style="background:#8c2159;" title="8c2159"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#5b1ba4]','[/color]', {{ area }})" style="background:#5b1ba4;" title="5b1ba4"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#1e1599]','[/color]', {{ area }})" style="background:#1e1599;" title="1e1599"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#2364de]','[/color]', {{ area }})" style="background:#2364de;" title="2364de"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#439ab9]','[/color]', {{ area }})" style="background:#439ab9;" title="439ab9"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#808080]','[/color]', {{ area }})" style="background:#808080;" title="808080"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#59d62f]','[/color]', {{ area }})" style="background:#59d62f;" title="59d62f"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#a4d62f]','[/color]', {{ area }})" style="background:#a4d62f;" title="a4d62f"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#fef538]','[/color]', {{ area }})" style="background:#fef538;" title="fef538"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#ffe854]','[/color]', {{ area }})" style="background:#ffe854;" title="ffe854"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#ffb31c]','[/color]', {{ area }})" style="background:#ffb31c;" title="ffb31c"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#fb9314]','[/color]', {{ area }})" style="background:#fb9314;" title="fb9314"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#f44a06]','[/color]', {{ area }})" style="background:#f44a06;" title="f44a06"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#e62414]','[/color]', {{ area }})" style="background:#e62414;" title="e62414"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#a82769]','[/color]', {{ area }})" style="background:#a82769;" title="a82769"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#7421c4]','[/color]', {{ area }})" style="background:#7421c4;" title="7421c4"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#2d1abb]','[/color]', {{ area }})" style="background:#2d1abb;" title="2d1abb"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#3276ff]','[/color]', {{ area }})" style="background:#3276ff;" title="3276ff"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#4eb2df]','[/color]', {{ area }})" style="background:#4eb2df;" title="4eb2df"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#a6a6a6]','[/color]', {{ area }})" style="background:#a6a6a6;" title="a6a6a6"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#78ed4b]','[/color]', {{ area }})" style="background:#78ed4b;" title="78ed4b"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#c1ed4b]','[/color]', {{ area }})" style="background:#c1ed4b;" title="c1ed4b"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#fef45f]','[/color]', {{ area }})" style="background:#fef45f;" title="fef45f"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#ffe773]','[/color]', {{ area }})" style="background:#ffe773;" title="ffe773"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#ffb83f]','[/color]', {{ area }})" style="background:#ffb83f;" title="ffb83f"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#fa9f3c]','[/color]', {{ area }})" style="background:#fa9f3c;" title="fa9f3c"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#f26c3f]','[/color]', {{ area }})" style="background:#f26c3f;" title="f26c3f"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#e64b4c]','[/color]', {{ area }})" style="background:#e64b4c;" title="e64b4c"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#d33288]','[/color]', {{ area }})" style="background:#d33288;" title="d33288"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#8c29fe]','[/color]', {{ area }})" style="background:#8c29fe;" title="8c29fe"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#3222f5]','[/color]', {{ area }})" style="background:#3222f5;" title="3222f5"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#5597ff]','[/color]', {{ area }})" style="background:#5597ff;" title="5597ff"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#67d7ff]','[/color]', {{ area }})" style="background:#67d7ff;" title="67d7ff"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#cccccc]','[/color]', {{ area }})" style="background:#cccccc;" title="cccccc"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#98f07a]','[/color]', {{ area }})" style="background:#98f07a;" title="98f07a"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#cdf07a]','[/color]', {{ area }})" style="background:#cdf07a;" title="cdf07a"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#fef888]','[/color]', {{ area }})" style="background:#fef888;" title="fef888"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#ffee97]','[/color]', {{ area }})" style="background:#ffee97;" title="ffee97"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#ffca70]','[/color]', {{ area }})" style="background:#ffca70;" title="ffca70"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#fab770]','[/color]', {{ area }})" style="background:#fab770;" title="fab770"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#f39174]','[/color]', {{ area }})" style="background:#f39174;" title="f39174"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#eb7d7f]','[/color]', {{ area }})" style="background:#eb7d7f;" title="eb7d7f"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#da67a6]','[/color]', {{ area }})" style="background:#da67a6;" title="da67a6"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#a551ff]','[/color]', {{ area }})" style="background:#a551ff;" title="a551ff"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#6049ff]','[/color]', {{ area }})" style="background:#6049ff;" title="6049ff"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#81b2ff]','[/color]', {{ area }})" style="background:#81b2ff;" title="81b2ff"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#84e3ff]','[/color]', {{ area }})" style="background:#84e3ff;" title="84e3ff"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#e8e8e8]','[/color]', {{ area }})" style="background:#e8e8e8;" title="e8e8e8"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#bcf4a8]','[/color]', {{ area }})" style="background:#bcf4a8;" title="bcf4a8"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#def4a8]','[/color]', {{ area }})" style="background:#def4a8;" title="def4a8"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#fef9b0]','[/color]', {{ area }})" style="background:#fef9b0;" title="fef9b0"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#fff3ba]','[/color]', {{ area }})" style="background:#fff3ba;" title="fff3ba"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#ffdba1]','[/color]', {{ area }})" style="background:#ffdba1;" title="ffdba1"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#fbcea2]','[/color]', {{ area }})" style="background:#fbcea2;" title="fbcea2"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#f7b8a5]','[/color]', {{ area }})" style="background:#f7b8a5;" title="f7b8a5"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#f0aaab]','[/color]', {{ area }})" style="background:#f0aaab;" title="f0aaab"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#e59cc5]','[/color]', {{ area }})" style="background:#e59cc5;" title="e59cc5"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#c18cff]','[/color]', {{ area }})" style="background:#c18cff;" title="c18cff"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#9586ff]','[/color]', {{ area }})" style="background:#9586ff;" title="9586ff"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#adccff]','[/color]', {{ area }})" style="background:#adccff;" title="adccff"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#acecff]','[/color]', {{ area }})" style="background:#acecff;" title="acecff"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#ffffff]','[/color]', {{ area }})" style="background:#ffffff;" title="ffffff"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#d8f3ce]','[/color]', {{ area }})" style="background:#d8f3ce;" title="d8f3ce"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#e9f3ce]','[/color]', {{ area }})" style="background:#e9f3ce;" title="e9f3ce"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#fdfbd8]','[/color]', {{ area }})" style="background:#fdfbd8;" title="fdfbd8"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#fff9dc]','[/color]', {{ area }})" style="background:#fff9dc;" title="fff9dc"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#ffecd0]','[/color]', {{ area }})" style="background:#ffecd0;" title="ffecd0"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#fde8d2]','[/color]', {{ area }})" style="background:#fde8d2;" title="fde8d2"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#fadbd3]','[/color]', {{ area }})" style="background:#fadbd3;" title="fadbd3"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#f6d5d7]','[/color]', {{ area }})" style="background:#f6d5d7;" title="f6d5d7"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#f0cfe2]','[/color]', {{ area }})" style="background:#f0cfe2;" title="f0cfe2"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#e0c5ff]','[/color]', {{ area }})" style="background:#e0c5ff;" title="e0c5ff"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#cbc5ff]','[/color]', {{ area }})" style="background:#cbc5ff;" title="cbc5ff"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#d5e6ff]','[/color]', {{ area }})" style="background:#d5e6ff;" title="d5e6ff"></a>
			<a onclick="ShowOrHide('color');insertext('[color=#d4f5ff]','[/color]', {{ area }})" style="background:#d4f5ff;" title="d4f5ff"></a>
		</dt>
	</div>
	<span class="bb-sep"></span>
	<b id="b_code" class="bb-btn" onclick="insertext('[code]','[/code]', {{ area }})" title="{{ lang['tags.code'] }}"></b>
	<b id="b_hide" class="bb-btn" onclick="insertext('[hide]','[/hide]', {{ area }})" title="{{ lang['tags.hide'] }}"></b>
	<b id="b_quote" class="bb-btn" onclick="insertext('[quote]','[/quote]', {{ area }})" title="{{ lang['tags.quote'] }}"></b>
	<b id="b_spoiler" class="bb-btn" onclick="insertext('[spoiler]','[/spoiler]', {{ area }})" title="Вставка спойлера"></b>
	<span class="bb-sep"></span>
<!-- 	<b id="b_mail" class="bb-btn" onclick="tag_email();" title="{{ lang['tags.email'] }}"></b> -->
</span>
</div>