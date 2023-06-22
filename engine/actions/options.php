<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: options.php
// Description: Все настройки
// Author: NGCMS Development Team
//

if (!defined('NGCMS')) {
    exit('HAL');
}

// ==============================================================
//  Module functions
// ==============================================================
@include_once root.'includes/inc/extraconf.inc.php';
@include_once root.'includes/inc/httpget.inc.php';


$lang = LoadLang('options', 'admin');

function allOptionList()
{
    global $lang, $twig, $PHP_SELF, $breadcrumb;
	
    $extras = pluginsGetList();
    ksort($extras);

    $pCount = [0 => 0, 1 => 0, 2 => 0, 3 => 0];

    $tEntries = [];
    foreach ($extras as $id => $extra) {
        if (!isset($extra['author_uri'])) {
            $extra['author_uri'] = '';
        }
        if (!isset($extra['author'])) {
            $extra['author'] = 'Unknown';
        }

        $tEntry = [
            'version'     => $extra['version'],
            'description' => isset($extra['description']) ? $extra['description'] : '',
            'author_url'  => ($extra['author_uri']) ? ('<a href="'.((strpos($extra['author_uri'], '@') !== false) ? 'mailto:' : '').$extra['author_uri'].'">'.$extra['author'].'</a>') : $extra['author'],
            'author'      => $extra['author'],
            'id'          => $extra['id'],
			'icon' 		  => isset($extra['icon']) ? $extra['icon'] : '<i class="fa fa-puzzle-piece fa-2x"></i>',
            'logo'        => file_exists(extras_dir.'/'.$id.'/logo.png') && filesize(extras_dir.'/'.$id.'/logo.png') ? ('<img src="'.admin_url.'/plugins/'.$id.'/logo.png" width=70 height=70 />') : '',
			'info' 		  => $extra['information'] ? ('<a href="#" class="extra_info" data-toggle="modal" data-target="#modal-'.$id.'" data-placement="top" data-popup="tooltip" data-original-title="'.$lang['information'].'" title="'.$lang['information'].'"><i class="fa fa-exclamation-circle"></i></a>') : '',
			'information' => isset($extra['information']) ? $extra['information'] : '',
            'readme'      => file_exists(extras_dir.'/'.$id.'/readme') && filesize(extras_dir.'/'.$id.'/readme') ? ('<a class="extra_readme" href="'.admin_url.'/includes/showinfo.php?mode=plugin&amp;item=readme&amp;plugin='.$id.'" target="_blank" data-placement="top" data-popup="tooltip" data-original-title="'.$lang['entry.readme'].'" title="'.$lang['entry.readme'].'"><i class="fa fa-question-circle"></i></a>') : '',
            'history'     => file_exists(extras_dir.'/'.$id.'/history') && filesize(extras_dir.'/'.$id.'/history') ? ('<a class="extra_history" href="'.admin_url.'/includes/showinfo.php?mode=plugin&amp;item=history&amp;plugin='.$id.'" target="_blank" data-placement="top" data-popup="tooltip" data-original-title="'.$lang['entry.history'].'" title="'.$lang['entry.history'].'"><i class="fa fa-history"></i></a>') : '',
            'flags'       => [
                'isCompatible'  => $extra['isCompatible'],
            ],
        ];


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

        $tEntry['url'] = (isset($extra['config']) && $extra['config'] && (!$needinstall) && is_file(extras_dir.'/'.$extra['dir'].'/'.$extra['config'])) ? '<a href="'.$PHP_SELF.'?mod=extra-config&amp;plugin='.$extra['id'].'">'.$extra['name'].'</a>' : $extra['name'];

        if ($needinstall) {
            $tEntry['link'] = '';
            $pCount[3]++;
        } else {
            $pCount[1 + (!getPluginStatusActive($id))]++;
        }
        $pCount[0]++;

	if (getPluginStatusActive($id)) {
        $tEntries[] = $tEntry;
    }
	}

	$breadcrumb = breadcrumb('<i class="fa fa-cogs btn-position"></i><span class="text-semibold">'.$lang['settings'].'</span>', '<i class="fa fa-cogs"></i>'.$lang['settings'].'' );
	
    $tVars = [
        'entries'        => $tEntries,
        'token'          => genUToken('admin.extras'),
        'cntAll'         => $pCount[0],
        'cntActive'      => $pCount[1],
        'cntInactive'    => $pCount[2],
        'cntUninstalled' => $pCount[3],
    ];
    $xt = $twig->loadTemplate(tpl_actions.'options.tpl');

    return $xt->render($tVars);
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

$main_admin = allOptionList();