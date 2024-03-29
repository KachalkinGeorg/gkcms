<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: default.php
// Description: Главная страница админки (По умолчанию использует statistics.rpc.php)
// Author: NGCMS Development Team
//

// Protect against hack attempts
if (!defined('NGCMS')) {
    exit('HAL');
}

// Load library
@include_once root.'actions/statistics.rpc.php';

$lang = LoadLang('default', 'admin');

// Create a protective .htaccess
create_access_htaccess();

function phpConfigGetBytes($size_str)
{
    switch (substr($size_str, -1)) {
        case 'M':
        case 'm':
            return (int) $size_str * 1048576;
        case 'K':
        case 'k':
            return (int) $size_str * 1024;
        case 'G':
        case 'g':
            return (int) $size_str * 1073741824;
        default:
            return $size_str;
    }
}

// Gather information about directories
$STATS = [];
$timeLimit = 0;
foreach (['backup' => root.'backups', 'avatar' => avatars_dir, 'photo' => photos_dir, 'file' => files_dir, 'image' => images_dir] as $id => $dir) {
    if (!is_dir($dir)) {
        // Directory do not exists
        $STATS[$id.'_amount'] = 'n/a';
        $STATS[$id.'_volume'] = 'n/a';
        $STATS[$id.'_perm'] = 'n/a';
        $STATS[$id.'_size'] = 'n/a';
    } else {
        // Get permissions
        $perms = @fileperms($dir);
        $perms = ($perms === false) ? 'n/a' : (decoct($perms) % 1000);

        // Error - engine can't write into directory
        if (!is_writable($dir)) {
            $STATS[$id.'_perm'] = '<font color="red"><b>'.$perms.'</b></font> [<a href="#" onclick="showModal('."'".$lang['bug_rules']."'".');">'.$lang['bug'].'</a>]';
        } else {
            $STATS[$id.'_perm'] = '<font color="green"><b>'.$perms.'</b></font>';
        }
        //$STATS[$id.'_perm'] = $perms;

        // Load list of files, ExecTimeLimit = 5 sec (don't allow to work for > 5 sec)
        if (!$timeLimit) {
            list($size, $count, $null, $timeLimit) = directoryWalk($dir, null, null, false, 5);
            $STATS[$id.'_size'] = Formatsize($size);
            $STATS[$id.'_amount'] = $count.($timeLimit ? '<b>++</b>' : '');
        } else {
            $STATS[$id.'_size'] = 'too much';
            $STATS[$id.'_amount'] = 'too much';
        }
    }
}

$breadcrumb = breadcrumb('<i class="fa fa-home btn-position"></i><span class="text-semibold">'.$lang['admin_panel'].'</span>', '<i class="fa fa-laptop"></i>'.$lang['default_home'].'' );

if (function_exists('gd_info')) {
    $gd_version = gd_info();
    $gd_info = $gd_version['GD Version'];
    foreach (['JPEG', 'PNG'] as $v) {
        if ($gd_version[$v.' Support']) {
            $gd_info .= ' +'.$v;
        } else {
            $gd_info .= ' <span style="color: red; font-weight: bold;">No '.$v.'</span>';
        }
    }
}

$mysql_size = 0;

foreach ($mysql->select('SHOW TABLE STATUS FROM `'.$config['dbname'].'`') as $result) {
    $mysql_size += $result['Data_length'] + $result['Index_length'];
}
$mysql_size = Formatsize($mysql_size);

$backup = @decoct(@fileperms(root.'backups')) % 1000;
$avatars = @decoct(@fileperms(avatars_dir)) % 1000;
$photos = @decoct(@fileperms(photos_dir)) % 1000;
$upfiles = @decoct(@fileperms(files_dir)) % 1000;
$upimages = @decoct(@fileperms(images_dir)) % 1000;
$upimages = ($upimages != '777') ? '<span style="color:red;">'.$upimages.'</span>' : '<span style="color:green;"><b>'.$upimages.'</b></span>';
$upfiles = ($upfiles != '777') ? '<span style="color:red;">'.$upfiles.'</span>' : '<span style="color:green;"><b>'.$upfiles.'</b></span>';
$avatars = ($avatars != '777') ? '<span style="color:red;">'.$avatars.'</span>' : '<span style="color:green;"><b>'.$avatars.'</b></span>';
$photos = ($photos != '777') ? '<span style="color:red;">'.$photos.'</span>' : '<span style="color:green;"><b>'.$photos.'</b></span>';
$backup = ($backup != '777') ? '<span style="color:red;">'.$backup.'</span>' : '<span style="color:green;"><b>'.$backup.'</b></span>';

$note_path = root.'trash/'.$parse->translit(strtolower(name)).'_note.inc.txt';

if ($action == 'save') {
    $note = secure_html(trim($_POST['note']));

    if (!$note || $note == '') {
        @unlink($note_path);
    } elseif (strlen($note) > '3000') {
        msg(['type' => 'error', 'text' => $lang['msge_badnote'], 'info' => $lang['msgi_badnote']]);
    } else {
        $fp = fopen($note_path, 'w+');
        fwrite($fp, $note);
        fclose($fp);
        msg(['type' => 'info', 'text' => $lang['msgo_note_saved']]);
    }
}

if (file_exists($note_path)) {
    $fp = fopen($note_path, 'r');
    $note = fread($fp, filesize($note_path));
    fclose($fp);
} else {
    $note = '';
}

$df_size = @disk_free_space(root);
$df = ($df_size > 1) ? Formatsize($df_size) : 'n/a';

// Calculate number of news
$nCount = [];
foreach ($mysql->select('select approve, count(*) as cnt from '.prefix.'_news group by approve') as $rec) {
    $nCount['v_'.$rec['approve']] = $rec['cnt'];
}

if ( function_exists( 'gd_info' ) ) {

	$array=gd_info ();
	$gdversion = "";

	foreach ($array as $key=>$val) {
	  
	  if ($val===true) {
	    $val="Enabled";
	  }
	
	  if ($val===false) {
	    $val="Disabled";
	  }
	
	  $gdversion .= $key.":&nbsp;{$val}, ";
	
	}

} else $gdversion = $lang['unknow'];

$news_unapp = $mysql->result('SELECT count(id) FROM '.prefix."_news WHERE approve = '0'");
$news_unapp = ($news_unapp == '0') ? $news_unapp : '<font color="#ff6600">'.$news_unapp.'</font>';
$users_unact = $mysql->result('SELECT count(id) FROM '.uprefix."_users WHERE activation != ''");
$users_unact = ($users_unact == '0') ? $users_unact : '<font color="#ff6600">'.$users_unact.'</font>';

if (getPluginStatusActive('comments') && pluginGetVariable('comments', 'moderate') ) {
	$com_unapp = $mysql->result('SELECT count(id) FROM '.prefix."_comments WHERE approve = '0'");
	$com_unapp = ($com_unapp == '0') ? $com_unapp : '<font color="#ff6600">'.$com_unapp.' <a href="?mod=extra-config&plugin=comments&action=list&approve=1">['.Padeg($com_unapp, $lang['head_com_skl']).']</a></font>';
}

if( function_exists( 'apache_get_modules' ) ) {
	if( array_search( 'mod_rewrite', apache_get_modules() ) !== false) {
		$mod_rewrite = $lang['enable'];
	} else {
		$mod_rewrite = '<span class="text-danger">'.$lang['disable'].'</span>';
	}
} else {
	$mod_rewrite = $lang['undefined'];
}

$maxupload = str_replace( array ('M', 'm' ), '', @ini_get( 'upload_max_filesize' ) );
$maxupload = formatsize( $maxupload * 1024 * 1024 );

$dfs = @disk_free_space( "." );
$freespace = formatsize( $dfs );

$offline = (!$config['lock']) ? $lang['enable'] : '<span class="text-danger">'.$lang['disable'].'</span>';
$maxmemory = (@ini_get( 'memory_limit' ) != '') ? @ini_get( 'memory_limit' ) : $lang['unknow'];
$os_version = @php_uname( "s" ) . " " . @php_uname( "r" );
$disabledfunctions = (strlen( ini_get( 'disable_functions' ) ) > 1) ? @ini_get( 'disable_functions' ) : $lang['unknow'];
$disabledfunctions = str_replace( ",", ", ", $disabledfunctions );
$safemode = (@ini_get( 'safe_mode' ) == 1) ? $lang['enable'] : $lang['disable'];

$tVars = [
    'php_self'         => $PHP_SELF,
    'php_os'           => PHP_OS,
    'php_version'      => phpversion(),
    'mysql_version'    => $mysql->mysql_version(),
    'gd_version'       => isset($gd_version) ? $gd_info : '<font color="red"><b>'.$lang['not_install'].'</b></font>',
    'mysql_size'       => $mysql_size,
	'maxupload'        => $maxupload,
	'freespace'        => $freespace,
	'offline'          => $offline,
	'os_version'       => $os_version,
	'gdversion'        => $gdversion,
	'maxmemory'        => $maxmemory,
	'safemode'        => $safemode,
	'mod_rewrite'        => $mod_rewrite,
	'disabledfunctions'        => $disabledfunctions,
    'allowed_size'     => $df,
    'avatars'          => $avatars,
    'backup'           => $backup,
    'upfiles'          => $upfiles,
    'upimages'         => $upimages,
    'photos'           => $photos,
    'news_draft'       => empty($nCount['v_-1']) ? 0 : intval($nCount['v_-1']),
    'news_unapp'       => empty($nCount['v_0']) ? 0 : intval($nCount['v_0']),
    'news'             => empty($nCount['v_1']) ? 0 : intval($nCount['v_1']),
    'comments'         => getPluginStatusInstalled('comments') ? $mysql->result('SELECT count(id) FROM '.prefix.'_comments') : '-',
	'com_unapp'        => $com_unapp,
    'users'            => $mysql->result('SELECT count(id) FROM '.uprefix.'_users'),
    'users_unact'      => $users_unact,
    'images'           => $mysql->result('SELECT count(id) FROM '.prefix.'_images'),
    'files'            => $mysql->result('SELECT count(id) FROM '.prefix.'_files'),
    'categories'       => $mysql->result('SELECT count(id) FROM '.prefix.'_category'),
    'admin_note'       => $note,
    'pdo_support'      => (extension_loaded('PDO') && extension_loaded('pdo_mysql') && class_exists('PDO')) ? $lang['yesa'] : ('<font color="red">'.$lang['noa'].'</font>'),
    'token'            => genUToken('admin.statistics'),
	'user_id'          => $userROW['id'],
];

$tVars = $tVars + $STATS;

// Check if we have problems with limits for uploads
$minUploadLimits = [phpConfigGetBytes(ini_get('upload_max_filesize')), phpConfigGetBytes(ini_get('post_max_size'))];
$tVars['minUploadLimit'] = intval(min($minUploadLimits) / 1024).'kb';

$tVars['flags']['errorSizeFiles'] = (min($minUploadLimits) < ($config['files_max_size'] * 1024)) ? 1 : 0;
$tVars['flags']['errorSizeImages'] = (min($minUploadLimits) < ($config['images_max_size'] * 1024)) ? 1 : 0;

// PHP errors
$phpErrors = 0;
foreach (['register_globals', 'magic_quotes_gpc', 'magic_quotes_runtime', 'magic_quotes_sybase'] as $flag) {
    $tVars['flags'][$flag] = ini_get($flag) ? ('<font color="red"><b>'.$lang['perror.on'].'</b></font>') : $lang['perror.off'];
    if (ini_get($flag)) {
        $phpErrors++;
    }
}
$tVars['flags']['confError'] = ($phpErrors) ? 1 : 0;

$xt = $twig->loadTemplate('skins/default/tpl/default.tpl');
$main_admin = $xt->render($tVars);
