Class {
	#name : #GTExampleDependencyError,
	#superclass : #GTExampleError,
	#instVars : [
		'exception'
	],
	#category : #'GT-Examples-Exceptions'
}

{ #category : #accessing }
GTExampleDependencyError >> exception [
	^ exception
]

{ #category : #accessing }
GTExampleDependencyError >> exception: anObject [
	exception := anObject
]

{ #category : #testing }
GTExampleDependencyError >> isGTExampleError [
	^ self exception 
		ifNotNil: [ self exception isGTExampleError ]
		ifNil: [ super isGTExampleError ]
]
