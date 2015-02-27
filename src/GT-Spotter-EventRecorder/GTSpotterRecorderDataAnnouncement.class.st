"
A GTSpotterRecorderDataAnnouncement is an announcement that  groups  all  usage data  that is send over the network. 

Instance Variables
	computerUUID:		<Object>
	data:		<Object>
	imageHash:		<Object>
	imageVersion:		<Object>
	latestUpdate:		<Object>
	sessionCreationTime:		<Object>
	timestamp:		<Object>

computerUUID
	- xxxxx

data
	- xxxxx

imageHash
	- xxxxx

imageVersion
	- xxxxx

latestUpdate
	- xxxxx

sessionCreationTime
	- xxxxx

timestamp
	- xxxxx

"
Class {
	#name : #GTSpotterRecorderDataAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'computerUUID',
		'data',
		'imageHash',
		'imageVersion',
		'latestUpdate',
		'sessionCreationTime',
		'timestamp'
	],
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> computerUUID [
	^ computerUUID
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> computerUUID: anObject [
	computerUUID := anObject
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> data [
	^ data
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> data: aByteArray [ 
	data := aByteArray
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> imageHash [
	^ imageHash
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> imageHash: anObject [
	imageHash := anObject
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> imageVersion [
	^ imageVersion
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> imageVersion: anObject [
	imageVersion := anObject
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> latestUpdate [
	^ latestUpdate
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> latestUpdate: anObject [
	latestUpdate := anObject
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> materializedData [
	^ self data ifNotNil: [ :aData | FLMaterializer materializeFromByteArray: aData ]
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> sessionCreationTime [
	^ sessionCreationTime
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> sessionCreationTime: anObject [
	sessionCreationTime := anObject
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> timestamp [
	^ timestamp
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> timestamp: anObject [
	timestamp := anObject
]