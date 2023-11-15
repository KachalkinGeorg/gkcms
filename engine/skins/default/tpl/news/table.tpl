<!-- Filter form: BEGIN -->
<div id="collapseNewsFilter" class="collapse">
	<div class="card mb-4">
	<div class="card-header">{{ lang['filter'] }}</div>
		<div class="card-body">
			<form action="{{ php_self }}?mod=news" method="post" name="options_bar">

			<table class="table table-sm mb-0">
				<tr>				
					<td><label style="padding: .375rem 0rem .75rem 0rem;">{{ lang.editnews['header.search'] }}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-search"></i></label>
							</div>
							<input name="sl" type="text" value="{{ sl }}" class="form-control" style="max-width:220px;"/>
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-hand-o-right"></i></label>
							</div>
							<select name="st" class="custom-select" style="max-width:220px;">
								<option value="0" {{ not(selected) ? 'selected' : '' }}>{{ lang.editnews['header.stitle'] }}</option>
								<option value="1" {{ selected ? 'selected' : '' }}>{{ lang.editnews['header.stext'] }}</option>
							</select>
						</div>
					</td>
					<td><label style="padding: .375rem 0rem .75rem 0rem;">{{ lang.editnews.author }}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-user"></i></label>
							</div>
							<input name="an" id="an" class="form-control" type="text" value="{{ an }}" autocomplete="off" style="max-width:220px;"/>
						</div>
					</td>
				</tr>
				<tr>				
					<td><label style="padding: .375rem 0rem .75rem 0rem;">{{ lang.editnews['header.date'] }}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-calendar"></i></label>
								<label class="input-group-text">{{ lang.editnews['header.date_since'] }}</label>
							</div>
							<input type="text" id="dr1" name="dr1" value="{{ dr1 }}" class="form-control" pattern="[0-9]{2}\.[0-9]{2}\.[0-9]{4}" placeholder="{{ "now" | date('d.m.Y') }}" autocomplete="off" style="max-width:188px;"/>
							<div class="input-group-prepend">
								<span class="input-group-text">{{ lang.editnews['header.date_till'] }}</span>
							</div>
							<input type="text" id="dr2" name="dr2" value="{{ dr2 }}" class="form-control" pattern="[0-9]{2}\.[0-9]{2}\.[0-9]{4}" placeholder="{{ "now" | date('d.m.Y') }}" autocomplete="off" style="max-width:220px;"/>
						</div>
					</td>
					<td><label style="padding: .375rem 0rem .75rem 0rem;">{{ lang.editnews['category'] }}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-folder-open"></i></label>
							</div>
							{{ category_select }}
						</div>
					</td>
				</tr>
				<tr>				
					<td><label style="padding: .375rem 0rem .75rem 0rem;">{{ lang.editnews['header.status'] }}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-circle-o"></i></label>
							</div>
							<select name="status" class="custom-select" style="max-width:220px;">
								<option value="">{{ lang.editnews['smode_all'] }}</option>
									{{ statuslist }}
							</select>
						</div>
					</td>
					<td><label style="padding: .375rem 0rem .75rem 0rem;">{{ lang.editnews['header.perpage'] }}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-low-vision"></i></label>
							</div>
							<input type="number" name="rpp" value="{{ rpp }}" size="3" class="form-control" style="max-width:220px;"/>
						</div>
					</td>
				</tr>
				<tr>				
					<td><label style="padding: .375rem 0rem .75rem 0rem;">{{ lang.editnews['sort'] }}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-sort-amount-asc"></i></label>
							</div>
							<select name="sort" class="custom-select" style="max-width:220px;">{{ sortlist }}</select>
						</div>
					</td>	
				</tr>					
			</table>
			
			<div class="panel-footer" align="center" style="margin-left: -20px;margin-right: -20px;margin-bottom: -20px;">
				<button type="submit" class="btn btn-outline-primary">{{ lang.editnews['do_show'] }}</button>
			</div>
			</form>
		</div>
	</div>
</div>

<!-- Mass actions form: BEGIN -->
<form action="{{ php_self }}?mod=news" method="post" name="editnews">
	<input type="hidden" name="token" value="{{ token }}" />
	<input type="hidden" name="mod" value="news" />
	<input type="hidden" name="action" value="manage" />

	<div class="panel panel-default">
		<div class="panel-heading">{{ lang.editnews['news_pupl'] }}
		<div class="panel-head-right">
			<a href="{{ php_self }}?mod=news&action=add" class="btn2" data-placement="top" data-popup="tooltip" data-original-title="{{ lang.addnews['addnews_title'] }}" title="{{ lang.addnews['addnews_title'] }}"><i class="fa fa-plus-circle"></i> {{ lang.addnews['addnews_title'] }}</a>
			<button type="button" class="btn2" data-toggle="collapse" data-target="#collapseNewsFilter" aria-expanded="false" aria-controls="collapseNewsFilter" data-placement="top" data-popup="tooltip" data-original-title="{{ lang['filter'] }}" title="{{ lang['filter'] }}">
				<i class="fa fa-filter"></i>
			</button>
		</div>
		</div>
		<div class="panel-body">
		<div class="table-responsive">
			<table class="table table-sm mb-0">
				<thead>
					<tr>
						<th width="2%" nowrap>{{ lang.editnews['postid_short'] }}</th>
						<th width="12%" nowrap>{{ lang.editnews['date'] }}</th>
						<th width="5%">&nbsp;</th>
						<th width="45%">{{ lang.editnews['title'] }}</th>
							{% if (pluginIsActive('comments')) %}
								{% if flags.comments %}
									<th width="50"><i class="fa fa-comments-o"></i></th>
								{% endif %}
							{% endif %}
						<th width="50"><i class="fa fa-eye"></i></th>
						<th width="6%">{{ lang.editnews['status'] }}</th>
						<th width="25%">{{ lang.editnews['category'] }}</th>
						<th width="10%">{{ lang.editnews['author'] }}</th>
						<th width="2%">
							<input class="check" type="checkbox" name="master_box" title="{{ lang.editnews['select_all'] }}" onclick="javascript:check_uncheck_all(editnews)"/>
						</th>
					</tr>
				</thead>
				<tbody>
					{% for entry in entries %}
						<tr>
							<td style="vertical-align: middle;"><span data-placement="top" data-popup="tooltip" data-original-title="{{ lang.editnews['postid_short'] }}" title="{{ lang.editnews['postid_short'] }}"><b>{{ entry.newsid }}</b></span></td>
							<td style="vertical-align: middle;"><span data-placement="top" data-popup="tooltip" data-original-title="{{ entry.itemdate }}" title="{{ entry.itemdate }}">{{ entry.date|cdate }}</span></td>
							<td style="vertical-align: middle;" nowrap>
								{% if entry.flags.mainpage %}<span data-placement="top" data-popup="tooltip" data-original-title="{{ lang['on_main'] }}" title="{{ lang['on_main'] }}"><i class="fa fa-home"></i></span>{% else %}<span data-placement="top" data-popup="tooltip" data-original-title="{{ lang['off_main'] }}" title="{{ lang['off_main'] }}"><i class="fa fa-home text-danger"></i></span>{% endif %}
								{% if entry.flags.favorite %}<span data-placement="top" data-popup="tooltip" data-original-title="{{ lang['favorite'] }}" title="{{ lang['favorite'] }}"><i class="fa fa-bookmark-o text-dark"></i></span>{% else %}{% endif %}
								{% if (entry.attach_count > 0) %}<span data-placement="top" data-popup="tooltip" data-original-title="{{ lang['attach.count'] }}: {{ entry.attach_count }}" title="{{ lang['attach.count'] }}: {{ entry.attach_count }}"><i class="fa fa-paperclip"></i></span>{% endif %}
								{% if (entry.images_count > 0) %}<span data-placement="top" data-popup="tooltip" data-original-title="{{ lang['images.count'] }}: {{ entry.images_count }}" title="{{ lang['images.count'] }}: {{ entry.images_count }}"><i class="fa fa-images"></i></span>{% endif %}
								{% if entry.flags.fixed %}<span data-placement="top" data-popup="tooltip" data-original-title="{{ lang['on_fixed'] }}" title="{{ lang['on_fixed'] }}"><i class="fa fa-thumb-tack text-dark"></i></span>{% endif %}
							</td>
							<td style="vertical-align: middle;" nowrap>
								{% if entry.flags.editable %}<a href="{{ php_self }}?mod=news&action=edit&id={{ entry.newsid }}">{% endif %}
									{{ entry.title }}
								{% if entry.flags.editable %}</a>{% endif %}
							</td>
							{% if (pluginIsActive('comments')) %}
								{% if entry.flags.comments %}
									<td style="vertical-align: middle;">{% if (entry.comments > 0) %}<span data-placement="top" data-popup="tooltip" data-original-title="{{ lang['commentes'] }}" title="{{ lang['commentes'] }}">{{ entry.comments }}</span>{% else %}-{% endif %}</td>
								{% endif %}
							{% endif %}
							<td style="vertical-align: middle;">
								{% if entry.flags.isActive %}
								<a href="{{ entry.link }}" data-placement="top" data-popup="tooltip" data-original-title="{{ lang['viewes'] }}" title="{{ lang['viewes'] }}" target="_blank">{% endif %}{% if (entry.views > 0) %}{{ entry.views }}{% else %}-{% endif %}{% if entry.flags.isActive %}</a>
								{% endif %}
							</td>
							<td style="vertical-align: middle;" align="center">
								{% if (entry.state == 1) %}
									<span data-placement="top" data-popup="tooltip" data-original-title="{{ lang['state.published'] }}" title="{{ lang['state.published'] }}"><i class="fa fa-check-circle text-success"></i></span>
								{% elseif (entry.state == 0) %}
									<span data-placement="top" data-popup="tooltip" data-original-title="{{ lang['state.unpiblished'] }}" title="{{ lang['state.unpiblished'] }}"><i class="fa fa-ban text-warning"></i></span>
								{% else %}
									<span data-placement="top" data-popup="tooltip" data-original-title="{{ lang['state.draft'] }}" title="{{ lang['state.draft'] }}"><i class="fa fa-times text-danger"></i></span>
								{% endif %}
								{% if (pluginIsActive('comments')) %}
									{% if (entry.com == 2) %}
										<span data-placement="top" data-popup="tooltip" data-original-title="{{ lang['com.unpublished'] }}" title="{{ lang['com.unpublished'] }}"><i class="fa fa-commenting text-muted"></i></span>
									{% elseif (entry.com == 1) %}
										<span data-placement="top" data-popup="tooltip" data-original-title="{{ lang['com.published'] }}" title="{{ lang['com.published'] }}"><i class="fa fa-commenting text-info"></i></span>
									{% elseif (entry.com == 0) %}
										<span data-placement="top" data-popup="tooltip" data-original-title="{{ lang['com.unpiblished'] }}" title="{{ lang['com.unpiblished'] }}"><i class="fa fa-commenting text-warning"></i></span>
									{% endif %}
								{% endif %}
							</td>
							<td style="white-space: inherit;vertical-align: middle;" nowrap>{{ entry.allcats }}</td>
							<td style="vertical-align: middle;">
								<a href="{{ php_self }}?mod=users&action=editForm&id={{ entry.userid }}" data-placement="top" data-popup="tooltip" data-original-title="{{ entry.username }}" title="{{ entry.username }}">{{ entry.username }}</a>
							</td>
							<td style="vertical-align: middle;">
								<input type="checkbox" name="selected_news[]" value="{{ entry.newsid }}" />
							</td>
						</tr>
					{% else %}
						<tr>
							<td colspan="6"><p>- {{ lang.editnews['not_found'] }} -</p></td>
						</tr>
					{% endfor %}
				</tbody>
			</table>
		</div>
		</div>

		<div class="card-footer">
			<div class="row">
				<div class="col-lg-9 mb-2 mb-lg-0">{{ pagesss }}</div>

				<div class="col-lg-3">
					{% if flags.allow_modify %}
					<div class="input-group">
						<!-- {{ lang.editnews['action'] }}: -->
						<select name="subaction" class="custom-select">
							<option value="">-- {{ lang.editnews['action'] }} --</option>
							<option value="mass_approve">{{ lang.editnews['approve'] }}</option>
							<option value="mass_forbidden">{{ lang.editnews['forbidden'] }}</option>
							<option value="" class="bg-light" disabled>===================</option>
							<option value="mass_mainpage">{{ lang.editnews['massmainpage'] }}</option>
							<option value="mass_unmainpage">{{ lang.editnews['massunmainpage'] }}</option>
							<option value="" class="bg-light" disabled>===================</option>
							<option value="mass_currdate">{{ lang.editnews['modify.mass.currdate'] }}</option>
							<option value="" class="bg-light" disabled>===================</option>
							{% if flags.comments %}
								<option value="mass_com_approve">{{ lang.editnews['com_approve'] }}</option>
								<option value="mass_com_forbidden">{{ lang.editnews['com_forbidden'] }}</option>
								<option value="" class="bg-light" disabled>===================</option>
							{% endif %}
							<option value="mass_fixed">{{ lang.editnews['massfixed'] }}</option>
							<option value="mass_unfixed">{{ lang.editnews['massunfixed'] }}</option>
							<option value="" class="bg-light" disabled>===================</option>
							<option value="mass_favorite">{{ lang.editnews['massfavorite'] }}</option>
							<option value="mass_unfavorite">{{ lang.editnews['massunfavorite'] }}</option>
							<option value="" class="bg-light" disabled>===================</option>
							<option value="mass_delete">{{ lang.editnews['delete'] }}</option>
						</select>

						<div class="input-group-append">
							<button type="submit" class="btn btn-outline-warning">{{ lang.editnews['submit'] }}</button>
						</div>
					</div>
					{% endif %}
				</div>
			</div>
		</div>
	</div>
</form>

<script type="text/javascript" src="{{ scriptLibrary }}/ajax.js"></script>
<script type="text/javascript" src="{{ scriptLibrary }}/libsuggest.js"></script>

<script type="text/javascript">
	$('#dr1, #dr2').datetimepicker({
		format: "d.m.Y"
	});

	$(document).ready(function() {
		var aSuggest = new ngSuggest('an',
			{
				'localPrefix': '{{ localPrefix }}',
				'reqMethodName': 'core.users.search',
				'lId': 'loading-layer',
				'hlr': 'true',
				'iMinLen': 1,
				'stCols': 2,
				'stColsClass': ['cleft', 'cright'],
				'stColsHLR': [true, false],
			}
		);
	});
</script>