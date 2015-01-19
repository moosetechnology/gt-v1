Class {
	#name : #GTPrivateMessage,
	#superclass : #GTInternetMessage,
	#instVars : [
		'to'
	],
	#category : #'GT-Chatter-Announcements'
}

{ #category : #'instance creation' }
GTPrivateMessage class >> to: to [

	^ self new
		to: to;
		yourself
]

{ #category : #converting }
GTPrivateMessage >> asReceivedMessage [
	^ GTReceivedMessage new
			message: self message;
			timestamp: self timestamp;
			yourself
]

{ #category : #testing }
GTPrivateMessage >> isFor: clientId [ 
	^ self to = clientId
]

{ #category : #accessing }
GTPrivateMessage >> to [
	^ to
]

{ #category : #accessing }
GTPrivateMessage >> to: anObject [
	
	to := anObject
]
