"
I am an error that occurs when an example declares that a certain exception is expected to be raised, and during the evaluation that exception is not raised.
"
Class {
	#name : #GTExampleExpectedExceptionNotRaised,
	#superclass : #Error,
	#instVars : [
		'expectedError',
		'exception'
	],
	#category : #'GT-Examples-Exceptions'
}

{ #category : #accessing }
GTExampleExpectedExceptionNotRaised >> exception [
	^ exception
]

{ #category : #accessing }
GTExampleExpectedExceptionNotRaised >> exception: anObject [
	exception := anObject
]

{ #category : #accessing }
GTExampleExpectedExceptionNotRaised >> expectedError [
	^ expectedError
]

{ #category : #accessing }
GTExampleExpectedExceptionNotRaised >> expectedError: anObject [
	expectedError := anObject
]
