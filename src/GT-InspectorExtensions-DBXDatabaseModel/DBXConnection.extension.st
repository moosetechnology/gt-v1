Extension { #name : #DBXConnection }

{ #category : #'*GT-InspectorExtensions-DBXDatabaseModel' }
DBXConnection >> gtInspectorSchemasExecutorIn: composite [
	<gtInspectorPresentationOrder: 50>
	composite list
		title: 'Schemas';
		display: [ self schemas ];
		format: [ :each | each value name ]
]
