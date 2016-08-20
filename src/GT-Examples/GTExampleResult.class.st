"
I represent the result of executing an example.

I keep track of the
- returnValue - the real object returned by the example method
- expectedErrors, unexpectedErrors - collections of possible errors encountered when executing the example method
"
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
	#category : #'GT-Examples-Runtime'
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

{ #category : #'*GT-Examples-UI' }
GTExampleResult >> gtDisplayOn: aStream [
	self example gtDisplayOn: aStream. 
	
	self unexpectedError ifNotNil: [ 
		aStream nextPutAll: ' ['.
		self unexpectedError gtDisplayOn: aStream.
		aStream nextPutAll: ']' ]
]

{ #category : #'*GT-Examples-UI' }
GTExampleResult >> gtDisplayValidityOn: aStream [
	self isSuccess ifTrue: [ ^ self ].
	
	aStream nextPutAll: ' ['.
	self unexpectedError gtDisplayOn: aStream.
	aStream nextPutAll: ']'
]

{ #category : #testing }
GTExampleResult >> hasProblems [
	^ self example hasProblems
		or: [ self isFailure
			or: [ self isError ] ]
]

{ #category : #testing }
GTExampleResult >> isError [
	^ self isSuccess not
		and: [ self isUnexpectedError
			and: [ self unexpectedError isGTExampleError ] ]
]

{ #category : #testing }
GTExampleResult >> isExpectedError [
	^ self expectedError notNil
]

{ #category : #testing }
GTExampleResult >> isFailure [
	^ self isSuccess not
		and: [ self isUnexpectedError
			and: [ self unexpectedError isGTExampleError not ] ]
]

{ #category : #testing }
GTExampleResult >> isSuccess [
	^ self unexpectedError isNil
		and: [ self example isValid ]
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
