Class {
	#name : #GTExampleSubjectError,
	#superclass : #GTSignaledExampleError,
	#instVars : [
		'subject'
	],
	#category : #'GT-Examples-Exceptions'
}

{ #category : #accessing }
GTExampleSubjectError >> subject [
	^ subject
]

{ #category : #accessing }
GTExampleSubjectError >> subject: anObject [
	subject := anObject
]
