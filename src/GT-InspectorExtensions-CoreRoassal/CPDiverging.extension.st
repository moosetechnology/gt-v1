Extension { #name : #CPDiverging }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
CPDiverging classSide >> gtExample [
	<gtExample: 'Colors: diverging scheme'>
	^ CPDiverging new
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
CPDiverging >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite roassal2
		title: 'View';
		painting: [ :view | self viewOn: view ]
]
