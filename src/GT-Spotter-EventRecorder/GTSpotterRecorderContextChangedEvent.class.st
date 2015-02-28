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
		'text'
	],
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #initialization }
GTSpotterRecorderContextChangedEvent >> fromAnnouncement: anAnnouncement [
	GTSpotterEventRecorderSettings uniqueInstance sendSearchQuery ifFalse: [ ^ self ].
	text := anAnnouncement text
]
