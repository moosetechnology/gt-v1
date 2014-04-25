Extension { #name : #RTView }

{ #category : #'*GT-InspectorExtensions-Core' }
RTView >> gtInspectorElementsHierarchyIn: composite [
	<gtInspectorPresentationOrder: 20>
	composite list 
		title: 'Elements';
		display: [ :each | each elements ]
]

{ #category : #'*GT-InspectorExtensions-Core' }
RTView >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'View';
		initializeView: [ self ]
		
]
