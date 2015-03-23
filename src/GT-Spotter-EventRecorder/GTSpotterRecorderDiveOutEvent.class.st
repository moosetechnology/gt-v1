"
A GTSpotterRecorderDiveOutEvent  models the action of  diving out a step.

"
Class {
	#name : #GTSpotterRecorderDiveOutEvent,
	#superclass : #GTSpotterRecorderEvent,
	#category : #'GT-Spotter-EventRecorder-Events'
}

{ #category : #initialization }
GTSpotterRecorderDiveOutEvent >> fromAnnouncement: anAnnouncement [
	super fromAnnouncement: anAnnouncement.
	self infoAt: #elementName putHashForText: anAnnouncement element asString.
	self infoAt: #elementType putHashForText: anAnnouncement element class name asString.
]
