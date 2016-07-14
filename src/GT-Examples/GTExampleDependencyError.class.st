Class {
	#name : #GTExampleDependencyError,
	#superclass : #GTExampleError,
	#instVars : [
		'expected',
		'defined',
		'invalid'
	],
	#category : #'GT-Examples-Exceptions'
}

{ #category : #accessing }
GTExampleDependencyError >> defined [
	^ defined
]

{ #category : #accessing }
GTExampleDependencyError >> defined: anObject [
	defined := anObject
]

{ #category : #accessing }
GTExampleDependencyError >> expected [
	^ expected
]

{ #category : #accessing }
GTExampleDependencyError >> expected: anObject [
	expected := anObject
]

{ #category : #accessing }
GTExampleDependencyError >> invalid [
	^ invalid
]

{ #category : #accessing }
GTExampleDependencyError >> invalid: anObject [
	invalid := anObject
]
