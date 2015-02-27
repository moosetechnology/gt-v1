"
A GTSpotterRecorderOpenEvent  models the action of  opening Spotter.

Instance Variables
	timestamp:		<Object>

timestamp
	- xxxxx

"
Class {
	#name : #GTSpotterRecorderOpenEvent,
	#superclass : #GTSpotterRecorderEvent,
	#instVars : [
		'timestamp'
	],
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #initialization }
GTSpotterRecorderOpenEvent >> initialize [
	super initialize.
	
	timestamp := Time now asDateAndTime asUnixTime 
]
