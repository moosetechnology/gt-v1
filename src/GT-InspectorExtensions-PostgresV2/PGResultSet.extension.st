Extension { #name : #PGResultSet }

{ #category : #'*GT-InspectorExtensions-PostgresV2' }
PGResultSet >> gtInspectorResultTableIn: composite [
	<gtInspectorPresentationOrder: 0>
	composite dynamic 
		title: 'Result';
		display: [ | table |
		table := GLMFastTablePresentation new.
		table 
			display: [ self rows ];
			showOnly: 50.
		self rowDescription columnDescriptions doWithIndex: [:column :index | 
			table 
				column: [:r | column fieldName ] 
				evaluated: [:eachRow | 
					(eachRow dataKeyedByFieldName at: column fieldName) asString ]
				sortedBy: [:x :y | 
														(x dataKeyedByFieldName at: column fieldName) > 
														(y dataKeyedByFieldName at: column fieldName)]].
		table ]
]
