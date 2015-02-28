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
		'querySize',
		'isRefinement'
	],
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #initialization }
GTSpotterRecorderContextChangedEvent >> fromAnnouncement: anAnnouncement [

	querySize := anAnnouncement currentText size.
	anAnnouncement previousText size == 0 ifTrue: [ ^ self ].
	isRefinement := (anAnnouncement currentText size > anAnnouncement previousText size 
		ifTrue: [ anAnnouncement currentText beginsWith: anAnnouncement previousText]
		ifFalse: [ anAnnouncement previousText beginsWith: anAnnouncement currentText ]).
]

{ #category : #initialization }
GTSpotterRecorderContextChangedEvent >> initialize [
	super initialize.
	isRefinement := false.
]
