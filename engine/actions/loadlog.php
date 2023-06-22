<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: syslog.php
// Description: Лог нагрузки
// Author: NGCMS Development Team
//

// Protect against hack attempts
if (!defined('NGCMS')) {
    exit('HAL');
}

$lang = LoadLang('loadlog', 'admin');
$lang = LoadLang('configuration', 'admin');

$breadcrumb = breadcrumb('<i class="fa fa-info-circle btn-position"></i><span class="text-semibold">'.$lang['load_log'].'</span>', '<i class="fa fa-info-circle btn-position"></i>'.$lang['load_log'].'' );

if (!$config['load_analytics']) {
	msg(['type' => 'error', 'text' => $lang['w_loadlogs']]);
	return print_msg( 'warning', $lang['load_log'], str_replace('%load%', $lang['load'], $lang['w_loadlog']), 'javascript:history.go(-1)' );
}

	$admCookie = admcookie_get();
	
	$fDateStart = $_REQUEST['dr1'];
	$fDateEnd = $_REQUEST['dr2'];
	if ($fDateStart == 'DD.MM.YYYY') $fDateStart = '';
	if ($fDateEnd == 'DD.MM.YYYY') $fDateEnd = '';

	if ($fDateStart && $fDateEnd) {
		$conditions[] = "dt BETWEEN STR_TO_DATE(" . db_squote($fDateStart) . ",'%d.%m.%Y') AND STR_TO_DATE(" . db_squote($fDateEnd) . ",'%d.%m.%Y')";
	} elseif ($fDateStart) {
		$conditions[] = "dt BETWEEN STR_TO_DATE(" . db_squote($fDateStart) . ",'%d.%m.%Y') AND NOW()";
	} elseif ($fDateEnd) {
		$conditions[] =  "dt BETWEEN STR_TO_DATE('01.01.1970','%d.%m.%Y') AND STR_TO_DATE(" . db_squote($fDateEnd) . ",'%d.%m.%Y')";
	}
	
	$news_per_page = isset($_REQUEST['rpp']) ? intval($_REQUEST['rpp']) : intval($admCookie['loadlog']['pp']);

	if (($news_per_page < 2) || ($news_per_page > 2000))
		$news_per_page = 10;
	
	$queryFilter = count($conditions) ? 'where '.implode(' and ', $conditions) : '';
	$get_info_stats = "SELECT * FROM ".prefix."_load ".$queryFilter." order by dt limit ".$news_per_page."";

	foreach ($mysql->select($get_info_stats) as $row) {
		$array_date[] = $row["dt"];
		$array_all[] = $row;
	}

	$new_array_date = array_unique($array_date);

	foreach ($new_array_date as $key_date) {

		$i = 0;
		$exec_core = 0;
		$exec_plugin = 0;
		$exec_ppage = 0;
		$hit_core = 0;
		$hit_plugin = 0;
		$hit_ppage = 0;

		foreach ($array_all as $key_all) {

			if($key_date == $key_all["dt"]) {

				$exec_core = $key_all["exec_core"];
				$exec_plugin = $key_all["exec_plugin"];
				$exec_ppage = $key_all["exec_ppage"];
				$hit_core = $key_all["hit_core"];
				$hit_plugin = $key_all["hit_plugin"];
				$hit_ppage = $key_all["hit_ppage"];
				$i++;

			}

		}

		$final_array[] = array($key_date, $i, $exec_core, $exec_plugin, $exec_ppage, $hit_core, $hit_plugin, $hit_ppage);
	}

	foreach ($final_array as $rows) {

		if($rows[0] == date('d.m.Y H:i')) {
			
			$name_date = "Сегодня";
	
		} else {
			
			$name_date = substr($rows[0], 0, -5);
		
		}

		$array_day .= "'".$name_date."',";
		$execcore .= $rows[1].",";
		$execplugin .= $rows[2].",";
		$execppage .= $rows[3].",";
		$hitcore .= $rows[4].",";
		$hitplugin .= $rows[5].",";
		$hitppage .= $rows[6].",";

	}
	
    $tVars = array(
		'array_day' => $array_day,
		'exec_core' => $execcore,
		'exec_plugin' => $execplugin,
		'exec_ppage' => $execppage,
		'hit_core' => $hitcore,
		'hit_plugin' => $hitplugin,
		'hit_ppage' => $hitppage,
		'rpp' => $news_per_page,
        'fDateStart' => $fDateStart?$fDateStart:'',
        'fDateEnd' => $fDateEnd?$fDateEnd:'',
        'home' => home,
        'localPrefix' => localPrefix,
    );


$xt = $twig->loadTemplate('skins/default/tpl/loadlog.tpl');
$main_admin = $xt->render($tVars);