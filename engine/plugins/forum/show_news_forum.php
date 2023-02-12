<?php
/*
=====================================================
 NG FORUM v.alfa
-----------------------------------------------------
 Author: Nail' R. Davydov (ROZARD)
-----------------------------------------------------
 Jabber: ROZARD@ya.ru
 E-mail: ROZARD@list.ru
-----------------------------------------------------
 © Настоящий программист никогда не ставит 
 комментариев. То, что писалось с трудом, должно 
 пониматься с трудом. :))
-----------------------------------------------------
 Данный код защищен авторскими правами
=====================================================
*/
include_once(dirname(__FILE__) . '/includes/rewrite.php');

class ShowForumNewsFilter extends NewsFilter {

    public function showNews($newsID, $SQLnews, &$tvars, $mode = []) {
		global $mysql, $parse;
		
		if (empty($SQLnews['tid'])) {
			$tvars['vars']['topic_forum_mesage'] = '';
			$tvars['vars']['topic_forum_url'] = '';
			$tvars['regx']["'\[topic_show\](.*?)\[/topic_show\]'si"] = '';
			$tvars['regx']["#\[not_topic_show\](.*?)\[/not_topic_show\]#is"] = '$1';
		} else {
			$row1 = $mysql->record('SELECT * FROM ' . prefix . '_forum_topics WHERE id = ' . $SQLnews['tid'] . ' LIMIT 1');
			$row2 = $mysql->record('SELECT * FROM ' . prefix . '_forum_posts WHERE tid = ' . $SQLnews['tid'] . ' LIMIT 1');
			$tvars['regx']["'\[not_topic_show\](.*?)\[/not_topic_show\]'si"] = '';
			$tvars['regx']["'\[topic_show\](.*?)\[/topic_show\]'si"] = '$1';
			$tvars['vars']['topic_forum'] = $row1['title'];
			$tvars['vars']['topic_forum_url'] = link_topic($SQLnews['tid']);
			
			$message = $parse->bbcodes($row2['message']);
			$tvars['vars']['topic_forum_mesage'] = $parse->htmlformatter($message);

		}
		
		if (empty($SQLnews['did'])) {
			$tvars['regx']["'\[discus_show\](.*?)\[/discus_show\]'si"] = '';
			$tvars['vars']['discus_forum_url'] = '';
			$tvars['vars']['discus_forum'] = '';
			$tvars['regx']["#\[not_discus_show\](.*?)\[/not_discus_show\]#is"] = '$1';
		} else {
			$row1 = $mysql->record('SELECT * FROM ' . prefix . '_forum_topics WHERE id = ' . $SQLnews['did'] . ' LIMIT 1');
			//$forum_but2 = (pluginGetVariable('forum', 'forum_but2')) ? (pluginGetVariable('forum', 'forum_but2')) : 'кнопка 2';
			$tvars['regx']["'\[not_discus_show\](.*?)\[/not_discus_show\]'si"] = '';
			$tvars['regx']["'\[discus_show\](.*?)\[/discus_show\]'si"] = '$1';
			$tvars['vars']['discus_forum'] = $row1['title'];
			$tvars['vars']['discus_forum_url'] = link_topic($SQLnews['did']);
		}
		
		
	}
}
			
register_filter('news', 'forum', new ShowForumNewsFilter);