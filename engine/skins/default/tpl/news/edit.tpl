<!-- Оставляем эти скрипты и формы так как ими могут пользоваться плагины -->
<script type="text/javascript" src="{{ home }}/lib/ajax.js"></script>
<script type="text/javascript" src="{{ home }}/lib/libsuggest.js"></script>

<!-- Hidden SUGGEST div -->
<div id="suggestWindow" class="suggestWindow" style="width:80%">
	<table id="suggestBlock" cellspacing="0" cellpadding="0" width="100%"></table>
	<a href="#" align="right" id="suggestClose">{{ lang.editnews['close'] }}</a>
</div>

<form name="DATA_tmp_storage" action="" id="DATA_tmp_storage">
	<input type="hidden" name="area" value=""/>
</form>

{% if (flags['params.lost']) %}
<div class="alert alert-warning">
	<p>{{ lang.editnews['msgo_params'] }}</p>
	<hr>
	<p>{{ lang.editnews['msgo_params#lost'] }}</p>
	<ul>
		{% if flags['publish.lost'] %}<li>{{ lang.editnews['msgo_params#publish'] }}</li>{% endif %}
		{% if flags['html.lost'] %}<li>{{ lang.editnews['msgo_params#html'] }}</li>{% endif %}
		{% if flags['mainpage.lost'] %}<li>{{ lang.editnews['msgo_params#mainpage'] }}</li>{% endif %}
		{% if flags['pinned.lost'] %}<li>{{ lang.editnews['msgo_params#pinned'] }}</li>{% endif %}
		{% if flags['catpinned.lost'] %}<li>{{ lang.editnews['msgo_params#catpinned'] }}</li>{% endif %}
		{% if flags['favorite.lost'] %}<li>{{ lang.editnews['msgo_params#favorite'] }}</li>{% endif %}
		{% if flags['multicat.lost'] %}<li>{{ lang.editnews['msgo_params#multicat'] }}</li>{% endif %}
	</ul>
</div>
{% endif %}

<!-- Main content form -->
<form id="postForm" name="form" enctype="multipart/form-data" method="post" action="{{ php_self }}" target="_self">
	<input type="hidden" name="token" value="{{ token }}" />
	<input type="hidden" name="mod" value="news" />
	<input type="hidden" name="action" value="edit" />
	<input type="hidden" name="action" value="editdone" />
	<input type="hidden" name="subaction" value="submit" />
	<input type="hidden" name="id" value="{{ id }}" />

	<div class="row">
		<!-- Left edit column -->
		<div class="col-lg-8">


<div class="panel panel-default mb-4">

	<div class="panel-heading" style="padding: 0px;margin-bottom: 0;">
	<ul class="nav nav-tabs nav-fill" role="tablist">
		<li class="nav-item"><a href="#tabmain" class="nav-link active" data-toggle="tab"><span data-toggle="popover" data-placement="top" data-trigger="hover focus" data-content="{{ lang.editnews['bar.maincontent'] }}"><i class="fa fa-home"></i> {{ lang.editnews['bar.maincontent'] }}</span></a></li>
		<li class="nav-item"><a href="#tabmeta" class="nav-link" data-toggle="tab"><span data-toggle="popover" data-placement="top" data-trigger="hover focus" data-content="{{ lang.editnews['bar.meta'] }}"><i class="fa fa-tag"></i> {{ lang.editnews['bar.meta'] }}</span></a></li>
		<li class="nav-item"><a href="#tabadditional" class="nav-link" data-toggle="tab"><span data-toggle="popover" data-placement="top" data-trigger="hover focus" data-content="{{ lang.editnews['bar.additional'] }}"><i class="fa fa-th-list"></i> {{ lang.editnews['bar.additional'] }}</span></a></li>
		<li class="nav-item"><a href="#tabacces" class="nav-link" data-toggle="tab"><span data-toggle="popover" data-placement="top" data-trigger="hover focus" data-content="{{ lang.editnews['bar.acces'] }}"><i class="fa fa-lock"></i> {{ lang.editnews['bar.acces'] }}</span></a></li>
	</ul>
		<div class="panel-head-right">
			<a href="#" style="position: absolute;right: -8px;top: -6px;cursor: pointer;" class="btn2" title="{{ lang.editnews['fullscreen'] }}" onclick="$('#postForm').toggleClass('full-content');return false;"><i class="fa fa-expand fa-lg"></i></a>
		</div>
	</div>
	
    <div class="panel-tab-content tab-content">
	
		<div class="tab-pane active" id="tabmain">
			<!-- MAIN CONTENT -->
			<div id="maincontent" class="panel-body">

					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">{{ lang.editnews['title'] }}</label>
						<div class="col-lg-9">
							{% if (link) %}
								<div class="input-group">
									<input id="newsTitle" type="text" placeholder="{{ lang.editnews['pop.title#input'] }}..." name="title" tabindex="1" value="{{ title }}" class="form-control" />
									<div class="input-group-append">
										<span class="input-group-text"><a class="btn2" onclick="searchDouble();" title="{{ lang.editnews['search_double'] }}"><i class="fa fa-files-o"></i></a></span>
										<a class="btn btn-primary" data-toggle="popover" data-placement="top" data-trigger="focus" data-html="true" title="{{ lang.editnews['pop.title'] }}" data-content="{{ lang.editnews['pop.title#descr'] }}" tabindex="0">
											<i class="fa fa-question"></i>
										</a>
									</div>
								</div>
								<div id="searchDouble"></div>
							{% else %}
						<div class="input-group">
							<input id="newsTitle" placeholder="{{ lang.editnews['pop.title#input'] }}..." type="text" name="title" value="{{ title }}" class="form-control" required />
							<div class="input-group-append">
							<a class="btn btn-outline-primary" data-toggle="popover" data-placement="right" data-trigger="focus" data-html="true" title="{{ lang.editnews['pop.title'] }}" data-content="{{ lang.editnews['pop.title#descr'] }}" tabindex="0">
								<i class="fa fa-question"></i>
							</a>
							</div>
						</div>
							{% endif %}
						</div>
					</div>
						
					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">{{ lang.editnews['alt_name'] }}</label>
						<div class="col-lg-9">
							<input type="text" name="alt_name" value="{{ alt_name }}" {% if flags['altname.disabled'] %}disabled="disabled" {% endif %} class="form-control" />
						</div>
					</div>
					
					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">URL:</label>
						<div class="col-lg-9">
							<div class="input-group">
							<input type="text" value="{{ link }}" class="form-control" readonly />
							<div class="input-group-append">
								<span class="input-group-text"><a href="{{ link }}" title="{{ lang.editnews['open_news'] }}" target="_blank"><i class="fa fa-external-link"></i></a></span>
							</div>
							</div>
						</div>
					</div>
					
					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">
							{{ lang.editnews['category'] }}
							{% if (flags.mondatory_cat) %}
								<span style="font-size: 16px; color: red;"><b>*</b></span>
							{% endif %}
						</label>
						<div class="col-lg-9">
							<div class="list">
								{{ mastercat }}
							</div>
						</div>
					</div>
					
                {% if (extends.main) %}
					{% for entry in extends.main %}
					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">{{ entry.title }}</label>
						<div class="col-lg-9">
							{{ entry.body }}
						</div>
					</div>
                    {% endfor %}
                {% endif %}
				 
		
				{% if (not flags.disableTagsSmilies) %}
					{{ quicktags }}
					<!-- SMILES -->
					<div id="modal-smiles" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="smiles-modal-label" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 id="smiles-modal-label" class="modal-title">{{ lang.editnews['ins.smilies'] }}</h5>
									<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
								</div>
								<div class="modal-body">
									{{ smilies }}
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-outline-dark" data-dismiss="modal">{{ lang.editnews['cancel'] }}</button>
								</div>
							</div>
						</div>
					</div>
				{% endif %}

				{% if (flags.edit_split) %}
					<div class="mb-3">
						<div id="container.content.short" class="contentActive">
							<textarea id="ng_news_content_short" name="ng_news_content_short" onclick="changeActive('short');" onfocus="changeActive('short');" class="{{ editorClassName ? editorClassName : 'form-control' }}" rows="10">{{ content.short }}</textarea>
						</div>
						</div>

					{% if (flags.extended_more) %}
						<div class="form-row mb-3">
							<label class="col-lg-3 col-form-label">{{ lang.editnews['editor.divider'] }}</label>
							<div class="col-lg-9">
								<input type="text" name="content_delimiter" value="{{ content.delimiter }}" class="form-control" />
							</div>
						</div>
					{% endif %}

					<div class="mb-3">
						<div id="container.content.full" class="contentInactive">
							<textarea id="ng_news_content_full" name="ng_news_content_full" onclick="changeActive('full');" onfocus="changeActive('full');" class="{{ editorClassName ? editorClassName : 'form-control' }}" rows="10">{{ content.full }}</textarea>
						</div>
					</div>
				{% else %}
					<div id="container.content" class="mb-3" class="contentActive">
						<textarea id="ng_news_content" name="ng_news_content" class="{{ editorClassName ? editorClassName : 'form-control' }}" rows="10">{{ content.short }}</textarea>
					</div>
				{% endif %}
					
				{% if (flags.add_info) %}
				<div class="form-row mb-3">
					<label class="col-lg-3 col-form-label">{{ lang.editnews['info'] }}</label>
					<div class="col-lg-9">
						<textarea name="info" class="form-control" style="height: 180px;">{{ info }}</textarea>
					</div>
				</div>
				{% endif %}
					
				{% if (flags.add_scrin) %}
				<div class="form-row mb-3">
					<label class="col-lg-3 col-form-label">{{ lang.editnews['scrin'] }}</label>
					<div class="col-lg-9">
						{% include localPath(0)~"scrin.tpl" %}
						<textarea class="form-control form-scrin form-scrinwidth-500" rows="3" onkeydown="checkKey(event, this.form)" name="scrin" id="scrin" placeholder="{{ lang.editnews['img.upload'] }}">{{ scrin }}</textarea>
						<br>
						<div class="btn btn-default btn-light btn-fileinput"><span><i class="fa fa-file-image-o"></i> {{ lang.editnews['img.change'] }} ...</span>
							<input type="file" id="input_img" onchange="fileChange()" accept="image/*">
						</div>
					</div>
				</div>
				{% endif %}

				{% if (pluginIsActive('xfields')) %}
				<table class="table table-striped">
					<!-- XFields -->
					{{ plugin.xfields[1] }}
					<!-- /XFields -->
				</table>
				{% endif %}
		
				</div>

			</div>
		
		<!-- Мета -->
		<div class="tab-pane" id="tabmeta" >
			<div id="meta" class="panel-body">
			{% if (flags.meta) %}
			
                {% if (extends.meta) %}
					{% for entry in extends.meta %}
					<div class="form-row mb-3">
						<label class="col-lg-3 col-form-label">{{ entry.title }}</label>
						<div class="col-lg-9">
							{{ entry.body }}
						</div>
					</div>
                    {% endfor %}
                 {% endif %}
				 
				<div class="form-row mb-3">
					<label class="col-lg-3 col-form-label">{{ lang.editnews['description'] }}</label>
					<div class="col-lg-9">
						<textarea name="description" cols="80" class="form-control">{{ description }}</textarea>
					</div>
				</div>

				<div id="form-keywords" class="form-row mb-3">
					<label class="col-lg-3 col-form-label">{{ lang.editnews['keywords'] }}</label>
					<div class="col-lg-9">
						<input type="text" name="keywords" id="newsKeywords" value="{{ keywords }}" tabindex="7" class="form-control" maxlength="255" />
					</div>
				</div>
				{% endif %}
				
			</div>
		</div>
					
		<!-- ДОПОЛНИТЕЛЬНО -->
		<div class="tab-pane" id="tabadditional" >
			<div id="additional" class="panel-body">
			
				<div class="form-row mb-3">
					<label class="col-lg-3 col-form-label">{{ lang['editor.author'] }}:</label>
					<div class="col-lg-9">
					<div class="input-group">
						<input type="text" value="{{ author }}" id="AuthorName" placeholder="{{ lang.editnews['author#input'] }}..." class="form-control" readonly/>
						<div class="input-group-append">
							<span class="input-group-text">
								<a id="markAuthorEdit" href="#" title="{{ lang.editnews['edit_comm'] }}"><i class="fa fa-pencil"></i></a>
							</span>
							<a class="btn btn-primary" data-toggle="popover" data-placement="top" data-trigger="focus" data-html="true" title="" data-content="{{ lang.editnews['pop.author#descr'] }}" tabindex="0" data-original-title="{{ lang.editnews['pop.author'] }}">
											<i class="fa fa-question"></i>
										</a>
						</div>
					</div>
					<span id="AuthorNameLoader" style="width: 20px; visibility: hidden;"><img src="{{ skins_url }}/images/loading.gif" /> {{ lang.editnews['core.search'] }}</span>

					</div>
				</div>

				{% if (pluginIsActive('xfields')) %}
				<div class="form-row mb-3">
					<table class="table table table-striped">
						{{ plugin.xfields[0] }}
					</table>
				</div>
				{% endif %}
					
				{% for entry in extends.additional %}
				<div class="form-row mb-3">
					<table class="table table table-striped">
						<tr class="thead-light">
							<th colspan="2">{{ entry.title }}</th>
						</tr>
						{{ entry.body }}
					</table>
				</div>
				{% endfor %}		
				
			</div>
		</div>

		<!-- ДОСТУП -->
		<div class="tab-pane" id="tabacces" >
			<div id="acces" class="panel-body">
				<div class="form-row mb-3">
					<label class="col-lg-9 col-form-label">{{ lang.editnews['acces_info'] }} <small class="form-text text-muted">{{ lang.editnews['acces_info#descr'] }}<br>{{ lang.editnews['acces_grup'] }}<br>{{ usergrup }}</small></label>
					<div class="col-lg-3">
						<input type="text" name="acces" id="newsacces" value="{{ acces }}" tabindex="7" class="form-control" />
						<small>{{ lang.editnews['acces_grup#descr'] }}</small>
					</div>
				</div>
			</div>
		</div>
		
	</div> <!-- panel-tab-content -->
</div> <!-- panel panel-default -->

           <!-- PLUGIN WITH OWNER BLOCK -->
           {% if (extends.owner) %}
               {% for entry in extends.owner %}
                <div class="panel panel-default {% if(entry.table) %}panel-table{% endif %}">
                     <div id="owner-{{ loop.index }}" class="panel-heading">
                           <a href="#" data-toggle="collapse" data-target="#panel-owner-{{ loop.index }}" aria-expanded="false" aria-controls="panel-owner-{{ loop.index }}">{{ entry.title }}</a>
                      </div>
					<div class="panel-body" style="padding:0px">
						<div id="panel-owner-{{ loop.index }}" class="collapse" aria-labelledby="owner-{{ loop.index }}" data-parent="#attaches" style="padding:10px">
							<div class="form-row mb-3">
							<label class="col-lg-3 col-form-label">{{ entry.title }}</label>
								<div class="col-lg-9">
									{{ entry.body }}
								</div>
							</div>
						</div>
					</div>
                </div>
               {% endfor %}
           {% endif %}
		   
			<!-- ATTACHES -->
			<div id="attaches" class="accordion mb-4">
				<div class="panel panel-default">
					<div id="headingTwo" class="panel-heading">
						<a href="#" class="btn-block collapsed" data-toggle="collapse" data-target="#collapseNewsAttaches" aria-expanded="false" aria-controls="collapseNewsAttaches">
							{{ lang.editnews['bar.attaches'] }} ({{ attachCount }})
						</a>
					</div>
					<div class="panel-body" style="padding:0px">
					<div id="collapseNewsAttaches" class="collapse" aria-labelledby="headingTwo" data-parent="#attaches" style="padding:10px">
						<!-- <span class="f15">{{ lang.editnews['attach.list'] }}</span> -->
						<table id="attachFilelist" class="table table-sm mb-0">
							<thead>
								<tr>
									<th>ID</th>
									<th width="80">{{ lang.editnews['attach.date'] }}</th>
									<th nowrap></th>
									<th>{{ lang.editnews['attach.filename'] }}</th>
									<th width="90">{{ lang.editnews['attach.size'] }}</th>
									<th width="40">DEL</th>
								</tr>
							</thead>
							<tbody>
								{% for entry in attachEntries %}
									<tr>
										<td>{{ entry.id }}</td>
										<td>{{ entry.date }}</td>
										<td>
											<a href="#" onclick="insertext('[attach#{{ entry.id }}]{{ entry.orig_name }}[/attach]','', currentInputAreaID)" title='{{ lang['tags.file'] }}'>
												{{ lang['tags.file'] }}
											</a>
										</td>
										<td><a href="{{ entry.url }}">{{ entry.orig_name }}</a></td>
										<td>{{ entry.filesize }}</td>
										<td><input type="checkbox" name="delfile_{{ entry.id }}" value="1"/></td>
									</tr>
								{% else %}
									<tr>
										<td colspan="6">{{ lang.editnews['attach.no_files_attached'] }}</td>
									</tr>
								{% endfor %}
								<!-- <tr><td>*</td><td>New file</td><td colspan="2"><input type="file"/></td><td><input type="button" size="40" value="-"/></td></tr> -->
								<tr>
									<td colspan="6" class="text-right">
										<input type="button" value="{{ lang.editnews['attach.more_rows'] }}" class="btn btn-sm btn-outline-primary" onclick="attachAddRow();"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Right edit column -->
		<div id="rightBar" class="col col-lg-4">
			<div class="card mb-4">
				<div class="card-header">{{ lang['editor.comminfo'] }}</div>
				<table class="table table-condensed">
					<thead>
						<tr>
							<th>ID</th>
							<th><i class="fa fa-calendar"></i> {{ lang['editor.dcreate'] }}</th>
							<th><i class="fa fa-calendar-check-o"></i> {{ lang['editor.dedit'] }}</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><span data-placement="top" data-popup="tooltip" data-original-title="ID {{ lang.editnews['news_title'] }}" title="ID {{ lang.editnews['news_title'] }}"><b>{{ id }}</b></span></td>
							<td>{{ createdate }}</td>
							<td>{{ editdate }}</td>
						</tr>
					</tbody>
				</table>
				<table class="table table-condensed">
					<thead>
						<tr>
							<th><i class="fa fa-user-circle-o"></i> {{ lang['editor.author'] }}</th>
							<th><i class="fa fa-retweet"></i> {{ lang['news_status'] }}</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<b><span id="news-author">{{ author }}</span></b>
								<div class="pull-right">
								{% if (pluginIsActive('uprofile')) %}
									<a href="{{ author_page }}" target="_blank" title="{{ lang['site.viewuser'] }}" class="btn-sm btn-default"><i class="fa fa-eye"></i></a>&nbsp;
								{% endif %}
								<a href="{{ php_self }}?mod=users&action=editForm&id={{ authorid }}" target="_blank" class="btn-sm btn-default"><i class="fa fa-pencil"></i></a>&nbsp;
								</div>
							</td>
							<td>
							{% if (approve == -1) %}
								<i class="fa fa-check-circle text-warning"></i>&nbsp;<span class="text-danger text-size-small">{{ lang['state.draft'] }}</span>
							{% elseif (approve == 0) %}
								<i class="fa fa-ban text-warning"></i>&nbsp;<span class="text-danger text-size-small">{{ lang['state.unpublished'] }}</span>
							{% else %}
								<i class="fa fa-check-circle text-success"></i>&nbsp;<span class="text-success text-size-small">{{ lang['state.published'] }}</span>
							{% endif %}
							</td>
						</tr>
					</tbody>
				</table>
				{% for entry in filesEntries %}
				<table class="table table-condensed">
					<thead>
						<tr>
							<th><i class="fa fa-paperclip"></i> {{ lang.editnews['attach_name'] }}</th>
							<th><i class="fa fa-folder-o"></i> {{ lang.editnews['attach_folder'] }}</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="display: block; white-space: nowrap;overflow: hidden;text-overflow: ellipsis;width: 240px;">{{ entry.name }}</td>
							<td>{{ entry.folder }}</td>
						</tr>
					</tbody>
				</table>
				{% endfor %}

			</div>
			{% if flags['multicat.show'] %}
			<div class="card mb-4">
				<div class="card-header">
					{{ lang['editor.extcat'] }}
					<div class="card-header-right">
						<a style="position: absolute;right: 4px;border-bottom-left-radius: 0;border-top-left-radius: 0;cursor: pointer;" class="btn-sm btn-default" data-toggle="popover" data-placement="top" data-trigger="focus" data-html="true" title="" data-content="{{ lang.editnews['pop.cat#descr'] }}" tabindex="0" data-original-title="{{ lang.editnews['pop.cat'] }}">
							<i class="fa fa-question"></i>
						</a>
					</div>
				</div>
				<div class="card-body">
					<div class="has-feedback" onclick="$('.cat-list').toggle();">
						<input id="catSelector" class="form-control" type="button" value="{{ lang['no_cat'] }}" hidefocus="" autocomplete="off" readonly="" style="white-space: pre-wrap;height: auto; text-align: left;">
						<span class="form-control-feedback"><span class="caret"></span></span>
					</div>
					<div class="cat-list" style="display: none;">{{ extcat }}</div>
				</div>
			</div>
			{% endif %}

			{% if (extends.sidebar) %}
				{% for entry in extends.sidebar %}
				<div class="card mb-4">
					<div class="card-header">{{ entry.title }}</div>
					<div class="card-body">
						{{ entry.body }}
					</div>
				</div>
				{% endfor %}
			{% endif %}
			
			{% if (pluginIsActive('forum')) %}
				{{ edit_forum }}
			{% endif %}

			<div class="card mb-4">
				<div class="card-header">{{ lang['editor.configuration'] }}</div>
				<div class="card-body">
					<label class="col-form-label d-block">
						<input id="mainpage" type="checkbox" name="mainpage" value="1" {% if (flags.mainpage) %}checked {% endif %} {% if flags['mainpage.disabled'] %}disabled {% endif %} />
						{{ lang.editnews['mainpage'] }}
					</label>

					<label class="col-form-label d-block">
						<input id="pinned" type="checkbox" name="pinned" value="1" {% if (flags.pinned) %}checked {% endif %} {% if flags['pinned.disabled'] %}disabled {% endif %} />
						{{ lang.editnews['add_pinned'] }}
					</label>

					<label class="col-form-label d-block">
						<input id="catpinned" type="checkbox" name="catpinned" value="1" {% if (flags.catpinned) %}checked {% endif %} {% if flags['catpinned.disabled'] %}disabled {% endif %} />
						{{ lang.editnews['add_catpinned'] }}
					</label>

					<label class="col-form-label d-block">
						<input id="favorite" type="checkbox" name="favorite" value="1" {% if (flags.favorite) %}checked {% endif %} {% if flags['favorite.disabled'] %}disabled {% endif %} />
						{{ lang.editnews['add_favorite'] }}
					</label>

					<label class="col-form-label d-block">
						<input id="flag_HTML" type="checkbox" name="flag_HTML" value="1" {% if (flags['html']) %}checked {% endif %} {% if (flags['html.disabled']) %}disabled {% endif %} />
						{{ lang.editnews['flag_html'] }}
					</label>

					<label class="col-form-label d-block">
						<input id="flag_RAW" type="checkbox" name="flag_RAW" value="1" {% if (flags['raw']) %}checked {% endif %} {% if (flags['html.disabled']) %}disabled {% endif %} />
						{{ lang.editnews['flag_raw'] }}
						<div class="{{ flags['raw.disabled'] ? 'alert alert-warning mb-0' : 'd-none' }}">{{ lang.editnews['flags_lost'] }}</div>
					</label>
					
					<label class="col-form-label d-block">
						<input type="checkbox" name="fixed" value="1" {% if (flags.fixed) %}checked {% endif %} {% if flags['fixed.disabled'] %}disabled {% endif %} />
						{{ lang.editnews['flag_fixed'] }}
					</label>
					<label class="col-form-label d-block">
						<input id="robots" type="checkbox" name="robots" value="1" {% if (flags.robots) %}checked {% endif %} {% if flags['robots.disabled'] %}disabled {% endif %} />
						{{ lang.editnews['flag_robots'] }}
					</label>
					<label class="col-form-label d-block">
						<input type="checkbox" name="nosearch" value="1"  {% if (flags.nosearch) %}checked {% endif %} {% if flags['nosearch.disabled'] %}disabled {% endif %} />
						{{ lang.editnews['flag_nosearch'] }}
					</label>
				</div>
			</div>

			<div class="card mb-4">
				<div class="card-header">{{ lang.editnews['set_views'] }}</div>
				<div class="card-body">
					<div class="input-group">
						<div class="input-group-prepend">
							<div class="input-group-text">
								<input type="checkbox" name="setViews" class="" value="1" {% if (flags['setviews.disabled']) %}disabled{% endif %}>
							</div>
						</div>
						<input type="number" name="views" value="{{ views }}" class="form-control" {% if (flags['setviews.disabled']) %}disabled{% endif %} autocomplete="off">
						<div class="input-group-prepend input-group-append">
							<label class="input-group-text"><i class="fa fa-eye"></i></label>
						</div>
					</div>
				</div>
			</div>

			{% for entry in filesEntries %}
			<div class="card mb-4">
				<div class="card-header">{{ lang.editnews['set_down'] }}</div>
				<div class="card-body">
					<div class="input-group">
						<div class="input-group-prepend">
							<div class="input-group-text">
								<input type="checkbox" name="setDown" class="" value="1" {% if (flags['setdown.disabled']) %}disabled{% endif %}>
							</div>
						</div>
						<input type="number" name="dcount" value="{{ entry.dcount }}" class="form-control" {% if (flags['setdown.disabled']) %}disabled{% endif %} autocomplete="off">
						<div class="input-group-prepend input-group-append">
							<label class="input-group-text"><i class="fa fa-download"></i></label>
						</div>
					</div>
				</div>
			</div>
			{% endfor %}
			
			{% if not flags['customdate.disabled'] %}
				<div class="card mb-4">
					<div class="card-header">{{ lang.editnews['custom_date'] }}</div>
					<div class="card-body">
						<label class="col-form-label d-block">
							<input id="setdate_current" type="checkbox" name="setdate_current" value="1" onclick="document.getElementById('setdate_custom').checked=false;"/>
							{{ lang.editnews['date.setcurrent'] }}
						</label>

						<label class="col-form-label d-block">
							<input id="setdate_custom" type="checkbox" name="setdate_custom" value="1"  onclick="document.getElementById('setdate_current').checked=false;">
							{{ lang.editnews['date.setdate'] }}
						</label>

						<div class="input-group">
							<input id="cdate" type="text" name="cdate" value="{{ cdate }}" class="form-control" pattern="[0-9]{2}\.[0-9]{2}\.[0-9]{4} [0-9]{2}:[0-9]{2}" placeholder="{{ "now" | date('d.m.Y H:i') }}" autocomplete="off">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-calendar"></i></label>
							</div>
						</div>
					</div>
				</div>
			{% endif %}

			{% if (pluginIsActive('comments')) %}
				<div class="card mb-4">
					<div class="card-header">{{ lang['comments:mode.header'] }}</div>
					<div class="card-body">
					<div class="input-group">
						<select name="allow_com" class="custom-select">
							<option value="0" {{ plugin.comments['acom:0'] }}>{{ lang['comments:mode.disallow'] }}</option>
							<option value="1" {{ plugin.comments['acom:1'] }}>{{ lang['comments:mode.allow'] }}</option>
							<option value="2" {{ plugin.comments['acom:2'] }}>{{ lang['comments:mode.default'] }}</option>
						</select>
						<div class="input-group-prepend input-group-append">
							<label class="input-group-text"><i class="fa fa-commenting-o"></i></label>
						</div>
					</div>
					</div>
				</div>
			{% endif %}
		</div>
	</div>

	<div class="row">
		<div class="col col-lg-8">
			<div class="row">
				<div class="col-md-6 mt-4">
					<button type="button" class="btn btn-outline-success" onclick="return preview();">
						<span class="d-xl-none"><i class="fa fa-eye"></i></span>
						<span class="d-none d-xl-block">{{ lang.addnews['preview'] }}</span>
					</button>

					{% if flags.deleteable %}
						<a href="#" class="btn btn-outline-danger" data-toggle="modal" data-target="#modal-{{ id }}" title="{{ lang.editnews['delete'] }}">{{ lang.editnews['delete'] }}</a>
	<div id="modal-{{ id }}" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="{{ id }}-modal-label" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 id="{{ id }}-modal-label" class="modal-title">{{ lang.editnews['delete'] }}</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i class="fa fa-times-circle"></i></span></button>
				</div>
				<div class="modal-body">
					{{ lang.editnews['sure_del'] }}
				</div>
				<div class="modal-footer"> <a href="{{ php_self }}?mod=news&action=manage&subaction=mass_delete&selected_news[]={{ id }}&token={{ token }}" class="btn btn-outline-success">{{ lang.editnews['delyes'] }}</a> <button type="button" class="btn btn-outline-dark" data-dismiss="modal">{{ lang.editnews['close'] }}</button></div>
			</div>
		</div>
	</div>
					{% endif %}
				</div>

				<div class="col-md-6 mt-4">
					{% if flags.editable %}
						<div class="input-group">
							<select name="approve" class="custom-select">
								{% if flags['can_publish'] %}<option value="1" {{ approve ? 'selected' : '' }}>{{ lang.addnews['publish'] }}</option>{% endif %}
								{% if flags.can_unpublish %}<option value="0" {{ not(approve) ? 'selected' : '' }}>{{ lang.addnews['send_moderation'] }}</option>{% endif %}
								{% if flags.can_draft %}<option value="-1" {{ approve == -1 ? 'selected' : '' }}>{{ lang.addnews['save_draft'] }}</option>{% endif %}
							</select>
							<div class="input-group-append">
								<button type="submit" class="btn btn-outline-success">
									<span class="d-xl-none"><i class="fa fa-floppy-o"></i></span>
									<span class="d-none d-xl-block">{{ lang.editnews['do_editnews'] }}</span>
								</button>
							</div>
						</div>
					{% endif %}
				</div>
			</div>
		</div>
	</div>

	{% if (pluginIsActive('xfields')) %}
		<!-- XFields [GENERAL] -->
		{{ plugin.xfields.general }}
		<!-- /XFields [GENERAL] -->
	{% endif %}
	
	<div id="modal-uplimg" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="uplimg-modal-label" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 id="uplimg-modal-label" class="modal-title">{{ lang.editnews['img_upload'] }}</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				</div>
				<div class="modal-body">
					<div>
					{% if (flags.thumb_create_option) %}
						<input type="checkbox" id="imageCreateThumb" name="imageCreateThumb" value="" checked="checked"/> {{ lang.editnews['img_cr_thumb'] }}&nbsp;&nbsp;
					{% endif %}
						<input type="checkbox" id="imageRandomTitle" name="imageRandomTitle" checked="checked"/> {{ lang.editnews['img_rand_name'] }}
					</div>
					<br />
					<div class="table-responsive">
					<table id="newsimage-area" class="table table-sm mb-0">
						{% for image in images %}
							<tr id="newsimage-item-{{ image.id }}"><td style="margin: 10px 0;">{{ image.entry }}</td> <td style="vertical-align: middle;"><a href="#" onclick="if(confirm('Удалить')) deleteNewsImage({{ image.id }}); return false;" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></a></td></tr>
						{% endfor %}
					</table>
					</div>
					<hr>
                    <div>
						<input type="file" id="uploadimage" name="newsimage" value=""/>
						<input type="button" value="Загрузить" class="btn btn-sm btn-outline-secondary" onclick="return uploadNewsImage();"/>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-outline-dark" data-dismiss="modal">{{ lang.editnews['close'] }}</button>
				</div>
			</div>
		</div>
	</div>

</form>

{% if (pluginIsActive('comments')) %}
	<!-- COMMENTS -->
	<div id="additional" class="accordion mt-5">
		<div class="card">
			<div class="card-header" id="headingThree">
				<a href="#" class="btn-block collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
					<i class="fa fa-commenting mr-2"></i> {{ lang.editnews['bar.comments'] }} ({{ plugin.comments.count }})
				</a>
			</div>

			<div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#additional">
				<form id="commentsForm" name="commentsForm" action="{{ php_self }}?mod=news" method="post">
					<input type="hidden" name="token" value="{{ token }}" />
					<input type="hidden" name="mod" value="news" />
					<input type="hidden" name="action" value="edit" />
					<input type="hidden" name="subaction" value="mass_com_delete" />
					<input type="hidden" name="id" value="{{ id }}" />

					<!-- COMMENTS -->
					<div id="comments" class="table-responsive">
						<table class="table table-sm mb-0">
							<thead>
								<tr>
									<th>{{ lang.editnews['author'] }}</th>
									<th>{{ lang.editnews['date'] }}</th>
									<th>{{ lang.editnews['comment'] }}</th>
									<th>{{ lang.editnews['edit_comm'] }}</th>
									<th nowrap>{{ lang.editnews['block_ip'] }}</th>
									<th>
										<input type="checkbox" name="master_box" value="all" onclick="javascript:check_uncheck_all(commentsForm)" class="check"/>
									</th>
								</tr>
							</thead>
							<tbody>
								{{ plugin.comments.list }}
								<tr>
									<td colspan="6" class="text-right">
										<button type="submit" class="btn btn-outline-danger" onclick="if (!confirm('{{ lang.editnews['sure_del_com'] }}')) {return false;}">
											{{ lang.editnews['comdelete'] }}
										</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</form>
			</div>
		</div>
	</div>
{% endif %}

{% if (extends.css) %}
    {% for entry in extends.css %}
        {{ entry.body }}
    {% endfor %}
{% endif %}

{% if (extends.js) %}
    {% for entry in extends.js %}
        {{ entry.body }}
    {% endfor %}
{% endif %}

<script type="text/javascript">
function insertselcat(cat) {
	var ss = $('select[name=category] option:selected');
	if( ss.val() == 0 ) {
		$('input[name*=category_]').map(function() {$(this).prop('checked', false);});
	}
	var ctstring = $('input[name*=category_]:checked').map(function() {
		if( $.trim(ss.text()) != $.trim($(this).parent().text()) ) {
			return $(this).parent().text();
		} else {
			$(this).prop('checked', false);
		}
	}).get().join(", ") || "{{ lang['no_cat'] }}";
	$("#catSelector").val( ctstring.replace(/&amp;/g, '&') );
}
$('input[name*=category_], select[name=category]').on('click', function (e) {
	insertselcat();
});
insertselcat();
</script>

<script type="text/javascript">
	// Global variable: ID of current active input area
	var currentInputAreaID = 'ng_news_content{{ flags.edit_split ? '_short' : '' }}';

	function preview() {
		var form = document.getElementById("postForm");

		if (form.querySelector('[name*=ng_news_content]').value == '' || form.title.value == '') {
			ngNotifySticker('{{ lang.addnews['msge_preview'] }}', {className: 'stickers-danger'});

			return false;
		}

		form['mod'].value = "preview";
		form.target = "_blank";
		form.submit();

		form['mod'].value = "news";
		form.target = "_self";

		return true;
	}

	function changeActive(name) {
		if (name == 'full') {
			document.getElementById('container.content.full').className = 'contentActive';
			document.getElementById('container.content.short').className = 'contentInactive';
			currentInputAreaID = 'ng_news_content_full';
		} else {
			document.getElementById('container.content.short').className = 'contentActive';
			document.getElementById('container.content.full').className = 'contentInactive';
			currentInputAreaID = 'ng_news_content_short';
		}
	}
</script>

<script type="text/javascript">
	function attachAddRow() {
		var tbl = document.getElementById('attachFilelist');
		var lastRow = tbl.rows.length;
		var row = tbl.insertRow(lastRow - 1);

		// Add cells
		row.insertCell(-1).innerHTML = '*';
		row.insertCell(-1).innerHTML = '{{ lang.editnews['attach.new_file'] }}';
		row.insertCell(-1).innerHTML = '';

		// Add file input
		var el = document.createElement('input');
		el.setAttribute('type', 'file');
		el.setAttribute('name', 'userfile[' + (++attachAbsoluteRowID) + ']');
		el.setAttribute('size', '80');

		var xCell = row.insertCell(-1);
		xCell.colSpan = 2;
		xCell.appendChild(el);

		el = document.createElement('button');
		el.setAttribute('type', 'button');
		el.setAttribute('onclick', 'document.getElementById("attachFilelist").deleteRow(this.parentNode.parentNode.rowIndex);');
		el.setAttribute('class', 'btn btn-sm btn-danger');
		el.innerHTML = '<i class="fa fa-trash"></i>';
		row.insertCell(-1).appendChild(el);
	}

	// Add first row
	var attachAbsoluteRowID = 0;
	attachAddRow();
</script>
<script language="javascript" type="text/javascript">
    function uploadNewsImage() {
        var $input = $("#uploadimage");
        var fd = new FormData;

        if(!$input.val()) {
			$.notify({message:'Выберите изображение!'},{type: 'error'});
            return;
        }

        fd.append('newsimage', $input.prop('files')[0]);
        fd.append('newsId', {{id}});
        fd.append('imageRandomTitle', $("#imageRandomTitle").is(':checked'));
        fd.append('imageCreateThumb', $("#imageCreateThumb").is(':checked'));

        $.ajax({
            url: '{{php_self}}?mod=news&action=uploadimage',
            data: fd,
            processData: false,
            contentType: false,
            type: 'POST',
            dataType: 'json',
            success: function (result) {
                if(result.error) {
					$.notify({message:result.error},{type: 'error'});
                    return;
                }
                $("#newsimage-area").append('<li id="newsimage-item-'+result.id+'" style="margin: 10px 0;">'+result.data+' <a href="#" onclick="if(confirm(\'Удалить изображение?\')) deleteNewsImage('+result.id+'); return false;" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></a></li>');
                $input.val('');
                $("#newsimage-item-"+result.id).css('background-color', '#b4d8b2');
                setTimeout(function() { $("#newsimage-item-"+result.id).css('background-color', '#ffffff') }, 3000);
            },
            error: function (result) {
				$.notify({message:'Ошибка загрузки изображения'},{type: 'error'});
            }
        });
    }

    function deleteNewsImage(imageId) {
        if(imageId < 1) {
			$.notify({message:'Неправильный идентификатор!'},{type: 'error'});
            return;
        }

        var fd = new FormData;
        fd.append('imageId', imageId);

        $.ajax({
            url: '{{php_self}}?mod=news&action=deleteimage',
            data: fd,
            processData: false,
            contentType: false,
            type: 'POST',
            dataType: 'json',
            success: function (data) {
                if(data.error) {
					$.notify({message:data.error},{type: 'error'});
                    return;
                }

                $("#newsimage-item-"+imageId).css('background-color', '#da7b7b');
                setTimeout(function() { $("#newsimage-item-"+imageId).remove(); }, 2000);
            },
            error: function (data) {
				$.notify({message:'Ошибка удаления изображения'},{type: 'error'});
            }
        });
    }
</script>
<script language="javascript" type="text/javascript">
	$(document).ready(function() {
		$('#markAuthorEdit').on('click', function(event) {
			event.preventDefault();

			$('#AuthorName').removeAttr('readonly')
				.attr('name', 'author');

			$(this).parents('.input-group').removeClass();
			$(this).parents('.input-group-append').remove();
		});
	});
</script>
<script language="javascript" type="text/javascript">
	// INIT NEW SUGGEST LIBRARY [ call only after full document load ]
	var aSuggest = new ngSuggest('AuthorName',
		{
			'localPrefix': '',
			'reqMethodName': 'core.author.search',
			'lId': 'AuthorNameLoader',
			'hlr': 'true',
			'iMinLen': 1,
			'stCols': 2,
			'stColsClass': ['cleft', 'cright'],
			'stColsHLR': [true, false],
			'listDelimiter': ',',
		}
	);

</script>
<script>
var searchDouble = function() {
    if ($.trim($('#newsTitle').val()).length < 4)
        return $.notify({message: '{{ lang.editnews['msge_title'] }}'},{type: 'danger'});
    var url = '/engine/rpc.php';
    var method = 'admin.news.double';
    var params = {'token': '{{ token }}','title': $('#newsTitle').val(),'news_id': '{{ id }}','mode': 'edit',};
    $.reqJSON(url, method, params, function(json) {
        $('#searchDouble').html('');
        if (json.info) {
            $.notify({message:json.info},{type: 'info'});
        } else {
            var txt = '<ul class="alert alert-info list-unstyled alert-dismissible"><button type="button" class="close" data-dismiss="alert" >&times;</button>';
            $.each(json.data,function(index, value) {
                txt += '<li>#' +value.id+ ' &#9;&#9;<a href="'+value.url+'" target="_blank" class="alert-link">'+value.title +'</a></li>';
            });
            $('#searchDouble').html(txt+'</ul>');
        }
    });
};
</script>