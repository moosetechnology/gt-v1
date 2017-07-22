"
I represent a group of examples.

I am particularly useful for manipulating multiple examples at the same time, typically in a user interface (such as the inspector).
"
Class {
	#name : #GTExampleGroup,
	#superclass : #Object,
	#instVars : [
		'examples'
	],
	#category : #'GT-Examples-Core'
}

{ #category : #accessing }
GTExampleGroup >> examples [
	^ examples
]

{ #category : #accessing }
GTExampleGroup >> examples: anObject [
	examples := anObject
]
