Extension { #name : #Dictionary }

{ #category : #'*gt-inspector' }
Dictionary >> gtInspectorItemsIn: composite [
	^ (composite table)
		title: [ :anObject | self size asString, ' items' ];
		display: [ self associations];
		column: 'Key' evaluated: [:each | GTObjectPrinter asSimpleTextFrom: each ];
		column: 'Value' evaluated: [:each | GTObjectPrinter asSimpleTextFrom: each ];
		beMultiple;
		withSmalltalkSearch;
		send: [ :selection | (selection notNil and: [selection size = 1]) 
				ifTrue: [selection anyOne value] 
				ifFalse: [selection collect: #value] ];
		showOnly: 50;
		helpMessage: 'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'
]

{ #category : #'*gt-inspector' }
Dictionary >> gtInspectorVariableValuePairs [  
	^ OrderedCollection new 
		add: ( 'tally' -> self size );
		add: ( 'array' -> self array );
		yourself

]
