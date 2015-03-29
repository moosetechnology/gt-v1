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
	#category : #'GT-Spotter-EventRecorder-Events'
}

{ #category : #testing }
GTSpotterRecorderOpenEvent >> isOpenSpotter [
	^ true
]
