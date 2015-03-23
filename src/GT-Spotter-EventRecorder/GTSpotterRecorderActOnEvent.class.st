"
A GTSpotterRecorderActOnEvent models the action of pressing enter (or double clicking) on an element.

"
Class {
	#name : #GTSpotterRecorderActOnEvent,
	#superclass : #GTSpotterRecorderEvent,
	#category : #'GT-Spotter-EventRecorder-Events'
}

{ #category : #initialization }
GTSpotterRecorderActOnEvent >> fromAnnouncement: anAnnouncement [
	super fromAnnouncement: anAnnouncement.
	self infoAt: #eventType put: anAnnouncement eventType.
	self infoAt: #elementName putHashForText: anAnnouncement element asString.
	self infoAt: #elementType putHashForText: anAnnouncement element class name asString.
]
