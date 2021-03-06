Extension { #name : #DBXResultSet }

{ #category : #'*GT-InspectorExtensions-DBXTalk' }
DBXResultSet >> gtInspectorResultTableIn: composite [
	<gtInspectorPresentationOrder: 50>
	composite dynamic 
		title: 'Result';
		display: [:result | 
		| table |
		table := GLMTablePresentation new.
		table 
			display: [:r | result rows ];
			showOnly: 50.
		result columnDescriptions doWithIndex: [:column :index | 
			table column: [:r | column name ] evaluated: [:eachRow | (eachRow rawValueAt: index) asString ]].
		table ]
]
