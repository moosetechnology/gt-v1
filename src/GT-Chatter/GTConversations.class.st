Class {
	#name : #GTConversations,
	#superclass : #Object,
	#instVars : [
		'monitor',
		'items',
		'announcer'
	],
	#category : #'GT-Chatter-Model'
}

{ #category : #adding }
GTConversations >> addConversation: aGTConversation [ 
	aGTConversation announcer: self announcer.
	monitor critical: [ items addFirst: aGTConversation ].
	self announcer announce: (GTConversationAdded new conversation: aGTConversation; yourself).
	^ aGTConversation
]

{ #category : #adding }
GTConversations >> addMessage: aGTMessage to: aConversation [ 
	| message |
	message := aConversation addMessage: aGTMessage.
	self announcer announce: (GTMessageAdded new
											conversation: aConversation;
											message: message;
											yourself).
	^ message
]

{ #category : #adding }
GTConversations >> addNewConversation [
	^ self addConversation: GTConversation new.
]

{ #category : #accessing }
GTConversations >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
GTConversations >> announcer: anAnnouncer [
	announcer := anAnnouncer.
	self do: [ :eachConversation | eachConversation announcer: announcer ]
]

{ #category : #accessing }
GTConversations >> at: anIndex [
	^ monitor critical: [ 
		(anIndex < 1 or: [ anIndex > items size ])
			ifTrue: [ GTCNullConversation new ]
			ifFalse: [ items at: anIndex ] ]
]

{ #category : #enumerating }
GTConversations >> do: aBlockClosure [ 
	monitor critical: [ items do: aBlockClosure ]
]

{ #category : #accessing }
GTConversations >> first [
	^ self at: 1
]

{ #category : #initialization }
GTConversations >> initialize [
	super initialize.
	items := OrderedCollection new.
	monitor := Monitor new.
]

{ #category : #'instance creation' }
GTConversations >> newConversationWithRecipient: aClientId message: aGTMessage [
	| conversation |
	conversation := GTConversation new.
	conversation recipient: aClientId.
	conversation addMessage: aGTMessage.
	self addConversation: conversation.
	^ conversation
]

{ #category : #accessing }
GTConversations >> numberOfConversations [
	^ self size
]

{ #category : #accessing }
GTConversations >> numberOfMessages [
	^ monitor critical: [ 
		items 
			ifEmpty: [ 0 ]
			ifNotEmpty: [ items sum: #numberOfMessages ] ]
]

{ #category : #printing }
GTConversations >> printOn: aStream [
	| numOfConversations numOfMessages |
	numOfConversations := self numberOfConversations.
	numOfMessages := self numberOfMessages.
	aStream
		print: numOfConversations;
		nextPutAll: ' conversation'.
	numOfConversations = 1
		ifFalse: [ aStream nextPut: $s ].
	aStream
		nextPutAll: ' with ';
		print: numOfMessages;
		nextPutAll: ' message'.
	numOfMessages = 1
		ifFalse: [ aStream nextPut: $s ].
]

{ #category : #protocol }
GTConversations >> receive: aGTReceivedMessage from: aClientId [ 
	^ monitor critical: [ 
		items 
			detect: [ :aConversation | aConversation isWith: aClientId ] 
			ifFound: [ :aConversation | self addMessage: aGTReceivedMessage to: aConversation ]
			ifNone: [ self newConversationWithRecipient: aClientId message: aGTReceivedMessage ] ]
]

{ #category : #accessing }
GTConversations >> second [
	^ self at: 2
]

{ #category : #protocol }
GTConversations >> sent: aGTSentMessage to: aClientId [ 
	^ monitor critical: [ 
		items 
			detect: [ :aConversation | aConversation isWith: aClientId ] 
			ifFound: [ :aConversation | self addMessage: aGTSentMessage to: aConversation ]
			ifNone: [ self newConversationWithRecipient: aClientId message: aGTSentMessage ] ]
]

{ #category : #accessing }
GTConversations >> size [
	^ monitor critical: [ items size ]
]
