Extension { #name : #Bag }

{ #category : #'*GT-InspectorExtensions-Core' }
Bag >> gtInspectorOccurrencesIn: composite [
	<gtInspectorPresentationOrder: 1>  
	^ (composite table)
		title: 'Occurrences';
		display: [ :aCollection | self asSet ];
		column: 'Item' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		column: 'Occurences' 
			evaluated: [ :each | self occurrencesOf: each ];
		beMultiple;
		withSmalltalkSearch;
		showOnly: 50;
		send: [ :result | (result notNil and: [result size = 1]) 
				ifTrue: [result anyOne] 
				ifFalse: [self species withAll: result]];
		helpMessage: 'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'.
]