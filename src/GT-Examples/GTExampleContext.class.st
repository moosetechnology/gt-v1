"
I am a utility that holds custom contextual information about the current example.
"
Class {
	#name : #GTExampleContext,
	#superclass : #IdentityDictionary,
	#instVars : [
		'example'
	],
	#category : #'GT-Examples-Runtime'
}

{ #category : #accessing }
GTExampleContext >> example [
	^ example
]

{ #category : #accessing }
GTExampleContext >> example: anObject [
	example := anObject
]
