<?php

	$schema['central']['marketing']['items']['ai_companion'] = 
	[
		'attrs' =>
		[
			'class' => 'is-addon'
		],
		
		'subitems' =>
		[
            'ai_companion_templates' =>
            [
				'href' => 'ai_companion.templates',
				'position' => 600
            ],
            'ai_companion_content' =>
            [
				'href' => 'ai_companion.content',
				'position' => 600
            ],
		],
		
		'href' => 'ai_companion.templates',
		'alt' => 'ai_companion.update',
		'position' => 500
	];
	
	return $schema;