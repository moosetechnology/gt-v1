Extension { #name : #Collection }

{ #category : #'*GT-InspectorExtensions-Core' }
Collection >> gtDisplayOn: s [
	self printNameOn: s.
	s 
		space;
		nextPut: $[;
		nextPutAll: self size asString;
		nextPutAll: (self size = 1 ifTrue: [' item'] ifFalse: [ ' items' ]);
		nextPut: $];
		space.
	s 
		nextPutAll: 
			((String streamContents: [ :stream | self printElementsOn: stream ]) truncateWithElipsisTo: 42)
]

{ #category : #'*GT-InspectorExtensions-Core' }
Collection class >> gtExampleEmptyArray [
	<gtExample>
	^ #()
]

{ #category : #'*GT-InspectorExtensions-Core' }
Collection class >> gtExampleOrderedCollectionWithOneElement [
	<gtExample>
	^ #(42) asOrderedCollection
]

{ #category : #'*GT-InspectorExtensions-Core' }
Collection >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 0>  
	^ (composite list)
		title: 'Items';
		display: [ :aCollection | self ];
		beMultiple;
		withSmalltalkSearch;		
		format: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		send: [ :result | result isNil 
			ifTrue:[nil]
			ifFalse:[ (result size = 1) 
				ifTrue: [result anyOne] 
				ifFalse: [self species withAll: result]]];
		showOnly: 50;
		helpMessage: 'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'.
]
