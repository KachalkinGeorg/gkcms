<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: upgrade.php
// Description: Обновление
// Author: NGCMS Development Team
//

@define('root', dirname(__FILE__) . '/');
@error_reporting(E_ALL ^ E_NOTICE);

//
// Check if we have upgrademe.txt file
//
if (!is_file(root . 'upgrademe.txt')) {
	echo "Ошибка! Для запуска скрипта обновления вам необходимо в каталоге engine/ создать файл <b>upgrademe.txt</b> и удалить его после обновления.";

	return;
}

// Проверка заполнения опросника
if (!$_REQUEST['doupgrade']) {
	questionare_098();
	exit;
}

@include_once 'core.php';
@include_once root . 'includes/inc/extraconf.inc.php';
@include_once root . 'includes/inc/extrainst.inc.php';

@header("Cache-Control: no-store, no-cache, must-revalidate");
@header("Cache-Control: post-check=0, pre-check=0", false);
@header("Pragma: no-cache");
$PHP_SELF = "admin.php";

/* if (($config['skin'] && $config['skin'] != "") && file_exists("./skins/$config[skin]/header.tpl")) {
	require_once("./skins/$config[skin]/header.tpl");
} else {
	require_once("./skins/default/header.tpl");
}
echo $skin_header; */

//
// Create required fields in DB
//
$query_list_098rc1 = array(
	"alter table " . prefix . "_images add column filesize int(10) default '0'",
	"insert into " . prefix . "_config (name, value) values ('database.engine.version', '0.9.8 RC1') on duplicate key update value='0.9.8 RC1'",
);

// Load plugin list
$extras = pluginsGetList();
// Load lang files
$lang = LoadLang('extra-config', 'admin');

if ($_REQUEST['update098rc1']) {
	// Выполнение SQL запросов на обновление
	print '<br/>Выполнение SQL запросов:<br/>';
	print '<table width="80%">';
	print '<tr><td><b>Команда</b></td><td><b>Результат</b></td></tr>';

	$flag_err = false;

	$queryList = array();
	if ($_REQUEST['update098rc1']) {
		$queryList = $query_list_098rc1;
	}

	foreach ($queryList as $sql) {
		$res = $mysql->query($sql);
		$sqlErrorCode = 0;
		$sqlErrorFatal = 0;
		if ($res) {
			// OK
			print '<tr><td>' . $sql . '</td><td>OK</td></tr>' . "\n";
		} else {
			$sqlErrorCode = $mysql->db_errno();
			if (in_array($sqlErrorCode, array(1060, 1054, 1091, 1050))) {
				print '<tr><td>' . $sql . '</td><td>OK/Non fatal error (' . $sqlErrorCode . ': ' . $mysql->db_error() . ')</td></tr>' . "\n";
			} else {
				print '<tr><td>' . $sql . '</td><td><font color="red"><b>FAIL</b></font> (' . $sqlErrorCode . ': ' . $mysql->db_error() . ')</td></tr>' . "\n";
				$flag_err = true;
				break;
			}
		}
	}
	print "</table><br/>\n\n";

	if ($flag_err) {
		//
		print "<font color='red'><b>Во время обновления БД произошла ошибка!<br/>Обновление в автоматическом режиме невозможно, Вам необходимо обновить БД вручную.</b></font>";
		exit;
	}

	//echo "DONE <br><br>\n<b><u>Внимание!</u></b><br/>После завершения обновления Вам необходимо зайти в админ-панель и выключить-включить следующие плагины: uprofile, xfields.";
}

print "Все операции проведены.<br/><a href='?'>назад</a><br/><br/><br/>После окончания обновления вам <font color=\"red\"><u>необходимо</u></font> удалить файл <b>upgrademe.txt</b> из каталога engine/";

function questionare_098() {

	print "
 <style>BODY {PADDING-RIGHT: 8px; PADDING-LEFT: 8px; PADDING-TOP: 5px; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #333; FONT-FAMILY: 'Trebuchet MS', Verdana, Arial, sans-serif; BACKGROUND-COLOR: #f0f0f0; }</style>


 <form method='get' action=''>
 <input type=hidden name='doupgrade' value='1'/>
 <b><u>Перед началом обновления вам необходимо ответить на несколько вопросов:</u></b><br /><br />
 <font color='red'><b>ВНИМАНИЕ: </b> перед началом обновления вам <u>ОБЯЗАТЕЛЬНО</u> необходимо сделать
 резервную копию БД</font><br/><br/>
 <table width='80%' border='1'>
 <tr>
  <td>Выполнить обновление структуры БД для новой системы загрузки изображений<br/>
   <small>Данную операцию требуется произвести единожды при обновлении конфигурации системы.<br/>
   </small>
  </td>
  <td width='10%'><input type=checkbox name='update098rc1' value='1' /></td>
 </tr>
 </table><br/>
 <input type='submit' value='Начать преобразование!'>
 </form>
 ";
}