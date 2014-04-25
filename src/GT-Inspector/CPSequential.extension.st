Extension { #name : #CPSequential }

{ #category : #'*GT-Inspector' }
CPSequential >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite roassal2
		title: 'View';
		painting: [ :view | self new viewOn: view ]
]
