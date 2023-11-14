<div id="comment_{id}" class="comment" itemscope="" itemtype="http://schema.org/Comment">
	<div>
		<div>
			<div>
				<div class="avatar">
					{avatar}
				</div>
				<div class="head">
					<div class="num" style="float: right;">#{comnum}</div>
					{line} [profile]<a href="#{author_id}" title="{l_profile}"><span itemprop="author">{author}</span></a>{show_profile}[/profile]<br />
					<div itemprop="dateCreated">{date}</div>
				</div>

				[if-have-perm]
				<ul class="actions">
					[quote]<li><a onmouseover="copy_quote('{author}');" onclick="quote();return false;" style="cursor: pointer;" class="quotes">{l_quote}</a></li>[/quote]
					[quote]<li><a rel="nofollow" onmouseover="copy_quote('{author}');" onclick="quote();return false;" style="cursor: pointer;">Ответить</a></li>[/quote]
					<li>[edit-com]Изменить[/edit-com]</li>
					<li>[del-com]Удалить[/del-com]</li>
				</ul>
				[/if-have-perm]

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
				
				<span itemprop="text">{comment-short}</span>
				[comment_full]
					<span id="comment_full{comnum}" itemprop="text" style="display: none;">{comment-full}</span>
					<p style="text-align: right;"><a href="javascript:ShowOrHide('comment_full{comnum}');">{l_showhide}</a></p>
				[/comment_full]
			
				[answer]
					<br clear="all" /><div class="signature">---------------------------</div><div class="slink">{answer}</div>
					<div><i>{l_answer}</i> <b>{name}</b></div>
				[/answer]
			
				<div class="clr"></div>
			</div>
		</div>
	</div>
</div>