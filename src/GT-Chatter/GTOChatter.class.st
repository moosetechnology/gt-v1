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

{ #category : #'as yet unclassified' }
GTOChatter class >> named: aString [ 
	^ self new name: aString; yourself
]

{ #category : #'as yet unclassified' }
GTOChatter >> addUser: aGTOUser [ 
	^ self users add: aGTOUser
]

{ #category : #'as yet unclassified' }
GTOChatter >> handleOnline: aGTOOnline [ 
	self users online: aGTOOnline from since: aGTOOnline timestamp
]

{ #category : #'as yet unclassified' }
GTOChatter >> me [
	^ me ifNil: [ me := GTOUser new ]
]

{ #category : #'as yet unclassified' }
GTOChatter >> name: aString [ 
	self me name: aString
]

{ #category : #'as yet unclassified' }
GTOChatter >> online [
	proxy announce: (GTOOnline fromChatter: self)
]

{ #category : #'as yet unclassified' }
GTOChatter >> proxy: anAnnouncer [ 
	GTOProxyRegistration unsubscribe: self on: proxy.
	proxy := anAnnouncer.
	GTOProxyRegistration subscribe: self on: proxy.
]

{ #category : #'as yet unclassified' }
GTOChatter >> users [
	^ users ifNil: [ users := GTOUsers new ]
]
