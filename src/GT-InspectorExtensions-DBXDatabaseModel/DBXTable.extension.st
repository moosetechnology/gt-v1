Extension { #name : #DBXTable }

{ #category : #'*GT-InspectorExtensions-DBXDatabaseModel' }
DBXTable >> gtInspectorColumnsIn: composite inContext: anInspector [
	<gtInspectorPresentationOrder: 40>

	composite table
		title: 'Columns';
		display: [ self columns ];
		column: 'Name' evaluated: [ :each | each name ];
		column: 'Type' evaluated: [ :each | each type typeName ]
]
