<link href="{{ skins_url }}/public/css/code-editor.css" rel="stylesheet">
<script src="{{ skins_url }}/public/js/code-editor.js"></script>

<div class="panel-body" style="padding: 0;">

<form id="templates" action="" method="post">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	<ul class="navbar-nav">
	<li class="nav-item">
	<a href="#" class="nav-link" data-toggle="modal" data-target="#hotkeys">
                    <i class="fa fa-question-circle"></i></a>
	</li>				
		<li class="nav-item">
			<a href="#" class="nav-link dropdown-toggle" role="button" data-toggle="dropdown">
				{{ lang.templates['tplsite'] }}
			</a>
			<div class="dropdown-menu">
				{% for st in siteTemplates %}
				<a href="#" class="dropdown-item" data-teplate-mode="template" data-teplate-name="{{ st.name }}">{{ st.name }} ({{ st.title }})</a>
				{% endfor %}
			</div>
		</li>
		<li class="nav-item">
			<a href="#" class="nav-link" data-teplate-mode="plugin">{{ lang.templates['tplmodules'] }}</a>
		</li>
		<li class="nav-item">
			<a href="#" class="nav-link nav-right" title="На весь экран" onclick="$('#templates').toggleClass('content-full');return false;"><i class="fa fa-arrows-alt"></i></a>
		</li>
	</ul>

</nav>
	<input type="hidden" name="token" value="{{ token }}" />

	<div class="templates-explorer">
		<div class="row mb-3">
			<div class="col-sm-5 col-md-3 pr-lg-0">
				<div class="p-2">
					{{ lang.templates['tpl.edit'] }}
					<br/>
					[<b id="templateNameArea">default</b>]
				</div>
			</div>
			<div class="col-sm-7 col-md-9 pl-lg-0">

				<div id="fileEditorInfo" class="p-2">
					&nbsp;
				</div>
			</div>
		</div>

		<div class="row mb-3">
			<div class="col-lg-3 pr-lg-0">
				<div id="fileTreeSelector" class="" style="background-color: #ABCDEF; height: 578px; overflow: auto;">
					{{ lang.templates['test_content'] }}
				</div>
				<!-- <div style="width: 100%; background-color: #E0E0E0; padding: 3px; ">
					<input style="width: 150px;" type="button" class="navbutton" value="Create template.."/>
				</div> -->
			</div>

			<div id="fileEditorContainer" class="col-lg-9 pl-lg-0">
				<textarea id="fileEditorSelector" wrap="off" style="width: 100%; height: 100%; float: left; background-color: #EEEEEE; white-space: nowrap; font-family: monospace; font-size: 10pt;">*** {{ lang.templates['edit'] }} ***</textarea>
				<div id="imageViewContainer" style="display: none; height: 100%; width: 100%; vertical-align: middle;"></div>
			</div>
		</div>

		<div class="row">
			<div class="col-sm-5 col-md-3 pr-lg-0">

			</div>
			<div id="fileEditorButtonLine" class="col-sm-7 col-md-9 pl-lg-0">
				<button id="submitTemplateEdit" type="button" class="btn btn-outline-success">{{ lang.templates['save'] }}</button>
				<!-- <button type="button" class="btn btn-outline-danger">Delete file</button> -->
			</div>
		</div>
	</div>
</form>

<div id="hotkeys" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
                
            <div class="modal-header"> 
                <h4>{{ lang.templates['help'] }}</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <h4>{{ lang.templates['hot_codemir'] }}</h4>
                <div class="row">
                    <div class="col col-xs-6">
                        
                        <table class="table table-condensed">
                            <tr>
                                <td><kbd>Ctrl + S</kbd></td><td>{{ lang.templates['save'] }}</td>
                            </tr>
                            <tr>
                                <td><kbd>F11</kbd></td><td>{{ lang.templates['fullscreen'] }}</td>
                            </tr>
                            <tr>
                                <td><kbd>Ctrl + E</kbd></td><td>{{ lang.templates['abbreviation'] }} (<a href="http://docs.emmet.io/cheat-sheet/" target="_blank" title="Emmet cheat sheet" class="">emmet</a>)</td>
                            </tr>
                        </table>
                    </div>
                
                    <div class="col col-xs-6">
                        <table class="table table-condensed">
                            <tr>
                                <td><kbd>Ctrl + F</kbd></td><td>{{ lang.templates['searching'] }}</td>
                            </tr>
                            <tr>
                                <td><kbd>Ctrl + G</kbd></td><td>{{ lang.templates['find_next'] }}</td>
                            </tr>
                            <tr>
                                <td><kbd>Shift + Ctrl + F</kbd></td><td>{{ lang.templates['replace'] }}</td>
                            </tr>
                        </table>
                    </div>
                </div>
                <!--div class="well">
                    <h4>Twig &#123;&#123; variables &#125;&#125; for this template, if it is standard</h4>
                    <div class="row">
                        <div class="col col-xs-12"><code>&#123;&#123; lang['langcode'] &#125;&#125;</code> - language code</div>
                        <div class="col col-xs-12"><code>&#123;&#123; lang['langcode'] &#125;&#125;</code> - language code</div>
                    </div>
                </div-->
            </div>
            <div class="modal-footer">
                <button type="cancel" class="btn btn-default" data-dismiss="modal">{{ lang.templates['close'] }}</button>
            </div>
        </div>
    </div>
</div>

</div>