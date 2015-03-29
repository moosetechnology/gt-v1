Class {
	#name : #GTSpotterEvents,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis'
}

{ #category : #'instance creation' }
GTSpotterEvents class >> fromDirectory: aFileReference [
	"self fromDirectory: './gt/events/' asFileReference"
	^ self 
		withAll: (GTSpotterEventRecorder materializeObjectsFromDirectory: aFileReference)
]

{ #category : #accessing }
GTSpotterEvents >> developerUUIDs [
	^ #( 	'58d42da6-c993-4ad1-8624-5fd628793610' 
			'4483f704-6909-45d7-9367-869a5850c3e8'
			'52fe7c39-9c98-4fa7-a883-a8b2cabe84db'
			'69202c73-b32f-4968-aaf1-0666d421ea57'
		)
]

{ #category : #enumerating }
GTSpotterEvents >> developers [
	^ self select: [ :each | self developerUUIDs includes: each computerUUID  ]
]

{ #category : #enumerating }
GTSpotterEvents >> events [
	^ self flatCollect: #events
]

{ #category : #accessing }
GTSpotterEvents >> numberOfComputers [
	^ self perComputer size
]

{ #category : #enumerating }
GTSpotterEvents >> perComputer [
	^ self groupedBy: #computerUUID
]

{ #category : #sorting }
GTSpotterEvents >> sortByTimestamp [
	^ self sort: [ :a :b | a timestamp < b timestamp ]
]

{ #category : #enumerating }
GTSpotterEvents >> users [
	^ self select: [ :each | (self developerUUIDs includes: each computerUUID) not ]
]

{ #category : #enumerating }
GTSpotterEvents >> withoutEmptyComputerUUID [
	^ self select: [ :each | each computerUUID notNil and: [ (each computerUUID = 'nil') not ] ]
]
