<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: users.php
// Description: Управления пользователями
// Author: NGCMS Development Team
//

// Protect against hack attempts
if (!defined('NGCMS')) {
    exit('HAL');
}

$lang = LoadLang('users', 'admin');

LoadPluginLibrary('uprofile', 'lib');

//
// Form: Edit user
function userEditForm()
{
    global $mysql, $lang, $twig, $mod, $PFILTERS, $userROW, $UGROUP, $PHP_SELF, $config, $breadcrumb;

    $id = (getIsSet($_REQUEST['id'])) ? intval($_REQUEST['id']) : 0;

    // Determine user's permissions
    $perm = checkPermission(['plugin' => '#admin', 'item' => 'users'], null, ['modify', 'details']);
    $permModify = $perm['modify'];
    $permDetails = $perm['details'];

    // Check for permissions
    if (!$perm['modify'] && !$perm['details']) {
        ngSYSLOG(['plugin' => '#admin', 'item' => 'users', 'ds_id' => $id], ['action' => 'editForm'], null, [0, 'SECURITY.PERM']);
        msg(['type' => 'error', 'text' => $lang['perm.denied']], 1, 1);
		print_msg( 'error', $lang['users_title'], $lang['perm.denied'], '?mod=users' );
        return;
    }

    if (!($row = $mysql->record('select * from '.uprefix.'_users where id='.db_squote($id)))) {
        ngSYSLOG(['plugin' => '#admin', 'item' => 'users', 'ds_id' => $id], ['action' => 'editForm'], null, [0, 'NOT.FOUND']);
        msg(['type' => 'error', 'text' => $lang['msge_not_found']]);
		print_msg( 'error', $lang['users_title'], $lang['msge_not_found'], '?mod=users' );
        return;
    }

    // Manage profile data [if needed]
    if (is_array($PFILTERS['plugin.uprofile'])) {
        foreach ($PFILTERS['plugin.uprofile'] as $k => $v) {
            $v->editProfileFormPre($row['id'], $row);
        }
    }

    $status = '';
    foreach ($UGROUP as $ugID => $ugData) {
        $status .= ' <option value="'.$ugID.'"'.(($row['status'] == $ugID) ? ' selected' : '').'>'.$ugID.' ('.$ugData['name'].')</option>';
    }
	
	$breadcrumb = breadcrumb('<i class="fa fa-users btn-position"></i><span class="text-semibold">'.$lang['profile_of'].' ['.$row['name'].']</span>', array('?mod=users' => '<i class="fa fa-users"></i>'.$lang['users_title'].'', '<i class="fa fa-user-circle-o"></i>'.$lang['profile_of'].' ['.$row['name'].']' ) );

	$skins_url = skins_url;
	$avatar = ( isset($row['avatar']) and !empty($row['avatar']) and function_exists('userGetAvatar'))? userGetAvatar($userROW)[1] : $skins_url . '/images/default-avatar.jpg';
	$photo = ( isset($row['photo']) and !empty($row['photo']) and function_exists('userGetPhoto'))? userGetPhoto($userROW)[1] : $skins_url . '/images/default-avatar.jpg';
	$group = $UGROUP[$row['status']]['langName'][$config['default_lang']];
	$line = on_of_line($row['id']) ? on_of_line($row['id']) : $lang['on_of_line'];
	$alt_name = secure_html($row['alt_name']) ? secure_html($row['alt_name']) : $lang['alt_name_not'];
	$userPhoto = userGetPhoto($row);
	$userAvatar = userGetAvatar($row);
    //	Обрабатываем необходимые переменные для шаблона
    $tVars = [
        'php_self'   => $PHP_SELF,
        'name'       => secure_html($row['name']),
		'alt_name'   => $alt_name,
        'regdate'    => LangDate('l, j Q Y - H:i', $row['reg']),
        'com'        => $row['com'],
        'news'       => $row['news'],
        'status'     => $status,
		'group'      => $group,
		'avatar'     => $avatar,
		'photo'      => $photo,
		'line'     	 => $line,
		'site'       => secure_html($row['site']),
        'mail'       => secure_html($row['mail']),
        'gender'     => makeDropDown(array('0' => $lang['gender_not'], '1' => $lang['gender_m'], '2' => $lang['gender_w']), 'gender', $row['gender']),
        'icq'        => secure_html($row['icq']),
        'where_from' => secure_html($row['where_from']),
        'info'       => secure_html($row['info']),
		'inform'     => secure_html($row['info']) ? secure_html($row['info']) : $lang['inform_not'],
        'id'         => $id,
        'last'       => (empty($row['last'])) ? $lang['no_last'] : LangDate('l, j Q Y - H:i', $row['last']),
        'ip'         => $row['ip'],
        'token'      => genUToken('admin.users'),
        'perm'       => [
            'modify' => $perm['modify'] ? 1 : 0,
        ],
		'flags'               => [
			'photoAllowed'  => $config['use_photos'] ? 1 : 0,
			'avatarAllowed' => $config['use_avatars'] ? 1 : 0,
			'hasPhoto'  => $config['use_photos'] && $userPhoto[0],
			'hasAvatar' => $config['use_avatars'] && $userAvatar[0],
		],
    ];

    if (is_array($PFILTERS['plugin.uprofile'])) {
        foreach ($PFILTERS['plugin.uprofile'] as $k => $v) {
            $v->editProfileForm($row['id'], $row, $tVars);
        }
    }

    ngSYSLOG(['plugin' => '#admin', 'item' => 'users', 'ds_id' => $id], ['action' => 'editForm'], null, [1]);

    $xt = $twig->loadTemplate('skins/default/tpl/users/edit.tpl');

    return $xt->render($tVars);
}

//
// Edit user's profile
function userEdit()
{
    global $mysql, $lang, $mod, $config, $userROW;

    // Check for permissions
    if (!checkPermission(['plugin' => '#admin', 'item' => 'users'], null, 'modify')) {
        msg(['type' => 'error', 'text' => $lang['perm.denied']], 1, 1);
        ngSYSLOG(['plugin' => '#admin', 'item' => 'users', 'ds_id' => $id], ['action' => 'editForm'], null, [0, 'SECURITY.PERM']);
		print_msg( 'error', $lang['users_title'], $lang['perm.denied'], '?mod=users' );

        return;
    }

    // Check for security token
    if ((!isset($_REQUEST['token'])) || ($_REQUEST['token'] != genUToken('admin.users'))) {
        msg(['type' => 'error', 'text' => $lang['error.security.token'], 'info' => $lang['error.security.token#desc']]);
        ngSYSLOG(['plugin' => '#admin', 'item' => 'users', 'ds_id' => $id], ['action' => 'editForm'], null, [0, 'SECURITY.TOKEN']);
		print_msg( 'error', $lang['users_title'], ''.$lang['error.security.token'].'<br>'.$lang['error.security.token#desc'].'', '?mod=users' );
        return;
    }

    $id = intval($_REQUEST['id']);

    // Check if user exists
    if (!($row = $mysql->record('select * from '.uprefix.'_users where id='.db_squote($id)))) {
        msg(['type' => 'error', 'text' => $lang['msge_not_found']]);
        ngSYSLOG(['plugin' => '#admin', 'item' => 'users', 'ds_id' => $id], ['action' => 'editForm'], null, [0, 'NOT.FOUND']);
		print_msg( 'error', $lang['users_title'], $lang['msge_not_found'], '?mod=users' );
        return;
    }

    $pass = ($_REQUEST['password']) ? EncodePassword($_REQUEST['password']) : '';

    // Prepare a list of changed params
    $cList = [];
    foreach (['level', 'site', 'icq', 'where_from', 'info', 'mail'] as $k) {
        if ($row[$k] != $_REQUEST[$k]) {
            $cList[$k] = [$row[$k], $_REQUEST[$k]];
        }
    }
    if ($pass) {
        $cList['pass'] = ['****', '****'];
    }

	@include_once root . 'includes/classes/upload.class.php';
	
	$currentUser = $userROW;

	if ($_REQUEST['delphoto']) {
		uprofile_manageDelete('photo', $currentUser['id']);
	} else {
		$photo = $currentUser['photo'];
	}
	if ($_REQUEST['delavatar']) {
		uprofile_manageDelete('avatar', $currentUser['id']);
	} else {
		$avatar = $currentUser['avatar'];
	}

	if ($_FILES['newavatar']['name']) {
		// Delete an avatar if user already has it
		uprofile_manageDelete('avatar', $currentUser['id']);
		$fmanage = new file_managment();
		$imanage = new image_managment();
		$up = $fmanage->file_upload(array('type' => 'avatar', 'http_var' => 'newavatar', 'replace' => 1, 'manualfile' => $currentUser['id'] . '.' . strtolower($_FILES['newavatar']['name'])));
		if (is_array($up)) {
			// Now fetch information about size and prepare to write info into DB
			if (is_array($sz = $imanage->get_size($config['avatars_dir'] . $up[1]))) {
				$fmanage->get_limits('avatar');
				// Check avatar size limit (!!!)
				$lwh = intval($config['avatar_wh']);
				if ($lwh && (($sz[1] > $lwh) || ($sz[2] > $lwh))) {
					// Fatal: uploaded avatar mismatch size limits !
					msg(array("type" => "error", "text" => $lang['msge_size'], "info" => sprintf($lang['msgi_size'], $lwh . 'x' . $lwh)));
					return print_msg( 'error', ''.$lang['users_title'].'', ''.$lang['msge_size'].'<br>'.sprintf($lang['msgi_size'], $lwh . 'x' . $lwh).'', 'javascript:history.go(-1)' );
					$fmanage->file_delete(array('type' => 'avatar', 'id' => $up[0]));
				} else {
					$mysql->query("update " . prefix . "_" . $fmanage->tname . " set width=" . db_squote($sz[1]) . ", height=" . db_squote($sz[2]) . " where id = " . db_squote($up[0]));
					$avatar = $up[1];
				}
			} else {
				// We were unable to fetch image size. Damaged file, delete it!
				msg(array("type" => "error", "text" => $lang['msge_damaged']));
				return print_msg( 'error', ''.$lang['users_title'].'', $lang['msge_damaged'], 'javascript:history.go(-1)' );
				$fmanage->file_delete(array('type' => 'avatar', 'id' => $up[0]));
			}
		}
	}
	
	if ($_FILES['newphoto']['name']) {
		// Delete a photo if user already has it
		uprofile_manageDelete('photo', $currentUser['id']);
		$fmanage = new file_managment();
		$imanage = new image_managment();
		$up = $fmanage->file_upload(array('type' => 'photo', 'http_var' => 'newphoto', 'replace' => 1, 'manualfile' => $currentUser['id'] . '.' . strtolower($_FILES['newphoto']['name'])));
		if (is_array($up)) {
			if (is_array($sz = $imanage->get_size($config['photos_dir'] . $subdirectory . '/' . $up[1]))) {
				$fmanage->get_limits('photo');
				// Create preview for photo
				$tsx = intval($config['photos_thumb_size_x']) ? intval($config['photos_thumb_size_x']) : intval($config['photos_thumb_size']);
				$tsy = intval($config['photos_thumb_size_y']) ? intval($config['photos_thumb_size_y']) : intval($config['photos_thumb_size']);
				if (($tsx < 10) || ($tsx > 1000)) $tsx = 150;
				if (($tsy < 10) || ($tsy > 1000)) $tsy = 150;
				$thumb = $imanage->create_thumb($config['photos_dir'] . $subdirectory, $up[1], $tsx, $tsy);
				// If we were unable to create thumb - delete photo, it's damaged!
				if (!$thumb) {
					msg(array("type" => "error", "text" => $lang['msge_damaged']));
					return print_msg( 'error', ''.$lang['users_title'].'', $lang['msge_damaged'], 'javascript:history.go(-1)' );
					$fmanage->file_delete(array('type' => 'photo', 'id' => $up[0]));
				} else {
					$mysql->query("update " . prefix . "_" . $fmanage->tname . " set width=" . db_squote($sz[1]) . ", height=" . db_squote($sz[2]) . ", preview=1 where id = " . db_squote($up[0]));
					$photo = $up[1];
				}
			} else {
				// We were unable to fetch image size. Damaged file, delete it!
				msg(array("type" => "error", "text" => $lang['msge_damaged']));
				return print_msg( 'error', ''.$lang['users_title'].'', $lang['msge_damaged'], 'javascript:history.go(-1)' );
				$fmanage->file_delete(array('type' => 'photo', 'id' => $up[0]));
			}
		}
	}
	
	if (getPluginStatusActive('xfields')) {
	
		$xf = xf_configLoad();

		$rcall = $_REQUEST['xfields'];
		if (!is_array($rcall)) $rcall = array();

		$xdata = array();
		foreach ($xf['users'] as $id => $data) {
			if ($rcall[$id] != '') {
				$xdata[$id] = $rcall[$id];
			} else if ($data['required']) {
				msg(array("type" => "error", "text" => str_replace('%field%', $id, $lang['xf_msge_emptyrequired'])));
				print_msg( 'error', $lang['users_title'], str_replace('%field%', $id, $lang['xf_msge_emptyrequired']), '?mod=users' );
				return;
			}
		}

	    $xfields   = xf_encode($xdata);
	}
	
    ngSYSLOG(['plugin' => '#admin', 'item' => 'users', 'ds_id' => $id], ['action' => 'editForm', 'list' => $cList], null, [$userROW['status'], 'editupdateuser']);

    $mysql->query('update '.uprefix.'_users set `status`='.db_squote($_REQUEST['status']).', `site`='.db_squote($_REQUEST['site']).', `alt_name`='.db_squote($_REQUEST['alt_name']).', `gender`='.db_squote($_REQUEST['gender']).', `icq`='.db_squote($_REQUEST['icq']).', `photo`='.db_squote($photo).', `avatar`='.db_squote($avatar).', `where_from`='.db_squote($_REQUEST['where_from']).', `info`='.db_squote($_REQUEST['info']).', `mail`='.db_squote($_REQUEST['mail']).($pass ? ', `pass`='.db_squote($pass) : '').($xfields ? ', `xfields`='.db_squote($xfields) : '').' where id='.db_squote($row['id']));
    msg(['type' => 'info', 'text' => $lang['msgo_edituser']]);
	return print_msg( 'update', $lang['users_title'], str_replace('%name%', $row['name'], $lang['msgk_edituser']), array('?mod=users&action=editForm&id='.$row['id'] => $lang['edit'], '?mod=users' => $lang['back'] ) );
}

function uprofile_manageDelete($type, $userID) {

	global $mysql, $userROW;
	// Load required library
	@include_once root . 'includes/classes/upload.class.php';
	$localUpdate = 0;
	$userID = intval($userID);
	if ($userID != $userROW['id']) {
		if (!is_array($uRow = $mysql->record("select * from " . uprefix . "_users where id = " . $userID)))
			return;
	} else {
		$uRow = $userROW;
		$localUpdate = 1;
	}
	// Search for avatar record in mySQL table
	if (is_array($imageRow = $mysql->record("select * from " . prefix . "_images where owner_id = " . $userID . " and category = " . ($type == 'avatar' ? 1 : 2)))) {
		// Info was found in SQL table
		$fmanager = new file_managment();
		$fmanager->file_delete(array('type' => $type, 'id' => $imageRow['id']));
		//unlink(avatars_dir.$imageRow['name']);
	} else if ($uRow[$type]) {
		// Try to delete all avatars of this user
		@unlink($avatar_dir . $uRow['id'] . '.*');
	}
	$mysql->query("update " . uprefix . "_users set " . ($type == 'photo' ? 'photo' : 'avatar') . " = '' where id = " . $userID);
	if ($localUpdate) $userROW[$type] = '';
}

//
// Add new user
function userAdd()
{
    global $mysql, $lang, $mod, $config;

    // Check for permissions
    if (!checkPermission(['plugin' => '#admin', 'item' => 'users'], null, 'modify')) {
        msg(['type' => 'error', 'text' => $lang['perm.denied']], 1, 1);
		print_msg( 'error', $lang['users_title'], $lang['perm.denied'], '?mod=users' );
        return;
    }

    // Check for security token
    if ((!isset($_REQUEST['token'])) || ($_REQUEST['token'] != genUToken('admin.users'))) {
        msg(['type' => 'error', 'text' => $lang['error.security.token'], 'info' => $lang['error.security.token#desc']]);
		print_msg( 'error', $lang['users_title'], ''.$lang['error.security.token'].'<br>'.$lang['error.security.token#desc'].'', '?mod=users' );
        return;
    }

    $regusername = trim($_REQUEST['regusername']);
	$regaltname = trim($_REQUEST['regaltname']);
    $regemail = trim($_REQUEST['regemail']);
    $regpassword = $_REQUEST['regpassword'];
    $reglevel = $_REQUEST['reglevel'];
	$reggender = trim($_REQUEST['reggender']);

    if ((!$regusername) || (!strlen(trim($regpassword))) || (!$regemail)) {
        msg(['type' => 'error', 'text' => $lang['msge_fields'], 'info' => $lang['msgi_fields']]);
		print_msg( 'warning', $lang['users_title'], $lang['msgk_fields'], 'javascript:history.go(-1)' );
        return;
    }
    if ($mysql->record('select * from '.uprefix.'_users where lower(name) = '.db_squote(strtolower($regusername)).' or lower(mail)='.db_squote(strtolower($regemail)))) {
        msg(['type' => 'error', 'text' => $lang['msge_userexists'], 'info' => $lang['msgi_userexists']]);
		print_msg( 'warning', $lang['users_title'], $lang['msgk_userexists'], 'javascript:history.go(-1)' );
        return;
    }

    $add_time = time() + ($config['date_adjust'] * 60);
    $regpassword = EncodePassword($regpassword);

    $mysql->query('insert into '.uprefix.'_users (name, alt_name, pass, mail, status, reg, gender) values ('.db_squote($regusername).', '.db_squote($regaltname).', '.db_squote($regpassword).', '.db_squote($regemail).', '.db_squote($reglevel).', '.db_squote($add_time).', '.db_squote($reggender).')');
    msg(['type' => 'info', 'text' => $lang['msgo_adduser']]);
	
	$userid = $mysql->lastid('users');
	
	return print_msg( 'success', $lang['users_title'], str_replace('%user%', $regusername, $lang['msgk_newuser']), array('?mod=users&action=editForm&id='.$userid => $lang['edit'], '?mod=users' => $lang['back'] ) );
}

//
// Bulk action: activate selected users
function userMassActivate()
{
    global $mysql, $lang;

    // Check for permissions
    if (!checkPermission(['plugin' => '#admin', 'item' => 'users'], null, 'modify')) {
        msg(['type' => 'error', 'text' => $lang['perm.denied']], 1, 1);
		print_msg( 'error', $lang['users_title'], ''.$lang['msge_userexists'].'', 'javascript:history.go(-1)' );
        return;
    }

    // Check for security token
    if ((!isset($_REQUEST['token'])) || ($_REQUEST['token'] != genUToken('admin.users'))) {
        msg(['type' => 'error', 'text' => $lang['error.security.token'], 'info' => $lang['error.security.token#desc']]);
		print_msg( 'error', $lang['users_title'], ''.$lang['error.security.token'].'<br>'.$lang['error.security.token#desc'].'', 'javascript:history.go(-1)' );
        return;
    }

    $selected_users = getIsSet($_REQUEST['selected_users']);
    if (!$selected_users) {
        msg(['type' => 'error', 'text' => $lang['msge_select'], 'info' => $lang['msgi_select']]);
		print_msg( 'error', $lang['users_title'], ''.$lang['msge_select'].'<br>'.$lang['msgi_select'].'', 'javascript:history.go(-1)' );
        return;
    }
    foreach ($selected_users as $id) {
        $mysql->query('update '.uprefix."_users set activation='' where id=".db_squote($id));
    }
    msg(['type' => 'info', 'text' => $lang['msgo_activate']]);
	return print_msg( 'info', $lang['users_title'], $lang['msgo_activate'], '?mod=users' );
}

//
// Bulk action: LOCK selected users
function userMassLock()
{
    global $mysql, $lang;

    // Check for permissions
    if (!checkPermission(['plugin' => '#admin', 'item' => 'users'], null, 'modify')) {
        msg(['type' => 'info', 'type' => 'error', 'text' => $lang['perm.denied']], 1, 1);
		print_msg( 'error', $lang['users_title'], $lang['perm.denied'], '?mod=users' );
        return;
    }

    // Check for security token
    if ((!isset($_REQUEST['token'])) || ($_REQUEST['token'] != genUToken('admin.users'))) {
        msg(['type' => 'info', 'type' => 'error', 'text' => $lang['error.security.token'], 'info' => $lang['error.security.token#desc']]);
		print_msg( 'error', $lang['users_title'], ''.$lang['error.security.token'].'<br>'.$lang['error.security.token#desc'].'', '?mod=users' );
        return;
    }

    $selected_users = getIsSet($_REQUEST['selected_users']);
    if (!$selected_users) {
        msg(['type' => 'error', 'text' => $lang['msge_select'], 'info' => $lang['msgi_select']]);
		print_msg( 'error', $lang['users_title'], $lang['msgi_select'], '?mod=users' );
        return;
    }

    // Lock all users (excluding admins) and log them out!
    foreach ($selected_users as $id) {
        $mysql->query('update '.uprefix.'_users set activation='.db_squote(MakeRandomPassword()).", authcookie='' where (id=".db_squote($id).') and (status <> 1)');
    }
    msg(['type' => 'info', 'text' => $lang['msgo_lock']]);
	return print_msg( 'warning', $lang['users_title'], $lang['msgo_lock'], '?mod=users' );
}

//
// Bulk action: set status to selected users
function userMassSetStatus()
{
    global $mysql, $lang, $userROW, $UGROUP;

    // Check for permissions
    if (!checkPermission(['plugin' => '#admin', 'item' => 'users'], null, 'modify')) {
        msg(['type' => 'error', 'text' => $lang['perm.denied']], 1, 1);
		print_msg( 'error', $lang['users_title'], $lang['perm.denied'], '?mod=users' );
        return;
    }

    // Check for security token
    if ((!isset($_REQUEST['token'])) || ($_REQUEST['token'] != genUToken('admin.users'))) {
        msg(['type' => 'error', 'text' => $lang['error.security.token'], 'info' => $lang['error.security.token#desc']]);
		print_msg( 'error', $lang['users_title'], ''.$lang['error.security.token'].'<br>'.$lang['error.security.token#desc'].'', '?mod=users' );
        return;
    }

    $selected_users = getIsSet($_REQUEST['selected_users']);
    if (!$selected_users) {
        msg(['type' => 'error', 'text' => $lang['msge_select'], 'info' => $lang['msgi_select']]);
		print_msg( 'error', $lang['users_title'], $lang['msgk_select'], '?mod=users' );
        return;
    }

    // Determine status to set to
    // NOTE: we CAN'T set status `ADMIN` and we can't change STATUS for ADMINS
    $status = intval($_REQUEST['newstatus']);
    if (!isset($UGROUP[$status]) || ($status <= 1)) {
        msg(['type' => 'error', 'info' => $lang['msg_massadm']]);
		print_msg( 'error', $lang['users_title'], $lang['msg_massadm'], '?mod=users' );
        return;
    }

    // Lock all users (excluding admins)
    foreach ($selected_users as $id) {
        $mysql->query('update '.uprefix.'_users set status='.db_squote($status).' where (id='.db_squote($id).') and (status <> 1)');
    }
    msg(['type' => 'info', 'text' => $lang['msgo_status']]);
	return print_msg( 'update', $lang['users_title'], str_replace('%status%', $status, $lang['msgk_status']), '?mod=users' );
}

//
// Bulk action: delete selected users
function userMassDelete()
{
    global $mysql, $lang, $userROW, $config;

    // Check for permissions
    if (!checkPermission(['plugin' => '#admin', 'item' => 'users'], null, 'modify')) {
        msg(['type' => 'error', 'text' => $lang['perm.denied']], 1, 1);
		print_msg( 'error', $lang['users_title'], $lang['perm.denied'], '?mod=users' );
        return;
    }

    // Check for security token
    if ((!isset($_REQUEST['token'])) || ($_REQUEST['token'] != genUToken('admin.users'))) {
        msg(['type' => 'error', 'text' => $lang['error.security.token'], 'info' => $lang['error.security.token#desc']]);
		print_msg( 'error', $lang['users_title'], ''.$lang['error.security.token'].'<br>'.$lang['error.security.token#desc'].'', '?mod=users' );
        return;
    }

    $selected_users = getIsSet($_REQUEST['selected_users']);
    if (!$selected_users || !is_array($selected_users)) {
        msg(['type' => 'error', 'text' => $lang['msge_select'], 'info' => $lang['msgi_select']]);
		print_msg( 'error', $lang['users_title'], $lang['msgk_select'], '?mod=users' );
        return;
    }

    foreach ($selected_users as $id) {
        // Don't let us to delete ourselves
        if ($id == $userROW['id']) {
            continue;
        }

        // Fetch user's record
        if (is_array($urow = $mysql->record('select * from '.prefix.'_users where id = '.db_squote($id)))) {
            // Do not delete admins
            if ($urow['status'] == 1) {
                continue;
            }

            // Check if user has his own photo or avatar
            if (($urow['avatar'] != '') && (file_exists($config['avatars_dir'].$urow['photo']))) {
                @unlink($config['avatars_dir'].$urow['avatar']);
            }

            if (($urow['photo'] != '') && (file_exists($config['photos_dir'].$urow['photo']))) {
                @unlink($config['photos_dir'].$urow['photo']);
            }

            $mysql->query('delete from '.uprefix.'_users where id='.db_squote($id));
        }
    }
    msg(['type' => 'info', 'text' => $lang['msgo_deluser']]);
	return print_msg( 'delete', $lang['users_title'], str_replace('%name%', $urow['name'], $lang['msgk_deluser']), '?mod=users' );
}

//
// Bulk action: delete inactive (never logged in) users [but user should be registered for more than 1 day ago or who have 1+ news]
function userMassDeleteInactive()
{
    global $mysql, $lang, $userROW;

    // Check for permissions
    if (!checkPermission(['plugin' => '#admin', 'item' => 'users'], null, 'modify')) {
        msg(['type' => 'error', 'text' => $lang['perm.denied']], 1, 1);
		print_msg( 'error', $lang['users_title'], $lang['perm.denied'], '?mod=users' );
        return;
    }

    // Check for security token
    if ((!isset($_REQUEST['token'])) || ($_REQUEST['token'] != genUToken('admin.users'))) {
        msg(['type' => 'error', 'text' => $lang['error.security.token'], 'info' => $lang['error.security.token#desc']]);
		print_msg( 'error', $lang['users_title'], ''.$lang['error.security.token'].'<br>'.$lang['error.security.token#desc'].'', '?mod=users' );
        return;
    }

    $today = time();

    $mysql->query('DELETE FROM '.uprefix."_users WHERE ((last IS NULL) OR (last='')) AND ((reg + 86400) < $today) AND (news < 1)");
    msg(['type' => 'info', 'text' => $lang['msgo_delunact']]);
	return print_msg( 'delete', $lang['users_title'], $lang['msgk_delunact'], '?mod=users' );
}

//
// Show list of users
function userList()
{
    global $mysql, $lang, $mod, $userROW, $UGROUP, $twig, $PHP_SELF, $breadcrumb;

    // Check for permissions
    if (!checkPermission(['plugin' => '#admin', 'item' => 'users'], null, 'view')) {
        msg(['type' => 'error', 'text' => $lang['perm.denied']], 1, 1);
		print_msg( 'error', $lang['users_title'], $lang['perm.denied'], '?mod=users' );
        return;
    }

    // Load admin page based cookies
    $admCookie = admcookie_get();

    // Determine user's permissions
    $permModify = checkPermission(['plugin' => '#admin', 'item' => 'users'], null, 'modify');
    $permDetails = checkPermission(['plugin' => '#admin', 'item' => 'users'], null, 'details');
    $permMassAction = checkPermission(['plugin' => '#admin', 'item' => 'users'], null, 'modify');

    // Sorting parameters
    $sortOrderMap = [
        'i'  => 'id',
        'id' => 'id desc',
        'n'  => 'name',
        'nd' => 'name desc',
		'm'  => 'mail',
		'md' => 'mail desc',
        'r'  => 'reg',
        'rd' => 'reg desc',
        'l'  => 'last',
        'ld' => 'last desc',
        'p'  => 'news',
        'pd' => 'news desc',
        'g'  => 'status',
        'gd' => 'status desc',
    ];

    $inSort = (isset($_REQUEST['sort']) && (isset($sortOrderMap[$_REQUEST['sort']]))) ? $_REQUEST['sort'] : 'i';

    $sortLinkMap = [];
    foreach (['i', 'n', 'm', 'r', 'l', 'p', 'g'] as $kOrder) {
        $sRec = [];
        $sRec['isActive'] = (($inSort == $kOrder) || ($inSort == $kOrder.'d')) ? 1 : 0;
        if ($sRec['isActive']) {
            $sRec['sign'] = ($inSort == $kOrder) ? '&#8595;&#8595;' : '&#8593;&#8593;';
            $sRec['link'] = admin_url.'/admin.php?mod=users&action=list'.
                (isset($_REQUEST['name']) && $_REQUEST['name'] ? '&name='.htmlspecialchars($_REQUEST['name'], ENT_COMPAT | ENT_HTML401, 'UTF-8') : '').
                (isset($_REQUEST['rpp']) && $_REQUEST['rpp'] ? '&rpp='.intval($_REQUEST['rpp']) : '').
                '&sort='.$kOrder.(($inSort == $kOrder) ? 'd' : '');
        } else {
            $sRec['sign'] = '';
            $sRec['link'] = admin_url.'/admin.php?mod=users&action=list'.
                (isset($_REQUEST['name']) && $_REQUEST['name'] ? '&name='.htmlspecialchars($_REQUEST['name'], ENT_COMPAT | ENT_HTML401, 'UTF-8') : '').
                (isset($_REQUEST['rpp']) && $_REQUEST['rpp'] ? '&rpp='.intval($_REQUEST['rpp']) : '').
                '&sort='.$kOrder;
        }
        $sortLinkMap[$kOrder] = $sRec;
    }

    $sortValue = (isset($_REQUEST['sort']) && isset($sortOrderMap[$_REQUEST['sort']])) ? $sortOrderMap[$_REQUEST['sort']] : 'id';
    $name = (isset($_REQUEST['name']) && $_REQUEST['name'] != '') ? ("'%".$mysql->db_quote($_REQUEST['name'])."%'") : '';
	$mail = (isset($_REQUEST['mail']) && $_REQUEST['mail'] != '') ? ("'%".$mysql->db_quote($_REQUEST['mail'])."%'") : '';
	$singleuse = $_REQUEST['singleuse'];

    // Records Per Page
    // - Load
    $fRPP = (isset($_REQUEST['rpp']) && ($_REQUEST['rpp'] != '')) ? intval($_REQUEST['rpp']) : intval($admCookie['users']['pp']);
    // - Set default value for `Records Per Page` parameter
    if (($fRPP < 2) || ($fRPP > 2000)) {
        $fRPP = 30;
    }

    // - Save into cookies current value
    $admCookie['users']['pp'] = $fRPP;
    admcookie_set($admCookie);

    $pageNo = (isset($_REQUEST['page']) && $_REQUEST['page']) ? intval($_REQUEST['page']) : 0;
    if (!$pageNo) {
        $pageNo = 1;
    }

    // FILTER (where) PARAMETERS
    $whereRules = [];
    if (strlen($name)) {
        $whereRules[] = 'name like '.$name;
    }
    if (strlen($mail)) {
        $whereRules[] = 'mail like '.$mail;
    }
    if (isset($_REQUEST['group']) && (intval($_REQUEST['group']) > 0)) {
        $whereRules[] = 'status = '.intval($_REQUEST['group']);
    }
	if ($_REQUEST['single'] == "yes") {
		$ifsingle = "checked";
        $reg = time()-60*60*24*30;
        $whereRules[] = "last<".$reg;
	}
	if ($_REQUEST['offactiv'] == "yes") {
		$ifoffactiv = "checked";
        $whereRules[] = "activation > ''";
	}

    $queryFilter = count($whereRules) ? 'where '.implode(' and ', $whereRules) : '';
    $sql = 'select * from '.uprefix.'_users '.$queryFilter.' order by '.$sortValue.' '.'limit '.(($pageNo - 1) * $fRPP).', '.$fRPP;

    $tEntries = [];
    foreach ($mysql->select($sql) as $row) {
        $status = isset($UGROUP[$row['status']]) ? $UGROUP[$row['status']]['name'] : ('Unknown ['.$row['status'].']');

        $tEntry = [
            'id'          => $row['id'],
            'name'        => $row['name'],
			'mail'        => $row['mail'],
            'groupID'     => $row['status'],
            'groupName'   => $status,
            'cntNews'     => $row['news'],
            'cntComments' => $row['com'],
            'regdate'     => LangDate('j Q Y - H:i', $row['reg']),
            'lastdate'    => (empty($row['last'])) ? $lang['no_last'] : LangDate('j Q Y - H:i', $row['last']),
            'flags'       => [
                'isActive' => (!$row['activation'] || $row['activation'] == '') ? 1 : 0,
            ],
        ];

        $tEntries[] = $tEntry;
    }

    $userCount = $mysql->result('SELECT count(*) FROM '.uprefix.'_users '.$queryFilter);
    $pageCount = ceil($userCount / $fRPP);

    // Sorting flags
    //$linkSortOrders

    $pagination = generateAdminPagelist([
        'current' => $pageNo,
        'count'   => $pageCount,
        'url'     => admin_url.'/admin.php?mod=users&action=list'.
            (isset($_REQUEST['name']) && $_REQUEST['name'] ? '&name='.htmlspecialchars($_REQUEST['name'], ENT_COMPAT | ENT_HTML401, 'UTF-8') : '').
            (isset($_REQUEST['how']) && $_REQUEST['how'] ? '&how='.htmlspecialchars($_REQUEST['how'], ENT_COMPAT | ENT_HTML401, 'UTF-8') : '').
            (isset($_REQUEST['single']) && $_REQUEST['single'] ? '&single=yes' : '').
			(isset($_REQUEST['offactiv']) && $_REQUEST['offactiv'] ? '&offactiv=yes' : '').
			(isset($_REQUEST['rpp']) && $_REQUEST['rpp'] ? '&rpp='.intval($_REQUEST['rpp']) : '').
            '&page=%page%',
    ]);

    $tUgroup = [];
    foreach ($UGROUP as $id => $grp) {
        $tUge = [
            'id'       => $id,
            'identity' => $grp['identity'],
            'name'     => $grp['name'],
        ];

        $tUgroup[] = $tUge;
    }
	
	$breadcrumb = breadcrumb('<i class="fa fa-users btn-position"></i><span class="text-semibold">'.$lang['users'].'</span>', '<i class="fa fa-users"></i>'.$lang['users_title'].'' );

    $tVars = [
        'php_self'   => $PHP_SELF,
        'rpp'        => $fRPP,
		'ifsingle'   => $ifsingle,
		'ifoffactiv' => $ifoffactiv,
        'name'       => (isset($_REQUEST['name']) && $_REQUEST['name']) ? htmlspecialchars($_REQUEST['name'], ENT_COMPAT | ENT_HTML401, 'UTF-8') : '',
		'mail'       => (isset($_REQUEST['mail']) && $_REQUEST['mail']) ? htmlspecialchars($_REQUEST['mail'], ENT_COMPAT | ENT_HTML401, 'UTF-8') : '',
        'token'      => genUToken('admin.users'),
        'pagination' => $pagination,
        'ugroup'     => $tUgroup,
        'entries'    => $tEntries,
        'group'      => isset($_REQUEST['group']) ? intval($_REQUEST['group']) : 0,
        'sortLink'   => $sortLinkMap,
        'flags'      => [
            'canModify'     => $permModify ? 1 : 0,
            'canView'       => $permDetails ? 1 : 0,
            'canMassAction' => $permMassAction ? 1 : 0,
            'haveComments'  => getPluginStatusInstalled('comments') ? 1 : 0,
        ],

    ];

    $xt = $twig->loadTemplate('skins/default/tpl/users/table.tpl');

    return $xt->render($tVars);
}

// ==============================================
// Actions
// ==============================================

if ($action == 'editForm') {
	userEditForm();
    if (!$main_admin) {
        $main_admin = userEditForm();
    }
} else {
    switch ($action) {
        case 'edit':
            userEdit();
            break;
        case 'add':
            userAdd();
            break;
        case 'massActivate':
            userMassActivate();
            break;
        case 'massLock':
            userMassLock();
            break;
        case 'massSetStatus':
            userMassSetStatus();
            break;
        case 'massDel':
            userMassDelete();
            break;
        case 'massDelInactive':
            userMassDeleteInactive();
            break;
		default:
			$main_admin = userList();
    }
}