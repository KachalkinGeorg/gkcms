<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: core.php
// Description: Core
// Author: NGCMS Development Team
//

// Configure error display mode
@error_reporting(E_ALL ^ E_NOTICE);

// ============================================================================
// Define global directory constants
// ============================================================================

@define('NGCoreDir', __DIR__.'/');                // Location of Core directory
@define('NGRootDir', dirname(__DIR__).'/');       // Location of SiteRoot
@define('NGClassDir', NGCoreDir.'classes/');      // Location of AutoLoaded classes
@define('NGVendorDir', NGRootDir.'vendor/');      // Location of Vendor classes
$loader = require NGVendorDir.'autoload.php';

// Autoloader for NEW STYLE Classes
spl_autoload_register(function ($className) {
    if (file_exists($fName = NGClassDir.$className.'.class.php')) {
        require_once $fName;
    }
});


spl_autoload_register(function ($class) {
    if (strncmp('GKcms\\', $class, 6) === 0) {
        $file = __DIR__ . '/core/' . str_replace('GKcms\\', '', $class);
    } else {
        $isLib = true;
        $file = __DIR__ . '/core/' . $class;
    }

    $file = str_replace('\\', '/', $file) . '.php';
    if ( file_exists($file) ) {
        require_once $file;
        return;
    }

    if(isset($isLib)){
        $arr = explode('/', $file);
        $last = array_pop($arr);
        array_push($arr, 'src', $last);
        $src = implode('/', $arr);
        if ( file_exists($src) ) {
            require_once $src;
        }
    }
});

// Magic function for immediate closure call
function NGRun($f)
{
    $f();
}

// ============================================================================
// MODULE DEPs check + basic setup
// ============================================================================
NGRun(function () {
    $depList = [
        'sql'      => ['pdo' => '', 'pdo_mysql' => ''],
        'zlib'     => 'ob_gzhandler',
        'iconv'    => 'iconv',
        'GD'       => 'imagecreatefromjpeg',
        'mbstring' => 'mb_internal_encoding',
    ];
    NGCoreFunctions::resolveDeps($depList);

    $sx = NGEngine::getInstance();
    $sx->set('events', new NGEvents());
    $sx->set('errorHandler', new NGErrorHandler());
});

// ============================================================================
// Global variables definition
// ============================================================================
global $PLUGINS, $EXTRA_HTML_VARS, $EXTRA_CSS;
global $AUTH_METHOD, $AUTH_CAPABILITIES, $PPAGES, $PFILTERS, $RPCFUNC, $TWIGFUNC;
global $RPCADMFUNC, $SUPRESS_TEMPLATE_SHOW, $SUPRESS_MAINBLOCK_SHOW, $SYSTEM_FLAGS;
global $DSlist, $PERM, $confPerm, $confPermUser, $systemAccessURL, $cron;
global $timer, $mysql, $ip, $parse, $tpl, $lang, $config;
global $TemplateCache, $siteDomainName, $LastModified;
global $currentHandler, $ngTrackID, $ngCookieDomain;
global $twigGlobal, $twig, $twigLoader, $twigStringLoader;
global $multiDomainName;

// ============================================================================
// Initialize global variables
// ============================================================================
$EXTRA_HTML_VARS = [];        // a list of added HTML vars in <head> block
$EXTRA_CSS = [];

$AUTH_METHOD = [];
$AUTH_CAPABILITIES = [];

$PPAGES = [];        // plugin's pages
$PFILTERS = [];        // filtering plugins
$RPCFUNC = [];        // RPC functions
$TWIGFUNC = [];        // TWIG defined functions
$RPCADMFUNC = [];        // RPC admin functions

$PERM = [];        // PERMISSIONS
$UGROUP = [];        // USER GROUPS

$SUPRESS_TEMPLATE_SHOW = 0;
$SUPRESS_MAINBLOCK_SHOW = 0;

$CurrentHandler = [];
$TemplateCache = [];
$lang = [];

$twigGlobal = [
    'flags' => [
        'isLogged' => 0,
    ],
];

// List of DataSources
$DSlist = [
    'news'           => 1,
    'categories'     => 2,
    'comments'       => 3,
    'users'          => 4,
    'files'          => 10,
    'images'         => 11,
    '#xfields:tdata' => 51,
];

$PLUGINS = [
    'active'        => [],
    'active:loaded' => 0,
    'loaded'        => [],
    'loaded:files'  => [],
    'config'        => [],
    'config:loaded' => 0,
];

mb_internal_encoding('UTF-8');
mb_http_output('UTF-8');

// Define global constants "root", "site_root"
@define('root', __DIR__.'/');
@define('site_root', dirname(__DIR__).'/');

// Define domain name for cookies
$ngCookieDomain = preg_match('#^www\.(.+)$#', $_SERVER['HTTP_HOST'], $mHost) ? $mHost[1] : $_SERVER['HTTP_HOST'];
// Remove non-standart port from domain
if (preg_match("#^(.+?)\:\d+$#", $ngCookieDomain, $m)) {
    $ngCookieDomain = $m[1];
}
// Manage trackID cookie - can be used for plugins that don't require authentication,
// but need to track user according to his ID
if (!isset($_COOKIE['ngTrackID'])) {
    $ngTrackID = md5(md5(uniqid(rand(), 1)));
    @setcookie('ngTrackID', $ngTrackID, time() + 86400 * 365, '/', $ngCookieDomain, 0, 1);
} else {
    $ngTrackID = $_COOKIE['ngTrackID'];
}

// Initialize last variables
$confArray = [
    // Pre-defined init values
    'predefined' => [
        'HTTP_REFERER' => isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : '',
        'PHP_SELF'     => isset($_SERVER['PHP_SELF']) ? $_SERVER['PHP_SELF'] : '',
        'REQUEST_URI'  => isset($_SERVER['REQUEST_URI']) ? $_SERVER['REQUEST_URI'] : '',
        'config'       => [],
        'catz'         => [],
        'catmap'       => [],
        'is_logged'    => false,
    ],
];

// Load pre-defined variables
$predefinedUnsetArray = [
    '_GET',
    '_POST',
    '_SESSION',
    '_COOKIE',
    '_ENV',
];
foreach ($confArray['predefined'] as $key => $value) {
    foreach ($predefinedUnsetArray as $arr) {
        if (isset($$arr, $$arr[$key])) {
            unset($$arr[$key]);
        }
    }
    $$key = $value;
}

// Prepare variable with access URL
$systemAccessURL = $_SERVER['REQUEST_URI'];
if (($tmp_pos = strpos($systemAccessURL, '?')) !== false) {
    $systemAccessURL = mb_substr($systemAccessURL, 0, $tmp_pos);
}

// ============================================================================
// Initialize system libraries
// ============================================================================
// ** Time measurement functions
include_once root.'includes/classes/timer.class.php';
$timer = new microTimer();
$timer->start();

// ** Multisite engine
include_once root.'includes/inc/multimaster.php';

multi_multisites();
/**
 * @var $multiDomainName
 * @var $multimaster
 */
@define('confroot', root.'conf/'.($multiDomainName && $multimaster && ($multiDomainName != $multimaster) ? 'multi/'.$multiDomainName.'/' : ''));

// ** Load system config
include_once confroot.'config.php';
// [[FIX config variables]]
if (!isset($config['uprefix'])) {
    $config['uprefix'] = $config['prefix'];
}

if($config['last_modif'] == 1) {
	$SYSTEM_FLAGS = [
		'actions.disabled' => [],
		'http.headers'     => [
			'content-type'  => 'text/html; charset=utf-8',
			'cache-control' => 'no-cache, no-store',
			'expires' => gmdate('D, d M Y H:i:s', time() - 3600) . ' GMT',
		],
	];
}else{	
	$SYSTEM_FLAGS = [
		'actions.disabled' => [],
		'http.headers'     => [
			'content-type'  => 'text/html; charset=utf-8',
			'cache-control' => 'private',
		],
	];
}

// Set up default timezone [ default: Europe/Moscow ]
date_default_timezone_set($config['timezone'] ? $config['timezone'] : 'Europe/Moscow');

// [[MARKER]] Configuration file is loaded
$timer->registerEvent('Config file is loaded');

// Call multidomains processor
multi_multidomains();
//print "siteDomainName [".$siteDomainName."]<br/>\n";

// Initiate session - take care about right domain name for sites with/without www. prefix
//print "<pre>".var_export($_SERVER, true).var_export($_COOKIE, true)."</pre>";
@session_set_cookie_params(86400, '/', $ngCookieDomain);
@session_start();

// ** Load system libraries
include_once root.'includes/inc/consts.inc.php';
include_once root.'includes/inc/functions.inc.php';
include_once root.'includes/inc/extras.inc.php';

include_once 'includes/classes/templates.class.php';
include_once 'includes/classes/parse.class.php';

include_once 'includes/classes/uhandler.class.php';

// [[MARKER]] All system libraries are loaded
$timer->registerEvent('Core files are included');

// ** Activate URL processing library
$UHANDLER = new urlHandler();
$UHANDLER->loadConfig();

// ** Other libraries
$parse = new parse();
$tpl = new tpl();
$ip = checkIP();

// ** Load configuration file
if ((!file_exists(confroot.'config.php')) || (filesize(confroot.'config.php') < 10)) {
    if (preg_match("#^(.*?)(\/index\.php|\/engine\/admin\.php)$#", $_SERVER['PHP_SELF'], $ms)) {
        @header('Location: '.$ms[1].'/engine/install.php');
    } else {
        @header('Location: '.adminDirName.'/install.php');
    }
    echo 'NGCMS: Engine is not installed yet. Please run installer from /engine/install.php';
    exit;
}

// ** Load user groups
loadGroups();

// ** Init our own exception handler
set_exception_handler('ngExceptionHandler');
set_error_handler('ngErrorHandler');
register_shutdown_function('ngShutdownHandler');

//
// *** Initialize TWIG engine
$twigLoader = new NGTwigLoader(root);

// - Configure environment and general parameters
$twig = new NGTwigEnvironment($twigLoader, [
    'cache'       => root.'cache/twig/',
    'auto_reload' => true,
    'autoescape'  => false,
    'charset'     => 'UTF-8',
]);

// [[MARKER]] TWIG template engine is loaded
$timer->registerEvent('Template engine is activated');

// Give domainName to URL handler engine for generating absolute links
$UHANDLER->setOptions(['domainPrefix' => $config['home_url']]);

// Check if engine is installed in subdirectory
if (preg_match('#^(http|https)\:\/\/([^\/])+(\/.+)#', $config['home_url'], $match)) {
    $UHANDLER->setOptions(['localPrefix' => $match[2]]);
}

// ** Load cache engine
@include_once root . 'includes/classes/cache.class.php';
@include_once root . 'includes/inc/DBLoad.php';

// NEW :: PDO driver with global classes handler
NGRun(function () {
    global $config, $mysql;

    $sx = NGEngine::getInstance();

    switch ($config['dbtype']) {
        case 'mysqli':
            $sx->set('db', new NGMYSQLi(array('host' => $config['dbhost'], 'user' => $config['dbuser'], 'pass' => $config['dbpasswd'], 'db' => $config['dbname'], 'charset' => 'utf8')));
            break;
        case 'pdo':
            $sx->set('db', new NGPDO(array('host' => $config['dbhost'], 'user' => $config['dbuser'], 'pass' => $config['dbpasswd'], 'db' => $config['dbname'], 'charset' => 'utf8')));
            break;
        default:
            $sx->set('db', new NGMYSQLi(array('host' => $config['dbhost'], 'user' => $config['dbuser'], 'pass' => $config['dbpasswd'], 'db' => $config['dbname'], 'charset' => 'utf8')));
    }

    $sx->set('config', $config);
    $sx->set('legacyDB', new NGLegacyDB(false));
    $sx->getLegacyDB()->connect('', '', '');
    $mysql = $sx->getLegacyDB();

    // Sync PHP <=> MySQL timezones
    $mysql->query('SET @@session.time_zone = "'.date('P').'"');
});

// [[MARKER]] MySQL connection is established
$timer->registerEvent('DB connection established');

// ** Load categories from DB
ngLoadCategories();

// [[MARKER]] Categories are loaded
$timer->registerEvent('DB category list is loaded');

// ** Load compatibility engine [ rewrite old links ]
if ($config['libcompat']) {
    include_once root.'includes/inc/libcompat.php';
    compatRedirector();
}

//
// Special way to pass authentication cookie via POST params
if (!isset($_COOKIE['zz_auth']) && isset($_POST['ngAuthCookie'])) {
    $_COOKIE['zz_auth'] = $_POST['ngAuthCookie'];
}

// [[MARKER]] Ready to load auth plugins
$timer->registerEvent('Ready to load auth plugins');
loadActionHandlers('auth');

// ** Load user's permissions DB
loadPermissions();

// ============================================================================
// Initialize system libraries
// ============================================================================
// System protection
if (!$AUTH_CAPABILITIES[$config['auth_module']]['login']) {
    $config['auth_module'] = 'basic';
}
if (!$AUTH_CAPABILITIES[$config['auth_db']]['db']) {
    $config['auth_db'] = 'basic';
}

if ((is_object($AUTH_METHOD[$config['auth_module']])) && (is_object($AUTH_METHOD[$config['auth_db']]))) {
    // Auth subsystem is activated
    // * choose default or user defined auth module
    if (isset($_REQUEST['auth_module']) && $AUTH_CAPABILITIES[$_REQUEST['auth_module']]['login'] && is_object($AUTH_METHOD[$_REQUEST['auth_module']])) {
        $auth = &$AUTH_METHOD[$_REQUEST['auth_module']];
    } else {
        $auth = &$AUTH_METHOD[$config['auth_module']];
    }
    $auth_db = &$AUTH_METHOD[$config['auth_db']];

    $xrow = $auth_db->check_auth();
    $CURRENT_USER = $xrow;

    if (is_array($xrow)) {
        NGEngine::getInstance()->set('currentUser', new NGUser($xrow));
    }

    if (isset($xrow['name']) && $xrow['name']) {
        $is_logged_cookie = true;
        $is_logged = true;
        $username = $xrow['name'];
        $userROW = $xrow;
        if ($config['x_ng_headers']) {
            header('X-NG-UserID: '.(int) $userROW['id']);
            header('X-NG-Login: '.htmlentities($username));
        }

        // - Now every TWIG template will know if user is logged in
        $twigGlobal['flags']['isLogged'] = 1;
        $twigGlobal['user'] = $userROW;
        //$twig->addGlobalRef('user',	$userROW);
    }
} else {
    echo "Fatal error: No auth module is found.<br />Configuration is damaged, please restore from backup or perform manual fix.<br />\n";
}

// [[MARKER]] Authentification process is complete
$timer->registerEvent('Auth procedure is finished');

if ($is_logged) {
    @define('name', $userROW['name']);
}

// Init internal cron module
$cron = new cronManager();

// ** Load action handlers for action 'all'
loadActionHandlers('all');
$timer->registerEvent('ALL core-related plugins are loaded');

// ** Execute 'core' action handler
executeActionHandler('core');
$timer->registerEvent('ALL core-related plugins are executed');

// Define last consts
define('tpl_site', site_root.'templates/'.$config['theme'].'/');
define('tpl_url', home.'/templates/'.$config['theme']);

// - TWIG: Reconfigure allowed template paths - site template is also available
$twigLoader->setPaths([tpl_site, root]);

// - TWIG: Added global variable `tpl_url`, `scriptLibrary`
$twig->addGlobal('tpl_url', tpl_url);
$twig->addGlobal('scriptLibrary', scriptLibrary);

// Lang files are loaded _after_ executing core scripts. This is done for switcher plugin
$lang = LoadLang('common');
$lang = LoadLangTheme();

$langShortMonths = explode(',', $lang['short_months']);
$langMonths = explode(',', $lang['months']);

$timer->registerEvent('* CORE.PHP is complete');

$twig->addFilter(new \Twig\TwigFilter('cdate', 'cdate'));