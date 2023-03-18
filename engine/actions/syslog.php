<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: syslog.php
// Description: Логи пользователей (ngSYSLOG)
// Author: NGCMS Development Team
//

// Protect against hack attempts
if (!defined('NGCMS')) {
    exit('HAL');
}

$lang = LoadLang('syslog', 'admin');
$lang = LoadLang('configuration', 'admin');

$breadcrumb = breadcrumb('<i class="fa fa-info-circle btn-position"></i><span class="text-semibold">'.$lang['sys_log'].'</span>', ''.$lang['sys_log'].'' );

if (!$config['syslog']) {
	msg(['type' => 'error', 'text' => $lang['w_syslogs']]);
	return print_msg( 'warning', $lang['sys_log'], str_replace('%syslog%', $lang['syslog'], $lang['w_syslog']), 'javascript:history.go(-1)' );
}

// makePluginsList - make <SELECT> list of Plugins
// Params: set via named array
// * name 		- name field of <SELECT>
// * selected 		- ID of category to be selected or array of IDs to select (in list mode)
// * skip 		- ID of category to skip or array of IDs to skip
// * skipDisabled	- skip disabled areas
// * doempty 		- add empty category to the beginning ("no category"), value = 0
// * greyempty		- show empty category as `grey`
// * doall 		- add category named "ALL" to the beginning, value is empty
// * allMarker		- marker value for `doall`
// * dowithout		- add "Without category" after "ALL", value = 0
// * nameval 		- use DB field "name" instead of ID in HTML option value
// * checkarea	 	- flag, if set - generate a list of checkboxes instead of <SELECT>
// * class 		- HTML class name
// * style 		- HTML style
// * disabledarea	- mark all entries (for checkarea) as disabled [for cases when extra categories are not allowed]
// * noHeader		- Don't write header (<select>..</select>) in output
// * returnOptArray	- FLAG: if we should return OPTIONS (with values) array instead of data
// * obj	- objects to show
function makeVARList($params = array()) {

	global $lang, $mysql;
	$optList = array();
	$obj = $params['obj'];
	if (!isset($params['skip'])) {
		$params['skip'] = array();
	}
	if (!is_array($params['skip'])) {
		$params['skip'] = $params['skip'] ? array($params['skip']) : array();
	}
	$name = array_key_exists('name', $params) ? $params['name'] : 'category';
	$out = '';
	if (!isset($params['checkarea']) || !$params['checkarea']) {
		if (!$params['noHeader']) {
			$out = "<select name=\"$name\" id=\"plugmenu\"" .
				((isset($params['style']) && ($params['style'] != '')) ? ' style="' . $params['style'] . '"' : '') .
				((isset($params['class']) && ($params['class'] != '')) ? ' class="' . $params['class'] . '"' : '') .
				">\n";
		}
		if (isset($params['doempty']) && $params['doempty']) {
			$out .= "<option " . (((isset($params['greyempty']) && $params['greyempty'])) ? 'style="background: #c41e3a;" ' : '') . "value=\"0\">" . $lang['no_cat'] . "</option>\n";
			$optList [] = array('k' => 0, 'v' => $lang['nocat']);
		}
		if (isset($params['doall']) && $params['doall']) {
			$out .= "<option value=\"" . (isset($params['allmarker']) ? $params['allmarker'] : '') . "\">" . $lang['sh_all'] . "</option>\n";
			$optList [] = array('k' => (isset($params['allmarker']) ? $params['allmarker'] : ''), 'v' => $lang['sh_all']);
		}
		if (isset($params['dowithout']) && $params['dowithout']) {
			$out .= "<option value=\"0\"" . (((!is_null($params['selected'])) && ($params['selected'] == 0)) ? ' selected="selected"' : '') . ">" . $lang['sh_empty'] . "</option>\n";
			$optList [] = array('k' => 0, 'v' => $lang['sh_empty']);
		}
	}
	$catz = array();
	foreach ($mysql->select("select DISTINCT * from `" . prefix . "_syslog` order by id asc", 1) as $row) {
		$catz[$row[$obj]] = $row;
		$catmap[$row[$obj]] = $row[$obj];
	}
	foreach ($catz as $k => $v) {
		if (in_array($v[$obj], $params['skip'])) {
			continue;
		}
		if ($params['skipDisabled'] && ($v['alt_url'] != '')) {
			continue;
		}
		if (isset($params['checkarea']) && $params['checkarea']) {
			$out .= str_repeat('&#8212; ', $v['poslevel']) .
				'<label><input type="checkbox" name="' .
				$name .
				'_' .
				$v[$obj] .
				'" value="1"' .
				((isset($params['selected']) && is_array($params['selected']) && in_array($v[$obj], $params['selected'])) ? ' checked="checked"' : '') .
				(((($v['alt_url'] != '') || (isset($params['disabledarea']) && $params['disabledarea']))) ? ' disabled="disabled"' : '') .
				'/> ' .
				$v[$obj] .
				"</label><br/>\n";
		} else {
			$out .= "<option value=\"" . ((isset($params['nameval']) && $params['nameval']) ? $v[$obj] : $v[$obj]) . "\"" . ((isset($params['selected']) && ($v[$obj] == $params['selected'])) ? ' selected="selected"' : '') . ($v['alt_url'] != '' ? ' disabled="disabled" style="background: #c41e3a;"' : '') . ">" . str_repeat('&#8212; ', $v['poslevel']) . $v[$obj] . "</option>\n";
			$optList [] = array('k' => ((isset($params['nameval']) && $params['nameval']) ? $v[$obj] : $v[$obj]), 'v' => str_repeat('&#8212; ', $v['poslevel']) . $v[$obj]);
		}
	}
	if (!isset($params['checkarea']) || !$params['checkarea']) {
		if (!$params['noHeader']) {
			$out .= "</select>";
		}
	}
	if (isset($params['returnOptArray']) && $params['returnOptArray'])
		return $optList;

	return $out;
}


	//include_once 'file';
	// Load admin page based cookies
	$admCookie = admcookie_get();
	// Author filter (by name)
	$fAuthorName = $_REQUEST['name'];
	// Status filter (by 1/0)
	$fStatus = $_REQUEST['status'];
	//print $fStatus;
	// Selected plugin
	$fPlugin = $_REQUEST['fplugins'];
	// Selected item
	$fItem = $_REQUEST['fitems'];
	// Selected date
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
	
	if ($fAuthorName) {
		$conditions[] = "username = " . db_squote($fAuthorName);
	}

    if (isset($fStatus) && (intval($fStatus) > 0)) {
        $conditions[] = 'status = '.intval($fStatus);
    }

	if ($fPlugin) {
		$conditions[] = "plugin = " . db_squote($fPlugin);
	}
	if ($fItem) {
		$conditions[] = "item = " . db_squote($fItem);
	}
	if ($fDateStart && $fDateEnd) {
		$conditions[] = "dt BETWEEN STR_TO_DATE(" . db_squote($fDateStart) . ",'%d.%m.%Y') AND STR_TO_DATE(" . db_squote($fDateEnd) . ",'%d.%m.%Y')";
	} elseif ($fDateStart) {
		$conditions[] = "dt BETWEEN STR_TO_DATE(" . db_squote($fDateStart) . ",'%d.%m.%Y') AND NOW()";
	} elseif ($fDateEnd) {
		$conditions[] =  "dt BETWEEN STR_TO_DATE('01.01.1970','%d.%m.%Y') AND STR_TO_DATE(" . db_squote($fDateEnd) . ",'%d.%m.%Y')";
	}
	
	//var_export($conditions);
	
	$fSort = "ORDER BY id DESC";
	$sqlQPart = "from " . prefix . "_syslog " . (count($conditions) ? "where " . implode(" and ", $conditions) : '') . ' ' . $fSort;
	
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
    $sql = 'select * from '.prefix.'_syslog '.$queryFilter.' order by '.$sortValue.' '.'limit '.(($pageNo - 1) * $news_per_page).', '.$news_per_page; */
	
	foreach ($mysql->select($sqlQ . ' LIMIT ' . $start_from . ', ' . $news_per_page) as $row) {
	//foreach ($mysql->select($sql) as $row) {
		
		if($row['action'] == 'switch_on'){
			$action = $lang['switch_on'];
		}
		if($row['action'] == 'switch_off'){
			$action = $lang['switch_off'];
		}
		
		$status = isset($UGROUP[$row['status']]) ? $UGROUP[$row['status']]['name'] : ('Unknown ['.$row['status'].']');
		
		//$alist = json_decode(stripslashes($row['alist']),true);
		$alist = unserialize($row['alist']);
		
        $tEntry[] = array (
            'id' => $row['id'],
            'date' => $row['dt'],
            'ip' => $row['ip'],
            'plugin' => $row['plugin'],
            'item' => $row['item'],
            'ds' => $row['ds'],
            'action' => $action,
    		'alist' => $alist,
            'userid' => $row['userid'],
            'username' => $row['username'],
            'status' => $status,
            'stext' => $row['stext'],
        );
        //var_export(unserialize($row['alist']));
    }

    $pagesss = generateAdminPagelist([
        'current' => $pageNo,
        'count'   => $countPages,
        'url'     => '?mod=syslog'.
            (isset($_REQUEST['name']) && $_REQUEST['name'] ? '&name='.htmlspecialchars($_REQUEST['name'], ENT_COMPAT | ENT_HTML401, 'UTF-8') : '').
            (isset($_REQUEST['status']) && $_REQUEST['status'] ? '&status=' . $_REQUEST['status'] : '').
			(isset($_REQUEST['fplugins']) && $_REQUEST['fplugins'] ? '&fplugins=' . $_REQUEST['fplugins'] : '').
			(isset($_REQUEST['fitems']) && $_REQUEST['fitems'] ? '&fitems=' . $_REQUEST['fitems'] : '').
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
        'name' => secure_html($fAuthorName),
        'fstatus' => $fStatus,
        'catPlugins' => makeVARList(array('obj' => 'plugin', 'name' => 'fplugins', 'selected' => $fPlugin, 'class' => 'custom-select', 'doempty' => 1)),
        'catItems' => makeVARList(array('obj' => 'item', 'name' => 'fitems', 'selected' => $fItem, 'class' => 'custom-select', 'doempty' => 1)),
        'fDateStart' => $fDateStart?$fDateStart:'',
        'fDateEnd' => $fDateEnd?$fDateEnd:'',
        'localPrefix' => localPrefix,
    );


$xt = $twig->loadTemplate('skins/default/tpl/syslog.tpl');
$main_admin = $xt->render($tVars);