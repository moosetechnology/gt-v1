"
I am an error that occurs when an example declares a subject that does not exist in the image.
"
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
