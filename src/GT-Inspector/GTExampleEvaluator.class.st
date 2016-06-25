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
	
	processed := OrderedCollection new
]

{ #category : #private }
GTExampleEvaluator >> newResultFor: anExample [
	^ GTExampleResult new 
		example: anExample;
		context: self context;
		yourself.
]

{ #category : #primitives }
GTExampleEvaluator >> primitiveProcessExample: anExample withArguments: arguments [
	^ anExample provider perform: anExample method selector withArguments: arguments
]

{ #category : #private }
GTExampleEvaluator >> process: anExample withArguments: aBlock [
	| currentResult arguments |
	currentResult := self newResultFor: anExample.
	arguments := nil.
	anExample hasValidArguments 
		ifFalse: [ ^ self onArgumentError value: self value: anExample value: arguments ].
	[ arguments := aBlock value ]
		on: Error
		do: [ :exception | ^ self onDependencyError value: self value: anExample value: exception ].
	self do: [ currentResult returnValue: (self primitiveProcessExample: anExample withArguments: arguments) ]
		on: anExample signalableExceptions
		do: [ :exception | currentResult expectedError: exception ].
	processed add: currentResult.
	self do: [ self processAfter: anExample ]
		on: anExample signalableExceptions
		do: [ :exception | currentResult expectedError: exception ].
	anExample == self example ifTrue: [ result := currentResult ].
	anExample exceptions signaledBy: currentResult expectedError.
	^ currentResult returnValue
]

{ #category : #private }
GTExampleEvaluator >> processAfter: anExample [
	anExample == self example ifFalse: [ ^ self ].
	processed do: [ :processedResult |
		self processAfter: processedResult example withResult: processedResult returnValue ]
]

{ #category : #private }
GTExampleEvaluator >> processAfter: anExample withResult: anObject [
	anExample after ifNil: [ ^ self ].
	anExample after method
		valueWithReceiver: anExample after provider 
		arguments: { anObject }
]

{ #category : #public }
GTExampleEvaluator >> result [
	result := self newResultFor: self example.
	self do: [ self value ] 
		on: Error
		do: [ :exception | result returnValue: nil; unexpectedError: exception ].
	^ result
]
