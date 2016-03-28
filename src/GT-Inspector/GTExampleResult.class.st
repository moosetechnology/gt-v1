Class {
	#name : #GTExampleResult,
	#superclass : #Object,
	#instVars : [
		'example',
		'context',
		'returnValue',
		'expectedError',
		'unexpectedError'
	],
	#category : #'GT-Inspector-Examples-Utils'
}

{ #category : #accessing }
GTExampleResult >> context [
	^ context
]

{ #category : #accessing }
GTExampleResult >> context: anObject [
	context := anObject
]

{ #category : #actions }
GTExampleResult >> debug [
	self isSuccess ifTrue: [ ^ self ].
	^ self example debug
]

{ #category : #private }
GTExampleResult >> detachFromSystem [
	example ifNotNil: [ 
		example result: nil.
		GTExampleNautilus methodChanged: example method ].
	example := returnValue := expectedError := unexpectedError := nil.
]

{ #category : #accessing }
GTExampleResult >> example [
	^ example
]

{ #category : #accessing }
GTExampleResult >> example: anObject [
	example := anObject
]

{ #category : #accessing }
GTExampleResult >> expectedError [
	^ expectedError
]

{ #category : #accessing }
GTExampleResult >> expectedError: anObject [
	expectedError := anObject
]

{ #category : #ui }
GTExampleResult >> gtDisplayOn: aStream [
	self printOn: aStream.
	aStream nextPutAll: ' ('.
	self gtDisplaySummaryOn: aStream.
	aStream nextPutAll: ')'

]

{ #category : #ui }
GTExampleResult >> gtDisplaySummaryOn: aStream [
	self unexpectedError 
		ifNotNil: [ self unexpectedError gtDisplayOn: aStream ]
		ifNil: [ self returnValue gtDisplayOn: aStream ].

]

{ #category : #testing }
GTExampleResult >> isError [
	^ self isSuccess not
		and: [ self unexpectedError isExampleError ]
]

{ #category : #testing }
GTExampleResult >> isExpectedError [
	^ self expectedError notNil
]

{ #category : #testing }
GTExampleResult >> isFailure [
	^ self isSuccess not
		and: [ self unexpectedError isExampleError not ]
]

{ #category : #testing }
GTExampleResult >> isSuccess [
	^ self unexpectedError isNil
]

{ #category : #testing }
GTExampleResult >> isUnexpectedError [
	^ self unexpectedError notNil
]

{ #category : #accessing }
GTExampleResult >> returnValue [
	^ returnValue
]

{ #category : #accessing }
GTExampleResult >> returnValue: anObject [
	returnValue := anObject
]

{ #category : #actions }
GTExampleResult >> run [
	^ self example run
]

{ #category : #accessing }
GTExampleResult >> unexpectedError [
	^ unexpectedError
]

{ #category : #accessing }
GTExampleResult >> unexpectedError: anObject [
	unexpectedError := anObject
]
