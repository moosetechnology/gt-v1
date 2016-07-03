Class {
	#name : #GTExampleProcessor,
	#superclass : #Object,
	#instVars : [
		'example',
		'context',
		'processing',
		'onProcess',
		'onRecursionError',
		'onDependencyError',
		'onArgumentError'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #private }
GTExampleProcessor >> basicProcess: anExample [ 
	^ self 
		process: anExample 
		withArguments: [ anExample arguments collect: [ :each | self process: each gtExample ] ] 
]

{ #category : #testing }
GTExampleProcessor >> canProcess [
	[ self value ]
		on: GTExampleError
		do: [ ^ false ].
	^ true
]

{ #category : #accessing }
GTExampleProcessor >> context [
	^ context
]

{ #category : #accessing }
GTExampleProcessor >> context: anObject [
	^ context := anObject
]

{ #category : #'accessing-defaults' }
GTExampleProcessor >> defaultOnArgumentError [
	^ [ :aProcessor :anExample :someArguments | 
		aProcessor handleArgumentErrorFor: anExample withArguments: someArguments.
		nil ]
]

{ #category : #'accessing-defaults' }
GTExampleProcessor >> defaultOnDependencyError [
	^ [ :aProcessor :anExample :anException | 
		aProcessor handleDependencyErrorFor: anExample withException: anException.
		nil ]
]

{ #category : #'accessing-defaults' }
GTExampleProcessor >> defaultOnProcess [
	^ [ :aProcessor :anExample | 
		aProcessor basicProcess: anExample ]
]

{ #category : #'accessing-defaults' }
GTExampleProcessor >> defaultOnRecursionError [
	^ [ :aProcessor :anExample | 
		aProcessor handleRecursionErrorFor: anExample.
		nil ]
]

{ #category : #accessing }
GTExampleProcessor >> example [
	^ example
]

{ #category : #accessing }
GTExampleProcessor >> example: anObject [
	example := anObject
]

{ #category : #private }
GTExampleProcessor >> handleArgumentErrorFor: anExample withArguments: arguments [
	^ (GTExampleArgumentError new
		example: anExample;
		expected: anExample method argumentNames;
		defined: anExample arguments;
		evaluated: arguments;
		yourself) signal
]

{ #category : #private }
GTExampleProcessor >> handleDependencyErrorFor: anExample withException: anException [
	^ (GTExampleDependencyError new
		example: anExample;
		exception: anException;
		yourself) signal
]

{ #category : #private }
GTExampleProcessor >> handleRecursionErrorFor: anExample [
	^ (GTExampleRecursionDetected new 
		example: self example;
		resolved: processing;
		next: anExample;
		yourself) signal
]

{ #category : #initializing }
GTExampleProcessor >> initialize [
	super initialize.
	
	processing := IdentitySet new.
	context := GTExampleContext new
]

{ #category : #accessing }
GTExampleProcessor >> onArgumentError [
	^ onArgumentError ifNil: [ onArgumentError := self defaultOnArgumentError ]
]

{ #category : #accessing }
GTExampleProcessor >> onArgumentError: anObject [
	onArgumentError := anObject
]

{ #category : #accessing }
GTExampleProcessor >> onDependencyError [
	^ onDependencyError ifNil: [ onDependencyError := self defaultOnDependencyError ]
]

{ #category : #accessing }
GTExampleProcessor >> onDependencyError: anObject [
	onDependencyError := anObject
]

{ #category : #accessing }
GTExampleProcessor >> onProcess [
	^ onProcess ifNil: [ onProcess := self defaultOnProcess ]
]

{ #category : #accessing }
GTExampleProcessor >> onProcess: anObject [
	onProcess := anObject
]

{ #category : #accessing }
GTExampleProcessor >> onRecursionError [
	^ onRecursionError ifNil: [ onRecursionError := self defaultOnRecursionError ]
]

{ #category : #accessing }
GTExampleProcessor >> onRecursionError: anObject [
	onRecursionError := anObject
]

{ #category : #private }
GTExampleProcessor >> process: anExample [
	^ self process: anExample withoutLoopsDo: [ 
		self onProcess value: self value: anExample ]
]

{ #category : #private }
GTExampleProcessor >> process: anExample withArguments: aBlock [
	self subclassResponsibility
]

{ #category : #private }
GTExampleProcessor >> process: anExample withoutLoopsDo: aBlock [
	| value |
	" check whether we already scheduled the given example for processing -> prevent recursion "
	value := nil.
	processing do: [ :processingExample |
		(processingExample = anExample) ifTrue: [
			^ self onRecursionError value: self value: anExample ] ].	
	processing add: anExample. " prepare processing this example "
	value := aBlock value. " process this example "
	processing remove: anExample. " done processing "
	^ value
]

{ #category : #public }
GTExampleProcessor >> value [ 
	^ self withContextDo: [ self process: self example ]
]

{ #category : #private }
GTExampleProcessor >> withContextDo: aBlock [
	GTCurrentExampleContext use: context during: aBlock
]
