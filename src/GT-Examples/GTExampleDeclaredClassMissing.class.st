Class {
	#name : #GTExampleDeclaredClassMissing,
	#superclass : #GTExamplePragmaError,
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
