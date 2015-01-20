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
		"blank space must fill the rest of my width. It depends on messageBrick's percent width"
		blankBrick layoutProperties horizontalPercent: 5.
		blankBrick ]
]

{ #category : #examples }
GTMessageRowBrick >> exampleSentMessage [
	| message brick |
	message := (String loremIpsum: 100) asSentMessage.
	brick := self new.
	brick message: message.
	^ GLMFoundationBrick new
			addBrickBack: brick;
			openInWindowLabeled: 'Sent Message'.
]

{ #category : #examples }
GTMessageRowBrick >> exampleTextMessageBrick [
	| message brick |
	message := GTReceivedMessage new
			message: (String loremIpsum: 100);
			timestamp: DateAndTime now;
			yourself.
	brick := self new.
	brick message: message.
	^ GLMFoundationBrick new
			addBrickBack: brick;
			openInWindowLabeled: 'Received Message'.
]

{ #category : #initialization }
GTMessageRowBrick >> initialize [
	super initialize.
	
	"to allow my children have proportional width (i.e 33% of me) and to fill my height"
	self layoutPolicy: GLMBrickHorizontalFillProportionalLinearLayout new.
	
	"here we configurate paddings"
	self layoutProperties
		hSpaceFill;
		paddingLeft: 5;
		paddingRight: 5;
		paddingTop: 10;
		paddingBottom: 10
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
	messageBrick := aSentOrReceivedMessage message asMessageMorph.
	aSentOrReceivedMessage visit: messageBrick.
		
	"position of blank space depends on message's sender"
	aSentOrReceivedMessage visit: self.	

]

{ #category : #accessing }
GTMessageRowBrick >> messageBrick [
	^ messageBrick ifNil: [ 
		messageBrick := GTCTextMessageBrick new.
		messageBrick layoutProperties horizontalPercent: 95.
		messageBrick ]
]

{ #category : #visitor }
GTMessageRowBrick >> visitChatterMessage: aMessage factory: aGTCMessageFactory [ 
	^ aMessage acceptMessageRowBrick: self factory: aGTCMessageFactory
]
