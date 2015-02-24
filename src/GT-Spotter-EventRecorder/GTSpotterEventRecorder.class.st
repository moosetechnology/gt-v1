Class {
	#name : #GTSpotterEventRecorder,
	#superclass : #Object,
	#instVars : [
		'recordedData'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #'as yet unclassified' }
GTSpotterEventRecorder class >> instance [

	^ instance ifNil: [ instance := self new ]
]

{ #category : #'as yet unclassified' }
GTSpotterEventRecorder class >> reset [
	instance := nil
]

{ #category : #accessing }
GTSpotterEventRecorder >> eventClassNameFor: aSpotterAnnouncementClass [

	^  'GTSpotterRecorder', 
		(aSpotterAnnouncementClass name 
			copyFrom: 'GTSpotter' size + 1
			to: aSpotterAnnouncementClass name size), 
		'Event'.
 	
		

]

{ #category : #initialization }
GTSpotterEventRecorder >> initialize [
	super initialize.
	
	recordedData := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
GTSpotterEventRecorder >> initiateDataDelivery [
]

{ #category : #initialization }
GTSpotterEventRecorder >> linkToSpotter: aSpotterModel [

	aSpotterModel announcer when: Announcement send: #recordAccouncement: to: self
]

{ #category : #events }
GTSpotterEventRecorder >> recordAccouncement: anAnnouncement [
	| recorderEventClassName |
	
	recorderEventClassName := self eventClassNameFor: anAnnouncement class.
	(Smalltalk hasClassNamed: recorderEventClassName) ifFalse: [ ^ false ].
	
	self storeEvent: (recorderEventClassName asClass fromAnnouncement: anAnnouncement)

	
 	
		

]

{ #category : #events }
GTSpotterEventRecorder >> recordSpotterOpenEvent [

	self storeEvent: GTSpotterRecorderOpenEvent new
]

{ #category : #events }
GTSpotterEventRecorder >> storeEvent: anEvent [

	recordedData add: anEvent asRecordedData
]
