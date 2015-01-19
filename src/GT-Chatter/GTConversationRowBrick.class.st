Class {
	#name : #GTConversationRowBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'recipientBrick'
	],
	#category : #'GT-Chatter-UI'
}

{ #category : #actions }
GTConversationRowBrick >> click: anEvent [
	self announcer announce: (GTConversationSelected new 
										conversation: self data; 
										widget: self; 
										yourself).
	^ true.
]

{ #category : #accessing }
GTConversationRowBrick >> conversation [
	^ self data
]

{ #category : #accessing }
GTConversationRowBrick >> conversation: aConversation [
	self conversation = aConversation ifTrue: [ ^ self ].
	self conversation ifNotNil: [ :anOldConversation |
				anOldConversation announcer unsubscribe: self ].
	self data: aConversation.
	self recipientBrick recipient: aConversation recipient.
	(aConversation announcer 
				subscribe: GTCRecipientChanged 
					send: #recipientChanged:
					to: self) subscriber: self
]

{ #category : #examples }
GTConversationRowBrick >> exampleConversationModel [
	| message1 message2 message3 message4 conversation |
	message1 := (String loremIpsum: 100) asSentMessage.
	message2 := GTReceivedMessage new
			message: (String loremIpsum: 100);
			timestamp: DateAndTime now;
			yourself.
	message3 := (String loremIpsum: 100) asSentMessage.
	message4 := GTReceivedMessage new
			message: (String loremIpsum: 100);
			timestamp: DateAndTime now;
			yourself.
	conversation := GTConversation new.
	conversation 
		addMessage: message1;
		addMessage: message2;
		addMessage: message3;
		addMessage: message4;
		recipient: 'client2'.
	^ conversation
]

{ #category : #examples }
GTConversationRowBrick >> exampleExistingConversation [
	<example>
	| model brick |
	brick := self new.
	model := brick exampleConversationModel.
	brick conversation: model.
	^ GLMFoundationBrick new
			addBrickBack: brick;
			openInWindowLabeled: 'Conversation with ', model recipient asString.
]

{ #category : #initialization }
GTConversationRowBrick >> initialize [
	super initialize.
	
	self
		"to allow my children have proportional width (i.e 33% of me) and to fill my height"	
		layoutPolicy: GLMBrickHorizontalFillProportionalLinearLayout new;
		enable;
		normalColor: Color lightGray lighter;
		selectedColor: Color lightGray;
		pressedColor: Color gray;
		checkedColor: Color gray;
		addBrickBack: self recipientBrick.
		
	"here we configurate paddings"
	self layoutProperties
		hSpaceFill;
		paddingLeft: 5;
		paddingRight: 5;
		paddingTop: 10;
		paddingBottom: 10.
]

{ #category : #accessing }
GTConversationRowBrick >> recipientBrick [
	^ recipientBrick ifNil: [ recipientBrick := GTRecipientBrick new ]
]

{ #category : #'events-processing' }
GTConversationRowBrick >> recipientChanged: aGTCRecipientChanged [ 
	aGTCRecipientChanged conversation = self conversation ifFalse: [ ^ self ].
	self recipientBrick recipient: aGTCRecipientChanged recipient.
	self changed.
]

{ #category : #visitor }
GTConversationRowBrick >> visitChatterMessage: aGTConversation factory: aBrickFactory [
	^ aGTConversation acceptConversationRowBrick: self factory: aBrickFactory
]
