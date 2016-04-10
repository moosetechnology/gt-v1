Class {
	#name : #GTExampleUnexpectedExceptionRaised,
	#superclass : #Error,
	#instVars : [
		'unexpectedError'
	],
	#category : #'GT-Inspector-Examples-Exceptions'
}

{ #category : #ui }
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
