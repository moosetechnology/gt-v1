Class {
	#name : #GTCSelectionInMethodMessageBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'labelBrick',
		'browseBrick'
	],
	#category : #'GT-Chatter-UI'
}

{ #category : #visitor }
GTCSelectionInMethodMessageBrick >> acceptReceivedMessage: aGTReceivedMessage [ 
	self theme chatterWidgetThemer sentSourceCodePointerStyleFor: self.
]

{ #category : #visitor }
GTCSelectionInMethodMessageBrick >> acceptSentMessage: aGTSentMessage [ 
	self theme chatterWidgetThemer 
			receivedSourceCodePointerStyleFor: self;
			receivedSourceCodeLabelStyleFor: self labelBrick
]

{ #category : #accessing }
GTCSelectionInMethodMessageBrick >> browseBrick: aBrick [
	browseBrick ifNotNil: [ :anOldBrick | self removeBrick: anOldBrick ].
	browseBrick := aBrick.
	self theme chatterWidgetThemer sourceCodePointerBrowseButtonStyleFor: browseBrick.
	browseBrick addUpAction: [ self browseMethod ].
	self addBrickBack: aBrick.
]

{ #category : #protocol }
GTCSelectionInMethodMessageBrick >> browseMethod [
	^ self message ifNotNil: [ :aMessage | aMessage ring browse ]
]

{ #category : #initialization }
GTCSelectionInMethodMessageBrick >> initialize [
	super initialize.
	self theme chatterWidgetThemer sourceCodePointerStyleFor: self.
	self labelBrick: self newLabelBrick.
	self browseBrick: self newBrowseBrick.

]

{ #category : #accessing }
GTCSelectionInMethodMessageBrick >> labelBrick [
	^ labelBrick
]

{ #category : #accessing }
GTCSelectionInMethodMessageBrick >> labelBrick: aBrick [
	labelBrick ifNotNil: [ :anOldBrick | self removeBrick: anOldBrick ].
	labelBrick := aBrick.
	self theme chatterWidgetThemer sourceCodePointerLabelStyleFor: labelBrick.
	self addBrickBack: aBrick.
]

{ #category : #accessing }
GTCSelectionInMethodMessageBrick >> labelString [
	^ self message ring asString
]

{ #category : #accessing }
GTCSelectionInMethodMessageBrick >> message [
	^ self data
]

{ #category : #accessing }
GTCSelectionInMethodMessageBrick >> message: aSelectionInMethodMessage [
	self message = aSelectionInMethodMessage ifTrue: [ ^ self ].
	self data: aSelectionInMethodMessage.
	self labelBrick text: self labelString.
	self changed.
]

{ #category : #'instance creation' }
GTCSelectionInMethodMessageBrick >> newBrowseBrick [
	^ GLMActionButtonBrick new
]

{ #category : #'instance creation' }
GTCSelectionInMethodMessageBrick >> newLabelBrick [
	^ GLMLabelBrick new
]
