<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: preview.php
// Description: Просмотр публикаций
// Author: NGCMS Development Team
//

// Protect against hack attempts
if (!defined('NGCMS')) {
    exit('HAL');
}

$lang = LoadLang('preview', 'admin');

// Preload news display engine
include_once root.'includes/news.php';
include_once root.'includes/classes/upload.class.php';

$main_admin = showPreview();
