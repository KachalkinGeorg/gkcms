<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: ipban.php
// Description: Процедуры настройки IP-запрета
// Author: NGCMS Development Team
//

// Protect against hack attempts
if (!defined('NGCMS')) {
    exit('HAL');
}

$lang = LoadLang('ipban', 'admin');
LoadLang('ipban', 'admin', 'ipban');

//
// Add record into IPBAN list
//
function ipban_add()
{
    global $mysql, $lang;

    // Check for permissions
    if (!checkPermission(['plugin' => '#admin', 'item' => 'ipban'], null, 'modify')) {
        msg(['type' => 'error', 'text' => $lang['perm.denied']], 1, 1);
        ngSYSLOG(['plugin' => '#admin', 'item' => 'ipban'], ['action' => 'modify'], null, [0, 'SECURITY.PERM']);

        return false;
    }

    // Check for security token
    if ((!isset($_REQUEST['token'])) || ($_REQUEST['token'] != genUToken('admin.ipban'))) {
        msg(['type' => 'error', 'text' => $lang['error.security.token'], 'info' => $lang['error.security.token#desc']]);
        ngSYSLOG(['plugin' => '#admin', 'item' => 'ipban'], ['action' => 'modify'], null, [0, 'SECURITY.TOKEN']);

        return false;
    }

    // Check params
    $ip = trim($_REQUEST['ip']);
    //$atype = intval($_REQUEST['atype']);
    $reason = $_REQUEST['lock:rsn'];
    $flags = intval(getIsSet($_REQUEST['lock:open'])).intval($_REQUEST['lock:reg']).intval($_REQUEST['lock:login']).intval($_REQUEST['lock:comm']);

    $addr_start = 0;
    $addr_stop = 0;
    $letlen = 0;
    $result = false;
    if (preg_match('#^(\d+)\.(\d+)\.(\d+)\.(\d+)$#', $ip, $m) && ($m[1] < 256) && ($m[2] < 256) && ($m[3] < 256) && ($m[4] < 256)) {
        $result = true;
        $atype = 0;
        $addr_start = ip2long($m[1].'.'.$m[2].'.'.$m[3].'.'.$m[4]);
        $addr_stop = ip2long($m[1].'.'.$m[2].'.'.$m[3].'.'.$m[4]);
        $letlen = 0;
    } elseif (preg_match('#^(\d+)\.(\d+)\.(\d+)\.(\d+)\/(\d+)\.(\d+)\.(\d+)\.(\d+)$#', $ip, $m) &&
        ($m[1] < 256) && ($m[2] < 256) && ($m[3] < 256) && ($m[4] < 256) &&
        ($m[5] < 256) && ($m[6] < 256) && ($m[7] < 256) && ($m[8] < 256)
    ) {
        $result = true;
        $atype = 1;
        $laddr = ip2long($m[1].'.'.$m[2].'.'.$m[3].'.'.$m[4]);
        $lmask = ip2long($m[5].'.'.$m[6].'.'.$m[7].'.'.$m[8]);

        // Check mask
        $lbmask = decbin($lmask);
        if (!preg_match('#^1+0+$#', $lbmask, $null)) {
            msg(['type' => 'error', 'text' => $lang['ipban']['msge.mask'], 'info' => $lang['ipban']['msge.mask#desc']]);

            return;
        }

        $addr_start = $laddr & $lmask;
        $addr_stop = $laddr | (~$lmask);
        $net_len = $addr_stop - $addr_start;

        // Check maximum net len - 255.255.0.0 (/16) - 16M IP addresses
        if ($net_len > 16777216) {
            msg(['type' => 'error', 'text' => $lang['ipban']['msge.masklen'], 'info' => $lang['ipban']['msge.masklen#desc']]);

            return;
        }
    }

    if ($result) {
        // OK. Check if record already exists
        if (is_array($mysql->record('select addr from '.prefix.'_ipban where addr_start='.db_squote(sprintf('%u', $addr_start)).' and addr_stop='.db_squote(sprintf('%u', $addr_stop))))) {
            // Duplicated
            msg(['type' => 'error', 'text' => $lang['ipban']['msge.exist']]);

            return;
        }
        $mysql->query('insert into '.prefix.'_ipban (addr, atype, addr_start, addr_stop, netlen, flags, createDate, reason, hitcount) values ('.db_squote($ip).', '.db_squote($atype).', '.db_squote(sprintf('%u', $addr_start)).', '.db_squote(sprintf('%u', $addr_stop)).', '.db_squote(sprintf('%u', $net_len)).', '.db_squote($flags).', now(), '.db_squote($reason).', 0)');
        msg(['type' => 'info', 'text' => str_replace('{ip}', $ip, $lang['ipban']['msg.blocked'])]);
		return print_msg( 'info', $lang['ipban']['ipban_title'], str_replace('%ip%', $ip, $lang['ipban']['msgk.ip_block']), 'javascript:history.go(-1)' );
    } else {
        msg(['type' => 'error', 'text' => $lang['ipban']['msge.fields'], 'info' => $lang['ipban']['msgi.fields']]);
		return print_msg( 'error', $lang['ipban']['ipban_title'], $lang['ipban']['msgk.ip_erorr'], 'javascript:history.go(-1)' );
    }
}

//
// Remove record from IPBAN list
//
function ipban_delete()
{
    global $mysql, $lang;

    // Check for permissions
    if (!checkPermission(['plugin' => '#admin', 'item' => 'ipban'], null, 'modify')) {
        msg(['type' => 'error', 'text' => $lang['perm.denied']], 1, 1);
        ngSYSLOG(['plugin' => '#admin', 'item' => 'ipban'], ['action' => 'modify'], null, [0, 'SECURITY.PERM']);

        return false;
    }

    // Check for security token
    if ((!isset($_REQUEST['token'])) || ($_REQUEST['token'] != genUToken('admin.ipban'))) {
        msg(['type' => 'error', 'text' => $lang['error.security.token'], 'info' => $lang['error.security.token#desc']]);
        ngSYSLOG(['plugin' => '#admin', 'item' => 'ipban'], ['action' => 'modify'], null, [0, 'SECURITY.TOKEN']);

        return false;
    }

    $id = intval($_REQUEST['id']);

    // Fetch record
    if (is_array($row = $mysql->record('select * from '.prefix.'_ipban where id = '.$id))) {
        // Record found. Delete it
        $mysql->query('delete from '.prefix.'_ipban where id = '.$id);
        msg(['type' => 'info', 'text' => str_replace('{ip}', $row['addr'], $lang['ipban']['msg.unblocked'])]);
		return print_msg( 'delete', $lang['ipban']['ipban_title'], str_replace('%addr%', $row['addr'], $lang['ipban']['msgk.del_addr']), 'javascript:history.go(-1)' );
    } else {
        msg(['type' => 'error', 'text' => $lang['ipban']['msg.notfound']]);
		return print_msg( 'warning', $lang['ipban']['ipban_title'], $lang['ipban']['msgk.ip_er_id'], 'javascript:history.go(-1)' );
    }
}

//
// Show all records
//
function ipban_list()
{
    global $mysql, $lang, $breadcrumb, $mod, $twig, $PHP_SELF;

    // Check for permissions
    if (!checkPermission(['plugin' => '#admin', 'item' => 'ipban'], null, 'view')) {
        msg(['type' => 'error', 'text' => $lang['perm.denied']], 1, 1);
        ngSYSLOG(['plugin' => '#admin', 'item' => 'ipban'], ['action' => 'view'], null, [0, 'SECURITY.PERM']);

        return false;
    }

    $accessMAP = ['A', 'R', 'U', 'C'];

    $xEntries = [];

    foreach ($mysql->select('select * from '.prefix.'_ipban order by addr') as $row) {
        $accessLine = '';
        for ($i = 0; $i < 4; $i++) {
            $flag = intval(substr($row['flags'], $i, 1));
            switch ($flag) {
                case 1:
                    $accessLine .= '<font color="blue"><b>'.$accessMAP[$i].'</b></font>';
                    break;
                case 2:
                    $accessLine .= '<font color="red"><b>'.$accessMAP[$i].'</b></font>';
                    break;
                default:
                    $accessLine .= '<font color="#CCCCCC"><b>'.$accessMAP[$i].'</b></font>';
                    break;
            }
        }

        $xEntry = [
            'php_self' => $PHP_SELF,
            'id'       => $row['id'],
            'ip'       => $row['addr'],
            'whoisip'  => array_shift(explode('/', $row['addr'])),
            'atype'    => ($row['atype'] ? ' /net' : ''),
            'mode'     => '',
            'descr'    => $row['reason'] == '' ? '-' : $row['reason'],
            'type'     => $accessLine,
            'hitcount' => ($row['hitcount']),
        ];

        $xEntries[] = $xEntry;
    }
	
	$breadcrumb = breadcrumb('<i class="fa fa-search btn-position"></i><span class="text-semibold">'.$lang['ipban']['ipban_title'].'</span>', '<i class="fa fa-search btn-position"></i>'.$lang['ipban']['page-title'].'' );

    $tVars = [
        'php_self' => $PHP_SELF,
        'entries'  => $xEntries,
        'iplock'   => (isset($_REQUEST['iplock']) && $_REQUEST['iplock']) ? $_REQUEST['iplock'] : 0,
        'token'    => genUToken('admin.ipban'),
        'flags'    => [
            'permModify' => checkPermission(['plugin' => '#admin', 'item' => 'ipban'], null, 'modify') ? true : false,
        ],
    ];

    $xt = $twig->loadTemplate('skins/default/tpl/ipban.tpl');

    return $xt->render($tVars);
}

//
// Main loop
//

    switch ($_REQUEST['action']) {
        case 'add':
            ipban_add();
            break;
        case 'del':
            ipban_delete();
            break;
		default:
			$main_admin = ipban_list();
    }