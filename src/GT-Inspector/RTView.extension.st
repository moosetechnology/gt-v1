Extension { #name : #RTView }

{ #category : #'*gt-inspector' }
RTView >> gtInspectorElementsHierarchyIn: composite [
	<gtInspectorPresentationOrder: 20>
	composite list 
		title: 'Elements';
		display: [ :each | each elements ]
]

{ #category : #'*gt-inspector' }
RTView >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'View';
		initializeView: [ self ]
		
]
