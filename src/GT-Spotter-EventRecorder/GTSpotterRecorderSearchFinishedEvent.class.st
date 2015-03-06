"
A GTSpotterRecorderSearchFinishedEvent is triggered when spotter finished a search and displayed all the results. This event stores the size of the query.

"
Class {
	#name : #GTSpotterRecorderSearchFinishedEvent,
	#superclass : #GTSpotterRecorderEvent,
	#instVars : [
		'query',
		'processors'
	],
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #initialization }
GTSpotterRecorderSearchFinishedEvent >> fromAnnouncement: anAnnouncement [
	query := self textInfoFrom: anAnnouncement query.
	processors := (anAnnouncement processors flatCollect: [ :eachProcessor |
		Array 
			with: eachProcessor title
			with: eachProcessor allFilteredCandidates size ]) asArray
]
