Class {
	#name : #GTChatterExamples,
	#superclass : #Object,
	#category : #'GT-Chatter-Examples'
}

{ #category : #accessing }
GTChatterExamples class >> conversationModel [
	| conversation random max |
	conversation := GTConversation new.
	conversation recipient: 'client2'.
	random := Random new.
	max := (random next * 100) asInteger.
	1 to: max do: [ :aNumber | | message |
		message := random next < 0.5 
							ifTrue: [ self sentMessageModel ]
							ifFalse: [ self receivedMessageModel ].
	conversation addMessage: message ].
	^ conversation
]

{ #category : #accessing }
GTChatterExamples class >> conversationsModel [
	| conversations |
	conversations := GTConversations new.
	1 to: 20 do: [ :index | | conversation |
		conversation := self conversationModel.
		conversation recipient: 'client ', index asString.
		conversations addConversation: conversation ].
	^ conversations
]

{ #category : #examples }
GTChatterExamples class >> exampleChatterUI [
	<example>
	| chatter |
	chatter := GTChatter new.
	chatter setLocalProxy.
	chatter conversations: self conversationsModel.
	^ chatter open
]

{ #category : #examples }
GTChatterExamples class >> exampleConversationBrick [
	<example>
	| model brick |
	brick := GTConversationBrick new.
	model := self conversationModel.
	brick conversation: model.
	^ GLMFoundationBrick new
			addBrickBack: brick;
			extent: 400@300;
			openInWindowLabeled: 'My messages with ', model recipient asString.
]

{ #category : #examples }
GTChatterExamples class >> exampleConversationsBrick [
	<example>
	| model brick |
	brick := GTConversationsBrick new.
	model := GTChatter new conversations: self conversationsModel; yourself.
	brick chatterModel: model.
	^ GLMFoundationBrick new
			addBrickBack: brick;
			extent: 400@300;
			openInWindowLabeled: 'My Conversations'.
]

{ #category : #examples }
GTChatterExamples class >> exampleMessageInputField [
	^ GLMFoundationBrick new
			addBrickBack: GTMessageInputFieldBrick new;
			extent: 300@300;
			openInWindowLabeled: 'Message Input Field'
]

{ #category : #examples }
GTChatterExamples class >> exampleReceivedMessage [
	<example>
	| brick |
	brick := GTMessageBrick new.
	brick message: self receivedMessageModel.
	^ GLMFoundationBrick new
			addBrickBack: brick;
			openInWindowLabeled: 'Received Message'.
]

{ #category : #examples }
GTChatterExamples class >> exampleReceivedMessageRowBrick [
	<example>
	| brick |
	brick := GTMessageRowBrick new.
	brick message: self receivedMessageModel.
	^ GLMFoundationBrick new
			addBrickBack: brick;
			openInWindowLabeled: 'Received Message'.
]

{ #category : #examples }
GTChatterExamples class >> exampleSentMessage [
	<example>
	| brick |
	brick := GTMessageBrick new.
	brick message: self sentMessageModel.
	^ GLMFoundationBrick new
			addBrickBack: brick;
			openInWindowLabeled: 'Sent Message'.
]

{ #category : #examples }
GTChatterExamples class >> exampleSentMessageRowBrick [
	<example>
	| brick |
	brick := GTMessageRowBrick new.
	brick message: self sentMessageModel.
	^ GLMFoundationBrick new
			addBrickBack: brick;
			openInWindowLabeled: 'Sent Message'.
]

{ #category : #accessing }
GTChatterExamples class >> receivedMessageModel [
	^ (GTCTextMessage new
			message: (String loremIpsum: 100);
			yourself) asReceivedMessage
]

{ #category : #accessing }
GTChatterExamples class >> sentMessageModel [
	^ (GTCTextMessage new
		message: (String loremIpsum: 100);
		yourself) asSentMessage.
]
