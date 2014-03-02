Extension { #name : #PGConnection }

{ #category : #'*GT-InspectorExtensions-PostgresV2' }
PGConnection >> gtInspectorSQLIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite rubricText
		title: 'SQL';
		display: [ '' ];
		selectionPopulate: #selection
			on: $o 
			entitled: 'Execute and open'
			with: [ :text | 
				(self execute: text selectedText asString) resultSets anyOne ] 
		
]
