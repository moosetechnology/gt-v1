"
I am an error that occurs when an example declares a dependency to a method belonging to a class that does not exist in the image.
"
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
