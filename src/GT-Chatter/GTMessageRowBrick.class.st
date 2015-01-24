Class {
	#name : #GTMessageRowBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'messageBrick',
		'blankBrick'
	],
	#category : #'GT-Chatter-UI'
}

{ #category : #visitor }
GTMessageRowBrick >> acceptReceivedMessage: aMessage [
	self addBrickBack: self messageBrick.
	self addBrickBack: self blankBrick.

]

{ #category : #visitor }
GTMessageRowBrick >> acceptSentMessage: aMessage [
	self addBrickBack: self blankBrick.
	self addBrickBack: self messageBrick.
]

{ #category : #accessing }
GTMessageRowBrick >> blankBrick [
	^ blankBrick ifNil: [
		blankBrick := GLMBrick new.
		blankBrick height: 0.
		"blank space must fill the rest of my width. It depends on messageBrick's percent width"
		blankBrick layoutProperties horizontalPercent: 5.
		blankBrick ]
]

{ #category : #initialization }
GTMessageRowBrick >> initialize [
	super initialize.
	self theme chatterWidgetThemer messageRowStyleFor: self.
]

{ #category : #accessing }
GTMessageRowBrick >> message [
	^ self data
]

{ #category : #accessing }
GTMessageRowBrick >> message: aSentOrReceivedMessage [
	"for performance we reuse views in the list, instead of creating a new one.
	this method updates me and my subviews"
	
	"much easier to remove everything and add subviews back instead of changing order manually"
	self message = aSentOrReceivedMessage ifTrue: [ ^ self ].
	self data: aSentOrReceivedMessage.
	self removeAllBricks.
	messageBrick := aSentOrReceivedMessage contents asMessageMorph.
	aSentOrReceivedMessage visit: messageBrick.
		
	"position of blank space depends on message's sender"
	aSentOrReceivedMessage visit: self.	

]

{ #category : #accessing }
GTMessageRowBrick >> messageBrick [
	^ messageBrick
]

{ #category : #visitor }
GTMessageRowBrick >> visitChatterMessage: aMessage factory: aGTCMessageFactory [ 
	^ aMessage acceptMessageRowBrick: self factory: aGTCMessageFactory
]
