<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: replace.php
// Description: Поиск и замена
// Author: NGCMS Development Team
//


if (!defined('NGCMS')) {
    exit('HAL');
}

$lang = LoadLang('replace', 'admin');

$breadcrumb = breadcrumb('<i class="fa fa-exchange btn-position"></i><span class="text-semibold">'.$lang['replace'].'</span>', ''.$lang['replace.descr'].'' );

if (!getPluginStatusActive('comments')) {
	msg(['type' => 'error', 'title' => $lang['warning'], 'text' => $lang['w_com']]);
	return print_msg( 'warning', $lang['replace'], ''.$lang['warning'].'<br>'.$lang['w_com'].'', '?mod=replace' );
}

if ($_REQUEST['action'] == 'commit') {
	$query = '';
	do {
		$source = $_REQUEST['source'];
		$dest = $_REQUEST['dest'];
		$area = $_REQUEST['area'];
		if (!strlen($source) || !strlen($dest)) {
			msg(array("type" => "error", "text" => $lang['error.notext']));
			return print_msg( 'error', $lang['replace'], ''.$lang['error.notext'].'<br>'.$lang['error.notext.descr'].'', '?mod=replace' );
			break;
		}

		switch ($area) {
			case 'news':
				$query = "update " . prefix . "_news set content = replace(content, " . db_squote($source) . ", " . db_squote($dest) . ")";
				break;
			case 'static':
				$query = "update " . prefix . "_static set content = replace(content, " . db_squote($source) . ", " . db_squote($dest) . ")";
				break;
			case 'comments':
				$query = "update " . prefix . "_comments set text = replace(text, " . db_squote($source) . ", " . db_squote($dest) . ")";
				break;
		}
		if (!$query) {
			msg(["type" => "error", "text" => $lang['error.noarea']]);
			return print_msg( 'error', $lang['replace'], ''.$lang['error.noarea'].'', '?mod=replace' );
			break;
		}
	} while (0);

	if ($query) {
		$result = $mysql->select($query);
		$count = $mysql->affected_rows($mysql->connect);
		if ($count) {
			msg(["type" => "info", "text" => str_replace('{count}', $count, $lang['info.done'])]);
			return print_msg( 'info', $lang['replace'], str_replace('{count}', $count, $lang['info.done']), '?mod=replace' );
		} else {
			msg(["type" => "info", "text" => $lang['info.nochange']]);
			return print_msg( 'warning', $lang['replace'], ''.$lang['info.nochange'].'', '?mod=replace' );
		}
	}
}

$areas = '<option value="" ' . (empty($area) ? 'selected' : '') . '>'.$lang['area.choose'].'</option><option value="news" ' . (!empty($area) ? 'selected' : '') . '>'.$lang['area.news'].'</option><option value="static" ' . (!empty($area) ? 'selected' : '') . '>'.$lang['area.static'].'</option><option value="comments" ' . (!empty($area) ? 'selected' : '') . '>'.$lang['area.comments'].'</option>';

$tVars = [
	'php_self' => $PHP_SELF,
	'area'   => $areas,
	'source'   => $source,
	'dest'   => $dest,
];

$xt = $twig->loadTemplate('skins/default/tpl/replace.tpl');
$main_admin = $xt->render($tVars);