<?php

	if(!defined('AREA')) exit;
	
	if($mode == "manage")
	{
		$templates = fn_companion_get_templates();
		Tygh::$app['view']->assign('ai_companion_templates', $templates);
	}