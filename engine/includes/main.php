<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: main.php
// Description: Show different informational blocks
// Author: NGCMS Development Team
//

// Protect against hack attempts
if (!defined('NGCMS')) {
    exit('HAL');
}

//header('Content-Type: text/html; charset=utf-8');

if ($config['favorit_active']) {
	add_act('index', 'news_favorites');
}

function news_favorites() {
	global $config, $mysql, $template;

	$counter   = intval($config['favorit_count']);
	$number    = intval($config['favorit_number']);
	$maxlength = intval($config['favorit_maxlength']);

	$cacheFileName = md5('favorites'.$config['theme'].$config['default_lang'].$year.$month).'.txt';

	if ($config['favorit_cache']) {
		$cacheData = cacheRetrieveFile($cacheFileName, $config['favorit_cacheExpire'], 'favorites');
		if ($cacheData != false) {
			$template['vars']['favorites'] = $cacheData;
			return;
		}
	}

	if (!$number)		{ $number = 10; }
	if (!$maxlength)	{ $maxlength = 100; }

	foreach ($mysql->select("select alt_name, postdate, title, views, catid from ".prefix."_news where favorite = '1' and approve = '1' limit 0,$number") as $row) {

		$link =	newsGenerateLink($row);
		$views = ($counter) ? ' [ '.$row['views'].' ]' : '';
		if (strlen($row['title']) > $maxlength) {
			$title = substr(secure_html($row['title']), 0, $maxlength)."...";
		} else {
			$title = secure_html($row['title']);
		}

		$favorite .= '
		<table border="0" width="100%" cellspacing="0" cellpadding="0">
			<tr>
				<td>&nbsp;</td>
				<td><ul><li><a href="'.$link.'" title="'.$title.'">'.$title.' '.$views.'</a></li></ul></td>
			</tr>
		</table>
		';
	}

	$template['vars']['favorites'] = $favorite;

	if ($config['favorit_cache']) {
		cacheStoreFile($cacheFileName, $favorite, 'favorites');
	}
}

