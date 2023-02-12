<?php

if (!defined('NGCMS')) die ('HAL');

pluginsLoadConfig();

// Load lang files
LoadPluginLang('autokeys', 'admin', '', 'autokeys', ':');

if ( file_exists($stopFile = extras_dir .'/autokeys/config/stop-words/' . $config['default_lang'] . '.sw.txt') ){
	$stopText  = file_get_contents( $stopFile );
}
if ( file_exists($allowFile = extras_dir .'/autokeys/config/allow-words.txt') ){
	$allowText  = file_get_contents( $allowFile );
}

$cfg = array();

array_push($cfg, array('name' => 'activate_add', 'title' => $lang[$plugin.':activate_add'], 'type' => 'select', 'values' => array(0 => $lang['noa'], 1 => $lang['yesa']), 'value' => pluginGetVariable($plugin, 'activate_add'),));
array_push($cfg, array('name' => 'activate_edit', 'title' => $lang[$plugin.':activate_edit'], 'type' => 'select', 'values' => array(0 => $lang['noa'], 1 => $lang['yesa']), 'value' => pluginGetVariable($plugin, 'activate_edit'),));
array_push($cfg, array('name' => 'length', 'title' => $lang[$plugin.':length'], 'descr' => $lang[$plugin.':length#desc'], 'type' => 'input', 'value' => pluginGetVariable($plugin, 'length'),));
array_push($cfg, array('name' => 'sub', 'title' => $lang[$plugin.':sub'], 'descr' => $lang[$plugin.':sub#desc'], 'type' => 'input', 'value' => pluginGetVariable($plugin, 'sub'),));
array_push($cfg, array('name' => 'occur', 'title' => $lang[$plugin.':occur'], 'descr' => $lang[$plugin.':occur#desc'], 'type' => 'input', 'value' => pluginGetVariable($plugin, 'occur'),));
array_push($cfg, array('name' => 'add_title', 'title' => $lang[$plugin.':add_title'], 'descr' => $lang[$plugin.':add_title#desc'], 'type' => 'input', 'value' => pluginGetVariable($plugin, 'add_title'),));
array_push($cfg, array('name' => 'sum', 'title' => $lang[$plugin.':sum'], 'descr' => $lang[$plugin.':sum#desc'], 'type' => 'input', 'value' => pluginGetVariable($plugin, 'sum'),));
array_push($cfg, array('name' => 'count', 'title' => $lang[$plugin.':count'], 'descr' => $lang[$plugin.':count#desc'], 'type' => 'input', 'value' => pluginGetVariable($plugin, 'count'),));
array_push($cfg, array('name' => 'good_b', 'title' => $lang[$plugin.':good_b'], 'descr' => $lang[$plugin.':good_b#desc'],'type' => 'select', 'values' => array(0 => $lang['noa'], 1 => $lang['yesa']), 'value' => pluginGetVariable($plugin, 'good_b'),));
array_push($cfg, array('name' => 'block_y', 'title' => $lang[$plugin.':block_y'], 'descr' => $lang[$plugin.':block_y#desc'], 'type' => 'select', 'values' => array(0 => $lang['noa'], 1 => $lang['yesa']), 'value' => pluginGetVariable($plugin, 'block_y'),));
array_push($cfg, array('name' => 'block', 'title' => $lang[$plugin.':block'], 'descr' => $lang[$plugin.':block#desc'], 'type' => 'text', 'html_flags' => 'rows="8"', 'value' => $stopText, 'nosave' => true,));
array_push($cfg, array('name' => 'good_y', 'title' => $lang[$plugin.':good_y'], 'descr' => $lang[$plugin.':good_y#desc'], 'type' => 'select', 'values' => array(0 => $lang['noa'], 1 => $lang['yesa']), 'value' => pluginGetVariable($plugin, 'good_y'),));
array_push($cfg, array('name' => 'good', 'title' => $lang[$plugin.':good'], 'descr' => $lang[$plugin.':good#desc'], 'type' => 'text', 'html_flags' => 'rows="8"', 'value' => $allowText, 'nosave' => true,));

// RUN
if ($_REQUEST['action'] == 'commit') {
    if (($fs = fopen($stopFile, 'w')) !== FALSE) {
        fwrite($fs, $_REQUEST['block'] );
        fclose($fs);
    } else {
        msg(array('type' => 'danger', 'message' => 'Ошибка записи файла стоп-слов!'));
    }
    if (($fa = fopen($allowFile, 'w')) !== FALSE) {
        fwrite($fa, $_REQUEST['good'] );
        fclose($fa);
    } else {
        msg(array('type' => 'danger', 'message' => 'Ошибка записи файла желательных слов!'));
    }

    // If submit requested, do config save
    commit_plugin_config_changes($plugin, $cfg);
} else {
	generate_config_page('autokeys', $cfg);
}
