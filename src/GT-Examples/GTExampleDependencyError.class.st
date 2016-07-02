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
GTExampleDependencyError >> isExampleError [
	^ self exception 
		ifNotNil: [ self exception isExampleError ]
		ifNil: [ super isExampleError ]
]
