Extension { #name : #P3Client }

{ #category : #'*GT-InspectorExtensions-P3' }
P3Client >> gtInspectorSQLIn: composite [
	<gtInspectorPresentationOrder: 1>
	composite text
		title: 'SQL';
		display: [ GTSnippets instance snippetAtOrEmpty: #'P3Client-SQL'  ];
		selectionPopulate: #selection 
			on: $g 
			entitled: 'Evaluate selected query' 
			with: [ :text | self query: text selectedText ]
]
