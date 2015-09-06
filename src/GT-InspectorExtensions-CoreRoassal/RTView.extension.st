Extension { #name : #RTView }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTView classSide >> gtExampleEmptyView [
	<gtExample>
	<label: 'Empty view'>
	
	^ self new
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTView >> gtInspectorElementsHierarchyIn: composite [
	<gtInspectorPresentationOrder: 20>
	composite table 
		title: 'Elements';
		showOnly: 50;
		display: [ :each | each elements ];
		children: #nestedElements;
		column: 'Model' evaluated: [ :each | each model asString ];
		column: 'Shape' evaluated: [ :each | each shape asString ]
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTView >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'View';
		initializeView: [ self ]
		
]
