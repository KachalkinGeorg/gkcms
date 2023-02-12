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

$breadcrumb = breadcrumb('<i class="fa fa-commenting-o btn-position"></i><span class="text-semibold">'.$lang['lastcomments'].'</span>', ''.$lang['last_comments'].'' );

if (!getPluginStatusActive('comments')) {
	msg(['type' => 'error', 'text' => $lang['w_comm']]);
	return print_msg( 'warning', $lang['lastcomments'], $lang['w_com'], '?mod=lastcomments' );
}

if ($_REQUEST['action'] == 'commit') {
	$perpage = $_REQUEST['perpage'];
	$order = $_REQUEST['order'];
	$comm_length = $_REQUEST['comm_length'];
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
	// Выводим "шапку" таблицы

	foreach ($result as $prd) {
		// Parse comments
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
		$news = '<a href="' . newsGenerateLink(array('id' => $prd['nid'], 'alt_name' => $prd['alt_name'], 'catid' => $prd['catid'], 'postdate' => $prd['npostdate'])) . '" target="_blank">' . str_replace('<', '&lt;', $prd['title']) . '</a> <a href="/engine/admin.php?mod=news&action=edit&id=' . $prd['nid'] . '" title="'.$lang['edit'].'" target="_blank"><i class="fa fa-pencil-square"></i></a>';
		if ($prd['author_id']) {
			$author = '<a href="/engine/admin.php?mod=users&action=editForm&id=' . $prd['author_id'] . '" target="_blank">' . str_replace('<', '&lt;', $prd['author']) . '</a><br/><small><a href="mailto:' . $prd['mail'] . '">' . $prd['mail'] . '</a></small>';
		} else {
			$author = '' . str_replace('<', '&lt;', $prd['author']) . '<br/><small><a href="mailto:' . $prd['mail'] . '">' . $prd['mail'] . '</a></small>';
		}
		$ip = '[' . $prd['ip'] . '] - <a href="/engine/admin.php?mod=ipban&iplock=' . $prd['ip'] . '" title="'.$lang['ipban'].'' . $prd['ip'] . '" target="_blank"><i class="fa fa-ban"></i></a> <a href="http://www.nic.ru/whois/?ip=' . $prd['ip'] . '" title="'.$lang['ipwhois'].'' . $prd['ip'] . '" target="_blank"><i class="fa fa-question-circle"></i></a>';
		$check = '<input style="vertical-align: middle;" type="checkbox" name="type[]" value="' . $prd['id'] . '">';
		$act = '<a style="vertical-align: middle;" href="/engine/admin.php?mod=editcomments&newsid=' . $prd['nid'] . '&comid=' . $prd['id'] . '" title="'.$lang['edit'].'" target="_blank"><i class="fa fa-pencil-square-o"></i></a> <a style="vertical-align: middle;" href="/engine/admin.php?mod=editcomments&subaction=deletecomment&newsid=' . $prd['nid'] . '&comid=' . $prd['id'] . '&poster=' . $prd['author'] . '" title="'.$lang['del'].'"><i class="fa fa-trash" style="color: red;"></i></a>';

        $tEntry = [
            'date'   => $data,
			'com'    => $com,
			'news'   => $news,
			'author' => $author,
			'ip'     => $ip,
			'check'  => $check,
			'act'    => $act,
        ];
		
		$entries[] = $tEntry;
	}

	$type = $_POST['type'];
	if (!empty($type)) {
		// Начинаем формировать переменную, содержащую список
		// в формате "(3,5,6,7)"
		$query = "(";
		foreach ($type as $val) $query .= "$val,";
		// Удаляем последнюю запятую, заменяя её закрывающей скобкой )
		$query = substr($query, 0, strlen($query) - 1) . ")";
		// Завершаем формирование SQL-запроса на удаление
		$query = "DELETE FROM " . prefix . "_comments WHERE id IN " . $query;
		return print_msg( 'delete', $lang['lastcomments'], ''.$lang['com_del'].'', '?mod=lastcomments' );
		// Выполняем запрос
		if (!$mysql->query($query)) {
			//$pages .=  "<br>" . $mysql->db_error() . "<br>";
			//$pages .=  $query . "<br>";
		} else {
			foreach ($mysql->select("select n.id, count(c.id) as cid from " . prefix . "_news n left join " . prefix . "_comments c on c.post=n.id group by n.id") as $row) {
				$mysql->query("update " . prefix . "_news set com=" . $row['cid'] . " where id = " . $row['id']);
			}
			// Обновляем счетчик постов у юзеров
			foreach ($mysql->select("select author_id, count(*) as cnt from " . prefix . "_news group by author_id") as $row) {
				$mysql->query("update " . uprefix . "_users set news=" . $row['cnt'] . " where id = " . $row['author_id']);
			}
			foreach ($mysql->select("select n.id, count(c.id) as cid from " . prefix . "_news n left join " . prefix . "_comments c on c.post=n.id group by n.id") as $row) {
				$mysql->query("update " . prefix . "_news set com=" . $row['cid'] . " where id = " . $row['id']);
			}
			// Обновляем счетчик комментариев у юзеров
			foreach ($mysql->select("select author_id, count(*) as cnt from " . prefix . "_comments group by author_id") as $row) {
				$mysql->query("update " . uprefix . "_users set com=" . $row['cnt'] . " where id = " . $row['author_id']);
			}
			//$pages .=  "<META HTTP-EQUIV='Refresh' Content='0'>";
		}
	}
	$uri = strtok(''.$_SERVER['REQUEST_URI'].'', "&") . "&";
	if (count($_GET)) {
		foreach ($_GET as $k => $v) {
			if ($k != "page") $uri .= urlencode($k) . "=" . urlencode($v) . "&";
		}
	}
	// Строим постраничную навигацию
	if ($cnt_pages > 1) {
		//   echo '<div style="margin:1em 0">&nbsp;Страницы:';
		// Проверяем нужна ли стрелка "В начало"
		if ($page > 3)
			$startpage = '<li class="page-item"><a class="page-link" href="' . $uri . 'page=1">'.$lang['startpage'].'</a></li>';
		else
			$startpage = '';
		// Проверяем нужна ли стрелка "В конец"
		if ($page < ($cnt_pages - 2))
			$endpage = '<li class="page-item"><a class="page-link" href="' . $uri . 'page=' . $cnt_pages . '">'.$lang['endpage'].'</a></li>';
		else
			$endpage = '';
		// Находим две ближайшие станицы с обоих краев, если они есть
		if ($page - 2 > 0)
			$page2left = '<li class="page-item"><a class="page-link" href="' . $uri . 'page=' . ($page - 2) . '">' . ($page - 2) . '</a></li>';
		else
			$page2left = '';
		if ($page - 1 > 0)
			$page1left = '<li class="page-item"><a class="page-link" href="' . $uri . 'page=' . ($page - 1) . '">' . ($page - 1) . '</a></li>';
		else
			$page1left = '';
		if ($page + 2 <= $cnt_pages)
			$page2right = '<li class="page-item"><a class="page-link" href="' . $uri . 'page=' . ($page + 2) . '">' . ($page + 2) . '</a></li>';
		else
			$page2right = '';
		if ($page + 1 <= $cnt_pages)
			$page1right = '<li class="page-item"><a class="page-link" href="' . $uri . 'page=' . ($page + 1) . '">' . ($page + 1) . '</a></li>';
		else
			$page1right = '';
		// Выводим меню
		//$pages .=  '</div>';
	}
	$pages = '<li class="page-item">' . $startpage . $page2left . $page1left . '</li><li class="page-item active"><a class="page-link">' . $page . '</a></li><li class="page-item">' . $page1right . $page2right . $endpage . '</li>';

	$del = '<input class="btn btn-danger" type="submit" value="'.$lang['del'].'">';
	$orderes = '<option value="asc" ' . (empty($order) ? 'selected' : '') . '>'.$lang['order_asc'].'</option><option value="desc" ' . (!empty($order) ? 'selected' : '') . '>'.$lang['order_desc'].'</option>';
		
$tVars = [
	'php_self' => $PHP_SELF,
	'entries'   => $entries,
	'perpage'   => $perpage,
	'order'   => $orderes,
	'comm_length'   => $comm_length,
	'pages' => $pages,
	'del' => $del,
];

$xt = $twig->loadTemplate('skins/default/tpl/lastcomments.tpl');
$main_admin = $xt->render($tVars);
