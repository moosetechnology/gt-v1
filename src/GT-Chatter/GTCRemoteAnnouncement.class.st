Class {
	#name : #GTCRemoteAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'from',
		'timestamp'
	],
	#category : #'GT-Chatter-RemoteAnnouncements'
}

{ #category : #'instance creation' }
GTCRemoteAnnouncement class >> from: from timestamp: timestamp [

	^ self new
		from: from;
		timestamp: timestamp;
		yourself
]

{ #category : #converting }
GTCRemoteAnnouncement >> asReceivedMessage [
	^ GTReceivedMessage new
			contents: self;
			yourself
]

{ #category : #converting }
GTCRemoteAnnouncement >> asSentMessage [
	^ GTSentMessage new
			contents: self;
			yourself
]

{ #category : #accessing }
GTCRemoteAnnouncement >> from [
	^ from
]

{ #category : #accessing }
GTCRemoteAnnouncement >> from: anObject [
	
	from := anObject
]

{ #category : #initialization }
GTCRemoteAnnouncement >> initialize [
	super initialize.
	timestamp := DateAndTime now.
]

{ #category : #testing }
GTCRemoteAnnouncement >> isFrom: aClientId [
	^ from = aClientId
]

{ #category : #accessing }
GTCRemoteAnnouncement >> timestamp [
	^ timestamp
]

{ #category : #accessing }
GTCRemoteAnnouncement >> timestamp: anObject [
	
	timestamp := anObject
]

{ #category : #protocol }
GTCRemoteAnnouncement >> updateFromChatter: aGTChatter [ 
	self from: aGTChatter clientId.
]
