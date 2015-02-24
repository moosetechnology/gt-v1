Class {
	#name : #GTSpotterRecorderExitAnnouncementEvent,
	#superclass : #GTSpotterRecorderEvent,
	#instVars : [
		'timestamp'
	],
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #'as yet unclassified' }
GTSpotterRecorderExitAnnouncementEvent class >> eventCode [

	^ 7
]

{ #category : #'as yet unclassified' }
GTSpotterRecorderExitAnnouncementEvent >> asRecordedData [

	^ self
]

{ #category : #'as yet unclassified' }
GTSpotterRecorderExitAnnouncementEvent >> initialize [
	super initialize.
	
	timestamp := Time now asDateAndTime asUnixTime 
]
