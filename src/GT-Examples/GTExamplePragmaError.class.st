Class {
	#name : #GTExamplePragmaError,
	#superclass : #GTSignaledExampleError,
	#instVars : [
		'pragma'
	],
	#category : #'GT-Examples-Exceptions'
}

{ #category : #accessing }
GTExamplePragmaError >> pragma [
	^ pragma
]

{ #category : #accessing }
GTExamplePragmaError >> pragma: anObject [
	pragma := anObject
]
