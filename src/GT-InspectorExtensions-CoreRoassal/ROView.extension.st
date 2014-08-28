Extension { #name : #ROView }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
ROView >> gtInspectorElementsHierarchyIn: composite [
	<gtInspectorPresentationOrder: 20>
	composite tree 
		title: 'Elements';
		display: [ :each | {each} ];
		children: #elements
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
ROView >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: 30>
	composite roassal 
		title: 'View';
		initializeView: [self]
]
