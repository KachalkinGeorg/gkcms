<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: rules.php
// Description: Статистические страницы
// Author: NGCMS Development Team
//


if (!defined('NGCMS')) {
    exit('HAL');
}

$lang = LoadLang('rules', 'admin');

if ($config['reg_rules'] == '0') {
	msg(['type' => 'error', 'text' => $lang['rules.title'], 'info' => $lang['rules_off']]);
	return print_msg( 'warning', $lang['rules'], $lang['rules_off'], 'javascript:history.go(-1)' );
}

function RulesForm()
{
    global $lang, $parse, $mysql, $config, $twig, $tvars, $userROW, $PHP_SELF, $breadcrumb;

	$breadcrumb = breadcrumb('<i class="fa fa-book btn-position"></i><span class="text-semibold">'.$lang['rules'].'</span>', '<i class="fa fa-book btn-position"></i>'.$lang['rules.title'].'' );

	$row = $mysql->record( "select * from " . prefix . "_rules WHERE alt_name = 'rules_page' LIMIT 1" );
    $tVars = [
        'php_self'     => $PHP_SELF,
        'quicktags'    => QuickTags('currentInputAreaID', 'pmmes'),
        'smilies'      => $config['use_smilies'] ? InsertSmilies('content', 20) : '',
    ];
    // Fill data entry
    $tVars['data'] = [
        'id'                 => $row['id'],
        'title'              => secure_html(getIsSet($row['title'])),
        'content'            => secure_html(getIsSet($row['content'])),
        'alt_name'           => 'rules_page',
        'description'        => getIsSet($row['description']),
        'keywords'           => getIsSet($row['keywords']),
    ];

    exec_acts('doneRules');

    $xt = $twig->loadTemplate('skins/default/tpl/rules.tpl');
    return $xt->render($tVars);

}

function doneRules()
{
    global $mysql, $parse, $lang, $config;

    $id = intval($_REQUEST['id']);
    $title = $_REQUEST['title'];
    $content = $_REQUEST['content'];
    $alt_name = 'rules_page';

    if ((!strlen(trim($title))) || (!strlen(trim($content)))) {
		msg(['type' => 'error', 'title' => $lang['msge_fields'], 'text' => $lang['msgi_fields']]);
		print_msg( 'error', $lang['rules'], $lang['msgk_fields'], 'javascript:history.go(-1)' );
        return 0;
    }

    $SQL['title'] = $title;

    $SQL['alt_name'] = $alt_name;

    if ($config['meta']) {
        $SQL['description'] = $_REQUEST['description'];
        $SQL['keywords'] = $_REQUEST['keywords'];
    }

    $SQL['content'] = $content;

    $mysql->query('update '.prefix.'_rules set `title`='.db_squote($title).', `alt_name`='.db_squote($alt_name).', `content`='.db_squote($content).', `description`='.db_squote($description).', `keywords`='.db_squote($keywords).' where id='.db_squote($id));

	msg(['type' => 'info', 'title' => $lang['rules.title'], 'text' => $lang['msge.edited'], 'info' => $lang['msgi.edited']]);
	return print_msg( 'update', $lang['rules'], $lang['msgk.edited'], '?mod=rules' );

}

$action = isset($_REQUEST['action']) ? $_REQUEST['action'] : '';

switch ($action) {

    case 'edit':
        doneRules();
        break;

    case 'editForm':
        $main_admin = RulesForm();
        break;
	default:
        $main_admin = RulesForm();

    }
