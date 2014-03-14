Extension { #name : #PGDataRow }

{ #category : #'*GT-InspectorExtensions-PostgresV2' }
PGDataRow >> gtInspectorValuesIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite table
		title: 'Values';
		display: [ self dictionary keys ];
		column: 'Column' evaluated: [ :each | each ];
		column: 'Value' evaluated: [ :each | self atName: each ]
]
