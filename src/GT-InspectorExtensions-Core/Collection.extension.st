Extension { #name : #Collection }

{ #category : #'*GT-InspectorExtensions-Core' }
Collection class >> exampleEmptyArray [
	<example>
	^ #()
]

{ #category : #'*GT-InspectorExtensions-Core' }
Collection class >> exampleOrderedCollectionWithOneElement [
	<example>
	^ #(42) asOrderedCollection
]

{ #category : #'*GT-InspectorExtensions-Core' }
Collection >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 0>  
	^ (composite list)
		title: [ :anObject | anObject size asString, ' items' ];
		display: [ :aCollection | self ];
		beMultiple;
		withSmalltalkSearch;		
		format: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		send: [ :result | (result notNil and: [result size = 1]) 
				ifTrue: [result anyOne] 
				ifFalse: [self species withAll: result]];
		showOnly: 50;
		helpMessage: 'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'.
]
