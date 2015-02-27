Class {
	#name : #GTSpotterRecorderContextChangedEvent,
	#superclass : #GTSpotterRecorderEvent,
	#instVars : [
		'text'
	],
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #'as yet unclassified' }
GTSpotterRecorderContextChangedEvent class >> eventCode [

	^ 11
]

{ #category : #initialization }
GTSpotterRecorderContextChangedEvent >> fromAnnouncement: anAnnouncement [
	text := anAnnouncement text
]
