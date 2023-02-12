<?php

/*
 * Install plugin "downloadcounter" for NextGeneration CMS (http://ngcms.ru/)
 * Copyright (C) 2010 Alexey N. Zhukov (http://digitalplace.ru)
 * http://digitalplace.ru
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 *
 */
 
// Protect against hack attempts
if (!defined('NGCMS'))die ('Galaxy in danger');

function plugin_downloadcounter_install($action) {
	global $lang;
	
	if ($action != 'autoapply')
		loadPluginLang('downloadcounter', 'config', '', '', ':');
		
	$db_update = array(
		array(
			'table' => 'files',
			'action' => 'modify',
			'key' => 'primary key (`id`)',
			'fields' => array(
				array('action' => 'cmodify', 'name' => 'downloadcounter', 'type' => 'int(10)', 'params' =>  'DEFAULT 0')
			)
		)
	);
	
	switch ($action) {
		case 'confirm': 
			 generate_install_page('downloadcounter', $lang['downloadcounter:install']);
			 break;
		case 'autoapply':
		case 'apply':
			if (fixdb_plugin_install('downloadcounter', $db_update, 'install', ($action=='autoapply')?true:false)) {
				plugin_mark_installed('downloadcounter');
			} else {
				return false;
			}
			break;
	}
	return true;
}
