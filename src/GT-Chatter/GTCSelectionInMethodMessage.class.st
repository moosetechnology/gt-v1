Class {
	#name : #GTCSelectionInMethodMessage,
	#superclass : #GTCAbstractMessage,
	#instVars : [
		'ring',
		'selection'
	],
	#category : #'GT-Chatter-Model'
}

{ #category : #converting }
GTCSelectionInMethodMessage >> asText [
	| aText |
	aText := ring asString asText.
	aText addAttribute: (GTCTextRingLink new ring: ring; yourself).
	^ aText
]

{ #category : #accessing }
GTCSelectionInMethodMessage >> ring [
	^ ring
]

{ #category : #accessing }
GTCSelectionInMethodMessage >> ring: anObject [
	ring := anObject
]

{ #category : #accessing }
GTCSelectionInMethodMessage >> selection [
	^ selection
]

{ #category : #accessing }
GTCSelectionInMethodMessage >> selection: anObject [
	selection := anObject
]
