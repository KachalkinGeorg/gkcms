<?php
/*
=====================================================
 Создание тем с админки v 0.01
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
if (!defined('NGCMS'))
	exit('HAL');
include_once(dirname(__FILE__) . '/includes/constants.php');
include_once(dirname(__FILE__) . '/includes/security.php');
include_once(dirname(__FILE__) . '/includes/functions.php');
include_once(dirname(__FILE__) . '/includes/cache.php');

class CreateNewsFilter extends NewsFilter {

	function addNewsForm(&$tvars) {

		global $mysql, $plugin, $twig, $config;
		$tpath = locatePluginTemplates(array('add_show_forum', 'show_forum', 'show_entries'), 'forum', 1, '', 'news');
		$xt = $twig->loadTemplate($tpath['show_entries'] . 'show_entries.tpl');
		$xg = $twig->loadTemplate($tpath['show_forum'] . 'show_forum.tpl');
		$xd = $twig->loadTemplate($tpath['add_show_forum'] . 'add_show_forum.tpl');
		$result = $mysql->select('SELECT * FROM ' . prefix . '_forum_forums ORDER BY position ASC');
		$entries = array();
		foreach ($result as $row_2) {
			if ($row_2['parent'] != 0) {
				$tVars = array(
					'forum_id'   => $row_2['id'],
					'forum_name' => $row_2['title'],
				);
				$entries[$row_2['parent']] .= $xt->render($tVars);
			}
		}
		$output = '';
		foreach ($result as $row) {
			if ($row['parent'] == '0') {
				$tVars = array(
					'forum_name' => $row['title'],
					'entries'    => array(
						'true'  => isset($entries[$row['id']]) ? 1 : 0,
						'print' => isset($entries[$row['id']]) ? $entries[$row['id']] : ''
					),
				);
				$output .= $xg->render($tVars);
			}
		}

		if(pluginGetVariable('forum', 'forum_disc')){
			$tEntryDis[] = array(
				'forum_but2' => (pluginGetVariable('forum', 'forum_but2')) ? (pluginGetVariable('forum', 'forum_but2')) : 'кнопка 2',
			);
		}else{
			$forum_create =  '<br /><label><input type="checkbox" name="create_forum" value="1" class="check" id="mainpage" style="vertical-align: middle;"/> Создать на форуме</label>';
		}
		
		$tVars = array(
			'options_forum' => $output,
			'entries_discus'      => isset($tEntryDis) ? $tEntryDis : '',
			'forum_but1' => (pluginGetVariable('forum', 'forum_but1')) ? (pluginGetVariable('forum', 'forum_but1')) : 'кнопка 1',
			'forum_create' => isset($forum_create) ? $forum_create : '',
		);
		$add_forum = $xd->render($tVars);
		$tvars['add_forum'] = $add_forum;
	}

	function addNews(&$tvars, &$SQL) {

		if (isset($_REQUEST['create_forum']) && $_REQUEST['create_forum']) {
			$forum_id = intval($_REQUEST['forum_id']);
			if (empty($forum_id))
				return false;
			else
				return true;
		}
		
		return true;
	}

	function addNewsNotify(&$tvars, $SQL, $newsid) {

		global $mysql, $userROW, $config, $ip;
		if (isset($_REQUEST['create_forum']) && $_REQUEST['create_forum']) {
			$subject = secureinput($_REQUEST['title']);
			$message = isset($_REQUEST['ng_news_content']) ? secureinput($_REQUEST['ng_news_content']) : secureinput($_REQUEST['ng_news_content_short']);
			$id = intval($_REQUEST['forum_id']);
			$time = time() + ($config['date_adjust'] * 60);
			$mysql->query('insert into ' . prefix . '_forum_topics (
					author,
					author_id,
					title,
					c_data,
					l_date,
					l_author_id,
					l_author,
					fid
				)values(
					' . securemysql($userROW['name']) . ', 
					' . securemysql($userROW['id']) . ', 
					' . securemysql($subject) . ', 
					' . securemysql($time) . ', 
					' . securemysql($time) . ', 
					' . securemysql($userROW['id']) . ', 
					' . securemysql($userROW['name']) . ', 
					' . securemysql($id) . '
				)
			');
			$topic_id = $mysql->lastid('forum_topics');
			$mysql->query('insert into ' . prefix . '_forum_posts (
					author, 
					author_id, 
					author_ip, 
					message, 
					c_data, 
					tid
				)values(
					' . securemysql($userROW['name']) . ', 
					' . securemysql($userROW['id']) . ', 
					' . securemysql($ip) . ', 
					' . securemysql($message) . ', 
					' . securemysql($time) . ', 
					' . securemysql($topic_id) . '
				)
			');
			$post_id = $mysql->lastid('forum_posts');
			if($_REQUEST['create_forum'] == '1'){
				$forum = 'tid = ' . intval($topic_id) . '';
			}
			if($_REQUEST['create_forum'] == '2'){
				$forum = 'did = ' . intval($topic_id) . '';
			}
			$mysql->query('UPDATE ' . prefix . '_news SET ' . $forum . ' WHERE id = ' . securemysql($newsid) . ' LIMIT 1');
			update_forum($topic_id, $subject, 1, $time, $post_id, $userROW['name'], $userROW['id'], $id);
			$mysql->query('UPDATE ' . prefix . '_forum_topics SET l_post = ' . securemysql($post_id) . ' WHERE id = ' . securemysql($topic_id) . ' LIMIT 1');
			$mysql->query('UPDATE ' . prefix . '_users SET int_post = int_post + 1, l_post = ' . securemysql($time) . ' WHERE id = ' . securemysql($userROW['id']) . ' LIMIT 1');
			generate_index_cache(true);
			generate_statistics_cache(true);
		}

	}

	function editNewsForm($newsID, $SQLold, &$tvars) {

		global $mysql, $plugin, $twig, $config;

		$tpath = locatePluginTemplates('edit_show_forum', 'forum', 1, '', 'news');
		$xt = $twig->loadTemplate($tpath['edit_show_forum'] . 'edit_show_forum.tpl');
		
		$frow = $mysql->record("select * from " . prefix . "_news where id = " . $newsID);

		$forrow = $mysql->record('SELECT * FROM ' . prefix . '_forum_topics WHERE id = ' . $frow['tid']);
		$fodrow = $mysql->record('SELECT * FROM ' . prefix . '_forum_topics WHERE id = ' . $frow['did']);
		
		if(pluginGetVariable('forum', 'forum_disc')){
		$tEntryDis[] = array(
			'forum_did' => $fodrow['id'],
			'forum_discus' => $fodrow['title'],
			'forum_but2' => (pluginGetVariable('forum', 'forum_but2')) ? (pluginGetVariable('forum', 'forum_but2')) : 'кнопка 2',
		);
		}
		$tVars = array(
			'entries_discus'      => isset($tEntryDis) ? $tEntryDis : '',
			'forum_tid' => $forrow['id'],
			'forum_topic' => $forrow['title'],
			'forum_but1' => (pluginGetVariable('forum', 'forum_but1')) ? (pluginGetVariable('forum', 'forum_but1')) : 'кнопка 1',
			
		);
		$edit_forum = $xt->render($tVars);
		$tvars['edit_forum'] = $edit_forum;
	}

	function editNews($newsID, $SQLold, &$SQLnew, &$tvars) {
		global $mysql;

		$forum_tid = isset($_REQUEST['tid'])?secure_html($_REQUEST['tid']):'';
		$forum_did = isset($_REQUEST['did'])?secure_html($_REQUEST['did']):'';
		
		$mysql->query("update " . prefix . "_news set tid = " . intval($forum_tid) . " where id = " . intval($newsID));
		$mysql->query("update " . prefix . "_news set did = " . intval($forum_did) . " where id = " . intval($newsID));

		return true;
	}
}

register_filter('news', 'forum', new CreateNewsFilter);