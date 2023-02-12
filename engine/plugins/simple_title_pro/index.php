<?php
/*
=====================================================
 Simple Title 0.1 RC4
-----------------------------------------------------
 Author: Nail' R. Davydov (ROZARD)
-----------------------------------------------------
 Jabber: ROZARD@ya.ru
 E-mail: ROZARD@list.ru
-----------------------------------------------------
 ? ????????? ??????????? ??????? ?? ?????? 
 ????????????. ??, ??? ???????? ? ??????, ?????? 
 ?????????? ? ??????. :))
-----------------------------------------------------
 ?????? ??? ??????? ?????????? ???????
=====================================================
*/
if (!defined('NGCMS')) die ( 'HAL' );

add_act ( 'index_post', 'simple_title_pro' );

function simple_title_pro()
{global $template, $SYSTEM_FLAGS, $CurrentHandler, $mysql, $config, $catz, $catmap, $lang;
	
	$pageNo = isset($CurrentHandler['params']['page'])?str_replace('%count%',intval($CurrentHandler['params']['page']), pluginGetVariable('simple_title_pro', 'num_title')):'';
	
	//$html = !empty($SYSTEM_FLAGS['info']['title']['secure_html'])?str_replace('%html%', $SYSTEM_FLAGS['info']['title']['secure_html'], pluginGetVariable('simple_title_pro', 'html_secure')):'';
	$html = !empty($SYSTEM_FLAGS['info']['title']['secure_html'])?str_replace('%html%', $SYSTEM_FLAGS['info']['title']['secure_html'], pluginGetVariable('simple_title_pro', 'html_secure')):str_replace('%html%', $SYSTEM_FLAGS['info']['title']['item'], pluginGetVariable('simple_title_pro', 'html_secure'));
	
	$speedbar = pluginGetVariable('simple_title_pro', 'separator');
	$separator = ' '.$speedbar.' ' ? ' '.$speedbar.' ' : ' ? ';

	//$runResult = $UHANDLER->run($systemAccessURL, array('debug' => true));
	//print "<pre>".var_export($runResult, true)."</pre>";
	//print "<pre>".var_export($CurrentHandler, true)."</pre>";
	//print "<pre>".var_export($SYSTEM_FLAGS, true)."</pre>";
	
	switch ($CurrentHandler['pluginName']){
		case 'news':
			if ($CurrentHandler['handlerName'] == 'by.category'){
				if(isset($SYSTEM_FLAGS['news']['currentCategory.alt'])){
					$cat_name[] = $catz[$SYSTEM_FLAGS['news']['currentCategory.alt']]['name'];
					$id = $catz[$CurrentHandler['params']['category']]['parent'];
					while($id <> 0){
						$cat_name[] = $catz[$catmap[$id]]['name'];
						$id = $catz[$catmap[$id]]['parent'];
					}
					$cat_name = implode($separator, $cat_name);
				} else {
					$cat_name = '??? ?????????';
				}
				
				$cacheFileName = md5('block_directory_sites_cat'.$SYSTEM_FLAGS['news']['currentCategory.id'].$config['default_lang']).'.txt';
				if (false){
					$cacheData = cacheRetrieveFile($cacheFileName, pluginGetVariable('simple_title_pro', 'cache') * 86400, 'simple_title_pro');
					$cacheData  = preg_replace('/\[([^\[\]]+)\]/' , (isset($pageNo) && $pageNo)?'\\1':'', $cacheData);
					if ($cacheData != false){
						$template ['vars'] ['titles'] = trim(str_replace(
							array ('%cat%', '%home%', '%num%', '%s%' ),
							array ($cat_name, $SYSTEM_FLAGS['info']['title']['header'], $pageNo, $separator ),
							$cacheData));
						return;
					}
				}
				
				//????????? ? ?????????
				$c_title = $mysql->result('SELECT title FROM '.prefix.'_simple_title_pro WHERE cat_id = '.db_squote($SYSTEM_FLAGS['news']['currentCategory.id']).' LIMIT 1');
				
				if(empty($c_title))
					$c_title = pluginGetVariable('simple_title_pro', 'c_title');
				
				if (true){
					cacheStoreFile($cacheFileName, $c_title, 'simple_title_pro');
				}
				
				$c_title  = preg_replace('/\[([^\[\]]+)\]/' , (isset($pageNo) && $pageNo)?'\\1':'', $c_title);
				
				$template ['vars'] ['titles'] = trim(str_replace(
					array ('%cat%', '%home%', '%num%', '%s%' ),
					array ($cat_name, $SYSTEM_FLAGS['info']['title']['header'], $pageNo, $separator ),
					$c_title));
			}
			
			if ($CurrentHandler['handlerName'] == 'news'){
				if(isset($SYSTEM_FLAGS['news']['currentCategory.alt'])){
					$cat_name[] = $catz[$SYSTEM_FLAGS['news']['currentCategory.alt']]['name'];
					
					$id = $catz[$CurrentHandler['params']['category']]['parent'];
					//print "<pre>".var_export($catz, true)."</pre>";
					//print "<pre>".var_export($catmap, true)."</pre>";
					while($id <> 0){
						$cat_name[] = $catz[$catmap[$id]]['name'];
						$id = $catz[$catmap[$id]]['parent'];
					}
					$cat_name = implode($separator, $cat_name);
				} else {
					$cat_name = '??? ?????????';
				}
				
				$cacheFileName = md5('block_directory_sites_news'.$SYSTEM_FLAGS['news']['db.id'].$config['default_lang']).'.txt';
				if (false){
					$cacheData = cacheRetrieveFile($cacheFileName, pluginGetVariable('simple_title_pro', 'cache') * 86400, 'simple_title_pro');
					$cacheData  = preg_replace('/\[([^\[\]]+)\]/' , (isset($pageNo) && $pageNo)?'\\1':'', $cacheData);
					if ($cacheData != false)
					{
						$template ['vars'] ['titles'] = trim(str_replace(
							array('%cat%', '%title%', '%home%', '%num%', '%s%'),
							array($cat_name, $SYSTEM_FLAGS['info']['title']['item'],$SYSTEM_FLAGS['info']['title']['header'], $pageNo, $separator),
							$cacheData));
						return;
					}
				}
				/* print '<pre>';
				print_r ($SYSTEM_FLAGS['news']);
				print '</pre>'; */
				
				//????????? ? ?????? ???????
				$n_title = $mysql->result('SELECT title FROM '.prefix.'_simple_title_pro WHERE news_id = '.db_squote($SYSTEM_FLAGS['news']['db.id']).' LIMIT 1');
				
				if(empty($n_title))
					$n_title = pluginGetVariable('simple_title_pro', 'n_title');
				
				if (true){
					cacheStoreFile($cacheFileName, $n_title, 'simple_title_pro');
				}
				
				$n_title  = preg_replace('/\[([^\[\]]+)\]/' , (isset($pageNo) && $pageNo)?'\\1':'', $n_title);
				
				$template['vars']['titles'] = trim(str_replace(
					array('%cat%','%title%','%home%', '%num%', '%s%'),
					array($cat_name, $SYSTEM_FLAGS['info']['title']['item'],$SYSTEM_FLAGS['info']['title']['header'], $pageNo, $separator),
					$n_title));
			}
			
			//???????? ????????? ??????
			if($SYSTEM_FLAGS['info']['title']['group'] == $lang['404.title']){
				$d_title = pluginGetVariable('simple_title_pro', 'd_title');
				$template ['vars'] ['titles'] = trim(str_replace(
						array ('%home%', '%other%', '%s%'),
						array ($SYSTEM_FLAGS['info']['title']['header'], $SYSTEM_FLAGS['info']['title']['group'], $separator ),
						$d_title));
			}
			
			//????????? ??????? ????????
			if ($CurrentHandler['handlerName'] == 'main'){
				$m_title = preg_replace('/\[([^\[\]]+)\]/' , (isset($pageNo) && $pageNo)?'\\1':'', pluginGetVariable('simple_title_pro', 'm_title'));
				
				$template ['vars'] ['titles'] = trim(str_replace(
					array ('%home%', '%num%', '%s%'),
					array ($SYSTEM_FLAGS['info']['title']['header'], $pageNo, $separator),
					$m_title));
			}
			break;
		
		case 'static':
			$cacheFileName = md5('block_directory_sites_static'.$SYSTEM_FLAGS['static']['db.id'].$config['default_lang']).'.txt';
			
			if (true){
				$cacheData = cacheRetrieveFile($cacheFileName, pluginGetVariable('simple_title_pro', 'cache') * 86400, 'simple_title_pro');
				
				if ($cacheData != false){
					$template ['vars'] ['titles'] = trim(str_replace(
						array('%static%', '%home%', '%s%' ),
						array($SYSTEM_FLAGS['info']['title']['item'], $SYSTEM_FLAGS['info']['title']['header'], $separator),
						$cacheData));
					return;
				}
			}
			
			//????????? ??????????? ????????
			$s_title = $mysql->result('SELECT title FROM '.prefix.'_simple_title_pro WHERE static_id = '.db_squote($SYSTEM_FLAGS['static']['db.id']).' LIMIT 1');
			
			if(empty($s_title))
					$s_title = pluginGetVariable('simple_title_pro', 's_title');
			
			if (true){
				cacheStoreFile($cacheFileName, $s_title, 'simple_title_pro');
			}
			
			$template['vars']['titles'] = trim(str_replace(
				array('%static%', '%home%', '%s%' ),
				array($SYSTEM_FLAGS['info']['title']['item'], $SYSTEM_FLAGS['info']['title']['header'], $separator),
				$s_title));
			
			break;
		
		default:
			$list_plugin = array_map('trim', explode(',',pluginGetVariable('simple_title_pro', 'p_title')));
			//print "<pre>".var_export($list_plugin, true)."</pre>";
			//????????? ????????? ???????
			if(isset($CurrentHandler['pluginName']) && $CurrentHandler['pluginName']){
				if(!in_array($CurrentHandler['pluginName'], $list_plugin)){
					$o_title = preg_replace('/\[([^\[\]]+)\]/' , (isset($pageNo) && $pageNo)?'\\1':'', pluginGetVariable('simple_title_pro', 'o_title'));
					$template ['vars'] ['titles'] = trim(str_replace(
						array ('%home%', '%other%', '%html%', '%num%', '%s%'),
						array ($SYSTEM_FLAGS['info']['title']['header'], $SYSTEM_FLAGS['info']['title']['group'], $html, $pageNo, $separator ),
						$o_title));
				}
			} else {
				//???????? ?????? 404
				$e_title = pluginGetVariable('simple_title_pro', 'e_title');
				$template ['vars'] ['titles'] = trim(str_replace(
						array ('%home%', '%other%', '%s%'),
						array ($SYSTEM_FLAGS['info']['title']['header'], $SYSTEM_FLAGS['info']['title']['group'], $separator ),
						$e_title));
			}
	}
}