<div id="uprofileReplaceForm">
	<table border="0" width="100%" id="table1" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<table border="0" width="100%" id="table2" cellspacing="0" cellpadding="0">
					<tr>
						<td width="100%">&nbsp;<b><font color="#FFFFFF">{l_uprofile:profile_of}
									{user}</font></b>{% if (user.flags.isOwnProfile) %} <b>
							[<a href="#" onclick="ng_uprofile_editCall(); return false;">Редактировать</a></b> ] {% endif %}
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<table border="0" width="100%" id="table4" cellspacing="0" cellpadding="0">
					<tr>
						<td bgcolor="#FFFFFF">
							<table border="0" width="100%">
								<tr>
									<td valign="top" style="text-align: center; padding: 5px;">
										<img src="{avatar}" alt=""/><br/><a href="{photo_link}"><img src="{photo}" alt=""/></a>
									</td>
									<td width="100%" valign="top" style="padding: 5px;">
										<table border="0" width="100%" cellpadding="0" cellspacing="0">
											<tr>
												<td width="40%" style="padding: 5px; background-color: #f9fafb;" class="entry">
													<b>{l_uprofile:status}:</b></td>
												<td width="60%" style="padding: 5px; background-color: #f9fafb;" class="entry">
													{status}
												</td>
											</tr>
											{% if pluginIsActive('pm') %}
											<tr>
												<td width="40%" style="padding: 5px; background-color: #f9fafb;" class="entry">
													<b>Написать:</b></td>
												<td width="60%" style="padding: 5px; background-color: #f9fafb;" class="entry">
													в <a href="/plugin/pm/?action=write&name={{ user.name }}">ЛС</a>
												</td>
											</tr>
											{% endif %}
											<tr>
												<td style="padding: 5px; background-color: #f9fafb;" class="entry"><b>{l_uprofile:regdate}:</b>
												</td>
												<td style="padding: 5px; background-color: #f9fafb;" class="entry">
													{reg}
												</td>
											</tr>
											<tr>
												<td style="padding: 5px;" class="entry"><b>{l_uprofile:last}:</b></td>
												<td style="padding: 5px;" class="entry">{last}</td>
											</tr>
											<tr>
												<td style="padding: 5px; background-color: #f9fafb;" class="entry"><b>{l_uprofile:all_news}:</b>
												</td>
												<td style="padding: 5px; background-color: #f9fafb;" class="entry">
													{news} {% if pluginIsActive('ublog') %}<a href="/plugin/ublog/?uid={id}&uname={name}">просмотреть статьи</a>{% endif %}
												</td>
											</tr>
											<tr>
												<td style="padding: 5px;" class="entry">
													<b>{l_uprofile:alt_name}:</b></td>
												<td style="padding: 5px;" class="entry">{alt_name}</td>
											</tr>
											<tr>
												<td style="padding: 5px;" class="entry">
													<b>{l_uprofile:gender}:</b></td>
												<td style="padding: 5px;" class="entry">{gender}</td>
											</tr>
											<tr>
												<td style="padding: 5px;" class="entry">
													<b>{l_uprofile:all_comments}:</b></td>
												<td style="padding: 5px;" class="entry">{com}</td>
											</tr>
											<tr>
												<td style="padding: 5px; background-color: #f9fafb;" class="entry"><b>{l_uprofile:site}:</b>
												</td>
												<td style="padding: 5px; background-color: #f9fafb;" class="entry">
													<a href="{site}" target="_blank" title="{site}">{site}</a></td>
											</tr>
											<tr>
												<td style="padding: 5px;" class="entry"><b>{l_uprofile:icq}:</b></td>
												<td style="padding: 5px;" class="entry">{icq} &nbsp; &nbsp; {icq}</td>
											</tr>
											<tr>
												<td style="padding: 5px; background-color: #f9fafb;" class="entry"><b>{l_uprofile:from}:</b>
												</td>
												<td style="padding: 5px; background-color: #f9fafb;" class="entry">
													{from}
												</td>
											</tr>
											<tr>
												<td style="padding: 5px;" class="entry"><b>{l_uprofile:about}:</b></td>
												<td style="padding: 5px;" class="entry">{info}</td>
											</tr>
										</table>
										{{ p.xfields.photos.value }}
									</td>
								</tr>
							</table>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>
{% if (user.flags.isOwnProfile) %}
	<script type="text/javascript" language="javascript">
	$(document).ready(function () {

		var ng_uprofile_editCall = (function () {
			$.post('/engine/rpc.php', {
				json: 1,
				methodName: 'plugin.uprofile.editForm',
				rndval: new Date().getTime(),
				params: json_encode({'token': '{{ token }}'})
			}, function (data) {
				// Try to decode incoming data
				try {
					resTX = eval('(' + data + ')');
				} catch (err) {
					alert('Error parsing JSON output. Result: ' + linkTX.response);
				}
				if (!resTX['status']) {
					ngNotifySticker('Error [' + resTX['errorCode'] + ']: ' + resTX['errorText'], {className: 'stickers-danger',sticked: 'true',closeBTN: true,});
				} else {
					$('#uprofileReplaceForm').html(resTX['data']);
				}
			}, "text").error(function () {
				ngNotifySticker('HTTP error during request', {className: 'stickers-danger',sticked: 'true',closeBTN: true,});
			});
	});
	}
	</script>
{% endif %}
