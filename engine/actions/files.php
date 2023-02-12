<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: files.php
// Description: Менеджер файлов
// Author: NGCMS Development Team
//

// Protect against hack attempts
if (!defined('NGCMS')) {
    exit('HAL');
}

$lang = LoadLang('files', 'admin');
@include_once root.'includes/classes/upload.class.php';
@include_once root.'includes/inc/file_managment.php';

// =======================================
// BODY
// =======================================

// Init file managment class
$fmanager = new file_managment();

$breadcrumb = breadcrumb('<i class="fa fa-file-text-o btn-position"></i><span class="text-semibold">'.$lang['files_title'].'</span>', '<i class="fa fa-file-text-o"></i>'.$lang['files_title'].'');

// Check perms
$perms = checkPermission(['plugin' => '#admin', 'item' => 'files'], null, [
    'modify',
    'details',
]);

if (!$perms['modify'] && !$perms['details']) {
    msg(['type' => 'error', 'text' => $lang['msge_mod']]);
}

switch ($subaction) {
    case 'newcat':
        $fmanager->category_create('file', $_REQUEST['newfolder']);
		return print_msg( 'delete', $lang['files_title'], $lang['msgo_catcreated'], '?mod=files' );
        break;
    case 'delcat':
        $fmanager->category_delete('file', $_REQUEST['category']);
		return print_msg( 'delete', $lang['files_title'], $lang['msgo_catdeleted'], '?mod=files' );
        break;
    case 'delete':
        manage_delete('file');
		return print_msg( 'delete', $lang['files_title'], $lang['msgo_deleted'], '?mod=files' );
        break;
    case 'rename':
        $main_admin = $fmanager->file_rename(['type' => 'file', 'id' => $_REQUEST['id'], 'newname' => $_REQUEST['rf']]);
        break;
    case 'move':
        $main_admin = manage_move('file');
        break;
    case 'upload':
    case 'uploadurl':
        $main_admin = manage_upload('file');
        break;

}

$main_admin = manage_showlist('file');
