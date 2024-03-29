<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: extraconf.inc.php
// Description: Plugin configuration manager
// Author: NGCMS Development Team
//

// Protect against hack attempts
if (!defined('NGCMS')) {
    exit('HAL');
}

//
// Switch plugin ON/OFF
//
function pluginSwitch($pluginID, $mode = 'on')
{
    global $PLUGINS;

    // Load list of active plugins
    $activated = getPluginsActiveList();

    // Decide what to do
    switch ($mode) {
        // TURN _ON_
        case 'on':
            // Load plugins list
            $extras = pluginsGetList();
            if (!is_array($extras)) {
                return false;
            }
            if (!$extras[$pluginID]) {
                return false;
            }

            // Mark module as active
            $activated['active'][$pluginID] = $extras[$pluginID]['dir'];

            // Mark module to be activated in all listed actions
            if (isset($extras[$pluginID]['acts']) && isset($extras[$pluginID]['file'])) {
                foreach (explode(',', $extras[$pluginID]['acts']) as $act) {
                    $activated['actions'][$act][$pluginID] = $extras[$pluginID]['dir'].'/'.$extras[$pluginID]['file'];
                }
            }

            foreach ($extras[$pluginID]['actions'] as $act => $file) {
                $activated['actions'][$act][$pluginID] = $extras[$pluginID]['dir'].'/'.$file;
            }

            if (count($extras[$pluginID]['library'])) {
                $activated['libs'][$pluginID] = $extras[$pluginID]['library'];
            }

            // update active extra list in memory
            $PLUGINS['active'] = $activated;

            return savePluginsActiveList();

        // TURN _OFF_
        case 'off':
            unset($activated['active'][$pluginID]);
            unset($activated['libs'][$pluginID]);

            foreach ($activated['actions'] as $key => $value) {
                if ($activated['actions'][$key][$pluginID]) {
                    unset($activated['actions'][$key][$pluginID]);
                }
            }

            $PLUGINS['active'] = $activated;

            return savePluginsActiveList();
    }

    return false;
}

//
// Save list of active plugins & required files
//

function savePluginsActiveList()
{
    global $PLUGINS;

    if (!is_file(conf_pactive)) {
        return false;
    }

    if (!($file = fopen(conf_pactive, 'w'))) {
        return false;
    }

    $content = '<?php $array = '.var_export($PLUGINS['active'], true).'; ?>';
    fwrite($file, $content);
    fclose($file);

    return true;
}

//
// Mark plugin as installed
//
function plugin_mark_installed($plugin)
{
    global $PLUGINS, $mysql, $breadcrumb, $lang, $main_admin;

    // Load activated list
    $activated = getPluginsActiveList();
	
	if(!$breadcrumb){
		$breadcrumb = breadcrumb('<i class="fa fa-exclamation-circle btn-position" style="color: #0a8b00;"></i><span class="text-semibold">'.str_replace('%plugin%', $plugin, $lang['plug_installed']).'</span>', array('?mod=extras' => '<i class="fa fa-puzzle-piece btn-position"></i>'.$lang['extras'].'', '<i class="fa fa-thumbs-o-up btn-position"></i>'.str_replace('%plugin%', $plugin, $lang['plug_installeds']).'' ) );
	}
	
	if(!$main_admin){
		fixdb_plugin_install($plugin, '', 'install', false); 
	}
	
    // return if already installed
    if ($activated['installed'][$plugin]) {
        return 1;
    }

    $activated['installed'][$plugin] = 1;
    $PLUGINS['active'] = $activated;
	
    return savePluginsActiveList();
}

//
// Mark plugin as deinstalled
//
function plugin_mark_deinstalled($plugin)
{
    global $PLUGINS, $breadcrumb, $lang, $main_admin;

    // Load activated list
    $activated = getPluginsActiveList();
	
	$breadcrumb = breadcrumb('<i class="fa fa-exclamation-triangle btn-position" style="color: #8b1100;"></i><span class="text-semibold">'.str_replace('%plugin%', $plugin, $lang['plug_deinstalled']).'</span>', array('?mod=extras' => '<i class="fa fa-puzzle-piece btn-position"></i>'.$lang['extras'].'', '<i class="fa fa-trash-o btn-position"></i>'.str_replace('%plugin%', $plugin, $lang['plug_deinstalleds']).'' ) );

	if(!$main_admin){
		fixdb_plugin_install($plugin, '', '', false); 
	}
    // return if already installed
    if (!$activated['installed'][$plugin]) {
        return 1;
    }

    unset($activated['installed'][$plugin]);
    unset($activated['active'][$plugin]);
    foreach ($activated['actions'] as $k => $v) {
        unset($activated['actions'][$k][$plugin]);
    }
	
    $PLUGINS['active'] = $activated;

    return savePluginsActiveList();
}
