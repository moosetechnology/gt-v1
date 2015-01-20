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
	self editingAreaBrick 
				backgroundColor: Color lightGray;
				textColor: Color black.
]

{ #category : #visitor }
GTCTextMessageBrick >> acceptSentMessage: aMessage [
	self editingAreaBrick 
				backgroundColor: Color green muchDarker;
				textColor: Color white.
]

{ #category : #accessing }
GTCTextMessageBrick >> editingAreaBrick [
	^ editingAreaBrick
]

{ #category : #accessing }
GTCTextMessageBrick >> editingAreaBrick: aBrick [
	editingAreaBrick ifNotNil: [ :anOldBrick | self removeBrick: anOldBrick ].
	editingAreaBrick := aBrick.
	editingAreaBrick 
		layoutProperties: GLMBrickLayoutProperties new;
		beReadOnly;
		beWrapped.
	editingAreaBrick layoutProperties hSpaceFill.
	self addBrickBack: aBrick.
]

{ #category : #initialization }
GTCTextMessageBrick >> initialize [
	super initialize.
	
	"my width is 90% of my parent"
	self layoutProperties 
			horizontalPercent: 90;
	 		vSpaceFill.
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
