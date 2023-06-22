<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: images.php
// Description: Менеджер изображений
// Author: NGCMS Development Team
//

// Protect against hack attempts
if (!defined('NGCMS')) {
    exit('HAL');
}

$lang = LoadLang('images', 'admin');
@include_once root.'includes/classes/upload.class.php';
@include_once root.'includes/inc/file_managment.php';

// =======================================
// BODY
// =======================================

// Init file managment class
$fmanager = new file_managment();

// Check perms
$perms = checkPermission(['plugin' => '#admin', 'item' => 'images'], null, [
    'modify',
    'details',
]);

if (!$perms['modify'] && !$perms['details']) {
    msg(['type' => 'error', 'text' => $lang['msge_mod']]);
}

switch ($subaction) {
    case 'newcat':
		$fmanager->category_create('image', $_REQUEST['newfolder']);
		return print_msg( 'success', $lang['images_title'], $lang['msgo_catcreated'], '?mod=images' );
        break;
    case 'delcat':
        $fmanager->category_delete('image', $_REQUEST['category']);
		return print_msg( 'delete', $lang['images_title'], $lang['msgo_catdeleted'], '?mod=images' );
        break;
    case 'delete':
        manage_delete('image');
		return print_msg( 'delete', $lang['images_title'], $lang['msgk_deleted'], '?mod=images' );
        break;
    case 'rename':
        $main_admin = $fmanager->file_rename(['type' => 'image', 'id' => $_REQUEST['id'], 'newname' => $_REQUEST['rf']]);
        break;
    case 'move':
        manage_move('image');
		return print_msg( 'success', $lang['images_title'], $lang['msgo_moved'], '?mod=images' );
        break;
    case 'upload':
    case 'uploadurl':
        $main_admin = manage_upload('image');
        break;
    case 'editForm':
		$breadcrumb = breadcrumb('<i class="fa fa-picture-o btn-position"></i><span class="text-semibold">'.$lang['images'].'</span>', array('?mod=images' => '<i class="fa fa-file-image-o btn-position"></i>'.$lang['images_title'].'', '<i class="fa fa-pencil-square-o"></i>'.$lang['edit_title'].' - ['.$_REQUEST['id'].']' ) );
        $main_admin = manage_editForm('image', $_REQUEST['id']);
        break;
    case 'editApply':
        $main_admin = manage_editApply('image', $_POST['id']);
        break;
	default:
		$breadcrumb = breadcrumb('<i class="fa fa-picture-o btn-position"></i><span class="text-semibold">'.$lang['images'].'</span>', '<i class="fa fa-picture-o"></i>'.$lang['images_title'].'');
		$main_admin = manage_showlist('image');
}

if (($subaction != 'editForm') && ($subaction != 'editApply')) {
	$main_admin = manage_showlist('image');
}

if ($subaction == 'submit') {
	return print_msg( 'update', 'Изображение', 'Изображение успешно отредактирована', array('?mod=images&subaction=editForm&id='.$_POST['id'].'' => 'Редактировать еще', '?mod=images' => 'Вернуться назад' ) );
}