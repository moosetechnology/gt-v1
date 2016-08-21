"
I am an error that occurs when the evaluation of an example raises an exception without that exception being declared as being expected.
"
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
