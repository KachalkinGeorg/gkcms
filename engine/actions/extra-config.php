<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: extra-config.php
// Description: Менеджер плагинов
// Author: NGCMS Development Team
//

// Protect against hack attempts
if (!defined('NGCMS')) {
    exit('HAL');
}

@include_once root.'includes/inc/extraconf.inc.php';
@include_once root.'includes/inc/extrainst.inc.php';

// ==============================================================
//  Main module code
// ==============================================================

// Load lang files
$lang = LoadLang('extra-config', 'admin');

// Load plugin list
$extras = pluginsGetList();

// Load passed variables:
// ID of called plugin
$plugin = $_REQUEST['plugin'];

// Type of script to call  ( install / deinstall / config )
$stype = isset($_REQUEST['stype']) ? $_REQUEST['stype'] : '';

if(!getPluginStatusActive($plugin) and $stype != 'install' and $stype != 'deinstall'){
	if (!is_array($extras[$plugin])) {
		$text = $lang['noplugin'];
	}else{
		$text = str_replace('%plugin%', $plugin, $lang['no_active']);
	}
	msg(['type' => 'error', 'title' => $lang['attention'], 'text' => $text]);
}

if (!is_array($extras[$plugin])) {

	return print_msg( 'warning', ''.$lang['noplugin'].'', $lang['noplugin_desc'], 'javascript:history.go(-1)' );
	
} else {
    //
    // Call 'install'/'deinstall' script if it's requested. Else - call config script.
    if (($stype != 'install') && ($stype != 'deinstall')) {
        $stype = 'config';
    }
	
    // Fetch the name of corresponding configuration file
    $cfg_file = extras_dir.'/'.$extras[$plugin]['dir'].'/'.$extras[$plugin][$stype];

    // Check if such type of script is configured in plugin & exists
    if (is_array($extras[$plugin]) && ($extras[$plugin][$stype]) && is_file($cfg_file)) {

        // Security update: for stype == 'config' and POST update action - check for token
        if (($stype == 'config') && (isset($_REQUEST['action']) && $_REQUEST['action'] == 'commit') && ($_REQUEST['token'] != genUToken('admin.extra-config'))) {
            msg(['type' => 'error', 'text' => $lang['error.security.token'], 'info' => $lang['error.security.token#desc']]);
            ngSYSLOG(['plugin' => '#admin', 'item' => 'config#'.$plugin], ['action' => 'modify'], null, [0, 'SECURITY.TOKEN']);
            exit;
        }

        //
        // Include required script file
        ob_start();
        @include extras_dir.'/'.$extras[$plugin]['dir'].'/'.$extras[$plugin][$stype];
        $main_admin .= ob_get_contents();
        ob_end_clean();

        //
        // Run install function if it exists in file
        if (($stype == 'install') && function_exists('plugin_'.$plugin.'_install')) {
            call_user_func('plugin_'.$plugin.'_install', ($_REQUEST['action'] == 'commit') ? 'apply' : 'confirm');
        }
    } else {

        return print_msg( 'warning', ''.$lang[$stype.'_text'].' '.$plugin.'', $lang['nomod_'.$stype], 'javascript:history.go(-1)' );
    }
}