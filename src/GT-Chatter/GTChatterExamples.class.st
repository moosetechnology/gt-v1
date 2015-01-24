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
			doLayout;
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
GTChatterExamples class >> exampleMessageInputFieldBrick [
	^ GLMFoundationBrick new
			addBrickBack: GTMessageInputFieldBrick new;
			extent: 300@300;
			openInWindowLabeled: 'Message Input Field'
]

{ #category : #'examples - random model' }
GTChatterExamples class >> exampleRandomChatterUI [
	<example>
	| chatter |
	chatter := GTChatter new.
	chatter setLocalProxy.
	chatter conversations: self randomConversationsModel.
	^ chatter open
]

{ #category : #'examples - random model' }
GTChatterExamples class >> exampleRandomConversationBrick [
	<example>
	| model brick |
	brick := GTConversationBrick new.
	model := self randomConversationModel.
	brick conversation: model.
	^ GLMFoundationBrick new
			addBrickBack: brick;
			extent: 400@300;
			openInWindowLabeled: 'My messages with ', model recipient asString.
]

{ #category : #'examples - random model' }
GTChatterExamples class >> exampleRandomSentMessageRowBrick [
	<example>
	| brick |
	brick := GTMessageRowBrick new.
	brick message: self randomSentMessageModel.
	^ GLMFoundationBrick new
			addBrickBack: brick;
			openInWindowLabeled: 'Sent Message'.
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
GTChatterExamples class >> exampleSelectionInMethodMessageBrick [
	<example>
	| brick |
	brick := GTCSelectionInMethodMessageBrick new.
	brick message: self selectionInMethodModel.
	brick color: Color white.
	^ GLMFoundationBrick new
			addBrickBack: brick;
			openInWindowLabeled: 'Selection In Method Message'.
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

{ #category : #examples }
GTChatterExamples class >> exampleSentSelectionInMethodRowBrick [
	<example>
	| brick |
	brick := GTMessageRowBrick new.
	brick message: self sentSelectionInMethodModel.
	^ GLMFoundationBrick new
			addBrickBack: brick;
			openInWindowLabeled: 'Sent Message'.
]

{ #category : #examples }
GTChatterExamples class >> exampleTextMessageBrick [
	<example>
	| brick |
	brick := GTCTextMessageBrick new.
	brick message: self messageModel.
	^ GLMFoundationBrick new
			addBrickBack: brick;
			openInWindowLabeled: 'Text Message'.
]

{ #category : #accessing }
GTChatterExamples class >> messageModel [
	^ GTCTextMessage new
			message: (String loremIpsum: ((Random new next * 100) rounded) + 10);
			yourself
]

{ #category : #'accessing - random model' }
GTChatterExamples class >> randomConversationModel [
	| conversation random max |
	conversation := GTConversation new.
	conversation recipient: 'client2'.
	random := Random new.
	max := (random next * 10) asInteger + 5.
	1 to: max do: [ :aNumber | | message |
		message := random next < 0.5 
							ifTrue: [ self randomSentMessageModel ]
							ifFalse: [ self randomReceivedMessageModel ].
	conversation addMessage: message ].
	^ conversation
]

{ #category : #'accessing - random model' }
GTChatterExamples class >> randomConversationsModel [
	| conversations |
	conversations := GTConversations new.
	1 to: 13 do: [ :index | | conversation |
		conversation := self randomConversationModel.
		conversation recipient: 'client ', index asString.
		conversations addConversation: conversation ].
	^ conversations
]

{ #category : #'accessing - random model' }
GTChatterExamples class >> randomModel [
	^ self perform: ({ #messageModel. #selectionInMethodModel } atRandom)
]

{ #category : #'accessing - random model' }
GTChatterExamples class >> randomReceivedMessageModel [
	^ self randomModel asReceivedMessage
]

{ #category : #'accessing - random model' }
GTChatterExamples class >> randomSentMessageModel [
	^ self randomModel asSentMessage
]

{ #category : #accessing }
GTChatterExamples class >> receivedMessageModel [
	^ self messageModel asReceivedMessage
]

{ #category : #accessing }
GTChatterExamples class >> receivedSelectionInMethodModel [
	^ self selectionInMethodModel asReceivedMessage
]

{ #category : #accessing }
GTChatterExamples class >> selectionInMethodModel [
	| allClasses aClass aSelector |
	allClasses := (Smalltalk globals allClassesAndTraits 
							select: [ :each | each methodDict notEmpty ]).
	aClass := allClasses atRandom.
	aSelector := aClass selectors atRandom.
	^ GTCSelectionInMethodMessage new
		ring: (aClass >> aSelector) asFullRingDefinition;
		selection: (1 to: 4);
		yourself
]

{ #category : #accessing }
GTChatterExamples class >> sentMessageModel [
	^ self messageModel asSentMessage
]

{ #category : #accessing }
GTChatterExamples class >> sentSelectionInMethodModel [
	^ self selectionInMethodModel asSentMessage
]
