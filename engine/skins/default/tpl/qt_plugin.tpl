<div id="tags" class="btn-toolbar mb-3" role="toolbar">
	<div class="btn-group btn-group-sm mr-2">
		<button type="button" class="btn btn-outline-dark" onclick="insertext('[p]','[/p]', {{ area }})"><i class="fa fa-paragraph"></i></button>
	</div>

	<div class="btn-group btn-group-sm mr-2">
		<button id="tags-font" type="button" class="btn btn-outline-dark dropdown-toggle" data-placement="top" data-popup="tooltip" data-original-title="Шрифт" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			<i class="fa fa-font"></i>
		</button>
		<ul class="dropdown-menu" aria-labelledby="tags-font">
			<li><a href="#" class="dropdown-item" onclick="insertext('[b]','[/b]', {{ area }})"><i class="fa fa-bold"></i> {{ lang['tags.bold'] }}</a></li>
			<li><a href="#" class="dropdown-item" onclick="insertext('[i]','[/i]', {{ area }})"><i class="fa fa-italic"></i> {{ lang['tags.italic'] }}</a></li>
			<li><a href="#" class="dropdown-item" onclick="insertext('[u]','[/u]', {{ area }})"><i class="fa fa-underline"></i> {{ lang['tags.underline'] }}</a></li>
			<li><a href="#" class="dropdown-item" onclick="insertext('[s]','[/s]', {{ area }})"><i class="fa fa-strikethrough"></i> {{ lang['tags.crossline'] }}</a></li>
			<div class="dropdown-divider"></div>
			<li class="dropdown-submenu">
				<a href="#" class="dropdown-item" tabindex="-1"><i class="fa fa-font" aria-hidden="true"></i>Вставить шрифт </a>
				<ul class="dropdown-menu" style="cursor: pointer;">
					<a class="dropdown-item" onclick="insertext('[font=Arial]','[/font]', {{ area }})" style="font-family:Arial" title="Arial">Arial</a>
					<a class="dropdown-item" onclick="insertext('[font=Arial Black]','[/font]', {{ area }})" style="font-family:Arial Black" title="Arial Black">Arial Black</a>
					<a class="dropdown-item" onclick="insertext('[font=Century Gothic]','[/font]', {{ area }})" style="font-family:Century Gothic" title="Century Gothic">Century Gothic</a>
					<a class="dropdown-item" onclick="insertext('[font=Courier New]','[/font]', {{ area }})" style="font-family:Courier New" title="Courier New">Courier New</a>
					<a class="dropdown-item" onclick="insertext('[font=Georgia]','[/font]', {{ area }})" style="font-family:Georgia" title="Georgia">Georgia</a>
					<a class="dropdown-item" onclick="insertext('[font=Impact]','[/font]', {{ area }})" style="font-family:Impact" title="Impact">Impact</a>
					<a class="dropdown-item" onclick="insertext('[font=System]','[/font]', {{ area }})" style="font-family:System" title="System">System</a>
					<a class="dropdown-item" onclick="insertext('[font=Tahoma]','[/font]', {{ area }})" style="font-family:Tahoma" title="Tahoma">Tahoma</a>
					<a class="dropdown-item" onclick="insertext('[font=Times New Roman]','[/font]', {{ area }})" style="font-family:Times New Roman" title="Times New Roman">Times New Roman</a>
					<a class="dropdown-item" onclick="insertext('[font=Verdana]','[/font]', {{ area }})" style="font-family:Verdana" title="Verdana">Verdana</a>
				</ul>
			</li>
			<li class="dropdown-submenu">
				<a href="#" class="dropdown-item" tabindex="-1"><i class="fa fa-header" aria-hidden="true"></i>Заголовок </a>
				<ul class="dropdown-menu" style="cursor: pointer;">
					<a href="#" class="dropdown-item" onclick="insertext('[h1]','[/h1]', {{ area }})">H1</a>
					<a href="#" class="dropdown-item" onclick="insertext('[h2]','[/h2]', {{ area }})">H2</a>
					<a href="#" class="dropdown-item" onclick="insertext('[h3]','[/h3]', {{ area }})">H3</a>
					<a href="#" class="dropdown-item" onclick="insertext('[h4]','[/h4]', {{ area }})">H4</a>
					<a href="#" class="dropdown-item" onclick="insertext('[h5]','[/h5]', {{ area }})">H5</a>
					<a href="#" class="dropdown-item" onclick="insertext('[h6]','[/h6]', {{ area }})">H6</a>
				</ul>
			</li>
		</ul>
	</div>

	<div class="btn-group btn-group-sm mr-2">
		<button id="tags-align" type="button" class="btn btn-outline-dark dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			<i class="fa fa-align-left"></i>
		</button>
		<ul class="dropdown-menu" aria-labelledby="tags-align">
			<li><a href="#" class="dropdown-item" onclick="insertext('[left]','[/left]', {{ area }})"><i class="fa fa-align-left"></i> {{ lang['tags.left'] }}</a></li>
			<li><a href="#" class="dropdown-item" onclick="insertext('[center]','[/center]', {{ area }})"><i class="fa fa-align-center"></i> {{ lang['tags.center'] }}</a></li>
			<li><a href="#" class="dropdown-item" onclick="insertext('[right]','[/right]', {{ area }})"><i class="fa fa-align-right"></i> {{ lang['tags.right'] }}</a></li>
			<li><a href="#" class="dropdown-item" onclick="insertext('[justify]','[/justify]', {{ area }})"><i class="fa fa-align-justify"></i> {{ lang['tags.justify'] }}</a></li>
		</ul>
	</div>

	<div class="btn-group btn-group-sm mr-2">
		<button type="button" class="btn btn-outline-dark dropdown-toggle" data-placement="top" data-popup="tooltip" data-original-title="Цвета" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-paint-brush" aria-hidden="true"></i></button>
		<ul class="dropdown-menu">
		<li class="dropdown-submenu">
          <a href="#" class="dropdown-item" tabindex="-1"><i class="fa fa-paint-brush" aria-hidden="true"></i>Вставить цвет текста </a>
		<ul class="dropdown-menu" style="left: 100%;">
			<div class="bb_color" >
			<a onclick="insertext('[color=#000000]','[/color]', {{ area }})" style="background:#000000;" title="000000"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#1b4a08]','[/color]', {{ area }})" style="background:#1b4a08;" title="1b4a08"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#37470b]','[/color]', {{ area }})" style="background:#37470b;" title="37470b"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#5d570c]','[/color]', {{ area }})" style="background:#5d570c;" title="5d570c"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#7a6301]','[/color]', {{ area }})" style="background:#7a6301;" title="7a6301"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#5d3b00]','[/color]', {{ area }})" style="background:#5d3b00;" title="5d3b00"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#562f06]','[/color]', {{ area }})" style="background:#562f06;" title="562f06"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#551600]','[/color]', {{ area }})" style="background:#551600;" title="551600"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#500700]','[/color]', {{ area }})" style="background:#500700;" title="500700"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#390b24]','[/color]', {{ area }})" style="background:#390b24;" title="390b24"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#250b43]','[/color]', {{ area }})" style="background:#250b43;" title="250b43"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#0c0941]','[/color]', {{ area }})" style="background:#0c0941;" title="0c0941"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#0e295b]','[/color]', {{ area }})" style="background:#0e295b;" title="0e295b"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#1c3f4d]','[/color]', {{ area }})" style="background:#1c3f4d;" title="1c3f4d"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#212121]','[/color]', {{ area }})" style="background:#212121;" title="212121"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#2b6516]','[/color]', {{ area }})" style="background:#2b6516;" title="2b6516"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#4f6516]','[/color]', {{ area }})" style="background:#4f6516;" title="4f6516"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#807b14]','[/color]', {{ area }})" style="background:#807b14;" title="807b14"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#a68a00]','[/color]', {{ area }})" style="background:#a68a00;" title="a68a00"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#825200]','[/color]', {{ area }})" style="background:#825200;" title="825200"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#764008]','[/color]', {{ area }})" style="background:#764008;" title="764008"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#731e00]','[/color]', {{ area }})" style="background:#731e00;" title="731e00"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#6f0b00]','[/color]', {{ area }})" style="background:#6f0b00;" title="6f0b00"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#4f1333]','[/color]', {{ area }})" style="background:#4f1333;" title="4f1333"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#350f5e]','[/color]', {{ area }})" style="background:#350f5e;" title="350f5e"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#100c57]','[/color]', {{ area }})" style="background:#100c57;" title="100c57"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#143a80]','[/color]', {{ area }})" style="background:#143a80;" title="143a80"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#265769]','[/color]', {{ area }})" style="background:#265769;" title="265769"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#404040]','[/color]', {{ area }})" style="background:#404040;" title="404040"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#3e8b20]','[/color]', {{ area }})" style="background:#3e8b20;" title="3e8b20"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#6e8b20]','[/color]', {{ area }})" style="background:#6e8b20;" title="6e8b20"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#b2a81b]','[/color]', {{ area }})" style="background:#b2a81b;" title="b2a81b"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#e8c202]','[/color]', {{ area }})" style="background:#e8c202;" title="e8c202"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#b57300]','[/color]', {{ area }})" style="background:#b57300;" title="b57300"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#a3590b]','[/color]', {{ area }})" style="background:#a3590b;" title="a3590b"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#a22a00]','[/color]', {{ area }})" style="background:#a22a00;" title="a22a00"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#9b0f00]','[/color]', {{ area }})" style="background:#9b0f00;" title="9b0f00"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#6e1a47]','[/color]', {{ area }})" style="background:#6e1a47;" title="6e1a47"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#481581]','[/color]', {{ area }})" style="background:#481581;" title="481581"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#19117c]','[/color]', {{ area }})" style="background:#19117c;" title="19117c"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#1b4fb0]','[/color]', {{ area }})" style="background:#1b4fb0;" title="1b4fb0"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#357993]','[/color]', {{ area }})" style="background:#357993;" title="357993"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#5e5e5e]','[/color]', {{ area }})" style="background:#5e5e5e;" title="5e5e5e"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#4cb228]','[/color]', {{ area }})" style="background:#4cb228;" title="4cb228"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#8bb228]','[/color]', {{ area }})" style="background:#8bb228;" title="8bb228"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#e2d724]','[/color]', {{ area }})" style="background:#e2d724;" title="e2d724"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#ffdd28]','[/color]', {{ area }})" style="background:#ffdd28;" title="ffdd28"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#e69100]','[/color]', {{ area }})" style="background:#e69100;" title="e69100"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#cf6e0e]','[/color]', {{ area }})" style="background:#cf6e0e;" title="cf6e0e"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#cd3600]','[/color]', {{ area }})" style="background:#cd3600;" title="cd3600"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#c21400]','[/color]', {{ area }})" style="background:#c21400;" title="c21400"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#8c2159]','[/color]', {{ area }})" style="background:#8c2159;" title="8c2159"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#5b1ba4]','[/color]', {{ area }})" style="background:#5b1ba4;" title="5b1ba4"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#1e1599]','[/color]', {{ area }})" style="background:#1e1599;" title="1e1599"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#2364de]','[/color]', {{ area }})" style="background:#2364de;" title="2364de"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#439ab9]','[/color]', {{ area }})" style="background:#439ab9;" title="439ab9"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#808080]','[/color]', {{ area }})" style="background:#808080;" title="808080"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#59d62f]','[/color]', {{ area }})" style="background:#59d62f;" title="59d62f"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#a4d62f]','[/color]', {{ area }})" style="background:#a4d62f;" title="a4d62f"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#fef538]','[/color]', {{ area }})" style="background:#fef538;" title="fef538"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#ffe854]','[/color]', {{ area }})" style="background:#ffe854;" title="ffe854"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#ffb31c]','[/color]', {{ area }})" style="background:#ffb31c;" title="ffb31c"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#fb9314]','[/color]', {{ area }})" style="background:#fb9314;" title="fb9314"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#f44a06]','[/color]', {{ area }})" style="background:#f44a06;" title="f44a06"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#e62414]','[/color]', {{ area }})" style="background:#e62414;" title="e62414"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#a82769]','[/color]', {{ area }})" style="background:#a82769;" title="a82769"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#7421c4]','[/color]', {{ area }})" style="background:#7421c4;" title="7421c4"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#2d1abb]','[/color]', {{ area }})" style="background:#2d1abb;" title="2d1abb"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#3276ff]','[/color]', {{ area }})" style="background:#3276ff;" title="3276ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#4eb2df]','[/color]', {{ area }})" style="background:#4eb2df;" title="4eb2df"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#a6a6a6]','[/color]', {{ area }})" style="background:#a6a6a6;" title="a6a6a6"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#78ed4b]','[/color]', {{ area }})" style="background:#78ed4b;" title="78ed4b"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#c1ed4b]','[/color]', {{ area }})" style="background:#c1ed4b;" title="c1ed4b"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#fef45f]','[/color]', {{ area }})" style="background:#fef45f;" title="fef45f"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#ffe773]','[/color]', {{ area }})" style="background:#ffe773;" title="ffe773"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#ffb83f]','[/color]', {{ area }})" style="background:#ffb83f;" title="ffb83f"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#fa9f3c]','[/color]', {{ area }})" style="background:#fa9f3c;" title="fa9f3c"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#f26c3f]','[/color]', {{ area }})" style="background:#f26c3f;" title="f26c3f"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#e64b4c]','[/color]', {{ area }})" style="background:#e64b4c;" title="e64b4c"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#d33288]','[/color]', {{ area }})" style="background:#d33288;" title="d33288"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#8c29fe]','[/color]', {{ area }})" style="background:#8c29fe;" title="8c29fe"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#3222f5]','[/color]', {{ area }})" style="background:#3222f5;" title="3222f5"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#5597ff]','[/color]', {{ area }})" style="background:#5597ff;" title="5597ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#67d7ff]','[/color]', {{ area }})" style="background:#67d7ff;" title="67d7ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#cccccc]','[/color]', {{ area }})" style="background:#cccccc;" title="cccccc"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#98f07a]','[/color]', {{ area }})" style="background:#98f07a;" title="98f07a"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#cdf07a]','[/color]', {{ area }})" style="background:#cdf07a;" title="cdf07a"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#fef888]','[/color]', {{ area }})" style="background:#fef888;" title="fef888"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#ffee97]','[/color]', {{ area }})" style="background:#ffee97;" title="ffee97"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#ffca70]','[/color]', {{ area }})" style="background:#ffca70;" title="ffca70"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#fab770]','[/color]', {{ area }})" style="background:#fab770;" title="fab770"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#f39174]','[/color]', {{ area }})" style="background:#f39174;" title="f39174"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#eb7d7f]','[/color]', {{ area }})" style="background:#eb7d7f;" title="eb7d7f"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#da67a6]','[/color]', {{ area }})" style="background:#da67a6;" title="da67a6"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#a551ff]','[/color]', {{ area }})" style="background:#a551ff;" title="a551ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#6049ff]','[/color]', {{ area }})" style="background:#6049ff;" title="6049ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#81b2ff]','[/color]', {{ area }})" style="background:#81b2ff;" title="81b2ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#84e3ff]','[/color]', {{ area }})" style="background:#84e3ff;" title="84e3ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#e8e8e8]','[/color]', {{ area }})" style="background:#e8e8e8;" title="e8e8e8"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#bcf4a8]','[/color]', {{ area }})" style="background:#bcf4a8;" title="bcf4a8"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#def4a8]','[/color]', {{ area }})" style="background:#def4a8;" title="def4a8"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#fef9b0]','[/color]', {{ area }})" style="background:#fef9b0;" title="fef9b0"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#fff3ba]','[/color]', {{ area }})" style="background:#fff3ba;" title="fff3ba"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#ffdba1]','[/color]', {{ area }})" style="background:#ffdba1;" title="ffdba1"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#fbcea2]','[/color]', {{ area }})" style="background:#fbcea2;" title="fbcea2"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#f7b8a5]','[/color]', {{ area }})" style="background:#f7b8a5;" title="f7b8a5"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#f0aaab]','[/color]', {{ area }})" style="background:#f0aaab;" title="f0aaab"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#e59cc5]','[/color]', {{ area }})" style="background:#e59cc5;" title="e59cc5"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#c18cff]','[/color]', {{ area }})" style="background:#c18cff;" title="c18cff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#9586ff]','[/color]', {{ area }})" style="background:#9586ff;" title="9586ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#adccff]','[/color]', {{ area }})" style="background:#adccff;" title="adccff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#acecff]','[/color]', {{ area }})" style="background:#acecff;" title="acecff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#ffffff]','[/color]', {{ area }})" style="background:#ffffff;" title="ffffff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#d8f3ce]','[/color]', {{ area }})" style="background:#d8f3ce;" title="d8f3ce"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#e9f3ce]','[/color]', {{ area }})" style="background:#e9f3ce;" title="e9f3ce"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#fdfbd8]','[/color]', {{ area }})" style="background:#fdfbd8;" title="fdfbd8"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#fff9dc]','[/color]', {{ area }})" style="background:#fff9dc;" title="fff9dc"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#ffecd0]','[/color]', {{ area }})" style="background:#ffecd0;" title="ffecd0"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#fde8d2]','[/color]', {{ area }})" style="background:#fde8d2;" title="fde8d2"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#fadbd3]','[/color]', {{ area }})" style="background:#fadbd3;" title="fadbd3"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#f6d5d7]','[/color]', {{ area }})" style="background:#f6d5d7;" title="f6d5d7"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#f0cfe2]','[/color]', {{ area }})" style="background:#f0cfe2;" title="f0cfe2"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#e0c5ff]','[/color]', {{ area }})" style="background:#e0c5ff;" title="e0c5ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#cbc5ff]','[/color]', {{ area }})" style="background:#cbc5ff;" title="cbc5ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#d5e6ff]','[/color]', {{ area }})" style="background:#d5e6ff;" title="d5e6ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertext('[color=#d4f5ff]','[/color]', {{ area }})" style="background:#d4f5ff;" title="d4f5ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
		</div>
		</ul></li>
		<li class="dropdown-submenu">
          <a href="#" class="dropdown-item" tabindex="-1"><i class="fa fa-paint-brush" aria-hidden="true"></i>Вставить цвет фона текста</a>
		<ul class="dropdown-menu" style="left: 100%;">
			<div class="bb_color" >
			<a onclick="insertfortext('bgcolor','#000000', {{ area }})" style="background:#000000;" title="000000"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#1b4a08', {{ area }})" style="background:#1b4a08;" title="1b4a08"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#37470b', {{ area }})" style="background:#37470b;" title="37470b"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#5d570c', {{ area }})" style="background:#5d570c;" title="5d570c"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#7a6301', {{ area }})" style="background:#7a6301;" title="7a6301"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#5d3b00', {{ area }})" style="background:#5d3b00;" title="5d3b00"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#562f06', {{ area }})" style="background:#562f06;" title="562f06"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#551600', {{ area }})" style="background:#551600;" title="551600"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#500700', {{ area }})" style="background:#500700;" title="500700"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#390b24', {{ area }})" style="background:#390b24;" title="390b24"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#250b43', {{ area }})" style="background:#250b43;" title="250b43"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#0c0941', {{ area }})" style="background:#0c0941;" title="0c0941"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#0e295b', {{ area }})" style="background:#0e295b;" title="0e295b"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#1c3f4d', {{ area }})" style="background:#1c3f4d;" title="1c3f4d"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#212121', {{ area }})" style="background:#212121;" title="212121"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#2b6516', {{ area }})" style="background:#2b6516;" title="2b6516"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#4f6516', {{ area }})" style="background:#4f6516;" title="4f6516"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#807b14', {{ area }})" style="background:#807b14;" title="807b14"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#a68a00', {{ area }})" style="background:#a68a00;" title="a68a00"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#825200', {{ area }})" style="background:#825200;" title="825200"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#764008', {{ area }})" style="background:#764008;" title="764008"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#731e00', {{ area }})" style="background:#731e00;" title="731e00"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#6f0b00', {{ area }})" style="background:#6f0b00;" title="6f0b00"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#4f1333', {{ area }})" style="background:#4f1333;" title="4f1333"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#350f5e', {{ area }})" style="background:#350f5e;" title="350f5e"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#100c57', {{ area }})" style="background:#100c57;" title="100c57"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#143a80', {{ area }})" style="background:#143a80;" title="143a80"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#265769', {{ area }})" style="background:#265769;" title="265769"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#404040', {{ area }})" style="background:#404040;" title="404040"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#3e8b20', {{ area }})" style="background:#3e8b20;" title="3e8b20"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#6e8b20', {{ area }})" style="background:#6e8b20;" title="6e8b20"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#b2a81b', {{ area }})" style="background:#b2a81b;" title="b2a81b"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#e8c202', {{ area }})" style="background:#e8c202;" title="e8c202"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#b57300', {{ area }})" style="background:#b57300;" title="b57300"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#a3590b', {{ area }})" style="background:#a3590b;" title="a3590b"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#a22a00', {{ area }})" style="background:#a22a00;" title="a22a00"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#9b0f00', {{ area }})" style="background:#9b0f00;" title="9b0f00"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#6e1a47', {{ area }})" style="background:#6e1a47;" title="6e1a47"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#481581', {{ area }})" style="background:#481581;" title="481581"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#19117c', {{ area }})" style="background:#19117c;" title="19117c"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#1b4fb0', {{ area }})" style="background:#1b4fb0;" title="1b4fb0"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#357993', {{ area }})" style="background:#357993;" title="357993"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#5e5e5e', {{ area }})" style="background:#5e5e5e;" title="5e5e5e"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#4cb228', {{ area }})" style="background:#4cb228;" title="4cb228"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#8bb228', {{ area }})" style="background:#8bb228;" title="8bb228"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#e2d724', {{ area }})" style="background:#e2d724;" title="e2d724"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#ffdd28', {{ area }})" style="background:#ffdd28;" title="ffdd28"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#e69100', {{ area }})" style="background:#e69100;" title="e69100"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#cf6e0e', {{ area }})" style="background:#cf6e0e;" title="cf6e0e"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#cd3600', {{ area }})" style="background:#cd3600;" title="cd3600"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#c21400', {{ area }})" style="background:#c21400;" title="c21400"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#8c2159', {{ area }})" style="background:#8c2159;" title="8c2159"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#5b1ba4', {{ area }})" style="background:#5b1ba4;" title="5b1ba4"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#1e1599', {{ area }})" style="background:#1e1599;" title="1e1599"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#2364de', {{ area }})" style="background:#2364de;" title="2364de"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#439ab9', {{ area }})" style="background:#439ab9;" title="439ab9"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#808080', {{ area }})" style="background:#808080;" title="808080"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#59d62f', {{ area }})" style="background:#59d62f;" title="59d62f"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#a4d62f', {{ area }})" style="background:#a4d62f;" title="a4d62f"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#fef538', {{ area }})" style="background:#fef538;" title="fef538"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#ffe854', {{ area }})" style="background:#ffe854;" title="ffe854"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#ffb31c', {{ area }})" style="background:#ffb31c;" title="ffb31c"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#fb9314', {{ area }})" style="background:#fb9314;" title="fb9314"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#f44a06', {{ area }})" style="background:#f44a06;" title="f44a06"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#e62414', {{ area }})" style="background:#e62414;" title="e62414"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#a82769', {{ area }})" style="background:#a82769;" title="a82769"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#7421c4', {{ area }})" style="background:#7421c4;" title="7421c4"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#2d1abb', {{ area }})" style="background:#2d1abb;" title="2d1abb"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#3276ff', {{ area }})" style="background:#3276ff;" title="3276ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#4eb2df', {{ area }})" style="background:#4eb2df;" title="4eb2df"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#a6a6a6', {{ area }})" style="background:#a6a6a6;" title="a6a6a6"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#78ed4b', {{ area }})" style="background:#78ed4b;" title="78ed4b"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#c1ed4b', {{ area }})" style="background:#c1ed4b;" title="c1ed4b"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#fef45f', {{ area }})" style="background:#fef45f;" title="fef45f"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#ffe773', {{ area }})" style="background:#ffe773;" title="ffe773"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#ffb83f', {{ area }})" style="background:#ffb83f;" title="ffb83f"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#fa9f3c', {{ area }})" style="background:#fa9f3c;" title="fa9f3c"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#f26c3f', {{ area }})" style="background:#f26c3f;" title="f26c3f"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#e64b4c', {{ area }})" style="background:#e64b4c;" title="e64b4c"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#d33288', {{ area }})" style="background:#d33288;" title="d33288"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#8c29fe', {{ area }})" style="background:#8c29fe;" title="8c29fe"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#3222f5', {{ area }})" style="background:#3222f5;" title="3222f5"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#5597ff', {{ area }})" style="background:#5597ff;" title="5597ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#67d7ff', {{ area }})" style="background:#67d7ff;" title="67d7ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#cccccc', {{ area }})" style="background:#cccccc;" title="cccccc"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#98f07a', {{ area }})" style="background:#98f07a;" title="98f07a"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#cdf07a', {{ area }})" style="background:#cdf07a;" title="cdf07a"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#fef888', {{ area }})" style="background:#fef888;" title="fef888"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#ffee97', {{ area }})" style="background:#ffee97;" title="ffee97"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#ffca70', {{ area }})" style="background:#ffca70;" title="ffca70"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#fab770', {{ area }})" style="background:#fab770;" title="fab770"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#f39174', {{ area }})" style="background:#f39174;" title="f39174"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#eb7d7f', {{ area }})" style="background:#eb7d7f;" title="eb7d7f"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#da67a6', {{ area }})" style="background:#da67a6;" title="da67a6"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#a551ff', {{ area }})" style="background:#a551ff;" title="a551ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#6049ff', {{ area }})" style="background:#6049ff;" title="6049ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#81b2ff', {{ area }})" style="background:#81b2ff;" title="81b2ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#84e3ff', {{ area }})" style="background:#84e3ff;" title="84e3ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#e8e8e8', {{ area }})" style="background:#e8e8e8;" title="e8e8e8"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#bcf4a8', {{ area }})" style="background:#bcf4a8;" title="bcf4a8"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#def4a8', {{ area }})" style="background:#def4a8;" title="def4a8"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#fef9b0', {{ area }})" style="background:#fef9b0;" title="fef9b0"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#fff3ba', {{ area }})" style="background:#fff3ba;" title="fff3ba"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#ffdba1', {{ area }})" style="background:#ffdba1;" title="ffdba1"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#fbcea2', {{ area }})" style="background:#fbcea2;" title="fbcea2"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#f7b8a5', {{ area }})" style="background:#f7b8a5;" title="f7b8a5"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#f0aaab', {{ area }})" style="background:#f0aaab;" title="f0aaab"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#e59cc5', {{ area }})" style="background:#e59cc5;" title="e59cc5"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#c18cff', {{ area }})" style="background:#c18cff;" title="c18cff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#9586ff', {{ area }})" style="background:#9586ff;" title="9586ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#adccff', {{ area }})" style="background:#adccff;" title="adccff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#acecff', {{ area }})" style="background:#acecff;" title="acecff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#ffffff', {{ area }})" style="background:#ffffff;" title="ffffff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#d8f3ce', {{ area }})" style="background:#d8f3ce;" title="d8f3ce"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#e9f3ce', {{ area }})" style="background:#e9f3ce;" title="e9f3ce"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#fdfbd8', {{ area }})" style="background:#fdfbd8;" title="fdfbd8"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#fff9dc', {{ area }})" style="background:#fff9dc;" title="fff9dc"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#ffecd0', {{ area }})" style="background:#ffecd0;" title="ffecd0"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#fde8d2', {{ area }})" style="background:#fde8d2;" title="fde8d2"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#fadbd3', {{ area }})" style="background:#fadbd3;" title="fadbd3"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#f6d5d7',{{ area }})" style="background:#f6d5d7;" title="f6d5d7"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#f0cfe2',{{ area }})" style="background:#f0cfe2;" title="f0cfe2"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#e0c5ff', {{ area }})" style="background:#e0c5ff;" title="e0c5ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#cbc5ff', {{ area }})" style="background:#cbc5ff;" title="cbc5ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#d5e6ff',{{ area }})" style="background:#d5e6ff;" title="d5e6ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('bgcolor','#d4f5ff',{{ area }})" style="background:#d4f5ff;" title="d4f5ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
		</div>
		</ul></li>
		<li class="dropdown-submenu">
		<a href="#" class="dropdown-item" tabindex="-1"><i class="fa fa-paint-brush" aria-hidden="true"></i>Вставить цвет для блока</a>
		<ul class="dropdown-menu" style="left: 100%;">
			<div class="bb_color" >
			<a onclick="insertfortext('ustyle','#000000', {{ area }})" style="background:#000000;" title="000000"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#1b4a08', {{ area }})" style="background:#1b4a08;" title="1b4a08"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#37470b', {{ area }})" style="background:#37470b;" title="37470b"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#5d570c', {{ area }})" style="background:#5d570c;" title="5d570c"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#7a6301', {{ area }})" style="background:#7a6301;" title="7a6301"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#5d3b00', {{ area }})" style="background:#5d3b00;" title="5d3b00"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#562f06', {{ area }})" style="background:#562f06;" title="562f06"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#551600', {{ area }})" style="background:#551600;" title="551600"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#500700', {{ area }})" style="background:#500700;" title="500700"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#390b24', {{ area }})" style="background:#390b24;" title="390b24"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#250b43', {{ area }})" style="background:#250b43;" title="250b43"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#0c0941', {{ area }})" style="background:#0c0941;" title="0c0941"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#0e295b', {{ area }})" style="background:#0e295b;" title="0e295b"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#1c3f4d', {{ area }})" style="background:#1c3f4d;" title="1c3f4d"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#212121', {{ area }})" style="background:#212121;" title="212121"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#2b6516', {{ area }})" style="background:#2b6516;" title="2b6516"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#4f6516', {{ area }})" style="background:#4f6516;" title="4f6516"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#807b14', {{ area }})" style="background:#807b14;" title="807b14"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#a68a00', {{ area }})" style="background:#a68a00;" title="a68a00"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#825200', {{ area }})" style="background:#825200;" title="825200"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#764008', {{ area }})" style="background:#764008;" title="764008"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#731e00', {{ area }})" style="background:#731e00;" title="731e00"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#6f0b00', {{ area }})" style="background:#6f0b00;" title="6f0b00"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#4f1333', {{ area }})" style="background:#4f1333;" title="4f1333"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#350f5e', {{ area }})" style="background:#350f5e;" title="350f5e"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#100c57', {{ area }})" style="background:#100c57;" title="100c57"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#143a80', {{ area }})" style="background:#143a80;" title="143a80"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#265769', {{ area }})" style="background:#265769;" title="265769"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#404040', {{ area }})" style="background:#404040;" title="404040"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#3e8b20', {{ area }})" style="background:#3e8b20;" title="3e8b20"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#6e8b20', {{ area }})" style="background:#6e8b20;" title="6e8b20"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#b2a81b', {{ area }})" style="background:#b2a81b;" title="b2a81b"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#e8c202', {{ area }})" style="background:#e8c202;" title="e8c202"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#b57300', {{ area }})" style="background:#b57300;" title="b57300"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#a3590b', {{ area }})" style="background:#a3590b;" title="a3590b"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#a22a00', {{ area }})" style="background:#a22a00;" title="a22a00"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#9b0f00', {{ area }})" style="background:#9b0f00;" title="9b0f00"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#6e1a47', {{ area }})" style="background:#6e1a47;" title="6e1a47"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#481581', {{ area }})" style="background:#481581;" title="481581"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#19117c', {{ area }})" style="background:#19117c;" title="19117c"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#1b4fb0', {{ area }})" style="background:#1b4fb0;" title="1b4fb0"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#357993', {{ area }})" style="background:#357993;" title="357993"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#5e5e5e', {{ area }})" style="background:#5e5e5e;" title="5e5e5e"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#4cb228', {{ area }})" style="background:#4cb228;" title="4cb228"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#8bb228', {{ area }})" style="background:#8bb228;" title="8bb228"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#e2d724', {{ area }})" style="background:#e2d724;" title="e2d724"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#ffdd28', {{ area }})" style="background:#ffdd28;" title="ffdd28"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#e69100', {{ area }})" style="background:#e69100;" title="e69100"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#cf6e0e', {{ area }})" style="background:#cf6e0e;" title="cf6e0e"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#cd3600', {{ area }})" style="background:#cd3600;" title="cd3600"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#c21400', {{ area }})" style="background:#c21400;" title="c21400"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#8c2159', {{ area }})" style="background:#8c2159;" title="8c2159"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#5b1ba4', {{ area }})" style="background:#5b1ba4;" title="5b1ba4"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#1e1599', {{ area }})" style="background:#1e1599;" title="1e1599"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#2364de', {{ area }})" style="background:#2364de;" title="2364de"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#439ab9', {{ area }})" style="background:#439ab9;" title="439ab9"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#808080', {{ area }})" style="background:#808080;" title="808080"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#59d62f', {{ area }})" style="background:#59d62f;" title="59d62f"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#a4d62f', {{ area }})" style="background:#a4d62f;" title="a4d62f"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#fef538', {{ area }})" style="background:#fef538;" title="fef538"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#ffe854', {{ area }})" style="background:#ffe854;" title="ffe854"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#ffb31c', {{ area }})" style="background:#ffb31c;" title="ffb31c"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#fb9314', {{ area }})" style="background:#fb9314;" title="fb9314"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#f44a06', {{ area }})" style="background:#f44a06;" title="f44a06"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#e62414', {{ area }})" style="background:#e62414;" title="e62414"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#a82769', {{ area }})" style="background:#a82769;" title="a82769"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#7421c4', {{ area }})" style="background:#7421c4;" title="7421c4"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#2d1abb', {{ area }})" style="background:#2d1abb;" title="2d1abb"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#3276ff', {{ area }})" style="background:#3276ff;" title="3276ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#4eb2df', {{ area }})" style="background:#4eb2df;" title="4eb2df"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#a6a6a6', {{ area }})" style="background:#a6a6a6;" title="a6a6a6"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#78ed4b', {{ area }})" style="background:#78ed4b;" title="78ed4b"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#c1ed4b', {{ area }})" style="background:#c1ed4b;" title="c1ed4b"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#fef45f', {{ area }})" style="background:#fef45f;" title="fef45f"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#ffe773', {{ area }})" style="background:#ffe773;" title="ffe773"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#ffb83f', {{ area }})" style="background:#ffb83f;" title="ffb83f"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#fa9f3c', {{ area }})" style="background:#fa9f3c;" title="fa9f3c"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#f26c3f', {{ area }})" style="background:#f26c3f;" title="f26c3f"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#e64b4c', {{ area }})" style="background:#e64b4c;" title="e64b4c"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#d33288', {{ area }})" style="background:#d33288;" title="d33288"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#8c29fe', {{ area }})" style="background:#8c29fe;" title="8c29fe"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#3222f5', {{ area }})" style="background:#3222f5;" title="3222f5"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#5597ff', {{ area }})" style="background:#5597ff;" title="5597ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#67d7ff', {{ area }})" style="background:#67d7ff;" title="67d7ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#cccccc', {{ area }})" style="background:#cccccc;" title="cccccc"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#98f07a', {{ area }})" style="background:#98f07a;" title="98f07a"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#cdf07a', {{ area }})" style="background:#cdf07a;" title="cdf07a"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#fef888', {{ area }})" style="background:#fef888;" title="fef888"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#ffee97', {{ area }})" style="background:#ffee97;" title="ffee97"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#ffca70', {{ area }})" style="background:#ffca70;" title="ffca70"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#fab770', {{ area }})" style="background:#fab770;" title="fab770"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#f39174', {{ area }})" style="background:#f39174;" title="f39174"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#eb7d7f', {{ area }})" style="background:#eb7d7f;" title="eb7d7f"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#da67a6', {{ area }})" style="background:#da67a6;" title="da67a6"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#a551ff', {{ area }})" style="background:#a551ff;" title="a551ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#6049ff', {{ area }})" style="background:#6049ff;" title="6049ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#81b2ff', {{ area }})" style="background:#81b2ff;" title="81b2ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#84e3ff', {{ area }})" style="background:#84e3ff;" title="84e3ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#e8e8e8', {{ area }})" style="background:#e8e8e8;" title="e8e8e8"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#bcf4a8', {{ area }})" style="background:#bcf4a8;" title="bcf4a8"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#def4a8', {{ area }})" style="background:#def4a8;" title="def4a8"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#fef9b0', {{ area }})" style="background:#fef9b0;" title="fef9b0"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#fff3ba', {{ area }})" style="background:#fff3ba;" title="fff3ba"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#ffdba1', {{ area }})" style="background:#ffdba1;" title="ffdba1"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#fbcea2', {{ area }})" style="background:#fbcea2;" title="fbcea2"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#f7b8a5', {{ area }})" style="background:#f7b8a5;" title="f7b8a5"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#f0aaab', {{ area }})" style="background:#f0aaab;" title="f0aaab"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#e59cc5', {{ area }})" style="background:#e59cc5;" title="e59cc5"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#c18cff', {{ area }})" style="background:#c18cff;" title="c18cff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#9586ff', {{ area }})" style="background:#9586ff;" title="9586ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#adccff', {{ area }})" style="background:#adccff;" title="adccff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#acecff', {{ area }})" style="background:#acecff;" title="acecff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#ffffff', {{ area }})" style="background:#ffffff;" title="ffffff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#d8f3ce', {{ area }})" style="background:#d8f3ce;" title="d8f3ce"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#e9f3ce', {{ area }})" style="background:#e9f3ce;" title="e9f3ce"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#fdfbd8', {{ area }})" style="background:#fdfbd8;" title="fdfbd8"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#fff9dc', {{ area }})" style="background:#fff9dc;" title="fff9dc"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#ffecd0', {{ area }})" style="background:#ffecd0;" title="ffecd0"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#fde8d2', {{ area }})" style="background:#fde8d2;" title="fde8d2"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#fadbd3', {{ area }})" style="background:#fadbd3;" title="fadbd3"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#f6d5d7',{{ area }})" style="background:#f6d5d7;" title="f6d5d7"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#f0cfe2',{{ area }})" style="background:#f0cfe2;" title="f0cfe2"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#e0c5ff', {{ area }})" style="background:#e0c5ff;" title="e0c5ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#cbc5ff', {{ area }})" style="background:#cbc5ff;" title="cbc5ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#d5e6ff',{{ area }})" style="background:#d5e6ff;" title="d5e6ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
			<a onclick="insertfortext('ustyle','#d4f5ff',{{ area }})" style="background:#d4f5ff;" title="d4f5ff"><i class="fa fa-paint-brush" aria-hidden="true"></i></a>
		</div>
		</ul></li>
	    
</ul>
	</div>
	
	<div class="btn-group btn-group-sm mr-2">
		<button id="tags-block" type="button" class="btn btn-outline-dark dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			<i class="fa fa-quote-left"></i>
		</button>
		<ul class="dropdown-menu" aria-labelledby="tags-block">
			<li><a href="#" class="dropdown-item" onclick="insertext('[ul]\n[li][/li]\n[li][/li]\n[li][/li]\n[/ul]','', {{ area }})"><i class="fa fa-list-ul"></i> {{ lang['tags.bulllist'] }}</a></li>
			<li><a href="#" class="dropdown-item" onclick="insertext('[ol]\n[li][/li]\n[li][/li]\n[li][/li]\n[/ol]','', {{ area }})"><i class="fa fa-list-ol"></i> {{ lang['tags.numlist'] }}</a></li>
			<div class="dropdown-divider"></div>
			<li><a href="#" class="dropdown-item" onclick="insertext('[code]','[/code]', {{ area }})"><i class="fa fa-code"></i> {{ lang['tags.code'] }}</a></li>
			<li><a href="#" class="dropdown-item" onclick="insertext('[quote]','[/quote]', {{ area }})"><i class="fa fa-quote-left"></i> {{ lang['tags.quote'] }}</a></li>
			<li><a href="#" class="dropdown-item" onclick="insertext('[spoiler]','[/spoiler]', {{ area }})"><i class="fa fa-list-alt"></i> {{ lang['tags.spoiler'] }}</a></li>
			<li><a href="#" class="dropdown-item" onclick="insertext('[acronym=]','[/acronym]', {{ area }})"><i class="fa fa-tags"></i> {{ lang['tags.acronym'] }}</a></li>
		</ul>
	</div>

	<div class="btn-group btn-group-sm mr-2">
		<button type="button" class="btn btn-outline-dark" data-placement="top" data-popup="tooltip" data-original-title="Вставить ссылку" data-toggle="modal" data-target="#modal-url" title="Вставить ссылку">
			<i class="fa fa-link"></i>
		</button>
		<button type="button" class="btn btn-outline-dark" data-placement="top" data-popup="tooltip" data-original-title="Вставить E-Mail" data-toggle="modal" data-target="#modal-email" title="Вставить E-Mail">	
			<i class="fa fa-envelope-o"></i>
		</button>
		<button type="button" class="btn btn-outline-dark" data-placement="top" data-popup="tooltip" data-original-title="Вставить изображение" data-toggle="modal" data-target="#modal-image" title="Вставить изображение">		
			<i class="fa fa-file-image-o"></i>
		</button>
	</div>

<div id="modal-url" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">

			<div class="modal-header">
				<h5 class="modal-title">{l_tags.link}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			</div>
			<div id="tags-link" class="tab-pane active">
				<div class="form-group">
					<label class="col-sm-12 control-label">Адрес ссылки:</label>
					<div class="col-sm-12">
						<input type="url" id="modal-url-1" placeholder="http://" class="form-control" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-12 control-label">Введите текст ссылки:</label>
					<div class="col-sm-12">
						<input type="text" id="modal-url-2" placeholder="текст" class="form-control" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-12 control-label">Введите подсказку для ссылки:</label>
					<div class="col-sm-12">
						<input type="text" id="modal-url-3" placeholder="текст" class="form-control" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label"></label>
						<div class="col-sm-9">
							<label><input type="checkbox" id="modal-url-4" /> Открыть в новом окне</label>
						</div>
					</div>
				</div>

			<div class="modal-footer">
				<button type="cancel" class="btn btn-default" data-dismiss="modal">Отмена</button>
				<button type="button" id="modal-url-submit" class="btn btn-success" data-dismiss="modal">Применить</button>
			</div>
		</div>
	</div>
</div>
	
<div id="modal-email" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">

			<div class="modal-header">
				<h5 class="modal-title">E-Mail</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			</div>
			<div id="tags-email" class="tab-pane active">
				<div class="form-group">
					<label class="col-sm-12 control-label">Электронная почта</label>
					<div class="col-sm-12">
						<input type="email" id="modal-email-1" placeholder="e-mail" class="form-control" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-12 control-label">Введите текст ссылки:</label>
						<div class="col-sm-12">
							<input type="text" id="modal-email-2" placeholder="текст" class="form-control" />
						</div>
					</div>
				</div>

			<div class="modal-footer">
				<button type="cancel" class="btn btn-default" data-dismiss="modal">Отмена</button>
				<button type="button" id="modal-email-submit" class="btn btn-success" data-dismiss="modal">Применить</button>
			</div>
		</div>
	</div>
</div>

<div id="modal-image" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">

			<div class="modal-header">
				<h5 class="modal-title">Изображение</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			</div>
			<div id="tags-img-url" class="tab-pane active">
				<div class="form-group">
					<label class="col-sm-12">Ссылка на изображение</label>
						<div class="col-sm-12">
							<input type="url" id="modal-img-url-1" placeholder="http://" class="form-control" />
						</div>
					</div>
				<div class="form-group">
					<label class="col-sm-12 control-label">Введите описание изображения</label>
						<div class="col-sm-12">
							<input type="text" id="modal-img-url-2" placeholder="описание" class="form-control" />
						</div>
					</div>
				<div class="form-group">
						<div class="col-sm-8">
							<div class="input-group">
								<label style="margin: 8px;">Размер:</label>
								<input type="text" id="modal-img-url-3" placeholder="width" class="form-control">
								<span class="input-group-addon"> x </span>
								<input type="text" id="modal-img-url-4" placeholder="height" class="form-control">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-8">
						<div class="input-group">
							<label style="margin: 8px;">Выравнивание:</label>
							<select id="modal-img-url-5" class="form-control">
								<option value="0" selected>{l_noa}</option>
								<option value="left">{l_tags.left}</option>
								<option value="center">{l_tags.center}</option>
								<option value="right">{l_tags.right}</option>
							</select>
						</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-8">
							<div class="input-group">
							<label style="margin: 8px;">Класс:</label>
							<input type="text" id="modal-img-url-6" placeholder="thumbnail" class="form-control" />
							<span class="input-group-addon"> ⚠ </span>
							</div>
						</div>
					</div>
				</div>

			<div class="modal-footer">
				<button type="cancel" class="btn btn-default" data-dismiss="modal">Отмена</button>
				<button type="button" id="modal-image-submit" class="btn btn-success" data-dismiss="modal">Применить</button>
			</div>
		</div>
	</div>
</div>

</div>
<script>
$(document).ready(function(){
	$('#modal-url-submit').click(function() {
		var activeTab = $(this).parents('#modal-url').find('.tab-pane.active').prop('id');
		
		if ( activeTab == 'tags-link' ){
			var titleLink = $('#modal-url-3').val() ? ' title="' + $('#modal-url-3').val() + '"' : '';
			var targetLink = $('#modal-url-4').prop('checked') ? ' target="_blank"' : '';
			insertext('[url=' + $('#modal-url-1').val() + ' ' + titleLink + targetLink + ']' + $('#modal-url-2').val(),'[/url]', {{ area }})
		}
		clearSearch();
	});
});

$(document).ready(function(){
	$('#modal-email-submit').click(function() {
		var activeTab = $(this).parents('#modal-email').find('.tab-pane.active').prop('id');
		
		if ( activeTab == 'tags-email' ){
			insertext('[email=' + $('#modal-email-1').val() + ']' + $('#modal-email-2').val(),'[/email]', {{ area }})
		}
		clearSearch();
	});
});
$(document).ready(function(){
	$('#modal-image-submit').click(function() {
		var activeTab = $(this).parents('#modal-image').find('.tab-pane.active').prop('id');
		
		if ( activeTab == 'tags-img-url' ){
			var widthImg = $('#modal-img-url-3').val() ? ' width="' + $('#modal-img-url-3').val() + '"' : '';
			var heightImg = $('#modal-img-url-4').val() ? ' height="' + $('#modal-img-url-4').val() + '"' : '';
			var alignImg = $('#modal-img-url-5').val() !== '0' ? ' align="' + $('#modal-img-url-5').val() + '"' : '';
			var classImg = $('#modal-img-url-6').val() ? ' class="' + $('#modal-img-url-6').val() + '"' : '';
			insertext('[img=' + $('#modal-img-url-1').val() + widthImg + heightImg + alignImg + classImg + ']' + $('#modal-img-url-2').val(),'[/img]', {{ area }})
		}
		clearSearch();
	});
});
function clearSearch() {
	var examStateArr = [
		'modal-img-url-1', 'modal-img-url-2', 'modal-img-url-3', 'modal-img-url-4', 'modal-img-url-5', 'modal-img-url-6',
		'modal-email-1', 'modal-email-2',
		'modal-url-1', 'modal-url-2', 'modal-url-3', 'modal-url-4'
	];
	for (var i = 0; i < examStateArr.length; i++) {
		document.getElementById(examStateArr[i]).value = '';
	}
}
</script>