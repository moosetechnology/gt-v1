Extension { #name : #DBXSchema }

{ #category : #'*GT-InspectorExtensions-DBXDatabaseModel' }
DBXSchema >> gtInspectorTablesIn: composite inContext: anInspector [
	<gtInspectorPresentationOrder: 40>

	| dbxConnection |
	(anInspector entities do: [ :object | 
		(object isKindOf: DBXConnection) 
			ifTrue: [dbxConnection := object ]]).
	composite list 
		title: 'Tables';
		display: [ dbxConnection tablesDescriptionForSchema: self name ];
		format: #name;
		when: [ dbxConnection notNil ]
]
