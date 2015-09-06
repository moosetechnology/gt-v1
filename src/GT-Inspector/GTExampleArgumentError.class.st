Class {
	#name : #GTExampleArgumentError,
	#superclass : #GTExampleError,
	#instVars : [
		'expected',
		'defined',
		'evaluated'
	],
	#category : #'GT-Inspector-Examples-Exceptions'
}

{ #category : #accessing }
GTExampleArgumentError >> defined [
	^ defined
]

{ #category : #accessing }
GTExampleArgumentError >> defined: anObject [
	defined := anObject
]

{ #category : #accessing }
GTExampleArgumentError >> evaluated [
	^ evaluated
]

{ #category : #accessing }
GTExampleArgumentError >> evaluated: anObject [
	evaluated := anObject
]

{ #category : #accessing }
GTExampleArgumentError >> expected [
	^ expected
]

{ #category : #accessing }
GTExampleArgumentError >> expected: anObject [
	expected := anObject
]
