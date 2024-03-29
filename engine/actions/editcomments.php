<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: editcomments.php
// Description: Менеджер редактирования комментария
// Author: NGCMS Development Team
//

// Protect against hack attempts
if (!defined('NGCMS')) {
    exit('HAL');
}

$lang = LoadLang('editcomments', 'admin');

// List comments
function commentsList($newsID)
{
    global $mysql;
}

$comid = $_REQUEST['comid'] ? intval($_REQUEST['comid']) : 0;
if (empty($comid)) {
    msg(['type' => 'error', 'text' => $lang['comid_not_found']]);
	return print_msg( 'error', $lang['page-title'], $lang['comid_not_found'], '?mod=news&action=edit&id='.$newsid );
    exit();
}

$newsid = $_REQUEST['newsid'] ? intval($_REQUEST['newsid']) : 0;
if (empty($newsid)) {
    msg(['type' => 'error', 'text' => $lang['comid_not_found']]);
	return print_msg( 'error', $lang['page-title'], $lang['comid_not_found'], '?mod=news&action=edit&id='.$newsid );
    exit();
}

if ($subaction == 'doeditcomment') {
    if (!trim($_REQUEST['poster'])) {
        msg(['type' => 'error', 'text' => $lang['msge_namefield']]);
		return print_msg( 'error', $lang['page-title'], $lang['msge_namefield'], '?mod=news&action=edit&id='.$row['post'] );
    } else {
        $comment = str_replace('{', '&#123;', str_replace("\r\n", '<br />', htmlspecialchars(trim($_REQUEST['comment']), ENT_COMPAT, 'UTF-8')));
        $content = str_replace('{', '&#123;', str_replace("\r\n", '<br />', htmlspecialchars(trim($_REQUEST['content']), ENT_COMPAT, 'UTF-8')));

        $mail = trim($_REQUEST['mail']);

        $mysql->query('UPDATE '.prefix.'_comments SET mail='.db_squote($mail).', text='.db_squote($comment).', answer='.db_squote($content).', name='.db_squote($userROW['name']).' WHERE id='.db_squote($comid));

        if ($content && $_REQUEST['send_notice'] && $mail) {
            $row = $mysql->record('select * from '.prefix.'_news where id='.db_squote($newsid));
            $newsLink = newsGenerateLink($row, false, 0, true);
            sendEmailMessage($mail, $lang['comanswer'], sprintf($lang['notice'], $userROW['name'], $content, $newsLink), 'html');
        }

        msg(['type' => 'info', 'text' => $lang['msgo_saved']]);
		return print_msg( 'update', $lang['page-title'], $lang['msgo_saved'], '?mod=news&action=edit&id='.$newsid );
    }
}

if ($subaction == 'deletecomment') {
    if ($row = $mysql->record('select * from '.prefix.'_comments where id='.db_squote($comid))) {
        $mysql->query('delete from '.prefix.'_comments where id='.db_squote($comid));
        $mysql->query('update '.uprefix.'_users set com=com-1 where id='.db_squote($row['author_id']));
        $mysql->query('update '.prefix.'_news set com=com-1 where id='.db_squote($row['post']));
        msg(['type' => 'info', 'text' => $lang['msgo_deleted'], 'info' => sprintf($lang['msgi_deleted'], '?mod=news&action=edit&id='.$row['post'])]);
		return print_msg( 'delete', $lang['page-title'], $lang['msgo_deleted'], '?mod=news&action=edit&id='.$row['post'] );
    } else {
        msg(['type' => 'error', 'text' => $lang['msge_not_found']]);
		return print_msg( 'error', $lang['page-title'], $lang['msge_not_found'], '?mod=news&action=edit&id='.$newsid );
    }
}

if ($subaction != 'deletecomment') {
    $row = $mysql->record('select * from '.prefix.'_comments where id = '.db_squote($comid));
    if ($row) {
        $row['text'] = str_replace('<br />', "\r\n", $row['text']);
        $row['answer'] = str_replace('<br />', "\r\n", $row['answer']);
		
		$breadcrumb = breadcrumb('<i class="fa fa-comments-o btn-position"></i><span class="text-semibold">'.$lang['page-title'].'</span>', '<i class="fa fa-comments-o btn-position"></i>'.$lang['page-title'].'' );

        $tvars['vars'] = [
            'php_self'  => $PHP_SELF,
            'quicktags' => QuickTags('', 'editcom'),
            'ip'        => $row['ip'],
            'author'    => $row['author'],
            'mail'      => $row['mail'],
            'text'      => $row['text'],
            'answer'    => $row['answer'],
            'newsid'    => $newsid,
            'comid'     => $comid,
        ];
        $tvars['vars']['smilies'] = ($config['use_smilies'] == '1') ? InsertSmilies('content', 5) : '';
        $tvars['vars']['comdate'] = LangDate(pluginGetVariable('comments', 'timestamp'), $row['postdate']);

        if ($userROW['status'] < '3') {
            $tvars['vars']['[answer]'] = '';
            $tvars['vars']['[/answer]'] = '';
        } else {
            $tvars['regx']['[\[answer\](.*)\[/answer\]]'] = '';
        }

        if ($row['text'] != '') {
            $tpl->template('editcomments', tpl_actions);
            $tpl->vars('editcomments', $tvars);
            $main_admin = $tpl->show('editcomments');
        }
    } else {
        msg(['type' => 'error', 'text' => $lang['msge_not_found']]);
		return print_msg( 'error', $lang['page-title'], $lang['msge_not_found'], '?mod=news&action=edit&id='.$newsid );
    }
}
