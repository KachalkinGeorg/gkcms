<?php
// Protect against hack attempts
if (!defined('NGCMS')) die ('HAL');
//
// Configuration file for plugin
//
// Preload config file
pluginsLoadConfig();
// Fill configuration parameters
$cfg = array();
$cfgX = array();
array_push($cfg, array('descr' => 'Плагин позволяет пользователям просматривать чужие профили и редактировать свой'));
$cfgX = array();
array_push($cfgX, array('name' => 'profilegrup', 'title' => "Включить для кажлой группы свой стиль<br /><small><b>Да</b> - В папке выбранного шаблона создайте файлы <b>users_1.tpl</b> <u>до</u> <b>users_4.tpl</b> где цифра обозначает ИД группы пользователя, в которой он принадлежит.<br /><b style='color: red;'>ПРИМИЧАНИЕ!</b><br />Если групп было создано больше, чем установленно по умолчанию, то для них также нужно создать свой users<b>_ИД-ГРУППЫ</b>.tpl файл<br /><b>Нет</b> - будет использоваться общий файл для групп <b>users.tpl</b></small>", 'type' => 'select', 'values' => array('0' => $lang['noa'], '1' => $lang['yesa']), 'value' => intval(pluginGetVariable($plugin, 'profilegrup'))));
array_push($cfgX, array('name' => 'localsource', 'title' => "Выберите каталог из которого плагин будет брать шаблоны для отображения<br /><small><b>Шаблон сайта</b> - плагин будет пытаться взять шаблоны из общего шаблона сайта; в случае недоступности - шаблоны будут взяты из собственного каталога плагина<br /><b>Плагин</b> - шаблоны будут браться из собственного каталога плагина</small>", 'type' => 'select', 'values' => array('0' => 'Шаблон сайта', '1' => 'Плагин'), 'value' => intval(extra_get_param($plugin, 'localsource'))));
array_push($cfg, array('mode' => 'group', 'title' => '<b>Настройки отображения</b>', 'entries' => $cfgX));
// RUN 
if ($_REQUEST['action'] == 'commit') {
	// If submit requested, do config save
	commit_plugin_config_changes($plugin, $cfg);
} else {
	generate_config_page($plugin, $cfg);
}
?>