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
	#instVars : [
		'timestamp'
	],
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #initialization }
GTSpotterRecorderExitAnnouncementEvent >> initialize [
	super initialize.
	
	timestamp := Time now asDateAndTime asUnixTime 
]
