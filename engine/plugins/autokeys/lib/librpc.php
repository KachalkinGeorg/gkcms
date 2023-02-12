<?php

//
// Online Auto-Keys generator
//

// Load library
LoadPluginLang('autokeys', 'admin', '', 'autokeys', ':');

function akeysGenerate($params){
    global $userROW;

    // Load library
    @include_once(root.'/plugins/autokeys/lib/class.php');

    // Check for permissions
    if (!checkPermission(array('plugin' => '#admin', 'item' => 'news'), null, 'modify')) {
        return array( 'status' => 0, 'errorCode' => 3, 'errorText' => $lang['access_denied'] );
    }

    // Check for permissions
    if (!isset($userROW) and !is_array($userROW) or ($userROW['status'] != 1)) {
        return array( 'status' => 0, 'errorCode' => 3, 'errorText' => $lang['access_denied'] );
    }

   // Scan incoming params
	if (!is_array($params) or empty($params['title']) or empty($params['content']) ) {
		return array( 'status' => 0, 'errorCode' => 4, 'errorText' => $lang['wrong_params_type'] );
	}

    // Generate keywords
    $words = akeysGetKeys(array('title' => $params['title'], 'content' => $params['content']));

    // Return output
    return array('status' => 1, 'errorCode' => 0, 'data' => $words);
}

rpcRegisterFunction('plugin.autokeys.generate', 'akeysGenerate');
