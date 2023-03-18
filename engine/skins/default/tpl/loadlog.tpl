<script type="text/javascript" src="{{ scriptLibrary }}/highcharts.js"></script>

<div id="collapseLoadLogFilter" class="collapse">
	<div class="card mb-4">
	<div class="card-header">{{ lang['filter'] }}</div>
		<div class="card-body">
		<form action="{{ php_self }}" method="get">
			<input type="hidden" name="mod" value="loadlog" />
	
			<table class="table table-sm mb-0">
				<tr>				
					<td><label style="padding: .375rem 0rem .75rem 0rem;">{{ lang['date'] }}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-calendar"></i></label>
								<label class="input-group-text">с</label>
							</div>
							<input type="text" id="dr1" name="dr1" value="{{fDateStart}}" pattern="[0-9]{2}\.[0-9]{2}\.[0-9]{4}" placeholder="{{ "now" | date('d.m.Y') }}" autocomplete="off" style="max-width:188px;">
							<div class="input-group-prepend">
								<span class="input-group-text">по</span>
							</div>
							<input type="text" id="dr2" name="dr2" value="{{fDateEnd}}" pattern="[0-9]{2}\.[0-9]{2}\.[0-9]{4}" placeholder="{{ "now" | date('d.m.Y') }}" autocomplete="off" style="max-width:220px;">
						</div>
					</td>

					<td><label style="padding: .375rem 0rem .75rem 0rem;">{{ lang['per_page'] }}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-low-vision"></i></label>
							</div>
							<input type="number" name="rpp" value="{{ rpp }}" placeholder="{{ lang['per_page'] }}..." class="form-control" style="max-width:220px;"/>
						</div>
					</td>
				</tr>
			</table>

			<div class="panel-footer" align="center" style="margin-left: -20px;margin-right: -20px;margin-bottom: -20px;">
				<button type="submit" class="btn btn-outline-primary">{{ lang['sortit'] }}</button>
			</div>
			</form>
		</div>
	</div>
</div>

<div class="panel panel-default">
  <div class="panel-heading">
  {{ lang['load_log'] }}
		<div class="panel-head-right">
			<button type="button" class="btn2" data-toggle="collapse" data-target="#collapseLoadLogFilter" aria-expanded="false" aria-controls="collapseLoadLogFilter" title="{{ lang['filter'] }}">
				<i class="fa fa-filter"></i>
			</button>
		</div>
  </div>
	<div class="panel-body">
		<div class="card">
			<div id="container" style="height: 350px;padding: 16px 11px 0 9px"></div>
		</div>
	</div>
</div>
<script>
Highcharts.chart('container', {
	colors: ['#ddd', '#ce7e00'],
		chart: {
			type: 'areaspline'
		},
		title: {
			text: ''
		},
		legend: {
			layout: 'vertical',
			align: 'left',
			verticalAlign: 'top',
			x: 100,
			y: 50,
			floating: true,
			borderWidth: 1,
			backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
		},
		xAxis: {
			categories: [{{ array_day }}],
		},
		yAxis: {
			title: {
				text: ''
			}
		},
		tooltip: {
			shared: true,
			valueSuffix: ''
		},
		credits: {
			enabled: false
		},
		plotOptions: {
			areaspline: {
				fillOpacity: 0.5
			}
		},
		series: [{
			name: 'hit_core',
			color: "#0c343d",
			data: [{{ hit_core }}]
		}, {
			name: 'hit_plugin',
			color: "#244850",
			data: [{{ hit_plugin }}]
		}, {
			name: 'hit_ppage',
			color: "#9dadb1",
			data: [{{ hit_ppage }}]
		}, {
			name: 'exec_core',
			color: "#FF404E",
			data: [{{ exec_core }}]
		}, {
			name: 'exec_plugin',
			color: "#ff8c94",
			data: [{{ exec_plugin }}]
		}, {
			name: 'exec_ppage',
			color: "#ffd8db",
			data: [{{ exec_ppage }}]
		}]
});
</script>
<script type="text/javascript">
	$('#dr1, #dr2').datetimepicker({
		format: "d.m.Y"
	});
</script>