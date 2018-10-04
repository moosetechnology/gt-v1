Extension { #name : #PGResult }

{ #category : #'*GT-InspectorExtensions-PostgresV2' }
PGResult >> gtInspectorSetsIn: composite [
	<gtInspectorPresentationOrder: 0>
	| queryResults |
	queryResults := self resultSets.
	^ queryResults isEmpty 
					ifTrue: [ queryResults ] 
					ifFalse: [ queryResults anyOne gtInspectorResultTableIn: composite ]
]
