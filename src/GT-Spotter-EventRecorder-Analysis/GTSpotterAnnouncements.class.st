Class {
	#name : #GTSpotterAnnouncements,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis'
}

{ #category : #'instance creation' }
GTSpotterAnnouncements class >> fromDirectory: aFileReference [
	"self fromDirectory: './gt/events/' asFileReference"
	^ self 
		withAll: (GTSpotterEventRecorder materializeObjectsFromDirectory: aFileReference)
]

{ #category : #'instance creation' }
GTSpotterAnnouncements class >> fromLocalDirectory [
	^ self fromDirectory: './gt/events/' asFileReference
]

{ #category : #helpers }
GTSpotterAnnouncements class >> sessions [
	"self sessions"
	^ self fromLocalDirectory 
			withoutEmptyComputerUUID
				sessionsPerComputer
]

{ #category : #accessing }
GTSpotterAnnouncements >> developerUUIDs [
	^ #( 	'58d42da6-c993-4ad1-8624-5fd628793610' 
			'4483f704-6909-45d7-9367-869a5850c3e8'
			'52fe7c39-9c98-4fa7-a883-a8b2cabe84db'
			'69202c73-b32f-4968-aaf1-0666d421ea57'
		)
]

{ #category : #enumerating }
GTSpotterAnnouncements >> developers [
	^ self select: [ :each | self developerUUIDs includes: each computerUUID  ]
]

{ #category : #'as yet unclassified' }
GTSpotterAnnouncements >> duration [
	^ 0 seconds
]

{ #category : #enumerating }
GTSpotterAnnouncements >> events [
	^ self flatCollect: #events as: GTSpotterEvents.
]

{ #category : #enumerating }
GTSpotterAnnouncements >> eventsPerComputer [
	| group |
	group := self perComputer.
	^ group collect: [ :eachComputer |
		eachComputer sortByTimestamp.
		eachComputer events.
	]
]

{ #category : #accessing }
GTSpotterAnnouncements >> numberOfComputers [
	^ self perComputer size
]

{ #category : #enumerating }
GTSpotterAnnouncements >> perComputer [
	^ (self groupedBy: #computerUUID) as: GTSpotterAnnouncements
]

{ #category : #'as yet unclassified' }
GTSpotterAnnouncements >> sessions [
	^ (self flatCollect: #materializedData as: GTSpotterEvents) sessions
]

{ #category : #enumerating }
GTSpotterAnnouncements >> sessionsPerComputer [
	| group computers |
	group := self perComputer.
	computers := group collect: [ :eachComputer |
		eachComputer sortByTimestamp.
		eachComputer sessions as: GTSpotterComputer.
	] as: GTSpotterComputers.
	^ computers select: #notEmpty
]

{ #category : #sorting }
GTSpotterAnnouncements >> sortByTimestamp [
	^ self sort: [ :a :b | a timestamp < b timestamp ]
]

{ #category : #'as yet unclassified' }
GTSpotterAnnouncements >> start [
	^ DateAndTime now
]

{ #category : #enumerating }
GTSpotterAnnouncements >> users [
	^ self select: [ :each | (self developerUUIDs includes: each computerUUID) not ]
]

{ #category : #enumerating }
GTSpotterAnnouncements >> withoutEmptyComputerUUID [
	^ self select: [ :each | each computerUUID notNil and: [ (each computerUUID = 'nil') not ] ]
]
