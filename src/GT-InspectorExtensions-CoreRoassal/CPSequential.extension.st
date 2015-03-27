Extension { #name : #CPSequential }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
CPSequential classSide >> gtExample [
	<gtExample: 'Colors: sequential scheme'>
	^ CPSequential new
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
CPSequential >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite roassal2
		title: 'View';
		painting: [ :view | self viewOn: view ]
]
