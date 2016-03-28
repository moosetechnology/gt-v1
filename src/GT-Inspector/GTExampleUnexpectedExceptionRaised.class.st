Class {
	#name : #GTExampleUnexpectedExceptionRaised,
	#superclass : #Error,
	#instVars : [
		'unexpectedError'
	],
	#category : #'GT-Inspector-Examples-Exceptions'
}

{ #category : #ui }
GTExampleUnexpectedExceptionRaised >> gtDisplayDetailsOn: aStream [
	aStream nextPutAll: self unexpectedError messageText; cr.
	"self unexpectedError signalContext ifNotNil: [ :context | 
		context debugStackOn: aStream ] - not working since the context has gone already - how to preserve ? "
]

{ #category : #accessing }
GTExampleUnexpectedExceptionRaised >> unexpectedError [
	^ unexpectedError
]

{ #category : #accessing }
GTExampleUnexpectedExceptionRaised >> unexpectedError: anObject [
	unexpectedError := anObject
]
