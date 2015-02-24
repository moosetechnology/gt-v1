Class {
	#name : #GTSpotterRecorderEvent,
	#superclass : #Object,
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #'as yet unclassified' }
GTSpotterRecorderEvent class >> eventCode [

	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
GTSpotterRecorderEvent class >> fromAnnouncement: anAnnouncement [

	^ self new fromAnnouncement: anAnnouncement
]

{ #category : #'as yet unclassified' }
GTSpotterRecorderEvent >> asRecordedData [

	^ self "class eventCode"
]

{ #category : #initialization }
GTSpotterRecorderEvent >> fromAnnouncement: anAnnouncement [

	
]
