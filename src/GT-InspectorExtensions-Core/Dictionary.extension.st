Extension { #name : #Dictionary }

{ #category : #'*GT-InspectorExtensions-Core' }
Dictionary class >> gtExampleEmptyDictionary [
	<example>

	^ Dictionary new
]

{ #category : #'*GT-InspectorExtensions-Core' }
Dictionary class >> gtExampleOneElementDictionaryFrom: anEmptyDictionary [
	<example>
	<exampleFrom: #gtExampleEmptyDictionary>
	
	anEmptyDictionary at: 4 put: 2.
	^ anEmptyDictionary
]

{ #category : #'*GT-InspectorExtensions-Core' }
Dictionary class >> gtExampleTwoElementsDictionaryFrom: aDictionary [
	<example>
	<exampleFrom: #gtExampleOneElementDictionaryFrom:>
	
	aDictionary at: #fourty put: 'two'.
	^ aDictionary
]

{ #category : #'*GT-InspectorExtensions-Core' }
Dictionary >> gtInspectorItemsIn: composite [
	^ (composite table)
		title: [ :anObject | self size asString, ' items' ];
		display: [ self associations ];
		children: [ :each | 
			(each value isDictionary) 
				ifTrue: [ each value associations ] 
				ifFalse: [ (each value isArray and: [ each value allSatisfy: #isDictionary ])
						ifTrue: [ each value collectWithIndex: [:x :i | i -> x ] ]
						ifFalse: [ #() ] ] ];
		column: 'Key' 
			evaluated: [:each | GTObjectPrinter new asTruncatedTextFrom: each key ];
		column: 'Value' 
			evaluated: [:each | GTObjectPrinter new asTruncatedTextFrom: each value ];
		selectionAct: [ :table |
			table rawSelection do: [ :assoc | self removeKey: assoc key ].
			table update ]
			entitled: 'Remove item(s)';
		selectionPopulate: #selection 
			entitled: 'Open key'
			with: [ :table | (table rawSelection collect: #key) gtInspectorInterestingObject ];
		beMultiple;
		withSmalltalkSearch;
		send: [ :selection | 
			(selection notNil and: [ selection size = 1 ]) 
				ifTrue: [ selection anyOne value ] 
				ifFalse: [ selection collect: #value ] ];
		showOnly: 50;
		helpMessage: 'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'
]
