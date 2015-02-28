"
A GTSpotterRecorderSearchFinishedEvent is triggered when spotter finished a search and displayed all the results.

"
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

	querySize := anAnnouncement query ifNil: [ 0 ]  ifNotNil: [ :aString | aString size]
]
