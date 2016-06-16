Class {
	#name : #GTExampleEvaluator,
	#superclass : #GTExampleProcessor,
	#instVars : [
		'processed',
		'result',
		'linkContext'
	],
	#category : #'GT-Inspector-Examples-Tools'
}

{ #category : #private }
GTExampleEvaluator >> do: aBlock on: anException do: anotherBlock [
	aBlock
		on: anException
		do: anotherBlock
]

{ #category : #initializing }
GTExampleEvaluator >> initialize [
	super initialize.
	
	processed := OrderedCollection new.
	result := GTExampleResult new
]

{ #category : #primitives }
GTExampleEvaluator >> primitiveProcessExample: anExample withArguments: arguments [
	| value |
	self withLinkContextFor: anExample do: [ 
		value := anExample provider perform: anExample method selector withArguments: arguments.
		" does not work with ReflectiveMethod: 
		value := anExample method valueWithReceiver: anExample provider arguments: arguments "
		self primitiveProcessExampleAfter: anExample.
		self primitiveProcessExampleAfterFinish: anExample ].
	^ value 
]

{ #category : #primitives }
GTExampleEvaluator >> primitiveProcessExampleAfter: anExample [
	anExample after ifNil: [ ^ self ].
	anExample after method 
		valueWithReceiver: anExample after provider 
		arguments: linkContext arguments
]

{ #category : #primitives }
GTExampleEvaluator >> primitiveProcessExampleAfterFinish: anExample [
	anExample afterFinish ifNil: [ ^ self ].
	anExample == self example ifFalse: [ ^ self ].
	anExample afterFinish method 
		valueWithReceiver: anExample afterFinish provider 
		arguments: linkContext arguments
]

{ #category : #private }
GTExampleEvaluator >> process: anExample withArguments: aBlock [
	| value arguments signaledException |
	value := nil.
	arguments := nil.
	signaledException := nil.
	anExample hasValidArguments 
		ifFalse: [ ^ self onArgumentError value: self value: anExample value: arguments ].
	[ arguments := aBlock value ]
		on: Error
		do: [ :exception | ^ self onDependencyError value: self value: anExample value: exception ].
	self do: [ value := self primitiveProcessExample: anExample withArguments: arguments ]
		on: (anExample exceptions copyWithAll: { Halt. Error. Exit. UnhandledError. TestFailure. Deprecation. })
		do: [ :exception | signaledException := exception ].
	processed add: { anExample. value. signaledException }.
	result returnValue: value.
	anExample exceptions signaledBy: signaledException.
	result expectedError: signaledException.
	^ value
]

{ #category : #public }
GTExampleEvaluator >> result [
	result example: self example.
	result context: self context.
	self do: [ self value ] 
		on: Error
		do: [ :exception | result returnValue: nil; unexpectedError: exception ].
	^ result
]

{ #category : #private }
GTExampleEvaluator >> withLinkContextFor: anExample do: aBlock [
	^ (linkContext := GTExampleLinkContext new 
		example: anExample;
		yourself) do: aBlock
]
