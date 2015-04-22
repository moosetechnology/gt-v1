"
A GTOUserTest is a test class for testing the behavior of GTOUser
"
Class {
	#name : #GTOUserTest,
	#superclass : #TestCase,
	#instVars : [
		'me',
		'users',
		'proxy'
	],
	#category : #'GT-Chatter-NewModel'
}

{ #category : #tests }
GTOUserTest >> addChatterNamed: aString [
	users ifNil: [ users := OrderedCollection new ].
	^ users add: ((GTOChatter named: aString) proxy: proxy; yourself)
]

{ #category : #'instance creation' }
GTOUserTest >> newOnlineUser [
	^ self newOnlineUserNamed: 'User'
]

{ #category : #tests }
GTOUserTest >> newOnlineUserNamed: aString [
	| user |
	user := me addUser: (GTOUser named: aString).
	(self addChatterNamed: aString) online.
	^ user
]

{ #category : #running }
GTOUserTest >> setUp [
	super setUp.
	proxy := Announcer new.
	me := GTOChatter new.
	me name: 'Me'.
	me proxy: proxy.
]

{ #category : #tests }
GTOUserTest >> testIsOnline [
	| user |
	me online.
	user := self newOnlineUser.
	self assert: user isOnline.
]

{ #category : #tests }
GTOUserTest >> testSendTextMessage [
	| user |
	user := self newOnlineUser.
	user sendTextMessage: 'Hi!'.
	me waitForMessageFrom: user timeoutMSecs: 100.
	self assert: (me lastMessageFrom: user) text equals: 'Hi!'.
]
