Extension { #name : #ROMondrianViewBuilder }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
ROMondrianViewBuilder >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: 30>
	composite roassal 
		title: 'View';
		view: self
]
