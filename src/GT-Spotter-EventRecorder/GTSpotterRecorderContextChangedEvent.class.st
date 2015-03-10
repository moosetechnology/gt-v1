"
A GTSpotterRecorderContextChangedEvent stores current query written in Spotter input field. This event stores the size of the query and wheather or not the current query is a refinment of a previous query.

Instance Variables
	text:		<String>

text
	- query writen in Spotter input field

"
Class {
	#name : #GTSpotterRecorderContextChangedEvent,
	#superclass : #GTSpotterRecorderEvent,
	#instVars : [
		'isRefinement',
		'currentTextInfo',
		'previousTextInfo'
	],
	#category : #'GT-Spotter-EventRecorder-Events'
}

{ #category : #initialization }
GTSpotterRecorderContextChangedEvent >> fromAnnouncement: anAnnouncement [

	currentTextInfo := self textInfoFrom: anAnnouncement currentText.
	anAnnouncement previousText size == 0 ifTrue: [ ^ self ].
	previousTextInfo := self textInfoFrom: anAnnouncement previousText.
	isRefinement := (anAnnouncement currentText size > anAnnouncement previousText size 
		ifTrue: [ anAnnouncement currentText beginsWith: anAnnouncement previousText]
		ifFalse: [ anAnnouncement previousText beginsWith: anAnnouncement currentText ]).
]

{ #category : #initialization }
GTSpotterRecorderContextChangedEvent >> initialize [
	super initialize.
	isRefinement := false.
]
