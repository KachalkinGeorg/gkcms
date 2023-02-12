<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: extras.rpc.php
// Description: Библиотека RPC для дополнительных манипуляций
// Author: NGCMS Development Team
//

// Protect against hack attempts
if (!defined('NGCMS')) {
    exit('HAL');
}

header('Content-Type: text/html; charset=utf-8');
setlocale(LC_ALL, 'ru_RU.UTF-8');

// Load library
@include_once root.'includes/classes/upload.class.php';
$lang = LoadLang('extras', 'admin');

// ////////////////////////////////////////////////////////////////////////////
// Processing functions :: show list of categories
// ///////////////////////////////////////////////////////////////////////////

function admExtrasGetConfig($params)
{
    global $userROW, $mysql, $PLUGINS;

    // Check for permissions
    if (!checkPermission(['plugin' => '#admin', 'item' => 'extras'], null, 'modify')) {
        // ACCESS DENIED
        return ['status' => 0, 'errorCode' => 3, 'errorText' => 'Access denied'];
    }

    // Check for security token
    if ($params['token'] != genUToken('admin.extras')) {
        return ['status' => 0, 'errorCode' => 5, 'errorText' => 'Wrong security code'];
    }

    pluginsLoadConfig();

    //$confLine = arrayCharsetConvert(0, $PLUGINS['config']);
    $confLine = json_encode($PLUGINS['config']);
    //$confLine = preg_replace('#\\(\\u....)#', '$1', $confLine);
    $confLine = jsonFormatter($confLine);

    return ['status' => 1, 'errorCode' => 0, 'errorText' => 'Ok', 'content' => $confLine];
    //return (array('status' => 1, 'errorCode' => 0, 'errorText' => 'Ok', 'content' => arrayCharsetConvert(0, $PLUGINS['config'])));
}

// Plugins switch ON/OFF
function admExtrasOnOff($params)
{
    global $userROW, $mysql, $PLUGINS;

    // Check for permissions
    if (!checkPermission(['plugin' => '#admin', 'item' => 'extras'], null, 'modify')) {
        // ACCESS DENIED
        return ['status' => 0, 'errorCode' => 3, 'errorText' => 'Access denied'];
    }

    // Check for security token
    if ($params['token'] != genUToken('admin.extras')) {
        return ['status' => 0, 'errorCode' => 5, 'errorText' => 'Wrong security code'];
    }

    // Check if plugin name is specified
    if (!$params['plugin'] || !$params['state']) {
        return ['status' => 0, 'errorCode' => 6, 'errorText' => 'Plugin name or state is not specified'];
    }

    $extras = pluginsGetList();
    if (!isset($extras[$params['plugin']])) {
        return ['status' => 0, 'errorCode' => 7, 'errorText' => 'Plugin ['.$params['plugin'].' is not found'];
    }

    // Manage `ON` call
    if ($params['state'] == 'on') {
        if (pluginSwitch($params['plugin'], 'on')) {
            ngSYSLOG(['plugin' => '#admin', 'item' => 'extras'], ['action' => 'switch_on', 'list' => ['plugin' => $params['plugin']]], null, [1, '']);

            return ['status' => 1, 'errorCode' => 0, 'errorText' => 'Ok', 'content' => 'Plugin ['.$params['plugin'].']is switched on'];
        } else {
            // generate error message
            ngSYSLOG(['plugin' => '#admin', 'item' => 'extras'], ['action' => 'switch_on', 'list' => ['plugin' => $params['plugin']]], null, [0, 'ERROR: '.$params['state']]);

            return ['status' => 0, 'errorCode' => 8, 'errorText' => 'Error turning plugin ['.$params['plugin'].'] on'];
        }
    }

    if ($params['state'] == 'off') {
        if ($extras[$params['plugin']]['permanent']) {
            ngSYSLOG(['plugin' => '#admin', 'item' => 'extras'], ['action' => 'switch_off', 'list' => ['plugin' => $params['plugin']]], null, [0, 'ERROR: PLUGIN is permanent '.$params['state']]);

            return ['status' => 0, 'errorCode' => 9, 'errorText' => 'Cannot turn off permanent plugin ['.$params['plugin'].']'];
        } else {
            if (pluginSwitch($params['plugin'], 'off')) {
                ngSYSLOG(['plugin' => '#admin', 'item' => 'extras'], ['action' => 'switch_off', 'list' => ['plugin' => $params['plugin']]], null, [1, '']);

                return ['status' => 1, 'errorCode' => 0, 'errorText' => 'Ok', 'content' => 'Plugin ['.$params['plugin'].']is switched on'];
            } else {
                ngSYSLOG(['plugin' => '#admin', 'item' => 'extras'], ['action' => 'switch_on', 'list' => ['plugin' => $params['plugin']]], null, [0, 'ERROR: '.$params['state']]);

                return ['status' => 0, 'errorCode' => 10, 'errorText' => 'Error turning plugin ['.$params['plugin'].'] off'];
            }
        }
    }

    return ['status' => 0, 'errorCode' => 11, 'errorText' => 'Unknown state'];
}

if (function_exists('rpcRegisterAdminFunction')) {
    rpcRegisterAdminFunction('admin.extras.getPluginConfig', 'admExtrasGetConfig');
    rpcRegisterAdminFunction('admin.extras.switch', 'admExtrasOnOff');
}
