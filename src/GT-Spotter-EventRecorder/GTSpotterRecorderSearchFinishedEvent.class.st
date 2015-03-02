"
A GTSpotterRecorderSearchFinishedEvent is triggered when spotter finished a search and displayed all the results. This event stores the size of the query.

"
Class {
	#name : #GTSpotterRecorderSearchFinishedEvent,
	#superclass : #GTSpotterRecorderEvent,
	#instVars : [
		'querySize'
	],
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #initialization }
GTSpotterRecorderSearchFinishedEvent >> fromAnnouncement: anAnnouncement [

	querySize := anAnnouncement query ifNil: [ 0 ]  ifNotNil: [ :aString | aString size]
]
