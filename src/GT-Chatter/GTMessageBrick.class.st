Class {
	#name : #GTMessageBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'editingAreaBrick'
	],
	#category : #'GT-Chatter-UI'
}

{ #category : #visitor }
GTMessageBrick >> acceptReceivedMessage: aMessage [
	self editingAreaBrick 
				backgroundColor: Color lightGray;
				textColor: Color black.
]

{ #category : #visitor }
GTMessageBrick >> acceptSentMessage: aMessage [
	self editingAreaBrick 
				backgroundColor: Color green muchDarker;
				textColor: Color white.
]

{ #category : #accessing }
GTMessageBrick >> editingAreaBrick [
	^ editingAreaBrick
]

{ #category : #accessing }
GTMessageBrick >> editingAreaBrick: aBrick [
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
GTMessageBrick >> initialize [
	super initialize.
	
	"my width is 90% of my parent"
	self layoutProperties 
			horizontalPercent: 90;
	 		vSpaceFill.
	self editingAreaBrick: self newEditingAreaBrick.
]

{ #category : #accessing }
GTMessageBrick >> message [
	^ self data
]

{ #category : #accessing }
GTMessageBrick >> message: aMessage [
	self data: aMessage.
	aMessage visit: self.
	self editingAreaBrick setTextWith: aMessage message asText.
]

{ #category : #'instance creation' }
GTMessageBrick >> newEditingAreaBrick [
	^ RubEditingArea new
]
