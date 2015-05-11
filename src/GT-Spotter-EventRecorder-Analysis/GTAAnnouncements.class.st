Class {
	#name : #GTAAnnouncements,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #accessing }
GTAAnnouncements class >> developerUUIDs [
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
GTAAnnouncements class >> fromDirectory: aFileReference [
	"self fromDirectory: './gt/events/' asFileReference"
	^ self 
		withAll: (GTSpotterEventRecorder materializeObjectsFromDirectory: aFileReference)
]

{ #category : #'instance creation' }
GTAAnnouncements class >> fromLocalDirectory [
	^ self fromDirectory: './gt/events/' asFileReference
]

{ #category : #testing }
GTAAnnouncements class >> isDeveloper: anUUID [
	^ self developerUUIDs includes: anUUID asString
]

{ #category : #helpers }
GTAAnnouncements class >> spotterDevelopers [
	"self spotterDevelopers"
	^ self fromLocalDirectory 
			withoutEmptyComputerUUID
				developers
					sessionsPerComputer
						sessionsWithNumberOfInputsGreaterThenOne
]

{ #category : #helpers }
GTAAnnouncements class >> spotterUsers [
	"self spotterUsers"
	^ self fromLocalDirectory 
			withoutEmptyComputerUUID
				users
					sessionsPerComputer
						sessionsWithNumberOfInputsGreaterThenOne
]

{ #category : #helpers }
GTAAnnouncements class >> spotterUsersAndDevelopers [
	"self spotterUsersAndDevelopers"
	^ self fromLocalDirectory 
			withoutEmptyComputerUUID
					sessionsPerComputer
						"sessionsWithNumberOfInputsGreaterThenOne"
]

{ #category : #accessing }
GTAAnnouncements >> developerUUIDs [
	^ self class developerUUIDs
]

{ #category : #enumerating }
GTAAnnouncements >> developers [
	^ self select: [ :each | self developerUUIDs includes: each computerUUID asString ]
]

{ #category : #accessing }
GTAAnnouncements >> numberOfComputers [
	^ self perComputer size
]

{ #category : #enumerating }
GTAAnnouncements >> perComputer [
	^ (self groupedBy: [ :each | each computerUUID asString]) as: GTAAnnouncements
]

{ #category : #enumerating }
GTAAnnouncements >> sessions [
	^ GTSpotterSessionsBuilder fromEvents: (
			self flatCollect: #events as: OrderedCollection)
]

{ #category : #enumerating }
GTAAnnouncements >> sessionsPerComputer [
	| group computers |
	group := self perComputer.
	computers := group collect: [ :eachComputer |
		eachComputer sortByTimestamp.
		eachComputer sessions.
	] as: GTAComputers.
	computers updateEvents.
	^ computers select: #notEmpty
]

{ #category : #sorting }
GTAAnnouncements >> sortByTimestamp [
	^ self sort: [ :a :b | a timestamp < b timestamp ]
]

{ #category : #enumerating }
GTAAnnouncements >> users [
	^ self select: [ :each | (self developerUUIDs includes: each computerUUID asString) not ]
]

{ #category : #enumerating }
GTAAnnouncements >> withoutEmptyComputerUUID [
	^ self select: [ :each | each computerUUID notNil and: [ (each computerUUID = 'nil') not ] ]
]
