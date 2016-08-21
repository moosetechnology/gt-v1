Class {
	#name : #GTExampleEvaluator,
	#superclass : #GTExampleProcessor,
	#instVars : [
		'processed',
		'result'
	],
	#category : #'GT-Examples-Runtime'
}

{ #category : #private }
GTExampleEvaluator >> do: aBlock on: anException do: anotherBlock [
	"I give a chance to my subclass to not handle the exception is needed"
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
	anExample hasValidDependencies " dynamic check "
		ifFalse: [ ^ self handleDependencyErrorFor: anExample ].
	self 
		do: [ 
			arguments := aBlock value. 
			currentResult returnValue: (self 
				primitiveProcessExample: anExample 
				withArguments: arguments) ]
		on: anExample signalableExceptions
		do: [ :exception | currentResult expectedError: exception ].
	processed add: currentResult.
	self
		do: [ self processAfter: anExample ]
		on: anExample signalableExceptions
		do: [ :exception | currentResult expectedError: exception ].
	anExample == self example ifTrue: [ result := currentResult ].
	anExample exceptions signaledBy: currentResult expectedError.
	^ currentResult returnValue
]

{ #category : #private }
GTExampleEvaluator >> processAfter: anExample [
	anExample == self example ifFalse: [ ^ self ].
	processed reverseDo: [ :processedResult |
		self processAfter: processedResult example withResult: processedResult returnValue ]
]

{ #category : #private }
GTExampleEvaluator >> processAfter: anExample withResult: anObject [
	anExample after ifNil: [ ^ self ].
	anExample after method
		gtValueWithReceiver: anExample after provider 
		possibleArguments: { anObject }
]

{ #category : #public }
GTExampleEvaluator >> result [
	result := self newResultFor: self example.
	self do: [ self value ] 
		on: Error
		do: [ :exception | result returnValue: nil; unexpectedError: exception ].
	GTExampleOrganizer instance resultAt: self example put: result.
	^ result
]
