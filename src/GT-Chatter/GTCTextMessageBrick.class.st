Class {
	#name : #GTCTextMessageBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'editingAreaBrick'
	],
	#category : #'GT-Chatter-UI'
}

{ #category : #visitor }
GTCTextMessageBrick >> acceptReceivedMessage: aMessage [
	self theme chatterWidgetThemer 
			receivedTextMessageStyleFor: self;
			receivedTextMessageEditingAreaStyleFor: self editingAreaBrick.
]

{ #category : #visitor }
GTCTextMessageBrick >> acceptSentMessage: aMessage [
	self theme chatterWidgetThemer 
			sentTextMessageStyleFor: self;
			sentTextMessageEditingAreaStyleFor: self editingAreaBrick.
]

{ #category : #accessing }
GTCTextMessageBrick >> editingAreaBrick [
	^ editingAreaBrick
]

{ #category : #accessing }
GTCTextMessageBrick >> editingAreaBrick: aMorph [
	|brick|
	editingAreaBrick ifNotNil: [ :anOldBrick | self removeBrick: anOldBrick ].
	editingAreaBrick := aMorph.
	self theme chatterWidgetThemer textMessageEditingAreaStyleFor: editingAreaBrick.
	
	"we receive a Morph and need to manually convert it to brick,
	to allow its container shrink vertically to fit height of the rubric"
	brick := aMorph asBrick.
	brick layout vShrinkWrap.
	
	self addBrickBack: brick.
]

{ #category : #initialization }
GTCTextMessageBrick >> initialize [
	super initialize.
	self theme chatterWidgetThemer textMessageStyleFor: self.
	self editingAreaBrick: self newEditingAreaBrick.
]

{ #category : #accessing }
GTCTextMessageBrick >> message [
	^ self data
]

{ #category : #accessing }
GTCTextMessageBrick >> message: aTextMessage [
	self data: aTextMessage.
	self editingAreaBrick setTextWith: aTextMessage message asText.
]

{ #category : #'instance creation' }
GTCTextMessageBrick >> newEditingAreaBrick [
	^ RubEditingArea new
]
