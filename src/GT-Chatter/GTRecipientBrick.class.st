Class {
	#name : #GTRecipientBrick,
	#superclass : #GLMLabelBrick,
	#category : #'GT-Chatter-UI'
}

{ #category : #initialization }
GTRecipientBrick >> initialize [
	super initialize.
	self theme chatterWidgetThemer recipientStyleFor: self.

]

{ #category : #accessing }
GTRecipientBrick >> recipient: aClientId [
	self data: aClientId.
	self text: (aClientId ifNil: [ 'new conversation' ]) asString
]
