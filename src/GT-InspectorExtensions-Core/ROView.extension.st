Extension { #name : #ROView }

{ #category : #'*GT-InspectorExtensions-Core' }
ROView >> gtInspectorElementsHierarchyIn: composite [
	<gtInspectorPresentationOrder: 20>
	composite tree 
		title: 'Elements';
		display: [ :each | {each} ];
		children: #elements
]
