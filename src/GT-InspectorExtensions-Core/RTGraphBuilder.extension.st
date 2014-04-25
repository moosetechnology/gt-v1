Extension { #name : #RTGraphBuilder }

{ #category : #'*GT-InspectorExtensions-Core' }
RTGraphBuilder >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'View';
		initializeView: [ self ]
]
