<!-- Filter form: BEGIN -->
<div id="collapseFilesFilter" class="collapse">
	<div class="card mb-4">
	<div class="card-header">{l_filter}</div>
		<div class="card-body">

			<form action="{php_self}" method="get" name="options_bar">
				<input type="hidden" name="mod" value="files" />
				<input type="hidden" name="action" value="list" />
				<input type="hidden" name="area" value="{area}" />

			<table class="table table-sm mb-0">
				<tr>				
					<td width="12px" style="display: inline-flex;">
						<div class="btn-sm btn-default"><input type="checkbox" name="linked_ds" value="0" {ifactiv} class="form-control" style="vertical-align: text-bot;" /></div></td>
					<td><label> - Отобразить только файлы загруженные на сервер в общаю папку</label></td>
				</tr>
			</table>
			
			<table class="table table-sm mb-0">
				<tr>			
					<td><label style="padding: .375rem 0rem .75rem 0rem;">{l_month}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-calendar"></i></label>
							</div>
							<select name="postdate" class="custom-select" style="max-width:220px;">
								<option selected value="">- {l_all} -</option>
								{dateslist}
							</select>
						</div>
					</td>
					<td><label style="padding: .375rem 0rem .75rem 0rem;">{l_category}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-folder-open-o"></i></label>
							</div>
							{dirlistcat}
						</div>
					</td>

					[status]
					<td><label style="padding: .375rem 0rem .75rem 0rem;">{l_author}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-user-o"></i></label>
							</div>
							<select name="author" class="custom-select" style="max-width:220px;">
								<option value="">- {l_all} -</option>
								{authorlist}
							</select>
						</div>
					</td>
					[/status]
					
					<td><label style="padding: .375rem 0rem .75rem 0rem;">{l_per_page}</label></td>
					<td>
						<div class="input-group mb-3">
							<div class="input-group-prepend input-group-append">
								<label class="input-group-text"><i class="fa fa-low-vision"></i></label>
							</div>
							<input type="text" name="npp" value="{npp}" class="form-control" style="max-width:150px;"/>
						</div>
					</td>
				</tr>
			</table>
				
			<div class="panel-footer" align="center" style="margin-left: -20px;margin-right: -20px;margin-bottom: -20px;">
				<button type="submit" class="btn btn-outline-primary">{l_show}</button>
			</div>
			</form>
		</div>
	</div>
</div>

<!-- Mass actions form: BEGIN -->
<form id="delform" name="imagedelete" action="{php_self}?mod=files" method="post">
	<input type="hidden" name="area" value="{area}" />

	<div class="panel panel-default">
		<div class="panel-heading">{l_files}
			<div class="panel-head-right">
				<button type="button" class="btn2" data-toggle="modal" data-target="#uploadnewModal" data-backdrop="static" title="{l_upload_file}"><i class="fa fa-file-text-o"></i> {l_upload_file}</button>
				<button type="button" class="btn2" data-toggle="modal" data-target="#uploadNewByUrlModal" data-backdrop="static" title="{l_upload_file_url}"><i class="fa fa-file-code-o"></i> {l_upload_file_url}</button>
				[status]
				<button type="button" class="btn2" data-toggle="modal" data-target="#categoriesModal" data-backdrop="static" title="{l_categories}">
					<i class="fa fa-folder-open-o"></i>
				</button>
				[/status]
				<button type="button" class="btn2" data-toggle="collapse" data-target="#collapseFilesFilter" title="{l_filter}">
					<i class="fa fa-filter"></i>
				</button>
			</div>
		</div>
		
		<div class="panel-body">
		<div class="table-responsive">
			<table id="entries" class="table table-sm mb-0">
				<thead>
					<tr>
						<th width="5%">#</th>
						<th width="25%">{l_name}</th>
						<th>{l_size}</th>
						<th width="15%">{l_category}</th>
						<th width="10%">{l_author}</th>
						<th>{l_action}</th>
						<th width="5%">
							<input type="checkbox" name="master_box" title="{l_select_all}" onclick="javascript:check_uncheck_all(delform)"/>
						</th>
					</tr>
				</thead>
				<tbody>
					{entries}
				</tbody>
			</table>
		</div>
		</div>

		<div class="card-footer">
			<div class="row">
				<div class="col-lg-6 mb-2 mb-lg-0">{pagesss}</div>

				<div class="col-lg-6">
					[status]
					<div class="input-group">
						<select name="subaction" class="custom-select">
							<option value="">-- {l_action} --</option>
							<option value="delete">{l_delete}</option>
							<option value="move">{l_move}</option>
						</select>

						{dirlist}

						<div class="input-group-append">
							<button type="submit" class="btn btn-outline-warning">{l_done}</button>
						</div>
					</div>
					[/status]
				</div>
			</div>
		</div>
	</div>
</form>


<div id="uploadnewModal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 id="uploadnewModalLabel" class="modal-title">{l_uploadnew}</h5>
				<button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
			</div>

			<form id="uploadnew_form" action="{php_self}?mod=files" method="post" enctype="multipart/form-data" name="sn">
				<input type="hidden" name="subaction" value="upload" />
				<input type="hidden" name="area" value="{area}" />

				<div class="modal-body">
					<div class="form-group row">
						<label class="col-sm-4 col-form-label">{l_category}</label>
						<div class="col-sm-8">{dirlistS}</div>
					</div>

					<div class="form-group row">
						<div class="col-sm-8 offset-4">
							<label class="col-form-label d-block"><input id="flagReplace" type="checkbox" name="replace" value="1" /> {l_do_replace}</label>
							<label class="col-form-label d-block"><input id="flagRand" type="checkbox" name="rand" value="1" /> {l_do_rand}</label>
						</div>
					</div>

					<div class="table-responsive">
						<table id="fileup" class="table table-sm">
							<tbody>
								<tr id="row">
									<td width="10">1:</td>
									<td><input id="fileUploadInput" type="file" name="userfile[0]" /></td>
								</tr>
							</tbody>
						</table>
					</div>

					<div id="showRemoveAddButtoms" class="form-group text-right">
						<div class="btn-group btn-group-sm" role="group">
							<button type="button" onclick="AddFiles();return false;" class="btn btn-outline-success">{l_onemore}</button>
							<button type="button" onclick="RemoveFiles();return false;" class="btn btn-outline-danger">{l_delone}</button>
						</div>
					</div>
				</div>

				<div class="modal-footer text-right">
					<button type="submit" class="btn btn-outline-success">{l_upload}</button>
				</div>
			</form>
		</div>
	</div>
</div>

<div id="uploadNewByUrlModal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 id="uploadnewModalLabel" class="modal-title">{l_upload_file_url}</h5>
				<button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
			</div>

			<form action="{php_self}?mod=files" method="post" name="snup">
				<input type="hidden" name="subaction" value="uploadurl" />
				<input type="hidden" name="area" value="{area}" />

				<div class="modal-body">
					<div class="form-group row">
						<label class="col-sm-4 col-form-label">{l_category}</label>
						<div class="col-sm-8">
							{dirlistS}
						</div>
					</div>

					<div class="form-group row">
						<div class="col-sm-8 offset-sm-4">
							<label class="col-form-label d-block"><input id="replace2" type="checkbox" name="replace" value="1" /> {l_do_replace}</label>
							<label class="col-form-label d-block"><input id="rand2" type="checkbox" name="rand" value="1" /> {l_do_rand}</label>
						</div>
					</div>

					<div class="table-responsive">
						<table id="fileup2" class="table table-sm">
							<tbody>
								<tr id="row">
									<td width="10">1:</td>
									<td><input type="text" name="userurl[0]" class="form-control" /></td>
								</tr>
							</tbody>
						</table>
					</div>

					<div class="form-group text-right">
						<div class="btn-group btn-group-sm" role="group">
							<button type="button" onclick="AddFiles2();return false;" class="btn btn-outline-success">{l_onemore}</button>
							<button type="button" onclick="RemoveFiles2();return false;" class="btn btn-outline-danger">{l_delone}</button>
						</div>
					</div>
				</div>

				<div class="modal-footer text-right">
					<button type="submit" class="btn btn-outline-success">{l_upload}</button>
				</div>
			</form>
		</div>
	</div>
</div>

[status]
<div id="categoriesModal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 id="categoriesModalLabel" class="modal-title">{l_categories}</h5>
				<button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
			</div>

			<div class="modal-body">
				<form action="{php_self}?mod=files" method="post" name="newcat">
					<input type="hidden" name="subaction" value="newcat" />
					<input type="hidden" name="area" value="{area}" />

					<div class="form-group row">
						<label class="col-sm-4 col-form-label">{l_addnewcat}</label>
						<div class="col-sm-8">
							<div class="input-group mb-3">
								<input type="text" name="newfolder" class="form-control" />
								<div class="input-group-append">
									<button type="submit" class="btn btn-outline-success">{l_done}</button>
								</div>
							</div>
						</div>
					</div>
				</form>

				<form action="{php_self}?mod=files" method="post" name="delcat">
					<input type="hidden" name="subaction" value="delcat" />
					<input type="hidden" name="area" value="{area}" />

					<div class="form-group row">
						<label class="col-sm-4 col-form-label">{l_delcat}</label>
						<div class="col-sm-8">
							<div class="input-group mb-3">
								{dirlist}
								<div class="input-group-append">
									<button type="submit" class="btn btn-outline-danger">{l_done}</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
[/status]

<script language="javascript" type="text/javascript">
	function AddFiles() {
		var tbl = document.getElementById('fileup');
		var lastRow = tbl.rows.length;
		var iteration = lastRow + 1;
		var row = tbl.insertRow(lastRow);
		var cellRight = row.insertCell(0);
		cellRight.innerHTML = '<span>' + iteration + ': </span>';

		cellRight = row.insertCell(1);

		var el = document.createElement('input');
		el.setAttribute('type', 'file');
		el.setAttribute('name', 'userfile[' + iteration + ']');
		el.setAttribute('size', '30');
		el.setAttribute('value', iteration);
		cellRight.appendChild(el);
	}

	function RemoveFiles() {
		var tbl = document.getElementById('fileup');
		var lastRow = tbl.rows.length;
		if (lastRow > 1) {
			tbl.deleteRow(lastRow - 1);
		}
	}

	function AddFiles2() {
		var tbl = document.getElementById('fileup2');
		var lastRow = tbl.rows.length;
		var iteration = lastRow + 1;
		var row = tbl.insertRow(lastRow);
		var cellRight = row.insertCell(0);
		cellRight.innerHTML = '<span>' + iteration + ': </span>';

		cellRight = row.insertCell(1);

		var el = document.createElement('input');
		el.setAttribute('type', 'text');
		el.setAttribute('name', 'userurl[' + iteration + ']');
		el.setAttribute('size', '30');
		el.setAttribute('class', 'form-control');
		cellRight.appendChild(el);
		//	document.getElementById('files_number').value = iteration;
	}

	function RemoveFiles2() {
		var tbl = document.getElementById('fileup2');
		var lastRow = tbl.rows.length;
		if (lastRow > 1) {
			tbl.deleteRow(lastRow - 1);
			// document.getElementById('files_number').value =  document.getElementById('files_number').value - 1;
		}
	}
</script>

<!-- BEGIN: Init UPLOADIFY engine -->
<script type="text/javascript">
	$(document).ready(function () {
		$('#delform').on('input', function(event) {
			$(this.elements.category).toggle(
				'move' === $(this.elements.subaction).val()
			);
		})
		.trigger('input');

		$('#uploadnew_form').on('submit', function(event) {
			event.preventDefault();

			$('#uploadnewModal').on('hidden.bs.modal', function (e) {
				document.location = document.location;
			});

			// Prepare script data
			$('#fileUploadInput').uploadifive('upload');
		});

		var uploader = $('#fileUploadInput').uploadifive({
			auto: false,
			uploadScript: '{admin_url}/rpc.php?methodName=admin.files.upload',
			cancelImg: '{skins_url}/images/up_cancel.png',
			folder: '',
			fileExt: '{listExt}',
			fileDesc: '{descExt}',
			sizeLimit: '{maxSize}',
			multi: true,
			buttonText: 'Выбрать файл ...',
			width: 200,
			// 'removeCompleted': true,
			onInit: function () {
				$('#showRemoveAddButtoms').hide();
			},
			onUpload: function(filesToUpload) {
				uploader.data('uploadifive').settings.formData = {
					ngAuthCookie: '{authcookie}',
					uploadType: 'file',
					category: $('#categorySelect').val(),
					rand: $('#flagRand').is(':checked') ? 1 : 0,
					replace: $('#flagReplace').is(':checked') ? 1 : 0
				};
			},
			onUploadComplete: function (fileObj, data) {
				// Response should be in JSON format
				var response = JSON.parse(data);

				fileObj.queueItem.find('.fileinfo')
					.replaceWith(
						response.status
						? '<div class="text-info">' + response.errorText + '</div>'
						: '<div class="text-danger">(' + response.errorCode + ') ' + response.errorText + ' ' + response.errorDescription +'</div>'
					);
			}
		});
	});
</script>
<!-- END: Init UPLOADIFY engine -->