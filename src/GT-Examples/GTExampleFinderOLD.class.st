Class {
	#name : #GTExampleFinderOLD,
	#superclass : #Object,
	#instVars : [
		'source',
		'provider',
		'subjects'
	],
	#category : #'GT-Examples-DEPRECATED'
}

{ #category : #public }
GTExampleFinderOLD class >> allGTExamples [
	" self allGTExamples "
	| examples |
	examples := OrderedCollection new.
	self allGTExamplesTo: examples.
	^ examples
]

{ #category : #public }
GTExampleFinderOLD class >> allGTExamplesTo: examples [
	Object withAllSubclasses do: [ :class | 
		class gtExamplesFinder ifNotNil: [ :finder | 
			finder gtExamplesContainedTo: examples ] ]
]

{ #category : #examples }
GTExampleFinderOLD class >> gtExampleInstance [
	<gtExample>
	<label: 'An example finder on the source/provider #Number'>
	
	^ self new
		source: Number;
		provider: Number;
		subjects: #();
		yourself
]

{ #category : #public }
GTExampleFinderOLD class >> gtExamplesContained [
	" self gtExamplesContained "
	| examples |
	examples := OrderedCollection new.
	self gtExamplesContainedTo: examples.
	^ examples
]

{ #category : #public }
GTExampleFinderOLD class >> gtExamplesContainedTo: examples [
	Object withAllSubclasses do: [ :class | 
		class gtExamplesFinder ifNotNil: [ :finder | 
			self = finder class ifTrue: [ 
				finder gtExamplesContainedTo: examples ] ] ]
]

{ #category : #ui }
GTExampleFinderOLD class >> gtSpotterExamplesFor: aStep [
	<spotterOrder: 100>
	aStep listProcessor
		title: 'Examples';
		allCandidates: [ self gtExamplesContained ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #DEPRECATED }
GTExampleFinderOLD class >> myExamples [
	self deprecated: 'Please use #gtExamplesContained instead'.
	^ self gtExamplesContained
]

{ #category : #DEPRECATED }
GTExampleFinderOLD class >> myExamplesTo: examples [
	self deprecated: 'Please use #gtExamplesContainedTo: instead'.
	^ self gtExamplesContainedTo: examples
]

{ #category : #'private-primitives' }
GTExampleFinderOLD >> class: aClass selector: aSelector method: aMethod pragma: aPragma [
	^ GTExampleOrganizerOLD instance atMethod: aMethod ifAbsentPut: [ self newExampleFromPragma: aPragma ]
]

{ #category : #private }
GTExampleFinderOLD >> class: aClass selector: aSelector method: aMethod to: examples [
	(aMethod pragmas 
		detect: [ :pragma | pragma isGTExamplePragma ]
		ifNone: [ nil ]) ifNotNil: [ :pragma |
			self example: (self class: aClass selector: aSelector method: aMethod pragma: pragma) to: examples ] 
]

{ #category : #private }
GTExampleFinderOLD >> class: aClass selector: aSelector to: examples [
	(aClass includesSelector: aSelector) ifFalse: [ 
		^ (GTExampleDeclaredMethodMissing new
			methodClass: aClass;
			selector: aSelector;
			yourself) signal ].
	self class: aClass selector: aSelector method: aClass >> aSelector to: examples
]

{ #category : #private }
GTExampleFinderOLD >> class: aClass to: examples [
	aClass selectorsAndMethodsDo: [ :selector :method | 
		self class: aClass selector: selector method: method to: examples ] 
]

{ #category : #private }
GTExampleFinderOLD >> example: anExample to: examples [
	(examples anySatisfy: [ :each | each equalsExample: anExample ]) ifTrue: [ ^ self ].
	examples add: anExample
]

{ #category : #public }
GTExampleFinderOLD >> gtExamplesContained [
	| examples |
	examples := OrderedCollection new.
	self gtExamplesContainedTo: examples.
	^ examples
]

{ #category : #public }
GTExampleFinderOLD >> gtExamplesContainedTo: examples [
	self class: self provider class to: examples
]

{ #category : #ui }
GTExampleFinderOLD >> gtSpotterExamplesFor: aStep [
	<spotterOrder: 100>
	aStep listProcessor
		title: 'Examples';
		allCandidates: [ self gtExamplesContained ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #private }
GTExampleFinderOLD >> method: aMethod to: examples [
	self class: aMethod methodClass selector: aMethod selector method: aMethod to: examples
]

{ #category : #DEPRECATED }
GTExampleFinderOLD >> myExamples [
	self deprecated: 'Please use #gtExamplesContained instead'.
	^ self gtExamplesContained
]

{ #category : #DEPRECATED }
GTExampleFinderOLD >> myExamplesTo: examples [
	self deprecated: 'Please use #gtExamplesContainedTo: instead'.
	^ self gtExamplesContainedTo: examples
]

{ #category : #private }
GTExampleFinderOLD >> newExample [
	^ GTExample new
]

{ #category : #private }
GTExampleFinderOLD >> newExampleFromPragma: aPragma [
	^ self newExample
		initializeFromFinder: self withPragma: aPragma;
		yourself 
]

{ #category : #private }
GTExampleFinderOLD >> newImpostorPragma: aCompiledMethod [
	^ GTExampleImpostorPragma new
		method: aCompiledMethod;
		yourself
]

{ #category : #accessing }
GTExampleFinderOLD >> provider [
	^ provider
]

{ #category : #accessing }
GTExampleFinderOLD >> provider: anObject [
	provider := anObject
]

{ #category : #private }
GTExampleFinderOLD >> proxy: anExampleProxy [
	| examples |
	examples := OrderedCollection new.
	self class: anExampleProxy provider class selector: anExampleProxy selector to: examples.
	^ examples first
]

{ #category : #private }
GTExampleFinderOLD >> proxy: anExampleProxy matchesMethod: aCompiledMethod [
	^ aCompiledMethod class = CompiledMethod
		and: [ anExampleProxy provider class = aCompiledMethod methodClass
			and: [ anExampleProxy selector = aCompiledMethod selector ] ]
]

{ #category : #private }
GTExampleFinderOLD >> proxyExists: anExampleProxy [
	^ anExampleProxy provider class includesSelector: anExampleProxy selector
]

{ #category : #'private-primitives' }
GTExampleFinderOLD >> remove: anExample ifPresent: aBlock [
	^ GTExampleOrganizerOLD instance removeAtMethod: anExample method ifPresent: aBlock
]

{ #category : #accessing }
GTExampleFinderOLD >> source [
	^ source
]

{ #category : #accessing }
GTExampleFinderOLD >> source: anObject [
	source := anObject
]

{ #category : #accessing }
GTExampleFinderOLD >> subjects [
	^ subjects ifNil: [ 
		source 
			ifNotNil: [ OrderedCollection with: source ]
			ifNil: [ OrderedCollection new ] ].
]

{ #category : #accessing }
GTExampleFinderOLD >> subjects: anObject [
	subjects := anObject ifNotNil: [ anObject asOrderedCollection ]
]
