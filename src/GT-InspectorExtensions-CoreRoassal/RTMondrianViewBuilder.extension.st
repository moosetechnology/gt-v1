Extension { #name : #RTMondrianViewBuilder }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTMondrianViewBuilder >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'View';
		initializeView: [ self ]
]
