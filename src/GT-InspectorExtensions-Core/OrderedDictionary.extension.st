Extension { #name : #OrderedDictionary }

{ #category : #'*GT-InspectorExtensions-Core' }
OrderedDictionary class >> exampleWithDifferentObjects [
	<gtExample>
	<label: 'Example with different objects'>
	
	^ OrderedDictionary  new
			at: 'Time'   put: Time now;
			at: 'Color'  put: Color cyan;
			at: 'Date'   put: Date today;
			at: 'Morph'  put: HSVAColorSelectorMorph new;
			yourself.
]

{ #category : #'*GT-InspectorExtensions-Core' }
OrderedDictionary >> gtInspectorItemsIn: composite [
	^ (composite table)
		title: 'Items';
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
				selection isNil 
				ifTrue: [ nil ]
				ifFalse: [ selection size = 1  
					ifTrue: [ selection anyOne value ] 
					ifFalse: [ selection collect: #value ] ]];
		showOnly: 50;
		helpMessage: 'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'
]
