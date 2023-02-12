<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: ugroup.php
// Description: Управление группами пользователей
// Author: NGCMS Development Team
//

// Protect against hack attempts
if (!defined('NGCMS')) {
    exit('HAL');
}
$lang = LoadLang('ugroup', 'admin');

function ugroupList()
{
    global $mysql, $lang, $mod, $userROW, $UGROUP, $twig, $breadcrumb;

    // Check for permissions
    if (!checkPermission(['plugin' => '#admin', 'item' => 'ugroup'], null, 'view')) {
        msg(['type' => 'error', 'text' => $lang['perm.denied']], 1, 1);

        return;
    }

    $permModify = checkPermission(['plugin' => '#admin', 'item' => 'ugroup'], null, 'modify');
    $permDetails = checkPermission(['plugin' => '#admin', 'item' => 'ugroup'], null, 'details');

    // Calculate number of users in each group
    $uCount = [];

    $query = 'select status, count(*) as cnt from '.uprefix.'_users group by status';
    foreach ($mysql->select($query) as $row) {
        $uCount[$row['status']] = $row['cnt'];
    }
	
	$breadcrumb = breadcrumb('<i class="fa fa-users btn-position"></i><span class="text-semibold">'.$lang['user_groups'].'</span>', ''.$lang['user_groups'].'' );

    $tEntries = [];
    foreach ($UGROUP as $id => $grp) {
        $tEntry = [
            'id'       => $id,
            'identity' => $grp['identity'],
            'name'     => $grp['name'],
            'count'    => (isset($uCount[$id]) && $uCount[$id]) ? intval($uCount[$id]) : 0,
            'flags'    => [
                'canEdit'   => $permDetails,
                'canDelete' => (isset($uCount[$id]) and ($uCount[$id] < 1) and $permModify) ? true : true,
            ],
        ];

        $tEntries[] = $tEntry;
    }

    $tVars = [
        'token'   => genUToken('admin.ugroup'),
        'entries' => $tEntries,
        'flags'   => [
            'canAdd' => $permModify,
        ],
    ];

    $xt = $twig->loadTemplate('skins/default/tpl/ugroup/list.tpl');

    return $xt->render($tVars);
}

function ugroupForm()
{
    global $mysql, $lang, $mod, $PFILTERS, $twig, $UGROUP, $breadcrumb;

    // ID of group for editing
    $id = intval(getIsSet($_REQUEST['id']));

    // Add/Edit mode flag
    $editMode = ($id > 0) ? true : false;

	if($editMode){	
		$breadcrumb = breadcrumb('<i class="fa fa-users btn-position"></i><span class="text-semibold">'.$lang['edit_group'].'</span>', array('?mod=ugroup' => '<i class="fa fa-users"></i>'.$lang['user_groups'].'', '<i class="fa fa-pencil-square-o"></i>'.$lang['edit_group'].' - ['.$id.']' ) );
	}else{
		$breadcrumb = breadcrumb('<i class="fa fa-users btn-position"></i><span class="text-semibold">'.$lang['add_group'].'</span>', array('?mod=ugroup' => '<i class="fa fa-users"></i>'.$lang['user_groups'].'', '<i class="fa fa-plus-square-o"></i>'.$lang['add_group'].'' ) );
	}
	
    // Determine user's permissions
    $perm = checkPermission(['plugin' => '#admin', 'item' => 'ugroup'], null, ['modify', 'details']);
    $permModify = $perm['modify'];
    $permDetails = $perm['details'];

    // Check for permissions
    if (!$perm['modify'] && !$perm['details']) {
        ngSYSLOG(['plugin' => '#admin', 'item' => 'ugroup', 'ds_id' => $id], ['action' => 'editForm'], null, [0, 'SECURITY.PERM']);
        msg(['type' => 'error', 'text' => $lang['perm.denied']], 1, 1);

        return;
    }

    // Check if group exist
    if ($editMode && (!isset($UGROUP[$id]))) {
        ngSYSLOG(['plugin' => '#admin', 'item' => 'ugroup', 'ds_id' => $id], ['action' => 'editForm'], null, [0, 'NOT.FOUND']);
        msg(['type' => 'error', 'text' => $lang['msge_not_found']]);

        return;
    }

    $tVars = [
        'token' => genUToken('admin.ugroup'),
    ];
    if ($editMode) {
        $eGroup = $UGROUP[$id];

        $tVars['entry'] = $eGroup;
        $tVars['entry']['id'] = $id;
    } else {
        $tVars['entry'] = [
            'id'        => 0,
            'langNames' => [],
        ];
    }

    // Update supported languages
    foreach (ListFiles('lang', '') as $langName) {
        if (!isset($tVars['entry']['langName'][$langName])) {
            $tVars['entry']['langName'][$langName] = '';
        }
    }

    $tVars['flags'] = [
        'editMode'  => $editMode,
        'canModify' => $permModify,
    ];

    $xt = $twig->loadTemplate('skins/default/tpl/ugroup/addEdit.tpl');

    return $xt->render($tVars);
}

function ugroupCommit()
{
    global $mysql, $lang, $mod, $PFILTERS, $twig, $UGROUP;

    // ID of group for editing
    $id = intval($_REQUEST['id']);

    // Add/Edit mode flag
    $addMode = ($_REQUEST['action'] == 'add') ? true : false;
    $editMode = ($_REQUEST['action'] == 'edit') ? true : false;
    $deleteMode = ($_REQUEST['action'] == 'delete') ? true : false;

    // Determine user's permissions
    $perm = checkPermission(['plugin' => '#admin', 'item' => 'ugroup'], null, ['modify', 'details']);
    $permModify = $perm['modify'];
    $permDetails = $perm['details'];

    // Check for permissions
    if (!$perm['modify']) {
        ngSYSLOG(['plugin' => '#admin', 'item' => 'ugroup', 'ds_id' => $id], ['action' => 'editForm'], null, [0, 'SECURITY.PERM']);
        msg(['type' => 'error', 'text' => $lang['perm.denied']], 1, 1);

        return;
    }

    // Check for security token
    if ((!isset($_REQUEST['token'])) || ($_REQUEST['token'] != genUToken('admin.ugroup'))) {
        msg(['type' => 'error', 'text' => $lang['error.security.token'], 'info' => $lang['error.security.token#desc']]);
        ngSYSLOG(['plugin' => '#admin', 'item' => 'users', 'ds_id' => $id], ['action' => 'editForm'], null, [0, 'SECURITY.TOKEN']);

        return;
    }

    // Load configuration
    // ** If file exists - load it
    if (is_file(confroot.'ugroup.php')) {
        include confroot.'ugroup.php';
        $edGroup = $confUserGroup;
    } else {
        // ** ELSE - get system defaults
        $edGroup = $UGROUP;
    }

    // Check if group exist [ for EDIT/DELETE mode ]
    if (($editMode || $deleteMode) && (!isset($UGROUP[$id]))) {
        ngSYSLOG(['plugin' => '#admin', 'item' => 'ugroup', 'ds_id' => $id], ['action' => 'editForm'], null, [0, 'NOT.FOUND']);
        msg(['type' => 'error', 'text' => $lang['msge_not_found']]);

        return;
    }

    // Check for empty identity [ for ADD/EDIT ]
    if (($addMode || $editMode) && (trim($_REQUEST['identity']) == '')) {
        msg(['type' => 'error', 'text' => 'Identity is empty']);

        return;
    }

    // Check for conflicted identity [ for ADD/EDIT ]
    if ($addMode || $editMode) {
        $isConflicted = false;
        foreach ($edGroup as $eid => $eval) {
            if ((strtolower($_REQUEST['identity']) == strtolower($eval['identity'])) && ($_REQUEST['id'] != $eid)) {
                msg(['type' => 'error', 'text' => 'Specified identity is already used for other group']);

                return;
            }
        }
    }

    // ** PROCESS EDIT **
    if ($editMode) {
        // Update group info
        $edGroup[$id]['identity'] = trim($_REQUEST['identity']);

        // Update LANG info
        if (is_array($_REQUEST['langname'])) {
            foreach ($_REQUEST['langname'] as $lk => $lv) {
                $edGroup[$id]['langName'][$lk] = $lv;
            }
        }
    }

    // ** PROCESS ADD **
    if ($addMode) {
        $newGroup = [
            'identity' => trim($_REQUEST['identity']),
            'langName' => [],
        ];
        if (is_array($_REQUEST['langname'])) {
            foreach ($_REQUEST['langname'] as $lk => $lv) {
                $newGroup['langName'][$lk] = $lv;
            }
        }
        $edGroup[] = $newGroup;
    }

    // ** PROCESS DELETE **
    if ($deleteMode) {
        // Calculate number of users in each group
        $uCount = [];

        $query = 'select count(*) as cnt from '.uprefix.'_users where status = '.intval($id);
        if (is_array($uCount = $mysql->record($query)) && ($uCount['cnt'] > 0)) {
            // Don't allow to delete groups with users
            msg(['type' => 'error', 'text' => $lang['group_del_users']]);
			print_msg( 'error', ''.$lang['user_groups'].'', 'ВНИМАНИЕ!<br>Нельзя удалять группу, в которой находятся пользователи!', '?mod=ugroup' );
			return;
        }
        unset($edGroup[$id]);
		msg(['type' => 'info', 'text' => $lang['del_group']]);
		print_msg( 'delete', ''.$lang['user_groups'].'', 'Данная группа успешно удалена!', '?mod=ugroup' );
    }

    // Prepare resulting config content
    $fcData = "<?php\n".'$confUserGroup = '.var_export($edGroup, true)."\n;";

    // Try to save config
    $fcHandler = @fopen(confroot.'ugroup.php', 'w');
    if ($fcHandler) {
        fwrite($fcHandler, $fcData);
        fclose($fcHandler);

        msg(['type' => 'info', 'text' => $lang['save_done']]);

        // Reload groups
        loadGroups();
    } else {
        msg(['type' => 'error', 'text' => $lang['save_error'], 'info' => $lang['save_error#desc']]);

        return false;
    }
}

if (($action == 'editForm') || ($action == 'addForm')) {
    $main_admin = ugroupForm();
} else {
    switch ($action) {
        case 'edit':
			ugroupCommit();
			return print_msg( 'update', ''.$lang['user_groups'].'', 'Группа успешно отредактирована!', '?mod=ugroup' );
            break;
        case 'delete':
			ugroupCommit();
			return;
            break;
        case 'add':
			ugroupCommit();
			return print_msg( 'success', ''.$lang['user_groups'].'', 'Новая группы добавлена!', '?mod=ugroup' );
            break;
    }
    $main_admin = ugroupList();
}
