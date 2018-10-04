"
A GTOUserTest is a test class for testing the behavior of GTOUser
"
Class {
	#name : #GTOUserTest,
	#superclass : #TestCase,
	#instVars : [
		'proxy',
		'chatter',
		'chatters'
	],
	#category : #'GT-Chatter-NewModel'
}

{ #category : #tests }
GTOUserTest >> addChatterNamed: aString [
	chatters ifNil: [ chatters := OrderedCollection new ].
	^ chatters add: ((GTOChatter named: aString) proxy: proxy; yourself)
]

{ #category : #tests }
GTOUserTest >> newOnlineChatterNamed: aString [
	^ (self addChatterNamed: aString) online; yourself
]

{ #category : #running }
GTOUserTest >> setUp [
	super setUp.
	proxy := Announcer new.
	chatter := GTOChatter new.
	chatter nickname: 'Me'.
	chatter proxy: proxy.
]

{ #category : #tests }
GTOUserTest >> testIsOnline [
	chatter online.
	self newOnlineChatterNamed: 'User1'.
	self assert: chatter users isNotEmpty.
	self assert: chatter users first isOnline.
]

{ #category : #tests }
GTOUserTest >> testNickname [
	self assert: chatter me class equals: GTOMe.
	self assert: chatter nickname equals: 'Me'.
]

{ #category : #tests }
GTOUserTest >> testSendTextMessage [
	| user1 chatter1 message |
	chatter1 := self newOnlineChatterNamed: 'User1'.
	chatter online.
	user1 := chatter users first.
	user1 sendTextMessage: 'Hi!'.
	chatter1 waitForMessageFrom: chatter sign timeoutMSecs: 100.
	message := chatter lastMessageWith: user1.
	self assert: message notNil.
	self assert: message text equals: 'Hi!'.
	self assert: message from equals: chatter sign.
	self assert: message to equals: user1 sign.
	self assert: (user1 lastMessage) notNil.
	self assert: user1 lastMessage == message.
	message := chatter1 lastMessageWith: chatter1 users first.
	self assert: message notNil.
	self assert: message text equals: 'Hi!'.
	self assert: message from equals: chatter sign.
	self assert: message to equals: user1 sign.
	self assert: chatter users first lastMessage == message.
	
]
