"
A GTSpotterRecorderContextChangedEvent stores current query written in Spotter input field.

Instance Variables
	text:		<String>

text
	- query writen in Spotter input field

"
Class {
	#name : #GTSpotterRecorderContextChangedEvent,
	#superclass : #GTSpotterRecorderEvent,
	#instVars : [
		'text',
		'querySize',
		'isRefinement',
		'timestamp'
	],
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #initialization }
GTSpotterRecorderContextChangedEvent >> fromAnnouncement: anAnnouncement [

	GTSpotterEventRecorderSettings uniqueInstance sendSearchQuery 
		ifTrue: [ text := anAnnouncement text. ^ self ].
	querySize := anAnnouncement text size.
	anAnnouncement previousQuery size == 0 ifTrue: [ ^ self ].
	isRefinement := (anAnnouncement text size > anAnnouncement previousQuery size 
		ifTrue: [ anAnnouncement text asString beginsWith: anAnnouncement previousQuery asString]
		ifFalse: [ anAnnouncement previousQuery asString beginsWith: anAnnouncement text asString ]).
]

{ #category : #initialization }
GTSpotterRecorderContextChangedEvent >> initialize [
	super initialize.
	isRefinement := false.
	timestamp := Time now asDateAndTime asUnixTime 
]
