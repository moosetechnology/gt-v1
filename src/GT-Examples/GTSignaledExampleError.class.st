Class {
	#name : #GTSignaledExampleError,
	#superclass : #Error,
	#instVars : [
		'signaledException'
	],
	#category : #'GT-Examples-Exceptions'
}

{ #category : #accessing }
GTSignaledExampleError >> signaledException [
	^ signaledException
]

{ #category : #accessing }
GTSignaledExampleError >> signaledException: anObject [
	signaledException := anObject
]
