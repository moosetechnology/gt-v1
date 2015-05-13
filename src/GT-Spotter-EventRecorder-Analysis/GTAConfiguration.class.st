Class {
	#name : #GTAConfiguration,
	#superclass : #Object,
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #accessing }
GTAConfiguration class >> developerUUIDs [
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

{ #category : #accessing }
GTAConfiguration class >> interestingSessions [
	^ OrderedCollection new
]

{ #category : #testing }
GTAConfiguration class >> isDeveloper: anUUID [
	^ self developerUUIDs includes: anUUID asString
]

{ #category : #api }
GTAConfiguration class >> loadBookmarks [
	GTABookmarks uniqueInstanceFrom: self savedBookmarks
]

{ #category : #api }
GTAConfiguration class >> saveBookmarks [
	| paths methodSource |
	paths := GTABookmarks uniqueInstance collect: [ :each | each path ] as: Array.
	methodSource := String streamContents: [ :aStream |
		aStream
			nextPutAll: 'savedBookmarks'; cr; 
			tab; nextPutAll: '"Automatically created by class method #saveBookmarks."'; cr;
			tab; nextPutAll: '^ '.
		paths storeOn: aStream. 			
	 ].
	self class compile: methodSource classified: 'stored bookmarks'.
]

{ #category : #'stored bookmarks' }
GTAConfiguration class >> savedBookmarks [
	"Automatically created by class method #saveBookmarks."
	^ ((Array new: 1) at: 1 put: ((Array new: 5) at: 1 put: GTASessionBookmark; at: 2 put: '29d8c44d-c6da-4026-bf49-c3b0c25625db'; at: 3 put: (DateAndTime basicNew instVarAt: 1 put: 72594; instVarAt: 2 put: (Duration seconds: 7200 nanoSeconds: 0); instVarAt: 3 put: 2457117; instVarAt: 4 put: 0; yourself); at: 4 put: 'History and calculator results'; at: 5 put: (DateAndTime basicNew instVarAt: 1 put: 70290; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457156; instVarAt: 4 put: 682694000; yourself); yourself); yourself)
]
