Class {
	#name : #GTORemoteUser,
	#superclass : #GTOUser,
	#category : #'GT-Chatter-NewModel'
}

{ #category : #testing }
GTORemoteUser >> isOnline [
	^ self 
		optionAt: #onlineSince
		ifPresent: [ :aDateAndTime | DateAndTime now - aDateAndTime < 10 minutes ]
		ifAbsent: [ false ]
]

{ #category : #'as yet unclassified' }
GTORemoteUser >> lastMessage [
	^ self chatter lastMessageWith: self
]

{ #category : #accessing }
GTORemoteUser >> onlineSince: aDateAndTime [ 
	self optionAt: #onlineSince put: aDateAndTime
]

{ #category : #printing }
GTORemoteUser >> printOn: aStream [
	self nickname 
		ifNil: [ aStream nextPutAll: 'a user' ]
		ifNotNil: [ aStream print: self nickname ].
	self isOnline
		ifTrue: [ aStream nextPutAll: ' is online' ]
		ifFalse: [ aStream nextPutAll: ' is offline' ]
]

{ #category : #'as yet unclassified' }
GTORemoteUser >> sendTextMessage: aString [ 
	self chatter sendTextMessage: aString to: self sign.
]
