<?php
/*
=====================================================
 Добавление <title></title> с админки v 0.01
-----------------------------------------------------
 Author: Nail' R. Davydov (ROZARD)
-----------------------------------------------------
 Jabber: ROZARD@ya.ru
 E-mail: ROZARD@list.ru
-----------------------------------------------------
 © Настоящий программист никогда не ставит 
 комментариев. То, что писалось с трудом, должно 
 пониматься с трудом. :))
-----------------------------------------------------
 Данный код защищен авторскими правами
=====================================================
*/

if (!defined('NGCMS'))
	exit('HAL');

class TitleNewsFilter extends NewsFilter {
	function addNewsForm(&$tvars)
	{
		global $twig, $lang;
		
        $ttvars = array(
            'localPrefix' => localPrefix,
			'titles' => '',
            );

		$extends = 'meta';

		$tpath = locatePluginTemplates(array('addnews'), 'simple_title_pro', pluginGetVariable('simple_title_pro', 'localsource'));
        $tvars['extends'][$extends][] = [
			'title' => "Титле<br />%home% %cat% %title%",
			'body' => $twig->render($tpath['addnews'].'/addnews.tpl', $ttvars),
			];
		return 1;
	}
	function addNews(&$tvars, &$SQL)
	{
		return true;
	}
	function addNewsNotify(&$tvars, $SQL, $newsid)
	{global $mysql;
		
		$title = secure_html($_REQUEST['titles']);
		
		if( isset($title) && !empty($title) ){
			if( isset($newsid) && !empty($newsid) ){
				$mysql->query('INSERT INTO '.prefix.'_simple_title_pro
									(	title,
										news_id
									) VALUES (
										'.db_squote($title).',
										'.db_squote($newsid).'
									)
				');
			}
		}
	}
	
	function editNewsForm($newsID, $SQLold, &$tvars)
	{global $twig, $lang, $mysql;
		if($row = $mysql->result('SELECT title FROM '.prefix.'_simple_title_pro WHERE news_id = \'' . intval($newsID) . '\' LIMIT 1')){
			$titles = $row;
		}else{
			$titles = '';
		}

        $ttvars = array(
            'localPrefix' => localPrefix,
			'titles' => $titles,
            );

		$extends = 'meta';

		$tpath = locatePluginTemplates(array('editnews'), 'simple_title_pro', pluginGetVariable('simple_title_pro', 'localsource'));
        $tvars['extends'][$extends][] = [
			'title' => "Титле<br />%home% %cat% %title%",
			'body' => $twig->render($tpath['editnews'].'/editnews.tpl', $ttvars),
			];
		return 1;
	}
	
	function editNews($newsID, $SQLold, &$SQLnew, &$tvars)
	{global $mysql, $config;
		$title = isset($_REQUEST['titles'])?secure_html($_REQUEST['titles']):'';
		
		if( isset($newsID) ){
			if($mysql->result('SELECT 1 FROM '.prefix.'_simple_title_pro WHERE news_id = \'' . intval($newsID) . '\' LIMIT 1')){
				$cacheFileName = md5('block_directory_sites_news'.$newsID.$config['default_lang']).'.txt';
				
				cacheStoreFile($cacheFileName, $title, 'simple_title_pro');
				$mysql->query('UPDATE '.prefix.'_simple_title_pro SET 
					title = '.db_squote($title).'
					WHERE news_id = \''.intval($newsID).'\'
				');
			} else {
				if(!empty($title)){
					$mysql->query('INSERT INTO '.prefix.'_simple_title_pro (title, news_id) 
							VALUES 
							('.db_squote($title).',
							'.db_squote($newsID).'
							)
					');
				}
			}
		}
		return true;
	}
}

class TitleStaticFilter extends StaticFilter {

	function addStaticForm(&$tvars)
	{
		global $twig, $lang;
		
        $ttvars = array(
            'localPrefix' => localPrefix,
			'titles' => '',
            );

		$extends = 'main';

		$tpath = locatePluginTemplates(array('addstatic'), 'simple_title_pro', pluginGetVariable('simple_title_pro', 'localsource'));
        $tvars['extends'][$extends][] = [
			'title' => "Титле<br />%home% %static%",
			'body' => $twig->render($tpath['addstatic'].'/addstatic.tpl', $ttvars),
			];
		return 1;
	}

	function addStatic(&$tvars, $SQL)
	{global $mysql;
		
		$title = secure_html($_REQUEST['title']);
		$staticID = $mysql->lastid('static')+1;
		
		if( isset($title) && !empty($title) ){
			if( isset($staticID) && !empty($staticID) ){
				$mysql->query('INSERT INTO '.prefix.'_simple_title_pro
									(	title,
										static_id
									) VALUES (
										'.db_squote($title).',
										'.db_squote($staticID).'
									)
				');
			}
		}
	}
	
	function editStaticForm($staticID, $SQLold, &$tvars)
	{global $twig, $lang, $mysql;
		if($row = $mysql->result('SELECT title FROM '.prefix.'_simple_title_pro WHERE static_id = \'' . intval($staticID) . '\' LIMIT 1')){
			$titles = $row;
		}else{
			$titles = '';
		}

        $ttvars = array(
            'localPrefix' => localPrefix,
			'titles' => $titles,
            );

		$extends = 'main';

		$tpath = locatePluginTemplates(array('editstatic'), 'simple_title_pro', pluginGetVariable('simple_title_pro', 'localsource'));
        $tvars['extends'][$extends][] = [
			'title' => "Титле<br />%home% %static%",
			'body' => $twig->render($tpath['editstatic'].'/editstatic.tpl', $ttvars),
			];
		return 1;
	}
	
	function editStatic($staticID, $SQLold, &$SQLnew, &$tvars)
	{global $mysql, $config;
		$title = isset($_REQUEST['titles'])?secure_html($_REQUEST['titles']):'';
		
		if( isset($staticID) ){
			if($mysql->result('SELECT 1 FROM '.prefix.'_simple_title_pro WHERE static_id = \'' . intval($staticID) . '\' LIMIT 1')){
				$cacheFileName = md5('block_directory_sites_news'.$staticID.$config['default_lang']).'.txt';
				
				cacheStoreFile($cacheFileName, $title, 'simple_title_pro');
				$mysql->query('UPDATE '.prefix.'_simple_title_pro SET 
					title = '.db_squote($title).'
					WHERE static_id = \''.intval($staticID).'\'
				');
			} else {
				if(!empty($title)){
					$mysql->query('INSERT INTO '.prefix.'_simple_title_pro (title, static_id) 
							VALUES 
							('.db_squote($title).',
							'.db_squote($staticID).'
							)
					');
				}
			}
		}
		return true;
	}
}

register_filter('news','simple_title_pro', new TitleNewsFilter);
register_filter('static','simple_title_pro', new TitleStaticFilter);