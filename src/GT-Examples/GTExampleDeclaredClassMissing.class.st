Class {
	#name : #GTExampleDeclaredClassMissing,
	#superclass : #GTExampleError,
	#instVars : [
		'classNamed'
	],
	#category : #'GT-Examples-Exceptions'
}

{ #category : #accessing }
GTExampleDeclaredClassMissing >> classNamed [
	^ classNamed
]

{ #category : #accessing }
GTExampleDeclaredClassMissing >> classNamed: anObject [
	classNamed := anObject
]
