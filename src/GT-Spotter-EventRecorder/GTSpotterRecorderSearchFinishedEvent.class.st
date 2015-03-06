"
A GTSpotterRecorderSearchFinishedEvent is triggered when spotter finished a search and displayed all the results. This event stores the size of the query.

"
Class {
	#name : #GTSpotterRecorderSearchFinishedEvent,
	#superclass : #GTSpotterRecorderEvent,
	#instVars : [
		'query'
	],
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #initialization }
GTSpotterRecorderSearchFinishedEvent >> fromAnnouncement: anAnnouncement [
	anAnnouncement query ifNil: [ ^ self ].
	query := self textInfoFrom: anAnnouncement query.
]
