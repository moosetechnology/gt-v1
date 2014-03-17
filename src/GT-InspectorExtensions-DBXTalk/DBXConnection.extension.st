Extension { #name : #DBXConnection }

{ #category : #'*GT-InspectorExtensions-DBXTalk' }
DBXConnection >> gtInspectorSQLExecutorIn: composite [
	<gtInspectorPresentationOrder: 50>
	composite text
		title: 'SQL';
		display: [:connection | 'SELECT' ];
		populate: #selection 
			icon: GLMUIThemeExtraIcons glamorousPlay 
			on: $o entitled: 'Execute and open' 
			with: [:text | self execute: (text selectedText asString ifEmpty: [text text asString ]) ] 
]

{ #category : #'*GT-InspectorExtensions-DBXTalk' }
DBXConnection >> gtInspectorSchemasExecutorIn: composite [
	<gtInspectorPresentationOrder: 50>
	composite list
		title: 'Schemas';
		display: [ self schemas ];
		format: [ :each | each value name ]
]
