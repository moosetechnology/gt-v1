Class {
	#name : #GTExampleSubjectError,
	#superclass : #GTExamplePragmaError,
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
