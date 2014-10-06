Extension { #name : #ZnStatusLine }

{ #category : #'*GT-InspectorExtensions-Core' }
ZnStatusLine >> gtInspectorTextIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ composite rubricText
		title: 'HTTP';
		format: [ String streamContents: [ :out | self writeOn: out ] ]
]
