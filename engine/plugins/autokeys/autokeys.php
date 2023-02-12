<?php

// Protect against hack attempts
if (!defined('NGCMS')) die ('HAL');

// Load library
@include_once(root."/plugins/autokeys/lib/class.php");

// News filtering class
class autoKeysNewsFilter extends NewsFilter {

	function __construct() {
		LoadPluginLang('autokeys', 'admin', '', 'autokeys', ':');
	}

	function addNews(&$tvars, &$SQL) {
		if ($_POST['autokeys_generate'] == 1) {
			$SQL['keywords'] = akeysGetKeys(array('content' => $SQL['content'], 'title' => $SQL['title']));
		}
		return 1;
	}

	function editNews($newsID, $SQLold, &$SQLnew, &$tvars) {
		if ($_POST['autokeys_generate'] == 1) {
			$SQLnew['keywords'] = akeysGetKeys(array('content' => $SQLnew['content'], 'title' => $SQLnew['title']));
		}
		return 1;
	}

	function editNewsForm($newsID, $SQLold, &$tvars) {
		global $twig, $lang;

		$extends = 'js';

		$tpath = locatePluginTemplates(array('editnews'), 'autokeys', pluginGetVariable('autokeys', 'localsource'));
        $tvars['extends'][$extends][] = [
			'body' => $twig->render($tpath['editnews'].'/editnews.tpl', array('flags' => array('checked' => pluginGetVariable('autokeys', 'activate_edit')))),
			];

		return 1;
	}

	function addNewsForm(&$tvars) {
		global $twig, $lang;

		$extends = 'js'; //$extends = pluginGetVariable($plugin,'extends') ? pluginGetVariable($plugin,'extends') : 'js';

		$tpath = locatePluginTemplates(array('addnews'), 'autokeys', pluginGetVariable('autokeys', 'localsource'));
		$tvars['extends'][$extends][] = [
			'body' => $twig->render($tpath['addnews'].'/addnews.tpl', array('flags' => array('checked' => pluginGetVariable('autokeys', 'activate_add')))),
			];

		return 1;
	}
}

pluginRegisterFilter('news','autokeys', new autoKeysNewsFilter);