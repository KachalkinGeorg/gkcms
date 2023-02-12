<div class="panel panel-default">
	<div class="panel-heading">{{ lang.ipban['hdr.list'] }}</div>
	<div class="panel-body">
	<div class="table-responsive">
		<table class="table table-sm mb-0">
			<thead>
				<tr>
					<th>{{ lang.ipban['hdr.ip'] }}</th>
					<th>{{ lang.ipban['hdr.counter'] }}</th>
					<th>{{ lang.ipban['hdr.type'] }}</th>
					<th>{{ lang.ipban['hdr.reason'] }}</th>
					<th>&nbsp;</th>
				</tr>
			</thead>

			<tbody>
			{% for entry in entries %}
				<tr>
					<td nowrap>
						{{ entry.ip }} <a href="http://www.nic.ru/whois/?ip={{ entry.whoisip }}" target="_blank"><i class="fa fa-external-link"></i></a>
					</td>
					<td>{{ entry.hitcount }}</td>
					<td>{{ entry.type }}</td>
					<td nowrap>{{ entry.descr }}</td>
					<td class="text-right">
						{% if flags.permModify %}
							<a href="{{ php_self }}?mod=ipban&action=del&id={{ entry.id }}&token={{ token }}" class="btn btn-sm btn-outline-danger" title="{{ lang.ipban['act.unblock'] }}">
								<i class="fa fa-trash"></i>
							</a>
						{% endif %}
					</td>
				</tr>
			{% else %}
				<tr>
					<td colspan="5" class="text-center">---</td>
				</tr>
			{% endfor %}
			</tbody>
		</table>
	</div>
	</div>
</div>

{% if flags.permModify %}
<div class="panel panel-default mt-5">
	<form name="form" method="post" action="{{ php_self }}?mod=ipban">
		<input type="hidden" name="token" value="{{ token }}" />
		<input type="hidden" name="action" value="add" />

		<div class="panel-heading">
			{{ lang.ipban['hdr.block'] }}
			<div class="panel-head-right">
					<button type="button" class="btn2" data-toggle="modal" data-target="#infoModal">
						<i class="fa fa-question"></i>
					</button>
			</div>
		</div>

		<div class="panel-body">
			<div class="form-row mb-3">
				<label class="col-sm-4 col-form-label">{{ lang.ipban['add.ip'] }}</label>
			    <div class="col-sm-8">
		    		<input type="text" name="ip" value="{{ iplock }}" class="form-control" size="31" />
			    </div>
			</div>

			<div class="form-row mb-3">
				<label class="col-sm-4 col-form-label">{{ lang.ipban['add.block.open'] }}</label>
			    <div class="col-sm-8">
					<select name="lock:open" class="custom-select" disabled>
						<option value="0">--</option>
						<option value="1" style="color: blue;">{{ lang.ipban['lock.block'] }}</option>
						<option value="2" style="color: red;">{{ lang.ipban['lock.silent'] }}</option>
					</select>
			    </div>
			</div>

			<div class="form-row mb-3">
				<label class="col-sm-4 col-form-label">{{ lang.ipban['add.block.reg'] }}</label>
			    <div class="col-sm-8">
					<select name="lock:reg" class="custom-select">
						<option value="0">--</option>
						<option value="1" style="color: blue;">{{ lang.ipban['lock.block'] }}</option>
						<option value="2" style="color: red;">{{ lang.ipban['lock.silent'] }}</option>
					</select>
			    </div>
			</div>

			<div class="form-row mb-3">
				<label class="col-sm-4 col-form-label">{{ lang.ipban['add.block.login'] }}</label>
			    <div class="col-sm-8">
					<select name="lock:login" class="custom-select">
						<option value="0">--</option>
						<option value="1" style="color: blue;">{{ lang.ipban['lock.block'] }}</option>
						<option value="2" style="color: red;">{{ lang.ipban['lock.silent'] }}</option>
					</select>
			    </div>
			</div>

			<div class="form-row mb-3">
				<label class="col-sm-4 col-form-label">{{ lang.ipban['add.block.comm'] }}</label>
			    <div class="col-sm-8">
					<select name="lock:comm" class="custom-select">
						<option value="0">--</option>
						<option value="1" style="color: blue;">{{ lang.ipban['lock.block'] }}</option>
						<option value="2" style="color: red;">{{ lang.ipban['lock.silent'] }}</option>
					</select>
			    </div>
			</div>

			<div class="form-row mb-3">
				<label class="col-sm-4 col-form-label">{{ lang.ipban['add.block.rsn'] }}</label>
			    <div class="col-sm-8">
					<input type="text" name="lock:rsn" class="form-control" size="30" />
			    </div>
			</div>
		</div>

		<div class="card-footer text-center">
			<button type="submit" class="btn btn-outline-success">{{ lang.ipban['add.submit'] }}</button>
		</div>
	</form>
</div>

<div id="infoModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="legendModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				{{ lang.ipban['info.descr'] }}
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-secondary" data-dismiss="modal">{{ lang.ipban['cansel'] }}</button>
			</div>
		</div>
	</div>
</div>
{% endif %}