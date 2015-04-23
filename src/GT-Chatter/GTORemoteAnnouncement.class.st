Class {
	#name : #GTORemoteAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'from',
		'timestamp'
	],
	#category : #'GT-Chatter-NewModel'
}

{ #category : #'instance creation' }
GTORemoteAnnouncement class >> from: aGTOUser [ 
	^ self new from: aGTOUser; yourself
]

{ #category : #'instance creation' }
GTORemoteAnnouncement class >> fromChatter: aGTOChatter [ 
	^ self from: aGTOChatter me
]

{ #category : #testing }
GTORemoteAnnouncement class >> isAbstract [
	^ self name = #GTORemoteAnnouncement
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

{ #category : #testing }
GTORemoteAnnouncement >> isFrom: aGTOUser [ 
	^ self from = aGTOUser
]

{ #category : #accessing }
GTORemoteAnnouncement >> timestamp [
	^ timestamp
]
