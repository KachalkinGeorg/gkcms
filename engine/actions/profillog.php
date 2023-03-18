<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: profillog.php
// Description: Логи пользователей (ngSYSLOG)
// Author: NGCMS Development Team
//

// Protect against hack attempts
if (!defined('NGCMS')) {
    exit('HAL');
}

$lang = LoadLang('profillog', 'admin');
$lang = LoadLang('configuration', 'admin');

$breadcrumb = breadcrumb('<i class="fa fa-info-circle btn-position"></i><span class="text-semibold">'.$lang['profil_log'].'</span>', ''.$lang['profil_log'].'' );

if (!$config['load_profiler']) {
	msg(['type' => 'error', 'text' => $lang['w_profillogs']]);
	return print_msg( 'warning', $lang['profil_log'], str_replace('%load_profiler%', $lang['load_profiler'], $lang['w_profillog']), 'javascript:history.go(-1)' );
}

	// Load admin page based cookies
	$admCookie = admcookie_get();
	$fDateStart = $_REQUEST['dr1'];
	$fDateEnd = $_REQUEST['dr2'];
	if ($fDateStart == 'DD.MM.YYYY') $fDateStart = '';
	if ($fDateEnd == 'DD.MM.YYYY') $fDateEnd = '';
	// Records Per Page
	// - Load
	$news_per_page = isset($_REQUEST['rpp']) ? intval($_REQUEST['rpp']) : intval($admCookie['syslog']['pp']);
	// - Set default value for `Records Per Page` parameter
	if (($news_per_page < 2) || ($news_per_page > 2000))
		$news_per_page = 10;
	// - Save into cookies current value
	$admCookie['syslog']['pp'] = $news_per_page;
	admcookie_set($admCookie);
	
	$conditions = [];
	
	if ($fDateStart && $fDateEnd) {
		$conditions[] = "dt BETWEEN STR_TO_DATE(" . db_squote($fDateStart) . ",'%d.%m.%Y') AND STR_TO_DATE(" . db_squote($fDateEnd) . ",'%d.%m.%Y')";
	} elseif ($fDateStart) {
		$conditions[] = "dt BETWEEN STR_TO_DATE(" . db_squote($fDateStart) . ",'%d.%m.%Y') AND NOW()";
	} elseif ($fDateEnd) {
		$conditions[] =  "dt BETWEEN STR_TO_DATE('01.01.1970','%d.%m.%Y') AND STR_TO_DATE(" . db_squote($fDateEnd) . ",'%d.%m.%Y')";
	}
	
	//var_export($conditions);
	
	$fSort = "ORDER BY id DESC";
	$sqlQPart = "from " . prefix . "_profiler " . (count($conditions) ? "where " . implode(" and ", $conditions) : '') . ' ' . $fSort;
	
	$sqlQCount = "select count(id) " . $sqlQPart;
	$sqlQ = "select * " . $sqlQPart;
	$pageNo = $_REQUEST['page'] ? intval($_REQUEST['page']) : 0;
	if ($pageNo < 1) $pageNo = 1;
	if (!$start_from) $start_from = ($pageNo - 1) * $news_per_page;
	$count = $mysql->result($sqlQCount);
	$countPages = ceil($count / $news_per_page);
	
/*     $pageNo = (isset($_REQUEST['page']) && $_REQUEST['page']) ? intval($_REQUEST['page']) : 0;
    if (!$pageNo) {
        $pageNo = 1;
    }
	$sortValue = "id DESC";
    $queryFilter = count($conditions) ? 'where '.implode(' and ', $conditions) : '';
    $sql = 'select * from '.prefix.'_profiler '.$queryFilter.' order by '.$sortValue.' '.'limit '.(($pageNo - 1) * $news_per_page).', '.$news_per_page; */
	
	foreach ($mysql->select($sqlQ . ' LIMIT ' . $start_from . ', ' . $news_per_page) as $row) {
	//foreach ($mysql->select($sql) as $row) {
		if($userROW['id'] == $row['userid']){
			$username = $userROW['name'];
		}
        $tEntry[] = array (
            'id' => $row['id'],
            'date' => $row['dt'],
            'exectime' => $row['exectime'],
            'memusage' => $row['memusage'],
			'url' => $row['url'],
            'userid' => $row['userid'],
            'username' => $username,
            'tracedata' => $row['tracedata'],
        );
    }

    $pagesss = generateAdminPagelist([
        'current' => $pageNo,
        'count'   => $countPages,
        'url'     => '?mod=profillog'.
			(isset($_REQUEST['dr1']) && $_REQUEST['dr1'] ? '&dr1=' . $_REQUEST['dr1'] : '').
			(isset($_REQUEST['dr2']) && $_REQUEST['dr2'] ? '&dr2=' . $_REQUEST['dr2'] : '').
			(isset($_REQUEST['rpp']) && $_REQUEST['rpp'] ? '&rpp='.intval($_REQUEST['rpp']) : '').
            '&page=%page%',
    ]);

    $tVars = array(
        'entries' => isset($tEntry) ? $tEntry : '',
        'pagesss' => $pagesss,
        'php_self' => $confArray['predefined']['PHP_SELF'],
        'skins_url' => skins_url,
        'home' => home,
        'rpp' => $news_per_page,
        'fDateStart' => $fDateStart?$fDateStart:'',
        'fDateEnd' => $fDateEnd?$fDateEnd:'',
        'localPrefix' => localPrefix,
    );


$xt = $twig->loadTemplate('skins/default/tpl/profillog.tpl');
$main_admin = $xt->render($tVars);