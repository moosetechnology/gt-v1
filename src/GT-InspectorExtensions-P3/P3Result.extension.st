Extension { #name : #P3Result }

{ #category : #'*GT-InspectorExtensions-P3' }
P3Result >> gtInspectorTableIn: composite [
	<gtInspectorPresentationOrder: 1>
	| table |
	table := composite table
		title: 'Table';
		display: [ self data ].
	self columns doWithIndex: [ :column :index | 
		table column: column fieldName evaluated: [ :eachRow | (eachRow at: index) gtDisplayString ] ]
]
