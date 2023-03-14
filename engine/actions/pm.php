<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: pm.php
// Description: Персональные сообщения
// Author: NGCMS Development Team
//

// Protect against hack attempts
if (!defined('NGCMS')) {
    exit('HAL');
}

$lang = LoadLang('pm', 'admin');

if (!getPluginStatusActive('pm')) {
	msg(['type' => 'error', 'text' => $lang['error_pm']]);
	return print_msg( 'warning', $lang['pm'], $lang['error_pm'], 'javascript:history.go(-1)' );
}

function pm_send()
{
    global $lang, $userROW;

    $sendto = trim($_REQUEST['sendto']);
    $subject = secure_html($_REQUEST['subject']);
    $message = $_REQUEST['message'];

    if (!$subject || mb_strlen($subject) > 50) {
        msg(['type' => 'error', 'text' => $lang['msge_title'], 'info' => $lang['msgi_title']]);
		print_msg( 'error', $lang['pm'], ''.$lang['msge_title'].'<br>'.$lang['msgi_title'].'', 'javascript:history.go(-1)' );

        return;
    }
    if (!$message || mb_strlen($message) > 3000) {
        msg(['type' => 'error', 'text' => $lang['msge_content'], 'info' => $lang['msgi_content']]);
		print_msg( 'error', $lang['pm'], ''.$lang['msge_content'].'<br>'.$lang['msgi_content'].'', 'javascript:history.go(-1)' );

        return;
    }

    if (!isset($_REQUEST['token']) || ($_REQUEST['token'] != genUToken('pm.token'))) {
        msg(['type' => 'error', 'text' => $lang['error.security.token']]);
		print_msg( 'error', $lang['pm'], $lang['error.security.token'], 'javascript:history.go(-1)' );

        return;
    }

    $db = NGEngine::getInstance()->getDB();
	$query = "SELECT * FROM " . uprefix . "_users WHERE " . (is_numeric($sendto) ? "id = " . db_squote($sendto) : "name = " . db_squote($sendto));
    if ($sendto && ($torow = $db->record($query))) {
        $message = secure_html(trim($message));
		$time = time() + ($config['date_adjust'] * 60);

		$db->exec("insert into " . prefix . "_pm (from_id, to_id, date, subject, message, folder) values (" . db_squote($userROW['id']) . ", " . db_squote($torow['id']) . ", " . db_squote($time) . ", " . db_squote($subject) . ", " . db_squote($message) . ", 'inbox')");
        msg(['type' => 'info', 'text' => $lang['msgo_sent']]);
		return print_msg( 'success', $lang['pm'], str_replace(array ('%user%', '%title%' ), array ($torow['name'], $subject ), $lang['msgo_pmsend']), '?mod=pm' );
    } else {
        msg(['type' => 'error', 'text' => $lang['msge_nouser'], 'info' => $lang['msgi_nouser']]);
		return print_msg( 'error', $lang['pm'], ''.$lang['msge_nouser'].'<br>'.$lang['msgi_nouser'].'', 'javascript:history.go(-1)' );
    }

}

function pm_list()
{
    global $lang, $userROW, $twig, $breadcrumb;

    $tVars = [
        'entries'   => [],
        'token'     => genUToken('pm.token'),
    ];

	$breadcrumb = breadcrumb('<i class="fa fa-envelope-o btn-position"></i><span class="text-semibold">'.$lang['pm'].'</span>', '<i class="fa fa-envelope-open-o btn-position"></i>'.$lang['pm'].'' );

    $db = NGEngine::getInstance()->getDB();
    foreach ($db->query('select pm.*, u.id as uid, u.name as uname from '.uprefix.'_pm pm left join '.uprefix.'_users u on pm.from_id=u.id where pm.to_id = :id order by id desc limit 0, 30', ['id' => $userROW['id']]) as $row) {
        $senderProfileURL = '';
        $senderName = $lang['messaging'];
        if ($row['from_id'] && $row['uid']) {
            $senderProfileURL = checkLinkAvailable('uprofile', 'show') ?
                generateLink('uprofile', 'show', ['name' => $row['uname'], 'id' => $row['uid']]) :
                generateLink('core', 'plugin', ['plugin' => 'uprofile', 'handler' => 'show'], ['name' => $row['uname'], 'id' => $row['uid']]);
            $senderName = $row['uname'];
        } elseif ($row['from_id']) {
            $senderName = $lang['udeleted'];
        }
        $tEntry = [
            'id'               => $row['id'],
            'date'             => LangDate('j.m.Y', $row['date']),
			'time'             => LangDate('H:i', $row['date']),
            'subject'          => $row['subject'],
            'senderID'         => $row['from_id'],
            'senderProfileURL' => $senderProfileURL,
            'senderName'       => $senderName,
            'flags'            => [
                'viewed'        => $row['viewed'] ? true : false,
                'haveSender'    => strlen($senderProfileURL) ? true : false,
            ],
        ];
        $tVars['entries'][] = $tEntry;
    }
    $xt = $twig->loadTemplate('skins/default/tpl/pm/table.tpl');

    return $xt->render($tVars);
}

function pm_read()
{
    global $lang, $userROW, $parse, $twig, $config, $breadcrumb;

    if (!isset($_REQUEST['pmid'])) {
        msg(['type' => 'error', 'text' => $lang['msge_bad']]);
		print_msg( 'error', $lang['pm'], $lang['msge_bad'], '?mod=pm' );

        return;
    }
	
	$pmid = intval($_REQUEST['pmid']);
    $db = NGEngine::getInstance()->getDB();
    if ($row = $db->record("SELECT * FROM " . prefix . "_pm WHERE id = " . db_squote($pmid) . " AND ((`from_id`=" . db_squote($userROW['id']) . " AND `folder`='outbox') OR (`to_id`=" . db_squote($userROW['id']) . ") AND `folder`='inbox')")) {
        $tVars = [
            'id'        => $row['id'],
            'token'     => genUToken('pm.token'),
            'subject'   => $row['subject'],
            'fromID'    => $row['from_id'],
            'toID'      => $row['to_id'],
            'fromName'  => $lang['messaging'],
            'toName'    => $lang['messaging'],
            'message'   => $parse->htmlformatter($parse->smilies($parse->bbcodes($row['message']))),
        ];
		
		$breadcrumb = breadcrumb('<i class="fa fa-envelope-o btn-position"></i><span class="text-semibold">'.$lang['pm'].'</span>', array('?mod=pm' => '<i class="fa fa-envelope-o btn-position"></i>'.$lang['pm'].'', '<i class="fa fa-envelope-open-o btn-position"></i>'.$row['subject'].'' ) );

        if ($row['from_id'] > 0) {
            $r = locateUserById($row['from_id']);
            $tVars['fromName'] = (isset($r['name'])) ? $r['name'] : $lang['udeleted'];
        }
        if ($row['to_id'] > 0) {
            $r = locateUserById($row['to_id']);
            $tVars['toName'] = (isset($r['name'])) ? $r['name'] : $lang['udeleted'];
        }

        if ((!$row['viewed']) && ($row['to_id'] == $userROW['id'])) {
            // Mark as read ONLY if token is correct
            if (isset($_REQUEST['token']) && ($_REQUEST['token'] == genUToken('pm.token'))) {
                $db->exec('update '.uprefix.'_pm set viewed = 1 WHERE id = :pmid', ['pmid' => $row['id']]);
            } else {
                msg(['type' => 'error', 'text' => $lang['error.security.token']]);
            }
        }
        $xt = $twig->loadTemplate('skins/default/tpl/pm/read.tpl');

        return $xt->render($tVars);
    } else {
        msg(['type' => 'error', 'text' => $lang['msge_bad']]);
		return print_msg( 'warning', $lang['pm'], $lang['msge_bad'], '?mod=pm' );
    }
}

function pm_reply()
{
    global $config, $lang, $userROW, $twig, $breadcrumb;

    if (!isset($_REQUEST['pmid'])) {
        msg(['type' => 'error', 'text' => $lang['msge_reply']]);
		print_msg( 'warning', $lang['pm'], $lang['msge_reply'], '?mod=pm' );

        return;
    }
	
	$breadcrumb = breadcrumb('<i class="fa fa-envelope-o btn-position"></i><span class="text-semibold">'.$lang['pm'].'</span>', array('?mod=pm' => '<i class="fa fa-envelope-o btn-position"></i>'.$lang['pm'].'', '<i class="fa fa-paper-plane-o btn-position"></i>Ответить на письмо' ) );
	
	$pmid = $_REQUEST['pmid'];
    $db = NGEngine::getInstance()->getDB();
    if ($row = $db->record("SELECT * FROM " . prefix . "_pm WHERE id = " . db_squote($pmid) . " AND (to_id = " . db_squote($userROW['id']) . " OR from_id=" . db_squote($userROW['id']) . ")")) {
        if (!is_array($row)) {
            msg(['type' => 'error', 'text' => $lang['msge_reply']]);
			print_msg( 'error', $lang['pm'], $lang['msge_reply'], '?mod=pm' );
            return;
        }

        $reTitle = $row['subject'];
        if (mb_strlen($reTitle) > 50) {
            $reTitle = mb_substr($reTitle, 0, 50);
        }
        $tVars = [
            'id'        => $row['id'],
            'subject'   => $reTitle,
            'token'     => genUToken('pm.token'),
            'quicktags' => QuickTags('', 'pmmes'),
            'smilies'   => ($config['use_smilies'] == '1') ? InsertSmilies('content', 10) : '',
            'toID'      => $row['from_id'],
            'fromID'    => $row['to_id'],
            'fromName'  => $lang['messaging'],
            'toName'    => $lang['messaging'],
        ];

        if ($row['from_id'] > 0) {
            $r = locateUserById($row['from_id']);
            $tVars['toName'] = (isset($r['name'])) ? $r['name'] : $lang['udeleted'];
        }
        if ($row['to_id'] > 0) {
            $r = locateUserById($row['to_id']);
            $tVars['fromName'] = (isset($r['name'])) ? $r['name'] : $lang['udeleted'];
        }
        $xt = $twig->loadTemplate('skins/default/tpl/pm/reply.tpl');

        return $xt->render($tVars);
    } else {
        msg(['type' => 'error', 'text' => $lang['msge_bad']]);
		return print_msg( 'warning', $lang['pm'], $lang['msge_bad'], '?mod=pm' );
    }
}

function pm_write()
{
    global $config, $twig, $breadcrumb, $lang;
	
	$breadcrumb = breadcrumb('<i class="fa fa-envelope-o btn-position"></i><span class="text-semibold">'.$lang['pm'].'</span>', array('?mod=pm' => '<i class="fa fa-envelope-o btn-position"></i>'.$lang['pm'].'', '<i class="fa fa-paper-plane-o btn-position"></i>Написать письмо' ) );

    $tVars = [
        'quicktags' => QuickTags('', 'pmmes'),
        'smilies'   => ($config['use_smilies'] == '1') ? InsertSmilies('content', 10) : '',
        'token'     => genUToken('pm.token'),
    ];
    $xt = $twig->loadTemplate('skins/default/tpl/pm/write.tpl');

    return $xt->render($tVars);
}

function pm_delete()
{
    global $lang, $userROW;

    if (!isset($_REQUEST['token']) || ($_REQUEST['token'] != genUToken('pm.token'))) {
        msg(['type' => 'error', 'text' => $lang['error.security.token']]);
		print_msg( 'warning', $lang['pm'], $lang['error.security.token'], '?mod=pm' );

        return;
    }

    $selected_pm = getIsSet($_REQUEST['selected_pm']);
    if (!$selected_pm || !is_array($selected_pm)) {
        msg(['type' => 'error', 'text' => $lang['msge_select']]);
		print_msg( 'error', $lang['pm'], $lang['msge_select'], '?mod=pm' );

        return;
    }
	
    $db = NGEngine::getInstance()->getDB();
    foreach ($selected_pm as $id) {
        $db->exec('delete from '.uprefix.'_pm where id = :pmid and (from_id= :from_id or to_id= :to_id)', ['pmid' => $id, 'from_id' => $userROW['id'], 'to_id' => $userROW['id']]);
		$db->exec("UPDATE " . uprefix . "_users SET `pm_sync` = 0 WHERE `id` = " . db_squote($userROW['id']));
    }
    msg(['type' => 'info', 'text' => $lang['msgo_deleted']]);
	return print_msg( 'delete', $lang['pm'], $lang['msgo_deleted'], '?mod=pm' );
	
}

switch ($action) {
    case 'read':
        $main_admin = pm_read();
        break;
    case 'reply':
        $main_admin = pm_reply();
        break;
    case 'send':
        pm_send();
        break;
    case 'write':
        $main_admin = pm_write();
        break;
    case 'delete':
        pm_delete();
        break;
    default:
        $main_admin = pm_list();
}
