Class {
	#name : #GTRemoteAnnouncement,
	#superclass : #GTAnnouncement,
	#instVars : [
		'from',
		'timestamp'
	],
	#category : #'GT-Chatter-Announcements'
}

{ #category : #'instance creation' }
GTRemoteAnnouncement class >> from: from timestamp: timestamp [

	^ self new
		from: from;
		timestamp: timestamp;
		yourself
]

{ #category : #accessing }
GTRemoteAnnouncement >> from [
	^ from
]

{ #category : #accessing }
GTRemoteAnnouncement >> from: anObject [
	
	from := anObject
]

{ #category : #initialization }
GTRemoteAnnouncement >> initialize [
	super initialize.
	timestamp := DateAndTime now.
]

{ #category : #testing }
GTRemoteAnnouncement >> isFrom: aClientId [
	^ from = aClientId
]

{ #category : #accessing }
GTRemoteAnnouncement >> timestamp [
	^ timestamp
]

{ #category : #accessing }
GTRemoteAnnouncement >> timestamp: anObject [
	
	timestamp := anObject
]
