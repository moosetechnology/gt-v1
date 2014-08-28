Extension { #name : #ROView }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
ROView >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: 30>
	composite roassal 
		title: 'View';
		initializeView: [self]
]
