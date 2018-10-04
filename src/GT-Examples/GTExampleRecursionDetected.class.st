"
I represent an error that occurs when we have cycles in static example dependencies. The cycles can be either direct or indirect. For example,  these configurations induces an error:
- a depends-on b, b depends-on a
- a depends-on b, b depends-on c, c depends-on a
	
"
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
