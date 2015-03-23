"
A GTSpotterRecorderExitAnnouncementEvent  models the action of  exiting Spotter. 

Instance Variables
	timestamp:		<Object>

timestamp
	- xxxxx

"
Class {
	#name : #GTSpotterRecorderExitAnnouncementEvent,
	#superclass : #GTSpotterRecorderEvent,
	#category : #'GT-Spotter-EventRecorder-Events'
}

{ #category : #initialization }
GTSpotterRecorderExitAnnouncementEvent >> fromAnnouncement: anAnnouncement [
	super fromAnnouncement: anAnnouncement.
	self infoAt: #eventType put: anAnnouncement eventType.


]
