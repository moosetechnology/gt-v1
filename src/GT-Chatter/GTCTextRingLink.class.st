Class {
	#name : #GTCTextRingLink,
	#superclass : #TextLink,
	#instVars : [
		'ring'
	],
	#category : #'GT-Chatter-UI'
}

{ #category : #'as yet unclassified' }
GTCTextRingLink >> actOnClick: anEvent for: target in: aParagraph editor: anEditor [
	self ring ifNotNil: [ :aRing | aRing browse ].
	^ true
]

{ #category : #'as yet unclassified' }
GTCTextRingLink >> ring: aRGMethodDefinition [ 
	ring := aRGMethodDefinition
]
