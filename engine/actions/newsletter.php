<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: newsletter.php
// Description: Рассылка сообщений
// Author: NGCMS Development Team
//


// Protect against hack attempts
if (!defined('NGCMS')) {
    exit('HAL');
}

$lang = LoadLang('newsletter', 'admin');

$breadcrumb = breadcrumb('<i class="fa fa-envelope-o btn-position"></i><span class="text-semibold">'.$lang['newsletter'].'</span>', '<i class="fa fa-envelope-o btn-position"></i>'.$lang['pm_mail'].'' );

function newsletter($method, $group, $subject, $message) {
	global $lang, $mysql, $userROW, $config, $UGROUP;
	
	$send_to = $userROW['id'];
	$author = $userROW['name'];
	$link = $config['home_url'];
	//$title = $config['home_title'];
	$title = $_SERVER['SERVER_NAME'];
	$botdev = 'mailbot@'.str_replace('www.', '', $_SERVER['SERVER_NAME']);
	$bot = ($config['mailfrom']) ? $config['mailfrom'] : $botdev;

	if (!$subject || trim($subject) == "") {
		msg(['type' => 'error', 'text' => $lang['msge_subject']]);
		print_msg( 'error', $lang['newsletter'], $lang['msge_subject'], '?mod=newsletter' );
	}
	elseif (!$message || trim($message) == "") {
		msg(['type' => 'error', 'text' => $lang['msge_content']]);
		print_msg( 'error', $lang['newsletter'], $lang['msge_content'], '?mod=newsletter' );
	}
	else {
		if ($method == "0") {
			$mails = array();

			if ($group == 0) {
				foreach ($mysql->select("SELECT mail FROM `".uprefix."_users`") as $row) {
					$mails[] = $row['mail'];
				}
			}
			else {
				foreach ($mysql->select("SELECT mail FROM `".uprefix."_users` WHERE status='".$group."'") as $row) {
					$mails[] = $row['mail'];
				}
			}
			if (empty($mails)) {
				msg(['type' => 'error', 'text' => $lang['msge_status'], 'info' => $lang['msgi_status']]);
				print_msg( 'error', $lang['newsletter'], ''.$lang['msge_status'].' '.$lang['msgi_status'].'', '?mod=newsletter' );
			}
			else {
				$mails		=	join(', ', $mails);
				$message	=	nl2br($message);
				$conten = str_replace(array ('%author%', '%message%', '%link%', '%title%', '%bot%' ), array ($author, $message, $link, $title, $bot ), $lang['msgk_send_content']);
				zzMail($mails, $subject, $conten, 'html');
				msg(['type' => 'error', 'text' => $lang['msgo_sent']]);
				print_msg( 'info', $lang['newsletter'], str_replace('%subject%', $_REQUEST['subject'], $lang['msgk_subj_em']), '?mod=newsletter' );
			}
		}
		else {
			if ($group == 0) {
				foreach ($mysql->select("SELECT id FROM `".uprefix."_users`") as $row) {
					$ids[] = $row['id'];
				}
			}
			else {
				foreach ($mysql->select("SELECT id FROM `".uprefix."_users` WHERE status = '".$group."'") as $row) {
					$ids[] = $row['id'];
				}
			}
			if (empty($ids)) {
				msg(['type' => 'error', 'text' => $lang['msge_status'], 'info' => $lang['msgi_status']]);
				print_msg( 'error', $lang['newsletter'], ''.$lang['msge_status'].' '.$lang['msgi_status'].'', '?mod=newsletter' );
			}
			else {
				foreach ($ids as $to_id) {
					$sql = $mysql->query("INSERT INTO ".uprefix."_pm (from_id, to_id, date, subject, message) values ('$send_to', '$to_id', '".time()."', '$subject', '$message')");
				}
				msg(['type' => 'info', 'text' => $lang['msgo_sent']]);
				print_msg( 'info', $lang['newsletter'], str_replace('%subject%', $_REQUEST['subject'], $lang['msgk_subj_pm']), '?mod=newsletter' );
			}
		}
	}
}


$mesmail = '0';
if (!getPluginStatusActive('pm')) {
	$method = '<option value="0" ' . (empty($mesmail) ? 'selected' : '') . '>'.$lang['by_mail'].'</option>';
	$no_pm = 1;
} else {
	$method = '<option value="0" ' . (empty($mesmail) ? 'selected' : '') . '>'.$lang['by_mail'].'</option><option value="1" ' . (!empty($mesmail) ? 'selected' : '') . '>'.$lang['by_pm'].'</option>';
}
	
/* $mesgroup = '0';
$group = '<option value="0" ' . (empty($mesgroup) ? 'selected' : '') . '>Все группы</option><option value="1" ' . (!empty($mesgroup) ? 'selected' : '') . '>Администратор</option><option value="2" ' . (!empty($mesgroup) ? 'selected' : '') . '>Редактор</option><option value="3" ' . (!empty($mesgroup) ? 'selected' : '') . '>Журналист</option>';
 */

$group = '<option value="0" ' . (empty($mesgroup) ? 'selected' : '') . '>Все группы</option>';
foreach ($UGROUP as $k => $v) {
	$group .= '<option value="'.$k.'" ' . (empty($k) ? 'selected' : '') . '>'.$v['name'].'</option>';
}

$tVars = [
    'php_self' 	=> $PHP_SELF,
	'method' 	=> $method,
	'group' 	=> $group,
	'subject' 	=> $subject,
	'quicktags' => QuickTags('', 'pmmes'),
	'smilies'   => ($config['use_smilies'] == '1') ? InsertSmilies('content', 10) : '',
	'message' 	=> $message,
    'flags'   	=> [
		'no_pm'  => $no_pm,
    ],

];

$xt = $twig->loadTemplate('skins/default/tpl/newsletter.tpl');
$main_admin = $xt->render($tVars);


if ($action == 'save') {
	
    $message = secure_html(trim($_POST['message']));
     
	newsletter($_REQUEST['method'], $_REQUEST['group'], $_REQUEST['subject'], $_REQUEST['message']);
}

?>