Class {
	#name : #GTCLabeledButtonBrick,
	#superclass : #GLMLabelBrick,
	#instVars : [
		'action'
	],
	#category : #'GT-Chatter-UI'
}

{ #category : #accessing }
GTCLabeledButtonBrick >> action: aBlock [
	action := aBlock
]

{ #category : #actions }
GTCLabeledButtonBrick >> click: anEvent [
	action ifNil: [ ^ false ].
	action cull: anEvent.
	^ true
]
