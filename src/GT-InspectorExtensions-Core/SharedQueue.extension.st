Extension { #name : #SharedQueue }

{ #category : #'*GT-InspectorExtensions-Core' }
SharedQueue class >> gtExampleBasic [
	<gtExample>
	^ self new
		nextPut: 4;
		nextPut: 2;
		yourself
]

{ #category : #'*GT-InspectorExtensions-Core' }
SharedQueue >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 0>
	composite fastList
		title: 'Items';
		display: [ items copy ];
		format: [ :each | each gtDisplayString ]
]
