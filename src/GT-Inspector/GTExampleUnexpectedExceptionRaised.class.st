Class {
	#name : #GTExampleUnexpectedExceptionRaised,
	#superclass : #Error,
	#instVars : [
		'unexpectedError'
	],
	#category : #'GT-Inspector-Examples-Exceptions'
}

{ #category : #accessing }
GTExampleUnexpectedExceptionRaised >> unexpectedError [
	^ unexpectedError
]

{ #category : #accessing }
GTExampleUnexpectedExceptionRaised >> unexpectedError: anObject [
	unexpectedError := anObject
]
