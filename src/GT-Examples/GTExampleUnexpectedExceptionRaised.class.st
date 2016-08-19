Class {
	#name : #GTExampleUnexpectedExceptionRaised,
	#superclass : #Error,
	#instVars : [
		'unexpectedError'
	],
	#category : #'GT-Examples-Exceptions'
}

{ #category : #UI }
GTExampleUnexpectedExceptionRaised >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	aStream nextPutAll: ' ('.
	self unexpectedError gtDisplayOn: aStream.
	aStream nextPutAll: ')'.
]

{ #category : #accessing }
GTExampleUnexpectedExceptionRaised >> unexpectedError [
	^ unexpectedError
]

{ #category : #accessing }
GTExampleUnexpectedExceptionRaised >> unexpectedError: anObject [
	unexpectedError := anObject
]
