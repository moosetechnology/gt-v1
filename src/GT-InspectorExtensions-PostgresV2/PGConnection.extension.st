Extension { #name : #PGConnection }

{ #category : #'*GT-InspectorExtensions-PostgresV2' }
PGConnection >> gtInspectorSQLIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite rubricText
		title: 'SQL';
		display: [ GTSnippets instance snippetAtOrEmpty: #'PGConnection-SQL' ];
		selectionPopulate: #selection
			on: $o 
			entitled: 'Execute and open'
			with: [ :text | 
				| queryResults |
				queryResults := (self execute: text selectedText asString) resultSets.
				queryResults isEmpty 
					ifTrue: [ queryResults ] 
					ifFalse: [queryResults anyOne ]]
]
