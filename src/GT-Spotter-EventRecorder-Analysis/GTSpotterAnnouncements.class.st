Class {
	#name : #GTSpotterAnnouncements,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #accessing }
GTSpotterAnnouncements class >> developerUUIDs [
	"
	GTSpotterEventRecorderSettings ensureComputerID.
	GTSpotterEventRecorderSettings uniqueInstance computerUUID.
	"
	^ #( 	'58d42da6-c993-4ad1-8624-5fd628793610' 
			'8c7d33b4-1025-42b3-8dc4-4a2bb32c5a42'
			'4483f704-6909-45d7-9367-869a5850c3e8'
			'52fe7c39-9c98-4fa7-a883-a8b2cabe84db'
			'69202c73-b32f-4968-aaf1-0666d421ea57'
			'0cd69f50-ad08-8c47-84ec-329e2210a2f2'
		)
]

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

{ #category : #testing }
GTSpotterAnnouncements class >> isDeveloper: anUUID [
	^ self developerUUIDs includes: anUUID asString
]

{ #category : #helpers }
GTSpotterAnnouncements class >> spotterDevelopers [
	"self spotterDevelopers"
	^ self fromLocalDirectory 
			withoutEmptyComputerUUID
				developers
					sessionsPerComputer
						sessionsWithNumberOfInputsGreaterThenOne
]

{ #category : #helpers }
GTSpotterAnnouncements class >> spotterUsers [
	"self spotterUsers"
	^ self fromLocalDirectory 
			withoutEmptyComputerUUID
				users
					sessionsPerComputer
						sessionsWithNumberOfInputsGreaterThenOne
]

{ #category : #helpers }
GTSpotterAnnouncements class >> spotterUsersAndDevelopers [
	"self spotterUsersAndDevelopers"
	^ self fromLocalDirectory 
			withoutEmptyComputerUUID
					sessionsPerComputer
						sessionsWithNumberOfInputsGreaterThenOne
]

{ #category : #accessing }
GTSpotterAnnouncements >> developerUUIDs [
	^ self class developerUUIDs
]

{ #category : #enumerating }
GTSpotterAnnouncements >> developers [
	^ self select: [ :each | self developerUUIDs includes: each computerUUID asString ]
]

{ #category : #accessing }
GTSpotterAnnouncements >> numberOfComputers [
	^ self perComputer size
]

{ #category : #enumerating }
GTSpotterAnnouncements >> perComputer [
	^ (self groupedBy: [ :each | each computerUUID asString]) as: GTSpotterAnnouncements
]

{ #category : #enumerating }
GTSpotterAnnouncements >> sessions [
	^ GTSpotterSessionsBuilder fromEvents: (
			self flatCollect: #events as: OrderedCollection)
]

{ #category : #enumerating }
GTSpotterAnnouncements >> sessionsPerComputer [
	| group computers |
	group := self perComputer.
	computers := group collect: [ :eachComputer |
		eachComputer sortByTimestamp.
		eachComputer sessions.
	] as: GTSpotterComputers.
	computers updateEvents.
	^ computers select: #notEmpty
]

{ #category : #sorting }
GTSpotterAnnouncements >> sortByTimestamp [
	^ self sort: [ :a :b | a timestamp < b timestamp ]
]

{ #category : #enumerating }
GTSpotterAnnouncements >> users [
	^ self select: [ :each | (self developerUUIDs includes: each computerUUID asString) not ]
]

{ #category : #enumerating }
GTSpotterAnnouncements >> withoutEmptyComputerUUID [
	^ self select: [ :each | each computerUUID notNil and: [ (each computerUUID = 'nil') not ] ]
]
