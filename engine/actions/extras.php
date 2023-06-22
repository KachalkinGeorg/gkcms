<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: extras.php
// Description: Плагины
// Author: NGCMS Development Team
//

// Protect against hack attempts
if (!defined('NGCMS')) {
    exit('HAL');
}

// ==============================================================
//  Module functions
// ==============================================================
@include_once root.'includes/inc/extraconf.inc.php';
@include_once root.'includes/inc/httpget.inc.php';

// ==========================================================
// Functions
// ==========================================================

//
// Generate list of plugins
function admGeneratePluginList()
{
    global $lang, $twig, $repoPluginInfo, $PHP_SELF, $breadcrumb;

    $extras = pluginsGetList();
    ksort($extras);

    $pCount = [0 => 0, 1 => 0, 2 => 0, 3 => 0];

    $tEntries = [];
    foreach ($extras as $id => $extra) {
        if (!isset($extra['author_uri'])) {
            $extra['author_uri'] = '';
        }
        if (!isset($extra['author'])) {
            $extra['author'] = $lang['author.unknown'];
        }

        $tEntry = [
            'version'     => $extra['version'],
            'description' => isset($extra['description']) ? $extra['description'] : '',
            'author_url'  => ($extra['author_uri']) ? ('<a href="'.((strpos($extra['author_uri'], '@') !== false) ? 'mailto:' : '').$extra['author_uri'].'">'.$extra['author'].'</a>') : $extra['author'],
            'author'      => $extra['author'],
            'id'          => $extra['id'],
            'style'       => getPluginStatusActive($id) ? 'pluginEntryActive' : 'pluginEntryInactive',
			'icon' 		  => isset($extra['icon']) ? $extra['icon'] : '<i class="fa fa-puzzle-piece fa-2x"></i>',
            'logo'        => file_exists(extras_dir.'/'.$id.'/logo.png') && filesize(extras_dir.'/'.$id.'/logo.png') ? ('<img src="'.admin_url.'/plugins/'.$id.'/logo.png" width=70 height=70 />') : '',
			'info' 		  => $extra['information'] ? ('<a href="#" class="extra_info" data-toggle="modal" data-target="#modal-'.$id.'" data-placement="left" data-popup="tooltip" data-original-title="'.$lang['information'].'" title="'.$lang['information'].'"><i class="fa fa-exclamation-circle"></i></a>') : '',
			'information' => isset($extra['information']) ? $extra['information'] : '',
            'readme'      => file_exists(extras_dir.'/'.$id.'/readme') && filesize(extras_dir.'/'.$id.'/readme') ? ('<a class="extra_readme" href="'.admin_url.'/includes/showinfo.php?mode=plugin&amp;item=readme&amp;plugin='.$id.'" target="_blank" data-placement="left" data-popup="tooltip" data-original-title="'.$lang['entry.readme'].'" title="'.$lang['entry.readme'].'"><i class="fa fa-question-circle"></i></a>') : '',
            'history'     => file_exists(extras_dir.'/'.$id.'/history') && filesize(extras_dir.'/'.$id.'/history') ? ('<a class="extra_history" href="'.admin_url.'/includes/showinfo.php?mode=plugin&amp;item=history&amp;plugin='.$id.'" target="_blank" data-placement="left" data-popup="tooltip" data-original-title="'.$lang['entry.history'].'" title="'.$lang['entry.history'].'"><i class="fa fa-history"></i></a>') : '',
            'flags'       => [
                'isCompatible'  => $extra['isCompatible'],
            ],
        ];

        if (isset($repoPluginInfo[$extra['id']]) && ($repoPluginInfo[$extra['id']][1] > $extra['version'])) {
            $tEntry['new'] = '<a href="http://ngcms.ru/sync/plugins.php?action=jump&amp;id='.$extra['id'].'.html" title="'.$repoPluginInfo[$extra['id']][1].'"target="_blank"><img src="'.skins_url.'/images/new.png" width=30 height=15/></a>';
        } else {
            $tEntry['new'] = '';
        }

        $tEntry['type'] = in_array($extra['type'], ['plugin', 'module', 'filter', 'auth', 'widget', 'maintanance']) ? $lang[$extra['type']] : 'Undefined';

        //
        // Check for permanent modules
        //
        if (($extra['permanent']) and (!getPluginStatusActive($id))) {
            // turn on
            if (pluginSwitch($id, 'on')) {
                $notify = msg(['type' => 'info', 'text' => sprintf($lang['msgo_is_on'], $extra['name'])]);
            } else {
                // generate error message
                $notify = msg(['type' => 'error', 'text' => 'ERROR: '.sprintf($lang['msgo_is_on'], $extra['name'])]);
            }
        }

        $needinstall = 0;
        $tEntry['install'] = '';
        if (getPluginStatusInstalled($extra['id'])) {
            if (isset($extra['deinstall']) && $extra['deinstall'] && is_file(extras_dir.'/'.$extra['dir'].'/'.$extra['deinstall'])) {
                $tEntry['install'] = '<a href="'.$PHP_SELF.'?mod=extra-config&amp;plugin='.$extra['id'].'&amp;stype=deinstall" data-placement="left" data-popup="tooltip" data-original-title="'.$lang['deinstall'].'" title="'.$lang['deinstall'].'"><span class="fa-stack fa-1x"><i class="fa fa-circle fa-stack-2x" style="color: #2e353d;"></i><i class="fa fa-trash fa-stack-1x extra_trash"></i></span></a>';
            }
        } else {
            if (isset($extra['install']) && $extra['install'] && is_file(extras_dir.'/'.$extra['dir'].'/'.$extra['install'])) {
                $tEntry['install'] = '<a href="'.$PHP_SELF.'?mod=extra-config&amp;plugin='.$extra['id'].'&amp;stype=install" data-placement="left" data-popup="tooltip" data-original-title="'.$lang['install'].'" title="'.$lang['install'].'"><span class="fa-stack fa-1x"><i class="fa fa-circle fa-stack-2x" style="color: #2e353d;"></i><i class="fa fa-download fa-stack-1x extra_download"></i></span></a>';
                $needinstall = 1;
            }
        }

        $tEntry['url'] = (isset($extra['config']) && $extra['config'] && (!$needinstall) && is_file(extras_dir.'/'.$extra['dir'].'/'.$extra['config'])) ? '<a href="'.$PHP_SELF.'?mod=extra-config&amp;plugin='.$extra['id'].'">'.$extra['name'].'</a>' : $extra['name'];
        $tEntry['link'] = (getPluginStatusActive($id) ? '<a href="'.$PHP_SELF.'?mod=extras&amp;&amp;token='.genUToken('admin.extras').'&amp;disable='.$id.'" data-placement="left" data-popup="tooltip" data-original-title="'.$lang['switch_off'].'" title="'.$lang['switch_off'].'"><span class="fa-stack fa-1x"><i class="fa fa-circle fa-stack-2x" style="color: #2e353d;"></i><i class="fa fa-eye fa-stack-1x extra_eye"></i></span></a>' : '<a href="'.$PHP_SELF.'?mod=extras&amp;&amp;token='.genUToken('admin.extras').'&amp;enable='.$id.'" data-placement="left" data-popup="tooltip" data-original-title="'.$lang['switch_on'].'" title="'.$lang['switch_on'].'"><span class="fa-stack fa-1x"><i class="fa fa-circle fa-stack-2x" style="color: #2e353d;"></i><i class="fa fa-eye-slash fa-stack-1x" style="color: #7f7f7f;"></i></span></a></a>');

        if ($needinstall) {
            $tEntry['link'] = '';
            $tEntry['style'] = 'pluginEntryUninstalled';
            $pCount[3]++;
        } else {
            $pCount[1 + (!getPluginStatusActive($id))]++;
        }
        $pCount[0]++;

        $tEntries[] = $tEntry;
    }

	$breadcrumb = breadcrumb('<i class="fa fa-puzzle-piece btn-position"></i><span class="text-semibold">'.$lang['extras'].'</span>', '<i class="fa fa-puzzle-piece btn-position"></i>'.$lang['extras_title'].'' );

    $tVars = [
        'entries'        => $tEntries,
        'token'          => genUToken('admin.extras'),
        'cntAll'         => $pCount[0],
        'cntActive'      => $pCount[1],
        'cntInactive'    => $pCount[2],
        'cntUninstalled' => $pCount[3],
    ];
    $xt = $twig->loadTemplate(tpl_actions.'extras/table.tpl');

    return $xt->render($tVars);
}

function repoSync()
{
    global $extras, $config;
    if (($vms = cacheRetrieveFile('plugversion.dat', 86400)) === false) {
        // Prepare request to repository
        $paramList = ['_ver='.urlencode(engineVersion), 'UUID='.$config['UUID']];
        foreach ($extras as $id => $extra) {
            $paramList[] = urlencode($extra['id']).'='.urlencode($extra['version']);
        }

        $req = new http_get();
        $vms = $req->get('http://ngcms.ru/components/update/?action=info&'.implode('&', $paramList), 3, 1);

        // Save into cache
        cacheStoreFile('plugversion.dat', $vms);
    }
    $rps = unserialize($vms);

    return is_array($rps) ? $rps : [];
}

// ==============================================================
//  Main module code
// ==============================================================

$lang = LoadLang('extras', 'admin');
$extras = pluginsGetList();
ksort($extras);

// ==============================================================
// Load a list of updated plugins from central repository
// ==============================================================
$repoPluginInfo = repoSync();

// ==============================================================
// Process enable request
// ==============================================================
$enable = isset($_REQUEST['enable']) ? $_REQUEST['enable'] : '';
$disable = isset($_REQUEST['disable']) ? $_REQUEST['disable'] : '';
$manage = (isset($_REQUEST['manageConfig']) && $_REQUEST['manageConfig'] && isset($_REQUEST['action']) && ($_REQUEST['action'] == 'commit')) ? true : false;

// Check for security token
if ($enable || $disable || $manage) {
    if ((!isset($_REQUEST['token'])) || ($_REQUEST['token'] != genUToken('admin.extras'))) {
        $notify = msg(['type' => 'error', 'text' => $lang['error.security.token'], 'info' => $lang['error.security.token#desc']]);
        ngSYSLOG(['plugin' => '#admin', 'item' => 'extras', 'ds_id' => $id], ['action' => 'modify'], null, [0, 'SECURITY.TOKEN']);
        exit;
    }
}

if (isset($_REQUEST['manageConfig']) && $_REQUEST['manageConfig']) {
    pluginsLoadConfig();

    if (isset($_REQUEST['action']) && ($_REQUEST['action'] == 'commit')) {
        echo 'TRY COMMIT';
    }
    $confLine = json_encode($PLUGINS['config']);
    $confLine = jsonFormatter($confLine);
	
	$breadcrumb = breadcrumb('<i class="fa fa-puzzle-piece btn-position"></i><span class="text-semibold">'.$lang['extras'].'</span>', '<i class="fa fa-puzzle-piece btn-position"></i>'.$lang['extras_title'].'' );

    $tVars = [
        'config' => $confLine,
        'token'  => genUToken('admin.extras'),
    ];
    $xt = $twig->loadTemplate('skins/default/tpl/extras/manage_config.tpl');

    return $xt->render($tVars);

    exit;
}

if ($enable) {
    if (pluginSwitch($enable, 'on')) {
        ngSYSLOG(['plugin' => '#admin', 'item' => 'extras'], ['action' => 'switch_on', 'list' => ['plugin' => $enable]], null, [1, '']);
		msg(['type' => 'info', 'title' => $extras[$enable]['name'], 'text' => sprintf($lang['msgo_is_on'], 'admin.php?mod=extra-config&plugin=' . $extras[$enable]['id'], $extras[$enable]['name'])]);
    } else {
        // generate error message
        ngSYSLOG(['plugin' => '#admin', 'item' => 'extras'], ['action' => 'switch_on', 'list' => ['plugin' => $enable]], null, [0, 'ERROR: '.$enable]);
        $notify = msg(['type' => 'error', 'title' => $extras[$id]['name'], 'text' => 'ERROR: '.sprintf($lang['msgo_is_on'], $extras[$id]['name'])]);
    }
}

if ($disable) {
    if ($extras[$disable]['permanent']) {
        ngSYSLOG(['plugin' => '#admin', 'item' => 'extras'], ['action' => 'switch_off', 'list' => ['plugin' => $disable]], null, [0, 'ERROR: PLUGIN is permanent '.$disable]);
		msg(['type' => 'error', 'title' => $lang['permanent.lock'], 'text' => str_replace('{name}', $disable, $lang['permanent.lock#desc'])]);
    } else {
        if (pluginSwitch($disable, 'off')) {
            ngSYSLOG(['plugin' => '#admin', 'item' => 'extras'], ['action' => 'switch_off', 'list' => ['plugin' => $disable]], null, [1, '']);
			msg(['type' => 'info', 'title' => $extras[$disable]['name'], 'text' => sprintf($lang['msgo_is_off'], 'admin.php?mod=extra-config&plugin=' . $extras[$disable]['id'], $extras[$disable]['name'])]);
        } else {
            ngSYSLOG(['plugin' => '#admin', 'item' => 'extras'], ['action' => 'switch_on', 'list' => ['plugin' => $disable]], null, [0, 'ERROR: '.$disable]);
            msg(['type' => 'error', 'title' => $extras[$disable]['name'], 'text' => sprintf('ERROR: '.$lang['msgo_is_off'], $extras[$disable]['name'])]);
        }
    }
}

$main_admin = admGeneratePluginList();