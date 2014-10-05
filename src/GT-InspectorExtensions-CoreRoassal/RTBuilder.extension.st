Extension { #name : #RTBuilder }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTBuilder >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'View';
		initializeView: [ self ]
]
