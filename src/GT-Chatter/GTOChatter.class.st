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
	^ self users add: aGTOUser
]

{ #category : #'event handling' }
GTOChatter >> handleOnline: aGTOOnline [ 
	(aGTOOnline isFrom: self me) ifTrue: [ ^ self ].
	self users online: aGTOOnline from since: aGTOOnline timestamp
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

{ #category : #accessing }
GTOChatter >> users [
	^ users ifNil: [ users := GTOUsers new ]
]
