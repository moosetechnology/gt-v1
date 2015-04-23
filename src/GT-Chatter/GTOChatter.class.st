Class {
	#name : #GTOChatter,
	#superclass : #Object,
	#instVars : [
		'me',
		'proxy',
		'users'
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

{ #category : #'event handling' }
GTOChatter >> handleOnline: aGTOOnline [ 
	(aGTOOnline isFrom: self sign) ifTrue: [ ^ self ].
	self users online: aGTOOnline from since: aGTOOnline timestamp
]

{ #category : #'event handling' }
GTOChatter >> handleTextMessage: aGTOTextMessage [ 
	aGTOTextMessage to = self sign ifFalse: [ ^ self ].
	self halt.
	self me addMessage: aGTOTextMessage.
]

{ #category : #'as yet unclassified' }
GTOChatter >> lastMessageWith: aGTOUser [ 
	^ self me lastMessageWith: aGTOUser
]

{ #category : #accessing }
GTOChatter >> me [
	^ me ifNil: [ me := GTOMe new chatter: self; yourself ]
]

{ #category : #accessing }
GTOChatter >> nickname [
	^ self me nickname
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
GTOChatter >> sendTextMessage: aString to: aGTOUserSign [ 
	| announcement |
	announcement := (GTOTextMessage fromChatter: self) to: aGTOUserSign; text: aString; yourself.
	self me addMessage: announcement recipient: aGTOUserSign.
	proxy announce: announcement.
]

{ #category : #accessing }
GTOChatter >> sign [
	^ self me sign
]

{ #category : #accessing }
GTOChatter >> users [
	^ users ifNil: [ users := GTOUsers new chatter: self ]
]

{ #category : #'as yet unclassified' }
GTOChatter >> waitForMessageFrom: aGTOUser timeoutMSecs: anInteger [ 
	"self shouldBeImplemented."
]
