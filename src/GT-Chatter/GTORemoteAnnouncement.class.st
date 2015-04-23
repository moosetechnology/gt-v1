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
GTORemoteAnnouncement class >> from: aGTOUserSign [
	^ self new from: aGTOUserSign; yourself
]

{ #category : #'instance creation' }
GTORemoteAnnouncement class >> fromChatter: aGTOChatter [ 
	^ self fromUser: aGTOChatter me
]

{ #category : #'instance creation' }
GTORemoteAnnouncement class >> fromUser: aGTOUser [ 
	^ self new from: aGTOUser sign; yourself
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
GTORemoteAnnouncement >> isFrom: aGTOUserSign [ 
	^ self from = aGTOUserSign
]

{ #category : #accessing }
GTORemoteAnnouncement >> timestamp [
	^ timestamp
]
