"
I am an abstract error induced by a signaledException related to a specific example.

My subclasses define the specific error.
"
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
GTExampleError >> isGTExampleError [
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
