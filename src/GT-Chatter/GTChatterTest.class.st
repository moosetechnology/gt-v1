"
A GTChatterTest is a test class for testing the behavior of GTChatter
"
Class {
	#name : #GTChatterTest,
	#superclass : #TestCase,
	#instVars : [
		'server',
		'client1',
		'client2',
		'client3',
		'message',
		'proxy'
	],
	#category : #'GT-Chatter-Tests'
}

{ #category : #running }
GTChatterTest >> setUp [
	super setUp.
	proxy := Announcer new.
	client1 := GTChatter new clientId: 'client1'; proxy: proxy; start.
	client2 := GTChatter new clientId: 'client2'; proxy: proxy; start.
	client3 := GTChatter new clientId: 'client3'; proxy: proxy; start.
	message := 'Hello World'.
]

{ #category : #running }
GTChatterTest >> tearDown [
	server ifNotNil: [ :s | server := nil. s stop ].
	client1 ifNotNil: [ :s | client1 := nil. s stop ].
	client2 ifNotNil: [ :s | client2 := nil. s stop ].
	client3 ifNotNil: [ :s | client3 := nil. s stop ].
	super tearDown.
]

{ #category : #tests }
GTChatterTest >> testNotifyAsOnline [
	client2 onlineUsers removeAll.
	self assert: client2 onlineUsers size equals: 0.
	client1 notifyAsOnline.
	self assert: client2 onlineUsers size equals: 1.
]

{ #category : #tests }
GTChatterTest >> testSendTo [
	self assert: client1 numberOfMessages equals: 0.
	self assert: client2 numberOfMessages equals: 0.
	self assert: client3 numberOfMessages equals: 0.
	self assert: client1 numberOfConversations equals: 0.
	self assert: client2 numberOfConversations equals: 0.
	self assert: client3 numberOfConversations equals: 0.

	client1 send: message to: client2 clientId.
	self assert: client1 numberOfMessages equals: 1.
	self assert: client2 numberOfMessages equals: 1.
	self assert: client3 numberOfMessages equals: 0.
	self assert: client1 numberOfConversations equals: 1.
	self assert: client2 numberOfConversations equals: 1.
	self assert: client3 numberOfConversations equals: 0.
	self assert: client1 conversations first recipient equals: client2 clientId.
	self assert: client2 conversations first recipient equals: client1 clientId.

	client2 send: message to: client1 clientId.
	self assert: client1 numberOfMessages equals: 2.
	self assert: client2 numberOfMessages equals: 2.
	self assert: client3 numberOfMessages equals: 0.
	self assert: client1 numberOfConversations equals: 1.
	self assert: client2 numberOfConversations equals: 1.
	self assert: client3 numberOfConversations equals: 0.
	self assert: client1 conversations first recipient equals: client2 clientId.
	self assert: client2 conversations first recipient equals: client1 clientId.

	client2 send: message to: client3 clientId.
	self assert: client1 numberOfMessages equals: 2.
	self assert: client2 numberOfMessages equals: 3.
	self assert: client3 numberOfMessages equals: 1.
	self assert: client1 numberOfConversations equals: 1.
	self assert: client2 numberOfConversations equals: 2.
	self assert: client3 numberOfConversations equals: 1.

]

{ #category : #tests }
GTChatterTest >> testSendToAnnouncements [
	| receivedAnnouncements1 receivedAnnouncements2 receivedAnnouncements3 |
	receivedAnnouncements1 := OrderedCollection new.
	receivedAnnouncements2 := OrderedCollection new.
	receivedAnnouncements3 := OrderedCollection new.
	client1 announcer when: GTConversationAnnouncement do: [ :announcement | receivedAnnouncements1 addLast: announcement ].
	client2 announcer when: GTConversationAnnouncement do: [ :announcement | receivedAnnouncements2 addLast: announcement ].
	client3 announcer when: GTConversationAnnouncement do: [ :announcement | receivedAnnouncements3 addLast: announcement ].

	client1 send: 'message 1' to: client2 clientId.
	self assert: receivedAnnouncements1 size equals: 1.
	self assert: receivedAnnouncements2 size equals: 1.
	self assert: receivedAnnouncements3 size equals: 0.
	
	client2 send: 'message 2' to: client1 clientId.
	self assert: receivedAnnouncements1 size equals: 2.
	self assert: receivedAnnouncements2 size equals: 2.
	self assert: receivedAnnouncements3 size equals: 0.

	client2 send: 'message 3' to: client3 clientId.
	self assert: receivedAnnouncements1 size equals: 2.
	self assert: receivedAnnouncements2 size equals: 3.
	self assert: receivedAnnouncements3 size equals: 1.

]

{ #category : #tests }
GTChatterTest >> testWhoIsOnline [
	client1 whoIsOnline.
	self assert: client1 onlineUsers size equals: 2.
	self assert: client2 onlineUsers size equals: 2.
	self assert: client3 onlineUsers size equals: 2.
	self assert: (client1 onlineUsers includes: 'client2').
	self assert: (client1 onlineUsers includes: 'client3').
	self assert: (client2 onlineUsers includes: 'client1').
	self assert: (client2 onlineUsers includes: 'client3').
	self assert: (client3 onlineUsers includes: 'client1').
	self assert: (client3 onlineUsers includes: 'client2').

]
