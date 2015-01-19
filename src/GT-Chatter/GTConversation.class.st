Class {
	#name : #GTConversation,
	#superclass : #Object,
	#instVars : [
		'recipient',
		'messages',
		'announcer'
	],
	#category : #'GT-Chatter-Model'
}

{ #category : #visitor }
GTConversation >> acceptConversationRowBrick: aGTConversationRowBrick factory: aFactoryBrick [ 
	aGTConversationRowBrick conversation: self.
	^ aGTConversationRowBrick
]

{ #category : #visitor }
GTConversation >> acceptUndefinedObject: anUndefinedObject factory: aBrickFactory [ 
	| aBrick |
	aBrick := aBrickFactory newRowBrick.
	aBrick conversation: self.
	^ aBrick
]

{ #category : #adding }
GTConversation >> addMessage: aGTMessage [ 
	^ self messages addLast: aGTMessage.
]

{ #category : #accessing }
GTConversation >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
GTConversation >> announcer: anAnnouncer [ 
	announcer := anAnnouncer 
]

{ #category : #converting }
GTConversation >> asString [
	^ self recipient asString
]

{ #category : #testing }
GTConversation >> isNewConversation [
	^ self messages isEmpty
]

{ #category : #testing }
GTConversation >> isWith: aClientId [ 
	^ self recipient = aClientId
]

{ #category : #accessing }
GTConversation >> messages [	
	^ messages ifNil: [ messages := OrderedCollection new ]
]

{ #category : #accessing }
GTConversation >> messages: anObject [
	
	messages := anObject
]

{ #category : #accessing }
GTConversation >> numberOfMessages [
	^ self messages size
]

{ #category : #printing }
GTConversation >> printOn: aStream [
	aStream
		print: self numberOfMessages;
		nextPutAll: ' message'.
	self numberOfMessages = 1 ifFalse: [ aStream nextPut: $s ].
	aStream
		nextPutAll: ' with ';
		print: self recipient
]

{ #category : #accessing }
GTConversation >> recipient [
	^ recipient
]

{ #category : #accessing }
GTConversation >> recipient: anObject [
	recipient = anObject ifTrue: [ ^ self ].
	recipient := anObject.
	self announcer announce: (GTCRecipientChanged new conversation: self; yourself)
]

{ #category : #ui }
GTConversation >> updateBrick: aBrickOrNil factory: aBrickFactory [ 
	^ aBrickOrNil visitChatterMessage: self factory: aBrickFactory
]
