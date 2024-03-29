<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: index.php
// Description: core index file
// Author: NGCMS Development Team
//

// Check for minimum supported PHP version
if (version_compare(PHP_VERSION, '7.4.0') < 0) {
    @header('content-type: text/html; charset=utf-8');
    echo "<html><head><title>NGCMS required PHP version 7.4+ / Необходима версия PHP 7.4 или выше</title></head><body><div style='font: 24px verdana; background-color: #EEEEEE; border: #ABCDEF 1px solid; margin: 1px; padding: 3px;'><span style='color: red;'>FATAL ERROR / Фатальная ошибка</span><br/><br/><span style=\"font: 16px arial;\"> NGCMS requires PHP version <b>7.2+</b><br/>Please ask your hosting provider to upgrade your account</span><br/><hr/><span style=\"font: 16px arial;\"> Для работы NGCMS требуется PHP версии <b>7.2</b> или выше.<br/>Обратитесь к вашему хостинг провайдеру для обновления версии</span></div></body></html>";
    exit;
}

// Override charset
@header('content-type: text/html; charset=utf-8');

// Load CORE module
include_once 'engine/core.php';

/**
 * @var $config
 * @var $userROW
 * @var $twig
 * @var $timer
 * @var $systemAccessURL
 * @var $UHANDLER
 * @var $EXTRA_CSS
 * @var $mysql
 * @var $tpl
 * @var $SUPRESS_TEMPLATE_SHOW
 * @var $SUPRESS_MAINBLOCK_SHOW
 * @var $cron
 */


/* if($config['ssl_only'] || (!empty($_SERVER['HTTPS']) && strtolower($_SERVER['HTTPS']) !== 'off')){
    $redirect = 'https://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
    @header('HTTP/1.1 301 Moved Permanently');
    @header('Location: ' . $redirect);
    exit();
} */

if($config['iframe']) {
	if( !preg_match('#^(http|https)://(www.)?(webvisor.com)#', isset($_SERVER['HTTP_REFERER'])) ) {
		@header ("X-Frame-Options: SAMEORIGIN");
	}
}

// Init GZip handler
initGZipHandler();

// Define default TITLE
$SYSTEM_FLAGS['info']['title'] = [];
$SYSTEM_FLAGS['info']['title']['header'] = home_title;

    switch ($config['jsquery']) {
        case 0:
            $jsquery = '';
            break;
        case 1:
            $jsquery = '<script type="text/javascript" src="'.scriptLibrary.'/jquery-v1.8.3.js"></script>';
            break;
        case 2:
            $jsquery = '<script type="text/javascript" src="'.scriptLibrary.'/jquery-v3.4.1.js"></script>';
            break;
        case 3:
            $jsquery = '<script type="text/javascript" src="'.scriptLibrary.'/jquery-v3.6.0.js"></script>';
            break;
    }
$headers .= $jsquery;
if ($config['images_lazy']) $headers .= '<script type="text/javascript" src="'.scriptLibrary.'/lazyload.js"></script>';
$headers .= '<script type="text/javascript" src="'.scriptLibrary.'/functions.js"></script>';
$headers .= '<script type="text/javascript" src="'.scriptLibrary.'/ajax.js"></script>';
$headers .= '<link href="'.scriptLibrary.'/engine.css" type="text/css" rel="stylesheet">';

// Initialize main template array
$template = [
    'vars' => [
        'what'       => engineName,
        'version'    => engineVersion,
        'home'       => home,
        'titles'     => home_title,
        'home_title' => home_title,
        'mainblock'  => '',
        'htmlvars'   => '',
		'headers'    => $headers,
    ],
];

include_once 'engine/includes/main.php';

// ===================================================================
// Check if site access is locked [ for everyone except admins ]
// ===================================================================
if ($config['lock'] and (!isset($userROW) or !is_array($userROW) or (!checkPermission(array('plugin' => '#admin', 'item' => 'system'), null, 'lockedsite.view')))) {

	// Disable cache
	@header('Expires: Sat, 08 Jun 1985 09:10:00 GMT'); // дата в прошлом
	@header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . ' GMT'); // всегда модифицируется
	@header('Cache-Control: no-store, no-cache, must-revalidate'); // HTTP/1.1
	@header('Cache-Control: post-check=0, pre-check=0', false);
	@header('Pragma: no-cache'); // HTTP/1.0

	if (function_exists('opcache_get_status')) ini_set('opcache.enable', 0);
	if (function_exists('opcache_get_status')) ini_set('opcache.enable_cli', 0);
	if (function_exists('xcache_get')) ini_set('xcache.cacher', 0);

	@header('HTTP/1.1 503 Service Temporarily Unavailable', true, 503);
	@header('Status: 503 Service Temporarily Unavailable', true, 503);
	@header('Retry-After: ' . ($config['lock_retry'] ? $config['lock_retry'] : 3600));

    $template['vars']['lock_reason'] = $config['lock_reason'];

    // If template 'sitelock.tpl' exists - show only this template
    if (!file_exists(tpl_site.'sitelock.tpl')) {
        echo 'Site is disabled with reason: '.$config['lock_reason'];
    } else {
        $tVars = $template['vars'];
        $tVars['lock_reason'] = $config['lock_reason'];

        $xt = $twig->loadTemplate('sitelock.tpl');
        echo $xt->render($tVars);
    }

    // STOP SCRIPT EXECUTION
    exit;
}

// ===================================================================
// Start generating page
// ===================================================================

// External call: before executing URL handler
executeActionHandler('index_pre');

// Deactivate block [sitelock] ... [/sitelock]
$template['vars']['[sitelock]'] = '';
$template['vars']['[/sitelock]'] = '';

// /////////////////////////////////////////////////////////// //
// You may modify variable $systemAccessURL here (for hacks)   //
// /////////////////////////////////////////////////////////// //

// /////////////////////////////////////////////////////////// //
$timer->registerEvent('Search route for URL "'.$systemAccessURL.'"');

// Give domainName to URL handler engine for generating absolute links
$UHANDLER->setOptions(['domainPrefix' => $config['home_url']]);

// Check if engine is installed in subdirectory
if (preg_match('#^http\:\/\/([^\/])+(\/.+)#', $config['home_url'], $match)) {
    $UHANDLER->setOptions(['localPrefix' => $match[2]]);
}
$runResult = $UHANDLER->run($systemAccessURL, ['debug' => false]);

// [[MARKER]] URL handler execution is finished
$timer->registerEvent('URL handler execution is finished');

// Generate fatal 404 error [NOT FOUND] if URL handler didn't found any task for execution
if (!$runResult) {
    error404();
}

// External call: after executing URL handler
executeActionHandler('index');

// ===================================================================
// Generate additional informational blocks
// ===================================================================
$timer->registerEvent('General plugins execution is finished');

// Generate category menu
$template['vars']['categories'] = generateCategoryMenu();
$timer->registerEvent('Category menu created');

// Generate page title
$separator = $config['separator'] ? $config['separator'] : ':';
$template['vars']['titles'] = implode(' '.$separator.' ', array_values($SYSTEM_FLAGS['info']['title']));

// Generate user menu
coreUserMenu();

// Generate search form
coreSearchForm();

// Save 'category' variable
$template['vars']['category'] = (isset($_REQUEST['category']) && ($_REQUEST['category'] != '')) ? secure_html($_REQUEST['category']) : '';

// ====================================================================
// External call: All variables for main template are generated
// ===================================================================
executeActionHandler('index_post');

// ===================================================================

// Last-Modified
if($config['last_modif']) {

	$wsnaw = gmmktime(gmdate("H"), gmdate("i"), gmdate("s"), gmdate("m"), gmdate("d"), gmdate("Y"));

	if(!isset($LastModified)){
		// Если это не статья, то у страницы нет даты изменения и поэтому генерируем сами
		
		if ($_SERVER['REQUEST_URI'] == '/'){
			// если это главная
			// Формируем каждый час новую дату
			$LastModified = gmmktime(gmdate("H"), gmdate("d"), gmdate("d")+gmdate("m"), gmdate("m"), gmdate("d"), gmdate("Y"));
			// Задаём время обновления
			$wsuptimer = 3600;
		}
		else{
			// Формируем каждый день новую дату
			// Имитируя ежедневное обновление
			$LastModified = gmmktime(gmdate("m"), gmdate("d"), gmdate("d")+gmdate("m"), gmdate("m"), gmdate("d"), gmdate("Y"));
			// Задаём время обновления
			$wsuptimer = 86400;
		}
		
		if($wsnaw < $LastModified){
			// если сформированная время больше текущей, то отнимаем нужное время и генерируем дату так, как она была бы сгенерирована в то время
			$wstest = $LastModified - $wsuptimer;
			$LastModified = gmmktime(gmdate("H",$wstest), gmdate("d",$wstest), gmdate("d",$wstest)+gmdate("m",$wstest), gmdate("m",$wstest), gmdate("d",$wstest), gmdate("Y",$wstest));
		}
		
	} else {
		// Если это статья у которой известна дата изменения/создания
		// Отдаём её на обновление каждый месяц
		
		$wsdday = gmdate("d",$LastModified);
		if($wsdday > 28) $wsdday = 28; // дата для удобства, так как 28 день есть во всех месяцах
		// Формируем 28-ое число текущего месяца
		$wstemp = gmmktime(gmdate("H",$LastModified), gmdate("i",$LastModified), gmdate("s",$LastModified), gmdate("m"), $wsdday, gmdate("Y"));
		// Если сформированная дата меньше реальной, то конечно отображаем реальную как есть, а если больше, то используем её
		if($wstemp > $LastModified){
			if($wstemp < $wsnaw){
				// если сформированная дата уже наступила
				$LastModified = $wstemp;
			} else {
				// если сформированная дата больше текущей, то получаем такую-же дету месяц назад
				$wsdm = gmdate("m") - 1;
				$wsdy = gmdate("Y");
				if($wsdm == 0){
					$wsdm = 12; // Если прошлый месяц получился 0, значит это был декабрь
					--$wsdy; // значит ещё и год отнять надо
				}
				$wstemp = gmmktime(gmdate("H",$LastModified), gmdate("i",$LastModified), gmdate("s",$LastModified), $wsdm, $wsdday, $wsdy);
				if($wstemp > $LastModified){
					$LastModified = $wstemp;
				}
			}
		}
		
	}
	
	if($LastModified) {
		
		$IfModifiedSince = false;

		if (isset($_ENV['HTTP_IF_MODIFIED_SINCE']))
			$IfModifiedSince = strtotime(substr($_ENV['HTTP_IF_MODIFIED_SINCE'], 5));

		if (isset($_SERVER['HTTP_IF_MODIFIED_SINCE']))
			$IfModifiedSince = strtotime(substr($_SERVER['HTTP_IF_MODIFIED_SINCE'], 5));
	
		if ($IfModifiedSince && $IfModifiedSince >= $LastModified) {
			ob_end_clean();
			@header($_SERVER['SERVER_PROTOCOL'] . ' 304 Not Modified');
			die();
		}
	
		@header('Last-Modified: '. date('r', $LastModified) ." GMT");
	}
}


// Prepare JS/CSS/RSS references

// Make empty OLD STYLE variables
$template['vars']['metatags'] = '';
$template['vars']['extracss'] = '';

// Generate metatags
$EXTRA_HTML_VARS[] = ['type' => 'plain', 'data' => GetMetatags()];

// Fill extra CSS links
foreach ($EXTRA_CSS as $css => $null) {
    $EXTRA_HTML_VARS[] = ['type' => 'css', 'data' => $css];
}

// Fill additional HTML vars
$htmlrow = [];
$dupCheck = [];
foreach ($EXTRA_HTML_VARS as $htmlvar) {
    // Skip empty
    if (!$htmlvar['data']) {
        continue;
    }

    // Check for duplicated rows
    if (in_array($htmlvar['data'], $dupCheck)) {
        continue;
    }
    $dupCheck[] = $htmlvar['data'];

    switch ($htmlvar['type']) {
        case 'css':
            $htmlrow[] = '<link href="'.$htmlvar['data'].'" rel="stylesheet" type="text/css" />';
            break;
        case 'js':
            $htmlrow[] = '<script type="text/javascript" src="'.$htmlvar['data'].'"></script>';
            break;
        case 'rss':
            $htmlrow[] = '<link href="'.$htmlvar['data'].'" rel="alternate" type="application/rss+xml" title="RSS" />';
            break;
        case 'plain':
            $htmlrow[] = $htmlvar['data'];
            break;
    }
}
if (count($htmlrow)) {
    $template['vars']['htmlvars'] .= implode("\n", $htmlrow);
}

// Add support of blocks [is-logged] .. [/isnt-logged] in main template
$template['regx']['#\[is-logged\](.+?)\[/is-logged\]#is'] = is_array($userROW) ? '$1' : '';
$template['regx']['#\[isnt-logged\](.+?)\[/isnt-logged\]#is'] = is_array($userROW) ? '' : '$1';

// ***** EXECUTION TIME CATCH POINT *****
// Calculate script execution time
$template['vars']['queries'] = $mysql->qcnt();
$template['vars']['exectime'] = $timer->stop();

// Fill debug information (if it is requested)
if ($config['debug']) {
    $timer->registerEvent('Templates generation time: '.$tpl->execTime.' ('.$tpl->execCount.' times called)');
    $timer->registerEvent('Generate DEBUG output');
    if (checkPermission(['plugin' => '#admin', 'item' => 'system'], $userROW, 'debug.view')) {
        $template['vars']['debug_queries'] = ($config['debug_queries']) ? ('<b><u>SQL queries:</u></b><br>'.implode("<br />\n", $mysql->query_list).'<br />') : '';
        $template['vars']['debug_profiler'] = ($config['debug_profiler']) ? ('<b><u>Time profiler:</u></b>'.$timer->printEvents(1).'<br />') : '';
        $template['vars']['[debug]'] = '';
        $template['vars']['[/debug]'] = '';
    } else {
        $template['regx']["#\[debug\].*?\[/debug\]#si"] = '';
    }
}

// ===================================================================
// Generate template for main page
// ===================================================================
// 0. Calculate memory PEAK usage
$template['vars']['memPeakUsage'] = sprintf('%7.3f', (memory_get_peak_usage() / 1024 / 1024));

// 1. Determine template name & path
$mainTemplateName = isset($SYSTEM_FLAGS['template.main.name']) ? $SYSTEM_FLAGS['template.main.name'] : 'main';
$mainTemplatePath = isset($SYSTEM_FLAGS['template.main.path']) ? $SYSTEM_FLAGS['template.main.path'] : tpl_site;

// 2. Load & show template
$tpl->template($mainTemplateName, $mainTemplatePath);
$tpl->vars($mainTemplateName, $template);
if (!$SUPRESS_TEMPLATE_SHOW) {
    printHTTPheaders();
    echo $tpl->show($mainTemplateName);
} elseif (!$SUPRESS_MAINBLOCK_SHOW) {
    printHTTPheaders();
    echo $template['vars']['mainblock'];
}

// ===================================================================
// Maintanance activities
// ===================================================================
// Close opened sessions to avoid blocks
session_write_close();

// Run CRON
$cron->run();

// Terminate execution of script
coreNormalTerminate();
