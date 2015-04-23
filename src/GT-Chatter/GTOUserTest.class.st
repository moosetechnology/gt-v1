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

{ #category : #'instance creation' }
GTOUserTest >> newOnlineUser [
	^ self newOnlineChatterNamed: 'User'
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
	| user message |
	chatter online.
	self newOnlineChatterNamed: 'User1'.
	user := chatter users first.
	user sendTextMessage: 'Hi!'.
	chatters first waitForMessageFrom: chatter sign timeoutMSecs: 100.
	message := chatter lastMessageWith: user.
	self assert: message notNil.
	self assert: message text equals: 'Hi!'.
	self assert: message from equals: chatter sign.
	self assert: message to equals: user sign.
	self assert: (user lastMessage) notNil.
	self assert: user lastMessage == message.
	self assert: (chatters first lastMessageWith: chatters first users first) notNil.
	self assert: (chatters first lastMessageWith: chatters first users first) text equals: 'Hi!'.
]
