Class {
	#name : #GTSpotterRecorderDataAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'data'
	],
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #'instance creation' }
GTSpotterRecorderDataAnnouncement class >> data: aByteArray [ 
	^ self new data: aByteArray; yourself
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> data [
	^ data
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> data: aByteArray [ 
	data := aByteArray
]
