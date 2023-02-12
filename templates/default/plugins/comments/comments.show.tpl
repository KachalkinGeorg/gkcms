<div id="comment_{id}" class="comment" itemscope="" itemtype="http://schema.org/Comment">
	<div class="avatar">
		<div class="num">{comnum}</div>
		{avatar}
	</div>
	<div class="data">
		<div class="info">
			<div class="title author">{line} [profile]<a href="#{author_id}" title="{l_profile}"><span itemprop="author">{author}</span></a>[/profile]
			</div>
			<div class="meta date">{date} | [quote]<a rel="nofollow" onmouseover="copy_quote('{author}');" onclick="quote();return false;" style="cursor: pointer;">Ответить</a>[/quote][if-have-perm]|
				[edit-com]Изменить[/edit-com] | [del-com]Удалить[/del-com][/if-have-perm]
				<div class="modal">
				<div class="modal-close" onclick="this.parentNode.style.display='none';"><i class="fa fa-times-circle fa-2x" aria-hidden="true"></i></div>
				<div style="padding: 22px;">
					<div style="text-align: center;">Удалить комментарий?</div>
					<br>
					Вы действительно хотите удалить комментарий?
					<br><br>
					<div style="text-align: right;">{delcom}</div>
				</div>
				</div>
			</div>


		</div>
		<div class="text">
			{comment-short}[comment_full]<span id="comment_full{comnum}" style="display: none;">{comment-full}</span>
			<p style="text-align: right;"><a href="javascript:ShowOrHide('comment_full{comnum}');">{l_showhide}</a></p>
			[/comment_full]
			[answer]<br/> --------------------------
			<div><i>{l_answer}</i> <b>{name}</b><br/>{answer}</div>
			[/answer]
			[quote]<a onmouseover="copy_quote('{author}');" onclick="quote();return false;" class="quotes">{l_quote}</a>[/quote]
		</div>
	</div>
</div>