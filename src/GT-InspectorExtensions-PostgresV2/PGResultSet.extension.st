Extension { #name : #PGResultSet }

{ #category : #'*GT-InspectorExtensions-PostgresV2' }
PGResultSet >> gtInspectorResultTableIn: composite [
	<gtInspectorPresentationOrder: 50>
	composite dynamic 
		title: 'Result';
		display: [ | table |
		table := GLMTablePresentation new.
		table 
			display: [ self rows ];
			showOnly: 50.
		self rowDescription columnDescriptions doWithIndex: [:column :index | 
			table 
				column: [:r | column fieldName ] 
				evaluated: [:eachRow | 
					(eachRow dataKeyedByFieldName at: column fieldName) asString ]].
		table ]
]
