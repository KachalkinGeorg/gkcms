<?php

//
// Copyright (C) 2006 Next Generation CMS
// Name: syscron.php
// Description: Entry point for maintanance (cron) external calls
// Author: NGCMS Development Team
//

// Load CORE
@include_once 'engine/core.php';

// Run CRON tasks
$cron->run(true);

// Terminate execution of script
coreNormalTerminate();
