Extension { #name : #CPDiverging }

{ #category : #'*GT-InspectorExtensions-Core' }
CPDiverging >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite roassal2
		title: 'View';
		painting: [ :view | self viewOn: view ]
]
