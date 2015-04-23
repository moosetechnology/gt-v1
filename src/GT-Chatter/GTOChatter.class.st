Class {
	#name : #GTOChatter,
	#superclass : #Object,
	#instVars : [
		'me',
		'proxy',
		'users',
		'chats'
	],
	#category : #'GT-Chatter-NewModel'
}

{ #category : #'instance creation' }
GTOChatter class >> named: aString [ 
	^ self new nickname: aString; yourself
]

{ #category : #adding }
GTOChatter >> addUser: aGTOUser [
	aGTOUser chatter: self.
	^ self users add: aGTOUser
]

{ #category : #accessing }
GTOChatter >> chats [
	^ chats ifNil: [ chats := GTOChats new ]
]

{ #category : #'event handling' }
GTOChatter >> handleOnline: aGTOOnline [ 
	(aGTOOnline isFrom: self me) ifTrue: [ ^ self ].
	self users online: aGTOOnline from since: aGTOOnline timestamp
]

{ #category : #'event handling' }
GTOChatter >> handleTextMessage: aGTOTextMessage [ 
	aGTOTextMessage to = self me ifFalse: [ ^ self ].
	self chats add: aGTOTextMessage.
]

{ #category : #'as yet unclassified' }
GTOChatter >> lastMessageFrom: aGTOUser [ 
	^ self chats lastMessageFrom: aGTOUser 
]

{ #category : #'as yet unclassified' }
GTOChatter >> lastMessageWith: aGTOUser [ 
	^ self lastMessageFrom: aGTOUser
]

{ #category : #accessing }
GTOChatter >> me [
	^ me ifNil: [ me := GTOUser new ]
]

{ #category : #accessing }
GTOChatter >> nickname: aString [ 
	self me nickname: aString
]

{ #category : #announcing }
GTOChatter >> online [
	proxy announce: (GTOOnline fromChatter: self)
]

{ #category : #accessing }
GTOChatter >> proxy: anAnnouncer [ 
	GTOProxyRegistration unsubscribe: self on: proxy.
	proxy := anAnnouncer.
	GTOProxyRegistration subscribe: self on: proxy.
]

{ #category : #'as yet unclassified' }
GTOChatter >> sendTextMessage: aString to: aGTOUser [ 
	| announcement |
	announcement := (GTOTextMessage fromChatter: self) to: aGTOUser; text: aString; yourself.
	self chats add: announcement recipient: aGTOUser.
	proxy announce: announcement.
]

{ #category : #accessing }
GTOChatter >> users [
	^ users ifNil: [ users := GTOUsers new ]
]

{ #category : #'as yet unclassified' }
GTOChatter >> waitForMessageFrom: aGTOUser timeoutMSecs: anInteger [ 
	"self shouldBeImplemented."
]
