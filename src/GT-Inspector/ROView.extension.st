Extension { #name : #ROView }

{ #category : #'*gt-inspector' }
ROView >> gtInspectorElementsHierarchyIn: composite [
	<gtInspectorPresentationOrder: 20>
	composite tree 
		title: 'Elements';
		display: [ :each | {each} ];
		children: #elements
]

{ #category : #'*gt-inspector' }
ROView >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: 30>
	composite roassal 
		title: 'View';
		initializeView: [self]
]
