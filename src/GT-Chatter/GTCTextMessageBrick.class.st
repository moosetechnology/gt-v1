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
GTCTextMessageBrick >> editingAreaBrick: aMorph [
	|brick|
	editingAreaBrick ifNotNil: [ :anOldBrick | self removeBrick: anOldBrick ].
	editingAreaBrick := aMorph.
	editingAreaBrick 
		layoutProperties: GLMBrickLayoutProperties new;
		beReadOnly;
		beWrapped.
	editingAreaBrick layoutProperties hSpaceFill.
	
	"we receive a Morph and need to manually convert it to brick,
	to allow its container shrink vertically to fit height of the rubric"
	brick := aMorph asBrick.
	brick layout vShrinkWrap.
	
	self addBrickBack: brick.
]

{ #category : #initialization }
GTCTextMessageBrick >> initialize [
	super initialize.
	
	self layoutProperties hSpaceFill.
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
