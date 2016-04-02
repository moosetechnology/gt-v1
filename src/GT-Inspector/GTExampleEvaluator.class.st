Class {
	#name : #GTExampleEvaluator,
	#superclass : #GTExampleProcessor,
	#instVars : [
		'processed',
		'result'
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
	^ anExample method 
		valueWithReceiver: anExample provider 
		arguments: arguments
]

{ #category : #primitives }
GTExampleEvaluator >> primitiveProcessExampleAfter: anExample [
	anExample after ifNil: [ ^ self ].
	anExample after method 
		valueWithReceiver: anExample after provider 
		arguments: #() " context, example, result ? -> try some examples first, then decide "
]

{ #category : #primitives }
GTExampleEvaluator >> primitiveProcessExampleAfterFinish: anExample [
	anExample afterFinish ifNil: [ ^ self ].
	anExample == self example ifFalse: [ ^ self ].
	anExample afterFinish method 
		valueWithReceiver: anExample afterFinish provider 
		arguments: #() " context, example, result ? -> try some examples first, then decide "
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
	self do: [ 
			value := self primitiveProcessExample: anExample withArguments: arguments.
			self primitiveProcessExampleAfter: anExample.
			self primitiveProcessExampleAfterFinish: anExample ]
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
