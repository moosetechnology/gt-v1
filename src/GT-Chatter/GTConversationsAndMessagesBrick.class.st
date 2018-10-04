Class {
	#name : #GTConversationsAndMessagesBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'conversationsBrick',
		'conversationBrick'
	],
	#category : #'GT-Chatter-UI'
}

{ #category : #visitor }
GTConversationsAndMessagesBrick >> acceptConversationSelected: aGTConversationSelected [ 
	self conversationBrick: self newConversationBrick.
	self conversationBrick conversation: aGTConversationSelected conversation.
	self doLayout.
	self changed.
]

{ #category : #visitor }
GTConversationsAndMessagesBrick >> acceptMessageAdded: aGTMessageAdded [ 
	^ self conversationBrick messageAdded: aGTMessageAdded 
]

{ #category : #accessing }
GTConversationsAndMessagesBrick >> chatterModel [ 
	^ self data
]

{ #category : #accessing }
GTConversationsAndMessagesBrick >> chatterModel: aGTChatter [ 
	self data: aGTChatter.
	self conversationsBrick chatterModel: aGTChatter.
]

{ #category : #accessing }
GTConversationsAndMessagesBrick >> conversationBrick [
	^ conversationBrick
]

{ #category : #accessing }
GTConversationsAndMessagesBrick >> conversationBrick: aBrick [
	conversationBrick ifNotNil: [ :anOldBrick | self removeBrick: anOldBrick ].
	conversationBrick := aBrick.
	conversationBrick chatterModel: self chatterModel.
	self addBrickBack: aBrick.
]

{ #category : #accessing }
GTConversationsAndMessagesBrick >> conversationsBrick [
	^ conversationsBrick
]

{ #category : #accessing }
GTConversationsAndMessagesBrick >> conversationsBrick: aBrick [
	conversationsBrick ifNotNil: [ :anOldBrick | self removeBrick: anOldBrick ].
	conversationsBrick := aBrick.
	conversationsBrick selectedConversationProcessor: self.
	self addBrickBack: aBrick.
]

{ #category : #initialization }
GTConversationsAndMessagesBrick >> initialize [
	super initialize.
	self theme chatterWidgetThemer conversationsAndMessagesStyleFor: self.
	self conversationsBrick: self newConversationsBrick.
	self conversationBrick: self newConversationBrick.
]

{ #category : #'instance creation' }
GTConversationsAndMessagesBrick >> newConversationBrick [
	^ GTConversationBrick new
]

{ #category : #'instance creation' }
GTConversationsAndMessagesBrick >> newConversationsBrick [
	^ GTConversationsBrick new
]
