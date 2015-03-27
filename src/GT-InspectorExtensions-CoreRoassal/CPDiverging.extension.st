Extension { #name : #CPDiverging }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
CPDiverging classSide >> gtExampleColorPalette [
	<gtExample: 'Colors: diverging scheme'>
	^ self new
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
CPDiverging >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite roassal2
		title: 'View';
		painting: [ :view | self viewOn: view ]
]
