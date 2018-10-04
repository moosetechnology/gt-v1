Extension { #name : #PGAsciiRow }

{ #category : #'*GT-InspectorExtensions-PostgresV2' }
PGAsciiRow >> gtInspectorValuesIn: composite [
	<gtInspectorPresentationOrder: 0>
	self dataRow gtInspectorValuesIn: composite
]
