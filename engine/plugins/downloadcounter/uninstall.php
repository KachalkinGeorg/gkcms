<?php

/*
 * Uninstall plugin "downloadcounter" for NextGeneration CMS (http://ngcms.ru/)
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
if (!defined('NGCMS')) die ('Galaxy in danger');

global $lang;

loadPluginLang('downloadcounter', 'config', '', '', ':');

$db_update = array(
	array(
		'table'		=>	'files',
		'action'	=>	'modify',
		'fields' => array(
		 array('action' => 'drop', 'name' => 'downloadcounter',  'type' => 'int(10)'),
		)
	),
);

if ($_REQUEST['action'] == 'commit') {
	if (fixdb_plugin_install('downloadcounter', $db_update, 'deinstall')) {
		plugin_mark_deinstalled('downloadcounter');
	}
} else {
	generate_install_page('downloadcounter', $lang['downloadcounter:uninstall'], 'deinstall');
}