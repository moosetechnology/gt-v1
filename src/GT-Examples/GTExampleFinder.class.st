Class {
	#name : #GTExampleFinder,
	#superclass : #Object,
	#instVars : [
		'source',
		'provider',
		'subjects'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #public }
GTExampleFinder class >> allGTExamples [
	" self allGTExamples "
	| examples |
	examples := OrderedCollection new.
	self allGTExamplesTo: examples.
	^ examples
]

{ #category : #public }
GTExampleFinder class >> allGTExamplesTo: examples [
	Object withAllSubclasses do: [ :class | 
		class gtExamplesFinder ifNotNil: [ :finder | 
			finder gtExamplesContainedTo: examples ] ]
]

{ #category : #examples }
GTExampleFinder class >> gtExampleInstance [
	<gtExample>
	<label: 'An example finder on the source/provider #Number'>
	
	^ self new
		source: Number;
		provider: Number;
		subjects: #();
		yourself
]

{ #category : #public }
GTExampleFinder class >> gtExamplesContained [
	" self gtExamplesContained "
	| examples |
	examples := OrderedCollection new.
	self gtExamplesContainedTo: examples.
	^ examples
]

{ #category : #public }
GTExampleFinder class >> gtExamplesContainedTo: examples [
	Object withAllSubclasses do: [ :class | 
		class gtExamplesFinder ifNotNil: [ :finder | 
			self = finder class ifTrue: [ 
				finder gtExamplesContainedTo: examples ] ] ]
]

{ #category : #ui }
GTExampleFinder class >> gtSpotterExamplesFor: aStep [
	<spotterOrder: 100>
	aStep listProcessor
		title: 'Examples';
		allCandidates: [ self gtExamplesContained ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #DEPRECATED }
GTExampleFinder class >> myExamples [
	self deprecated: 'Please use #gtExamplesContained instead'.
	^ self gtExamplesContained
]

{ #category : #DEPRECATED }
GTExampleFinder class >> myExamplesTo: examples [
	self deprecated: 'Please use #gtExamplesContainedTo: instead'.
	^ self gtExamplesContainedTo: examples
]

{ #category : #'private-primitives' }
GTExampleFinder >> class: aClass selector: aSelector method: aMethod pragma: aPragma [
	^ GTExampleOrganizer instance atMethod: aMethod ifAbsentPut: [ self newExampleFromPragma: aPragma ]
]

{ #category : #private }
GTExampleFinder >> class: aClass selector: aSelector method: aMethod to: examples [
	(aMethod pragmas 
		detect: [ :pragma | pragma isGTExamplePragma ]
		ifNone: [ nil ]) ifNotNil: [ :pragma |
			self example: (self class: aClass selector: aSelector method: aMethod pragma: pragma) to: examples ] 
]

{ #category : #private }
GTExampleFinder >> class: aClass selector: aSelector to: examples [
	(aClass includesSelector: aSelector) ifFalse: [ 
		^ (GTExampleDeclaredMethodMissing new
			methodClass: aClass;
			selector: aSelector;
			yourself) signal ].
	self class: aClass selector: aSelector method: aClass >> aSelector to: examples
]

{ #category : #private }
GTExampleFinder >> class: aClass to: examples [
	aClass selectorsAndMethodsDo: [ :selector :method | 
		self class: aClass selector: selector method: method to: examples ] 
]

{ #category : #private }
GTExampleFinder >> example: anExample to: examples [
	(examples anySatisfy: [ :each | each equalsExample: anExample ]) ifTrue: [ ^ self ].
	examples add: anExample
]

{ #category : #public }
GTExampleFinder >> gtExamplesContained [
	| examples |
	examples := OrderedCollection new.
	self gtExamplesContainedTo: examples.
	^ examples
]

{ #category : #public }
GTExampleFinder >> gtExamplesContainedTo: examples [
	self class: self provider class to: examples
]

{ #category : #ui }
GTExampleFinder >> gtSpotterExamplesFor: aStep [
	<spotterOrder: 100>
	aStep listProcessor
		title: 'Examples';
		allCandidates: [ self gtExamplesContained ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #private }
GTExampleFinder >> method: aMethod to: examples [
	self class: aMethod methodClass selector: aMethod selector method: aMethod to: examples
]

{ #category : #DEPRECATED }
GTExampleFinder >> myExamples [
	self deprecated: 'Please use #gtExamplesContained instead'.
	^ self gtExamplesContained
]

{ #category : #DEPRECATED }
GTExampleFinder >> myExamplesTo: examples [
	self deprecated: 'Please use #gtExamplesContainedTo: instead'.
	^ self gtExamplesContainedTo: examples
]

{ #category : #private }
GTExampleFinder >> newExample [
	^ GTExample new
]

{ #category : #private }
GTExampleFinder >> newExampleFromPragma: aPragma [
	^ self newExample
		initializeFromFinder: self withPragma: aPragma;
		yourself 
]

{ #category : #private }
GTExampleFinder >> newImpostorPragma: aCompiledMethod [
	^ GTExampleImpostorPragma new
		method: aCompiledMethod;
		yourself
]

{ #category : #accessing }
GTExampleFinder >> provider [
	^ provider
]

{ #category : #accessing }
GTExampleFinder >> provider: anObject [
	provider := anObject
]

{ #category : #private }
GTExampleFinder >> proxy: anExampleProxy [
	| examples |
	examples := OrderedCollection new.
	self class: anExampleProxy provider class selector: anExampleProxy selector to: examples.
	^ examples first
]

{ #category : #private }
GTExampleFinder >> proxy: anExampleProxy matchesMethod: aCompiledMethod [
	^ aCompiledMethod class = CompiledMethod
		and: [ anExampleProxy provider class = aCompiledMethod methodClass
			and: [ anExampleProxy selector = aCompiledMethod selector ] ]
]

{ #category : #private }
GTExampleFinder >> proxyExists: anExampleProxy [
	^ anExampleProxy provider class includesSelector: anExampleProxy selector
]

{ #category : #'private-primitives' }
GTExampleFinder >> remove: anExample ifPresent: aBlock [
	^ GTExampleOrganizer instance removeAtMethod: anExample method ifPresent: aBlock
]

{ #category : #accessing }
GTExampleFinder >> source [
	^ source
]

{ #category : #accessing }
GTExampleFinder >> source: anObject [
	source := anObject
]

{ #category : #accessing }
GTExampleFinder >> subjects [
	^ subjects ifNil: [ 
		source 
			ifNotNil: [ OrderedCollection with: source ]
			ifNil: [ OrderedCollection new ] ].
]

{ #category : #accessing }
GTExampleFinder >> subjects: anObject [
	subjects := anObject ifNotNil: [ anObject asOrderedCollection ]
]