Class {
	#name : #GTExampleFinder,
	#superclass : #Object,
	#instVars : [
		'source',
		'provider',
		'subjects'
	],
	#category : #'GT-Inspector-Examples-Utils'
}

{ #category : #public }
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
GTExampleFinder class >> gtExamples [
	" self gtExamples "
	| examples |
	examples := OrderedCollection new.
	self gtExamplesTo: examples.
	^ examples
]

{ #category : #public }
GTExampleFinder class >> gtExamplesTo: examples [
	Object withAllSubclasses do: [ :class | 
		class gtExamplesFinder ifNotNil: [ :finder | 
			finder gtExamplesTo: examples ] ]
]

{ #category : #public }
GTExampleFinder class >> myExamples [
	" self myExamples "
	| examples |
	examples := OrderedCollection new.
	self myExamplesTo: examples.
	^ examples
]

{ #category : #public }
GTExampleFinder class >> myExamplesTo: examples [
	Object withAllSubclasses do: [ :class | 
		class gtExamplesFinder ifNotNil: [ :finder | 
			self = finder class ifTrue: [ 
				finder myExamplesTo: examples ] ] ]
]

{ #category : #private }
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
GTExampleFinder >> gtExamples [
	| examples |
	examples := OrderedCollection new.
	self gtExamplesTo: examples.
	^ examples
]

{ #category : #public }
GTExampleFinder >> gtExamplesTo: examples [
	self class: self provider class to: examples
]

{ #category : #ui }
GTExampleFinder >> gtSpotterExamplesFor: aStep [
	<spotterOrder: 100>
	aStep listProcessor
		title: 'Examples';
		allCandidates: [ self gtExamples ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #private }
GTExampleFinder >> method: aMethod to: examples [
	self class: aMethod methodClass selector: aMethod selector method: aMethod to: examples
]

{ #category : #public }
GTExampleFinder >> myExamples [
	^ self gtExamples
]

{ #category : #public }
GTExampleFinder >> myExamplesTo: examples [
	self gtExamplesTo: examples
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
