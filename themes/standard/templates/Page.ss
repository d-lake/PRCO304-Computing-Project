<!DOCTYPE html>

<!--[if !IE]><!-->
<html lang="$ContentLocale">
<!--<![endif]-->
<!--[if IE 6 ]><html lang="$ContentLocale" class="ie ie6"><![endif]-->
<!--[if IE 7 ]><html lang="$ContentLocale" class="ie ie7"><![endif]-->
<!--[if IE 8 ]><html lang="$ContentLocale" class="ie ie8"><![endif]-->
<head>
	<% base_tag %>
	<title><% if $MetaTitle %>$MetaTitle<% else %>$Title<% end_if %> &raquo; $SiteConfig.Title</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	$MetaTags(false)
	<!--[if lt IE 9]>
	<script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	<% require themedCSS('reset') %>
	<% require themedCSS('typography') %>
	<% require themedCSS('form') %>
	<% require themedCSS('layout') %>
	<link rel="shortcut icon" href="$ThemeDir/images/favicon.ico" />
	<link type="text/css" href="$ThemeDir/css/bootstrap.min.css" rel="stylesheet"/>
	<link type="text/css" href="$ThemeDir/css/font-awesome.min.css" rel="stylesheet" >
	<link type="text/css" href="$ThemeDir/css/lightbox.css" rel="stylesheet" >
	<link type="text/css" href="$ThemeDir/css/dropzone.css" rel="stylesheet" >
	<link type="text/css" href="$ThemeDir/css/style.css?v=2" rel="stylesheet"/>

</head>
<body class="$ClassName">
<% if CurrentMember %> 
	<% include Header %>
	<% include Dock %>
<% end_if %>
<div class="main" role="main">
	$Layout
</div>
<% require javascript('framework/thirdparty/jquery/jquery.js') %>
<%-- Please move: Theme javascript (below) should be moved to mysite/code/page.php  --%>
<script type="text/javascript" src="$ThemeDir/javascript/script.js?v=1"></script>
<script type="text/javascript" src="$ThemeDir/javascript/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="$ThemeDir/javascript/bootstrap.min.js"></script>
<script type="text/javascript" src="$ThemeDir/javascript/scripts.js?v=4"></script>
<script type="text/javascript" src="$ThemeDir/javascript/dropzone.js"></script>
<script type="text/javascript" src="$ThemeDir/javascript/masonry.min.js"></script>
<script type="text/javascript" src="$ThemeDir/javascript/imagesloaded.min.js"></script>
<script type="text/javascript" src="$ThemeDir/javascript/lightbox.js?v=1"></script>


</body>
</html>
