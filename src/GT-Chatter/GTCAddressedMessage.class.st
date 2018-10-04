Class {
	#name : #GTCAddressedMessage,
	#superclass : #GTCRemoteAnnouncement,
	#instVars : [
		'to'
	],
	#category : #'GT-Chatter-RemoteAnnouncements'
}

{ #category : #testing }
GTCAddressedMessage >> isFor: clientId [ 
	^ self to = clientId
]

{ #category : #accessing }
GTCAddressedMessage >> to [
	^ to
]

{ #category : #accessing }
GTCAddressedMessage >> to: anObject [
	
	to := anObject
]
