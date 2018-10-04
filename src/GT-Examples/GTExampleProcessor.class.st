"
I am an abstract class for manipulating examples.

My subclasses can add different semantics for different use cases. For example, evaluating an example is to be treated differently from a debugging scenario, or from a  scenario to recorver static dependencies.
"
Class {
	#name : #GTExampleProcessor,
	#superclass : #Object,
	#instVars : [
		'example',
		'context',
		'processing',
		'onProcess'
	],
	#category : #'GT-Examples-Runtime'
}

{ #category : #private }
GTExampleProcessor >> basicProcess: anExample [ 
	^ self 
		process: anExample 
		withArguments: [ anExample dependenciesOrArguments collect: [ :each | self process: each ] ] 
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
GTExampleProcessor >> defaultOnProcess [
	^ [ :aProcessor :anExample | 
		aProcessor basicProcess: anExample ]
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
GTExampleProcessor >> handleDependencyErrorFor: anExample [
	^ (GTExampleDependencyError new
		example: anExample;
		defined: anExample arguments;
		expected: anExample methodArgumentNames;
		invalid: anExample invalidArguments;
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
GTExampleProcessor >> onProcess [
	^ onProcess ifNil: [ onProcess := self defaultOnProcess ]
]

{ #category : #accessing }
GTExampleProcessor >> onProcess: anObject [
	onProcess := anObject
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
			^ self handleRecursionErrorFor: anExample ] ].	
	processing add: anExample. " prepare processing this example "
	context example: anExample.
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
