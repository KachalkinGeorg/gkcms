<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: lastcomments.php
// Description: Комментарии пользователей
// Author: NGCMS Development Team
//

// Protect against hack attempts
if (!defined('NGCMS')) {
    exit('HAL');
}

$lang = LoadLang('lastcomments', 'admin');

$breadcrumb = breadcrumb('<i class="fa fa-commenting-o btn-position"></i><span class="text-semibold">'.$lang['lastcomments'].'</span>', '<i class="fa fa-commenting-o btn-position"></i>'.$lang['last_comments'].'' );

if (!getPluginStatusActive('comments')) {
	msg(['type' => 'error', 'text' => $lang['w_comm']]);
	return print_msg( 'warning', $lang['lastcomments'], $lang['w_com'], 'javascript:history.go(-1)' );
}

if ($_REQUEST['action'] == 'delete') {

    $selected_com = getIsSet($_REQUEST['selected_com']);
    if (!$selected_com || !is_array($selected_com)) {
        msg(['type' => 'error', 'text' => $lang['msge_select']]);
		print_msg( 'error', $lang['lastcomments'], $lang['msge_select'], '?mod=lastcomments' );

        return;
    }
	
    $db = NGEngine::getInstance()->getDB();
    foreach ($selected_com as $query) {
		
		$db->exec("DELETE FROM ".prefix."_comments WHERE `id` = " . db_squote($query));
		foreach ($mysql->select("select n.id, count(c.id) as cid from ".prefix."_news n left join ".prefix."_comments c on c.post=n.id group by n.id") as $row) {
			$db->exec("update ".prefix."_news set com=".$row['cid']." where id = ".$row['id']);
		}

		// Обновляем счетчик постов у юзеров
		foreach ($mysql->select("select author_id, count(*) as cnt from ".prefix."_news group by author_id") as $row) {
			$db->exec("update ".uprefix."_users set news=".$row['cnt']." where id = ".$row['author_id']);
		}
	
		foreach ($mysql->select("select n.id, count(c.id) as cid from ".prefix."_news n left join ".prefix."_comments c on c.post=n.id group by n.id") as $row) {
			$db->exec("update ".prefix."_news set com=".$row['cid']." where id = ".$row['id']);
		}

		// Обновляем счетчик комментариев у юзеров
		foreach ($mysql->select("select author_id, count(*) as cnt from ".prefix."_comments group by author_id") as $row) {
			$db->exec("update ".uprefix."_users set com=".$row['cnt']." where id = ".$row['author_id']);
		}
    }
	
    msg(['type' => 'info', 'text' => $lang['msgo_deleted']]);
	return print_msg( 'delete', $lang['lastcomments'], ''.$lang['msgo_deleted'].'', '?mod=lastcomments' );

}

	//$perpage = extra_get_param('show_comments', 'perpage');
	$perpage = $_REQUEST['perpage'];
	if ($perpage == '') {
		$perpage = "5";
	}
	//$order = extra_get_param('show_comments', 'order');
	$order = $_REQUEST['order'];
	if ($order == 'desc') {
		$order = "DESC";
	} elseif ($order == 'asc') {
		$order = "ASC";
	} else {
		$order = "ASC";
	}
	//$comm_length = extra_get_param('show_comments', 'comm_length');
	$comm_length = $_REQUEST['comm_length'];
	if (($comm_length < 10) || ($comm_length > 5000)) {
		$comm_length = 50;
	}
	
	// Выбираем из БД общее количество записей
	$query = "SELECT COUNT(*) as cnt FROM " . prefix . "_comments";
	$res = $mysql->record($query, 1);
	$total = $res['cnt'];
	// Проверяем передан ли номер текущей страницы
	if (isset($_GET['page'])) {
		$page = (int)$_GET['page'];
		if ($page < 1) $page = 1;
	} else {
		$page = 1;
	}
	// Сколько всего получится страниц
	$cnt_pages = ceil($total / $perpage);
	if ($page > $cnt_pages) $page = $cnt_pages;
	// Начальная позиция
	$start = ($page - 1) * $perpage;
	if ($start < 0) {
		$start = 0;
	}
	
	$query = "select c.id, c.postdate, c.author, c.author_id, c.mail, c.text, c.ip, n.id as nid, n.title, n.alt_name, n.catid, n.postdate as npostdate from " . prefix . "_comments c left join " . prefix . "_news n on c.post=n.id where n.approve=1 order by c.id " . $order . " limit " . $start . ", " . $perpage;
	$result = $mysql->select($query);

	foreach ($result as $prd) {
		$text = $prd['text'];
		if ($config['blocks_for_reg']) {
			$text = $parse->userblocks($text);
		}
		if ($config['use_bbcodes']) {
			$text = $parse->bbcodes($text);
		}
		if ($config['use_htmlformatter']) {
			$text = $parse->htmlformatter($text);
		}
		if ($config['use_smilies']) {
			$text = $parse->smilies($text);
		}
		if (strlen($text) > $comm_length) {
			$text = $parse->truncateHTML($text, $comm_length);
		}
		if ($prd['author_id'] && getPluginStatusActive('uprofile')) {
			$author_link = checkLinkAvailable('uprofile', 'show') ?
				generateLink('uprofile', 'show', array('name' => $prd['author'], 'id' => $prd['author_id'])) :
				generateLink('core', 'plugin', array('plugin' => 'uprofile', 'handler' => 'show'), array('id' => $prd['author_id']));
			$tvars['regx']["'\[profile\](.*?)\[/profile\]'si"] = '$1';
		} else {
			$author_link = '';
		}

		$data =  langdate('d.m.Y H:i:s', $prd['postdate']);
		$com = '' . $text . '';
		$news = '<a href="' . newsGenerateLink(array('id' => $prd['nid'], 'alt_name' => $prd['alt_name'], 'catid' => $prd['catid'], 'postdate' => $prd['npostdate'])) . '" data-placement="left" data-popup="tooltip" data-original-title="'.$lang['open_news'].'" title="'.$lang['open_news'].'" target="_blank">' . str_replace('<', '&lt;', $prd['title']) . '</a> <a href="?mod=news&action=edit&id=' . $prd['nid'] . '" data-placement="left" data-popup="tooltip" data-original-title="'.$lang['edit'].'" title="'.$lang['edit'].'" target="_blank"><i class="fa fa-pencil-square"></i></a>';
		if ($prd['author_id']) {
			$author = '<a href="?mod=users&action=editForm&id=' . $prd['author_id'] . '" data-placement="left" data-popup="tooltip" data-original-title="'.$lang['edit'].'" title="'.$lang['edit'].'" target="_blank">' . str_replace('<', '&lt;', $prd['author']) . '</a><br/><small><a href="mailto:' . $prd['mail'] . '">' . $prd['mail'] . '</a></small>';
		} else {
			$author = '' . str_replace('<', '&lt;', $prd['author']) . '<br/><small><a href="mailto:' . $prd['mail'] . '">' . $prd['mail'] . '</a></small>';
		}
		$ip = '[' . $prd['ip'] . '] - <a href="?mod=ipban&iplock=' . $prd['ip'] . '" data-placement="left" data-popup="tooltip" data-original-title="'.$lang['ipban'].'" title="'.$lang['ipban'].'' . $prd['ip'] . '" target="_blank"><i class="fa fa-ban"></i></a> <a href="http://www.nic.ru/whois/?ip=' . $prd['ip'] . '" data-placement="left" data-popup="tooltip" data-original-title="'.$lang['ipwhois'].'" title="'.$lang['ipwhois'].'' . $prd['ip'] . '" target="_blank"><i class="fa fa-question-circle"></i></a>';
		$act = '<a class="btn btn-outline-primary" href="?mod=editcomments&newsid=' . $prd['nid'] . '&comid=' . $prd['id'] . '" data-placement="left" data-popup="tooltip" data-original-title="'.$lang['edit'].'" title="'.$lang['edit'].'" target="_blank"><i class="fa fa-pencil-square-o"></i></a> <a class="btn btn-outline-danger" href="?mod=editcomments&subaction=deletecomment&newsid=' . $prd['nid'] . '&comid=' . $prd['id'] . '&poster=' . $prd['author'] . '" data-placement="left" data-popup="tooltip" data-original-title="'.$lang['del'].'" title="'.$lang['del'].'"><i class="fa fa-trash" style="color: red;"></i></a>';

        $tEntry[] = [
            'id'   	 => $prd['id'],
			'date'   => $data,
			'com'    => $com,
			'news'   => $news,
			'author' => $author,
			'ip'     => $ip,
			'act'    => $act,
        ];
		
	}

    $pagesss = generateAdminPagelist([
        'current' => $page,
        'count'   => $cnt_pages,
        'url'     => '?mod=lastcomments'.
			(isset($_REQUEST['order']) && $_REQUEST['order'] ? '&order=' . $_REQUEST['order'] : '').
			(isset($_REQUEST['perpage']) && $_REQUEST['perpage'] ? '&perpage='.intval($_REQUEST['perpage']) : '').
			(isset($_REQUEST['comm_length']) && $_REQUEST['comm_length'] ? '&comm_length='.intval($_REQUEST['comm_length']) : '').
            '&page=%page%',
    ]);
	
	$orderes = '<option value="asc" ' . (empty($order) ? 'selected' : '') . '>'.$lang['order_asc'].'</option><option value="desc" ' . (!empty($order) ? 'selected' : '') . '>'.$lang['order_desc'].'</option>';
		
	$tVars = [
		'php_self' 	=> $PHP_SELF,
		'entries' => isset($tEntry) ? $tEntry : '',
		'perpage'   => $perpage,
		'order'   	=> $orderes,
		'comm_length'   => $comm_length,
		'pagesss' => $pagesss,
	];

$xt = $twig->loadTemplate('skins/default/tpl/lastcomments.tpl');
$main_admin = $xt->render($tVars);