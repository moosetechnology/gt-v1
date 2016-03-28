Class {
	#name : #GTExampleError,
	#superclass : #Error,
	#instVars : [
		'example'
	],
	#category : #'GT-Inspector-Examples-Exceptions'
}

{ #category : #accessing }
GTExampleError >> example [
	^ example
]

{ #category : #accessing }
GTExampleError >> example: anObject [
	example := anObject
]

{ #category : #ui }
GTExampleError >> gtDisplayDetailsOn: aStream [
]

{ #category : #testing }
GTExampleError >> isExampleError [
	^ true
]
