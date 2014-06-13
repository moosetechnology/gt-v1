Extension { #name : #Dictionary }

{ #category : #'*GT-InspectorExtensions-Core' }
Dictionary >> gtInspectorItemsIn: composite [
	^ (composite table)
		title: [ :anObject | self size asString, ' items' ];
		display: [ self associations];
		column: 'Key' 
			evaluated: [:each | GTObjectPrinter new asTruncatedTextFrom: each key ];
		column: 'Value' 
			evaluated: [:each | GTObjectPrinter new asTruncatedTextFrom: each value ];
		selectionAct: [ :table |
			table rawSelection do: [ :assoc |
				self removeKey: assoc key ].
			table update ]
			entitled: 'Remove item(s)';
		beMultiple;
		withSmalltalkSearch;
		send: [ :selection | (selection notNil and: [selection size = 1]) 
				ifTrue: [selection anyOne value] 
				ifFalse: [selection collect: #value] ];
		showOnly: 50;
		helpMessage: 'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'
]

{ #category : #'*GT-InspectorExtensions-Core' }
Dictionary >> gtInspectorVariableValuePairs [  
	^ Set new 
		add: ( 'tally' -> self size );
		add: ( 'array' -> self array );
		yourself

]
