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

{ #category : #testing }
GTSpotterRecorderExitAnnouncementEvent class >> shouldIgnoreAnnouncement: anAnnouncement [
	^ anAnnouncement eventType = #unknown
]

{ #category : #accessing }
GTSpotterRecorderExitAnnouncementEvent >> eventType [
	^ self infoAt: #eventType
]

{ #category : #initialization }
GTSpotterRecorderExitAnnouncementEvent >> fromAnnouncement: anAnnouncement [
	super fromAnnouncement: anAnnouncement.
	self infoAt: #eventType put: anAnnouncement eventType.


]

{ #category : #testing }
GTSpotterRecorderExitAnnouncementEvent >> isExit [
	^ true
]
