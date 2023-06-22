<div class="panel panel-default">
  <div class="panel-heading">
     {{ lang.list_pm }}
	 <div class="panel-head-right">
		<i class="fa fa-paper-plane"></i> <a href="?mod=pm&action=write" class="btn2">{{ lang.write }}</a>
	 </div>
  </div>
<form action="?mod=pm&action=delete" method="post" name="form">
	<input type="hidden" name="token" value="{{ token }}">
	<div class="panel-body">

		<div class="table-responsive">
			<table class="table table-sm mb-0">
				<thead>
					<tr>
						<th width="15%">{{ lang.pmdate }}</th>
						<th width="15%"><center>{{ lang.pmtime }}</center></th>
						<th width="40%">{{ lang.title }}</th>
						<th nowrap>{{ lang.from }}</th>
						<th width="15%"><center>{{ lang.status }}</center></th>
						<th width="5%">
							<input type="checkbox" name="master_box" title="{{ lang.select_all }}" onclick="javascript:check_uncheck_all(form)">
						</th>
					</tr>
				</thead>
				<tbody>
				{% for entry in entries %}
					<tr>
						<td>{{ entry.date }}</td>
						<td><center>{{ entry.time }}</center></td>
						<td><a href="?mod=pm&action=read&pmid={{ entry.id }}&token={{ token }}" data-placement="left" data-popup="tooltip" data-original-title="{{ entry.subject }}">{{ entry.subject }}</a></td>
						<td nowrap>{% if entry.flags.haveSender %}<a href="{{ entry.senderProfileURL }}" data-placement="left" data-popup="tooltip" data-original-title="{{ entry.senderName }}">{{ entry.senderName }}</a>{% else %}{{ entry.senderName }}{% endif %}</td>
						<td><center>{% if entry.flags.viewed %}<span data-placement="left" data-popup="tooltip" data-original-title="{{ lang.viewed }}" title="{{ lang.viewed }}"><i class="fa fa-eye text-success"></i></span>{% else %}<span data-placement="left" data-popup="tooltip" data-original-title="{{ lang.unviewed }}" title="{{ lang.unviewed }}"><i class="fa fa-low-vision text-warning"></i></span>{% endif %}</center></td>
						<td><input type="checkbox" name="selected_pm[]" value="{{ entry.id }}" /></td>
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
	<div class="card-footer text-right">
		<button type="submit" class="btn btn-outline-danger">{{ lang.delete }}</button>
	</div>
</form>
</div>