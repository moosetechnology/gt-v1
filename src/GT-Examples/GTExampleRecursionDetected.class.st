Class {
	#name : #GTExampleRecursionDetected,
	#superclass : #GTExampleError,
	#instVars : [
		'resolved',
		'next'
	],
	#category : #'GT-Examples-Exceptions'
}

{ #category : #accessing }
GTExampleRecursionDetected >> next [
	^ next
]

{ #category : #accessing }
GTExampleRecursionDetected >> next: anObject [
	next := anObject
]

{ #category : #accessing }
GTExampleRecursionDetected >> resolved [
	^ resolved
]

{ #category : #accessing }
GTExampleRecursionDetected >> resolved: anObject [
	resolved := anObject
]
