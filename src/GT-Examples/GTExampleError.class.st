Class {
	#name : #GTExampleError,
	#superclass : #Error,
	#instVars : [
		'example'
	],
	#category : #'GT-Examples-Exceptions'
}

{ #category : #accessing }
GTExampleError >> example [
	^ example
]

{ #category : #accessing }
GTExampleError >> example: anObject [
	example := anObject
]

{ #category : #testing }
GTExampleError >> isExampleError [
	^ true
]
