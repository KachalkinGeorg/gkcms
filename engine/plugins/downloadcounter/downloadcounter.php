<?php

/*
 * Plugin "downloadcounter" for NextGeneration CMS (http://ngcms.ru/)
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

register_plugin_page('downloadcounter', '', 'downloadcounter', 0);

loadPluginLang('downloadcounter', 'main', '', '', ':');

function downloadcounter(){
global $mysql, $config;

$name = $_REQUEST['name'];
$folder = $_REQUEST['folder'];

if($name && $folder)
$row = $mysql->result("SELECT COUNT(id) FROM ".prefix."_files WHERE name='".$name."' AND folder='".$folder."'");
else msg(array("type" => "error", "text" => '<META HTTP-EQUIV="refresh" CONTENT="0;URL=/">'));

if($row){
	if($row['storage'] == 0) {
		$file = $config['files_url'].'/'.$folder.'/'.$name;
	}
	elseif ($row['storage'] == 1) {
		$file = $config['attach_url'].'/'.$folder.'/'.$name;
	}
	$mysql->query("UPDATE ".prefix."_files SET downloadcounter=downloadcounter+1 WHERE name='".$name."' AND folder='".$folder."'");
	header('Location: '.$file);
}
else msg(array("type" => "error", "text" => '<META HTTP-EQUIV="refresh" CONTENT="0;URL=/">'));
}

class downloadcounterFilter extends NewsFilter {
    function showNews($newsID, $SQLnews, &$tvars, $mode = array()) {
	global $config, $parse, $mysql, $tpl, $twig;

	foreach (array('short', 'full') as $varKeyName) {
			//if (!isset($tvars['vars'][$varKeyName])) { continue; }
			if (!isset($tvars['vars']['news'][$varKeyName])) { continue; }

		$parsed = parse_url(home);
		
		if (preg_match_all("/(http:\/\/(".$parsed['host'].")[\w\.\/\-=?#]+)/", $tvars['vars']['news'][$varKeyName], $pcatch, PREG_SET_ORDER)) {
		
						
			$dom_document = new DOMDocument();      
			$dom_document->loadHTML($tvars['vars']['news'][$varKeyName]);

			$links = $dom_document->getElementsByTagName('a'); 
			foreach ($links as $tag)
					{
					
					$ret[$tag->getAttribute('href')] = $tag->childNodes->item(0)->nodeValue;
					}
		
			$rsrc = array();
			$rdest = array();
			$altsrc = array();
			$altdest = array();
		
			foreach ($pcatch as $catch) {
				if (strpos($catch[0],'dsn') !== false) {
				// Init variables
				list ($line, $null, $paramLine, $alt) = $catch;
				array_push($rsrc, $line);
				array_push($altsrc, $ret[$line]);


					$pathd = pathinfo(str_replace(home."/uploads/dsn/", "", $catch[0]));
					$folder = $pathd['dirname'];
					$name = $pathd['basename'];

				$urlREF = $config['home_url'].generatePluginLink('downloadcounter', null, array('folder' => $folder, 'name' => $name));
				$flag = 1;

							
				$downloadcounter = $mysql->result("SELECT downloadcounter FROM ".prefix."_files WHERE name='".$name."' AND folder='".$folder."' LIMIT 1");
				
				// Now let's compose a resulting URL
				$outkeys = $urlREF;

				// Now parse allowed tags and add it into output line
				/*
				foreach ($keys as $kn => $kv) {
					switch ($kn) {
						case 'class':
						case 'target':
							$v = str_replace(array(ord(0), ord(9), ord(10), ord(13), ' ', "'", "\"", ";", ":", '<', '>', '&'),'',$kv);
							$outkeys [] = $kn.'="'.$v.'"';
							break;
						case 'title':
							$v = str_replace(array("\"", ord(0), ord(9), ord(10), ord(13), ":", '<', '>', '&'),array("'",''),$kv);
							$outkeys [] = $kn.'="'.$v.'"';
							break;
					}
				}
				*/
				
				if($flag == 1){
					$tpath = locatePluginTemplates(array('downloadcounter'), 'downloadcounter', pluginGetVariable('downloadcounter', 'localsource'));
					$xt = $twig->loadTemplate($tpath['downloadcounter'].'downloadcounter.tpl');
					
					$pVars = array(
						'count' => $downloadcounter,
					);

					$str = $xt->render($pVars);
				}
				else
				$str = '';
				
				
				// Fill an output replacing array
				array_push($rdest, $outkeys);
				// Fill an output replacing array
				array_push($altdest, $ret[$line].$str);
					
				}
			
			}
		//var_dump($rdest);
		$tvars['vars']['news'][$varKeyName] = str_replace($rsrc, $rdest, $tvars['vars']['news'][$varKeyName]);
		$tvars['vars']['news'][$varKeyName] = str_replace($altsrc, $altdest, $tvars['vars']['news'][$varKeyName]);

		}
			
		if (preg_match_all("#\[counter(\=| *)(.*?)\](.*?)\[\/counter\]#is", $tvars['vars']['news'][$varKeyName], $pcatch, PREG_SET_ORDER)) {
		

			$rsrc = array();
			$rdest = array();
			// Scan all URL tags
			foreach ($pcatch as $catch) {

				// Init variables
				list ($line, $null, $paramLine, $alt) = $catch;
				array_push($rsrc, $line);

				// Check for possible error in case of using "]" within params/url
				// Ex: [url="file[my][super].avi" target="_blank"]F[I]LE[/url] is parsed incorrectly
				if ((strpos($alt, ']') !== false) && (strpos($alt, "\"") !== false)) {
					// Possible bracket error. Make deep analysis
					$jline = $paramLine.']'.$alt;
					$brk = 0;
					$jlen = strlen($jline);
					for ($ji = 0; $ji < $jlen; $ji++) {
						if ($jline[$ji] == "\"") {
							$brk = !$brk;
							continue;
						}

						if ((!$brk) && ($jline[$ji] == ']')) {
							// Found correct delimiter
							$paramLine = substr($jline, 0, $ji);
							$alt = substr($jline, $ji+1);
							break;
						}
					}
				}

				$outkeys = array();

				// Make a parametric line with url
				if (trim($paramLine)) {
					// Parse params
					$keys = $parse->parseBBCodeParams((($null=='=')?'href=':'').$paramLine);
				} else {
					// No params to scan
					$keys = array();
				}
				
				

				// Return an error if BB code is bad
				if (!is_array($keys)) {
					array_push($rdest,'[INVALID URL BB CODE]');
					continue;
				}

				// Check for EMPTY URL
				$urlREF = $parse->validateURL((!$keys['href'])?$alt:$keys['href']);

				if ($urlREF === false) {
					// EMPTY, SKIP
					array_push($rdest, $alt);
					continue;
				}

				$name = explode('/', $urlREF);
								
				$folder = $name[count($name)-2]; 
				$name = $name[count($name)-1];
				

				
				$flag = 0;
				if(strstr($urlREF, $config['files_url'])){
				$urlREF = $config['home_url'].generatePluginLink('downloadcounter', null, array('folder' => $folder, 'name' => $name));
				$flag = 1;
				}
				
				
							
				$downloadcounter = $mysql->result("SELECT downloadcounter FROM ".prefix."_files WHERE name='".$name."' AND folder='".$folder."' LIMIT 1");
				
				// Now let's compose a resulting URL
				$outkeys [] = 'href="'.$urlREF.'"';

				// Now parse allowed tags and add it into output line
				foreach ($keys as $kn => $kv) {
					switch ($kn) {
						case 'class':
						case 'target':
							$v = str_replace(array(ord(0), ord(9), ord(10), ord(13), ' ', "'", "\"", ";", ":", '<', '>', '&'),'',$kv);
							$outkeys [] = $kn.'="'.$v.'"';
							break;
						case 'title':
							$v = str_replace(array("\"", ord(0), ord(9), ord(10), ord(13), ":", '<', '>', '&'),array("'",''),$kv);
							$outkeys [] = $kn.'="'.$v.'"';
							break;
					}
				}
				
				if($flag == 1){
					$tpath = locatePluginTemplates(array('downloadcounter'), 'downloadcounter', pluginGetVariable('downloadcounter', 'localsource'));
					$xt = $twig->loadTemplate($tpath['downloadcounter'].'downloadcounter.tpl');
					
					$pVars = array(
						'count' => $downloadcounter,
					);

					$str = $xt->render($pVars);
				}
				else
				$str = '';
				
				
				// Fill an output replacing array
				array_push($rdest, "<a ".(implode(" ", $outkeys)).">".$alt.'</a>'.$str);

			}
			//$tvars['vars'][$varKeyName] = str_replace($rsrc, $rdest, $tvars['vars'][$varKeyName]);
			$tvars['vars']['news'][$varKeyName] = str_replace($rsrc, $rdest, $tvars['vars']['news'][$varKeyName]);

			
		} // preg_match end
	} //foreach end
	}// showNews end
}// class end

register_filter('news','downloadcounter', new downloadcounterFilter);
