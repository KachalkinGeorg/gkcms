<table border="0" width="100%" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" width="100%" cellspacing="0" cellpadding="0">

						<font color="#FFFFFF"><b>&nbsp;Популярные</b></font></td>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table border="0" width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td bgcolor="#FFFFFF">
						<ul>
							{% for entry in entries %}
								{{ entry }}
							{% endfor %}
						</ul>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>