Class {
	#name : #GTExampleError,
	#superclass : #Error,
	#instVars : [
		'example',
		'signaledException'
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

{ #category : #accessing }
GTExampleError >> signaledException [
	^ signaledException
]

{ #category : #accessing }
GTExampleError >> signaledException: anObject [
	signaledException := anObject
]
