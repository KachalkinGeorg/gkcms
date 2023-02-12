<div id="collapseCommentFilter" class="collapse">
	<div class="card mb-4">
		<div class="card-body">
			<form action="{{ php_self }}" method="get">
			<input type="hidden" name="mod" value="lastcomments" />
			<input type="hidden" name="action" value="list" />
			
			<table class="table table-sm">
				<tr>
					<td width="50%">Кол-во комментариев для отображения на одной странице<small class="form-text text-muted">Значение по умолчанию: <b>5</b></small></td>
					<td width="50%">
						<input type="text" name="perpage" value="{{ perpage }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">Усечение длины комментария<small class="form-text text-muted">Значение по умолчанию: <b>50</b></small></td>
					<td width="50%">
						<input type="text" name="comm_length" value="{{ comm_length }}" class="form-control" />
					</td>
				</tr>
				<tr>
					<td width="50%">Упорядочить по:<small class="form-text text-muted">Выберите порядок отображения комментариев.</small></td>
					<td width="50%">
						<select name="order" style="width: 22%;">{{ order }}</select>
					</td>
				</tr>				
			</table>

						<div class="form-group mb-0 text-right">
							<button type="submit" class="btn btn-outline-primary">{{ lang.sort }}</button>
						</div>
			</form>
		</div>
	</div>
</div>

<form method="post" name="select_comments">
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
						<th width="14%">{{ lang.author }}</th>
						<th width="14%">IP</th>
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
						<td style="vertical-align: middle;">{{ entry.check }} {{ entry.act }}</td>
					</tr>
				{% endfor %}
				</tbody>
			</table>
		</div>			
	</div>

	<div class="card-footer">
		<div class="row">
			<div class="col-lg-10 mb-2 mb-lg-0">
				<nav aria-label="Page navigation example"><ul class="pagination mb-0">{{ pages }}</ul></nav>
			</div>
			<div class="col-lg-2">{{ del }}</div>
		</div>
	</div>
</div>
</form>