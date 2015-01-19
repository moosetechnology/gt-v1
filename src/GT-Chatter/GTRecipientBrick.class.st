Class {
	#name : #GTRecipientBrick,
	#superclass : #GLMLabelBrick,
	#category : #'GT-Chatter-UI'
}

{ #category : #initialization }
GTRecipientBrick >> initialize [
	super initialize.
	
	"my width is 90% of my parent"
	self layoutProperties horizontalPercent: 90.
	self textPosition: #center
]

{ #category : #accessing }
GTRecipientBrick >> recipient: aClientId [
	self data: aClientId.
	self text: (aClientId ifNil: [ 'new conversation' ]) asString
]
