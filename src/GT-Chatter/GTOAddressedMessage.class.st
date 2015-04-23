Class {
	#name : #GTOAddressedMessage,
	#superclass : #GTORemoteAnnouncement,
	#instVars : [
		'to'
	],
	#category : #'GT-Chatter-NewModel'
}

{ #category : #testing }
GTOAddressedMessage >> isFor: aGTOUser [ 
	^ self to = aGTOUser
]

{ #category : #accessing }
GTOAddressedMessage >> to [
	^ to
]

{ #category : #accessing }
GTOAddressedMessage >> to: anObject [
	to := anObject
]
