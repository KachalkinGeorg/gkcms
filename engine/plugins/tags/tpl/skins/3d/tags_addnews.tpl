<input style="width: 300px;display: inline-block;border-bottom-right-radius: 0;border-top-right-radius: 0;" placeholder="Введите тег..." name="tags" id="pTags" />
<br><small>указывается через запятую (,)</small>
<span id="suggestLoader" style="width: 20px; visibility: hidden;"><img src="{{ admin_url }}/plugins/tags/tpl/img/loading.gif" /></span>
<script language="javascript" type="text/javascript">
	// INIT NEW SUGGEST LIBRARY [ call only after full document load ]
	var aSuggest = new ngSuggest('pTags',
		{
			'localPrefix': '{{ localPrefix }}',
			'reqMethodName': 'plugin.tags.suggest',
			'lId': 'suggestLoader',
			'hlr': 'true',
			'iMinLen': 1,
			'stCols': 2,
			'stColsClass': ['cleft', 'cright'],
			'stColsHLR': [true, false],
			'listDelimiter': ',',
		}
	);

</script>