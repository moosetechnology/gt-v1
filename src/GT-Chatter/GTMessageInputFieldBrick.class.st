Class {
	#name : #GTMessageInputFieldBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'textBrick'
	],
	#category : #'GT-Chatter-UI'
}

{ #category : #'events-processing' }
GTMessageInputFieldBrick >> acceptedText: aRubTextAccepted [ 
	aRubTextAccepted text asString trimBoth isEmpty ifTrue: [ ^ self ].
	self announcer 
				announce: (GTSendTextMessage new 
								widget: aRubTextAccepted morph;
								conversation: self conversation;
								yourself).
	aRubTextAccepted morph setText: ''.
]

{ #category : #accessing }
GTMessageInputFieldBrick >> announcer [
	^ self data 
			ifNil: [ Announcer new ]
			ifNotNil: [ :aData | aData announcer ]
]

{ #category : #'as yet unclassified' }
GTMessageInputFieldBrick >> conversation [
	^ self data
]

{ #category : #initialization }
GTMessageInputFieldBrick >> initialize [
	super initialize.
	self theme chatterWidgetThemer textMessageInputFieldStyleFor: self.
	self textBrick: self newTextBrick.
]

{ #category : #'instance creation' }
GTMessageInputFieldBrick >> newTextBrick [
	^ RubScrolledTextMorph new
]

{ #category : #accessing }
GTMessageInputFieldBrick >> textBrick [
	^ textBrick
]

{ #category : #accessing }
GTMessageInputFieldBrick >> textBrick: aRubScrolledTextMorph [
	self textBrick ifNotNil: [ :anOldBrick | 
				anOldBrick announcer unsubscribe: self. 
				self removeBrick: anOldBrick ].
	textBrick := aRubScrolledTextMorph.
	self theme chatterWidgetThemer scrolledTextMorphStyleFor: textBrick.
	self addBrickBack: textBrick.
	(self textBrick announcer subscribe: RubTextAccepted send: #acceptedText: to: self) subscriber: self.
]
