Extension { #name : #CPDiverging }

{ #category : #'*GT-Inspector' }
CPDiverging >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite roassal2
		title: 'View';
		painting: [ :view | self new viewOn: view ]
]
