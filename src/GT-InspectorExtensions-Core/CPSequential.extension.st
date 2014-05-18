Extension { #name : #CPSequential }

{ #category : #'*GT-InspectorExtensions-Core' }
CPSequential >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite roassal2
		title: 'View';
		painting: [ :view | self viewOn: view ]
]
