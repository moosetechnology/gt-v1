Class {
	#name : #GTCLabeledButtonBrick,
	#superclass : #GLMLabelBrick,
	#instVars : [
		'action'
	],
	#category : #'GT-Chatter-UI'
}

{ #category : #visitor }
GTCLabeledButtonBrick >> acceptReceivedMessage: aGTReceivedMessage [ 

]

{ #category : #visitor }
GTCLabeledButtonBrick >> acceptSentMessage: aGTSentMessage [ 

]

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
