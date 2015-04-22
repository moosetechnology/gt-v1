Class {
	#name : #GTORemoteAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'from',
		'timestamp'
	],
	#category : #'GT-Chatter-NewModel'
}

{ #category : #'as yet unclassified' }
GTORemoteAnnouncement class >> from: aGTOUser [ 
	^ self new from: aGTOUser; yourself
]

{ #category : #'as yet unclassified' }
GTORemoteAnnouncement class >> fromChatter: aGTOChatter [ 
	^ self from: aGTOChatter me
]

{ #category : #accessing }
GTORemoteAnnouncement >> from [
	^ from
]

{ #category : #accessing }
GTORemoteAnnouncement >> from: anObject [
	from := anObject
]

{ #category : #initialization }
GTORemoteAnnouncement >> initialize [
	super initialize.
	timestamp := DateAndTime now.
]

{ #category : #accessing }
GTORemoteAnnouncement >> timestamp [
	^ timestamp
]
