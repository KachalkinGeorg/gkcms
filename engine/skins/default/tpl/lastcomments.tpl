<div id="collapseCommentFilter" class="collapse">
	<div class="card mb-4">
	<div class="card-header">{{ lang['filter'] }}</div>
		<div class="card-body">
			<form action="{{ php_self }}" method="get">
			<input type="hidden" name="mod" value="lastcomments" />
			<input type="hidden" name="action" value="list" />
			
			<table class="table table-sm mb-0">
				<tr>
					<td><label style="padding: .375rem 0rem .75rem 0rem;">{{ lang['count_com'] }}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-scissors"></i></label>
							</div>
							<input type="number" name="comm_length" value="{{ comm_length }}" placeholder="{{ lang['length'] }}..." class="form-control" style="max-width:100px;text-align: center;"/>
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-commenting"></i></label>
							</div>
						</div>
					</td>
					<td><label style="padding: .375rem 0rem .75rem 0rem;">{{ lang['commet'] }}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-low-vision"></i></label>
							</div>
							<input type="number" name="perpage" value="{{ perpage }}" placeholder="{{ lang['commet'] }}..." class="form-control" style="max-width:150px;"/>
						</div>
					</td>
					<td><label style="padding: .375rem 0rem .75rem 0rem;">{{ lang['sort_by'] }}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-list-ol"></i></label>
							</div>
							<select name="order" style="width: 22%;">{{ order }}</select>
						</div>
					</td>
				</tr>				
			</table>

			<div class="panel-footer" align="center" style="margin-left: -20px;margin-right: -20px;margin-bottom: -20px;">
				<button type="submit" class="btn btn-outline-primary">{{ lang['sort'] }}</button>
			</div>
			</form>
		</div>
	</div>
</div>

<form action="?mod=lastcomments&action=delete" method="post" name="select_comments">
<div class="panel panel-default">
  <div class="panel-heading">
 {{ lang.lastcomments }}
		<div class="panel-head-right">
			<button type="button" class="btn2" data-toggle="collapse" data-target="#collapseCommentFilter" aria-expanded="false" aria-controls="collapseCommentFilter" title="{{ lang.filtr }}">
				<i class="fa fa-filter"></i>
			</button>
		</div>
  </div>
	<div class="panel-body">
		<div class="table-responsive">
			<table class="table table-sm mb-0">
				<thead>
					<tr>
						<th width="12%">{{ lang.date }}</th>
						<th width="30%">{{ lang.com }}</th>
						<th width="20%" nowrap>{{ lang.news }}</th>
						<th width="15%">{{ lang.author }}</th>
						<th width="15%">IP</th>
						<th width="10%" align="center">{{ lang.action }}</th>
						<th width="5%" align="center">
							<input type="checkbox" name="master_box" title="{{ lang.all_select }}" onclick="javascript:check_uncheck_all(select_comments)">
						</th>
					</tr>
				</thead>
				<tbody>
				{% for entry in entries %}
					<tr>
						<td>{{ entry.date }}</td>
						<td>{{ entry.com }}</td>
						<td>{{ entry.news }}</td>
						<td>{{ entry.author }}</td>
						<td>{{ entry.ip }}</td>
						<td style="vertical-align: middle;">
							<div class="btn-group btn-group-sm" role="group">
							{{ entry.act }}
							</div>
						</td>
						<td style="vertical-align: middle;">
							<div class="btn-group btn-group-sm" role="group">
							<input style="vertical-align: middle;" type="checkbox" name="selected_com[]" value="{{ entry.id }}">
							</div>
						</td>
					</tr>
				{% else %}
						<tr>
							<td colspan="6"><p>- {{ lang.head_pm_no }} -</p></td>
						</tr>
				{% endfor %}
				</tbody>
			</table>
		</div>			
	</div>

	<div class="card-footer">
		<div class="row">
			<div class="col-lg-10 mb-2 mb-lg-0">
			{% if pagesss %}
				<div class="col col-md-4">{{ pagesss }}</div>
			{% endif %}
			</div>
			<div class="col-lg-2 text-right"><input class="btn btn-danger" type="submit" value="{{ lang.del }}"></div>
		</div>
	</div>
</div>
</form>