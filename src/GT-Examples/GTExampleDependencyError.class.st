"
I represent a static error induced by a wrong declaration of an example. There are two cases when I am triggered:
	- when the amount of method arguments are not matching the amount of dependency definitions 
	- when the example dependencies do not exist 
"
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
