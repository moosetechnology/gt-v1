Extension { #name : #RTView }

{ #category : #'*GT-InspectorExtensions-Core' }
RTView >> gtInspectorElementsHierarchyIn: composite [
	<gtInspectorPresentationOrder: 20>
	composite list 
		title: 'Elements';
		display: [ :each | each elements ]
]
