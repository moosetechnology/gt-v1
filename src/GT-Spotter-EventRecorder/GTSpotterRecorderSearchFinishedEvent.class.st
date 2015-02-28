Class {
	#name : #GTSpotterRecorderSearchFinishedEvent,
	#superclass : #GTSpotterRecorderEvent,
	#instVars : [
		'querySize'
	],
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #'as yet unclassified' }
GTSpotterRecorderSearchFinishedEvent >> fromAnnouncement: anAnnouncement [

	querySize := anAnnouncement query size
]
