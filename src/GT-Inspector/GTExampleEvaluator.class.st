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
	self do: [ value := anExample method valueWithReceiver: anExample provider arguments: arguments ]
		on: (anExample exceptions copyWith: Error)
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
	self do: [ self value ] 
		on: Error
		do: [ :exception | result returnValue: nil; unexpectedError: exception ].
	^ result
]
