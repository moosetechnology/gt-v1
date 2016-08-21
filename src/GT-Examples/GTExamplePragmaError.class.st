"
I am an abstract error related to the way the pragmas are used within an example method.
"
Class {
	#name : #GTExamplePragmaError,
	#superclass : #GTExampleError,
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
