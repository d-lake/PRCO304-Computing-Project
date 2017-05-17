<?php

global $project;
$project = 'mysite';

global $databaseConfig;
$databaseConfig = array(
	'type' => 'MySQLDatabase',
	'server' => 'localhost',
	'username' => 'root',
	'password' => 'root',
	'database' => 'SS_mysite',
	'path' => ''
);

// Set the site locale
i18n::set_locale('en_GB');

Member::add_extension('MemberExtension');
Image::add_extension('ImageExtension');
Security::set_default_login_dest('/');