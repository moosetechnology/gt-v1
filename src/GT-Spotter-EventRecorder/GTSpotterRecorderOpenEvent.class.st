Class {
	#name : #GTSpotterRecorderOpenEvent,
	#superclass : #GTSpotterRecorderEvent,
	#instVars : [
		'timestamp'
	],
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #'as yet unclassified' }
GTSpotterRecorderOpenEvent class >> eventCode [

	^ 9
]

{ #category : #'as yet unclassified' }
GTSpotterRecorderOpenEvent >> asRecordedData [

	^ self
]

{ #category : #'as yet unclassified' }
GTSpotterRecorderOpenEvent >> initialize [
	super initialize.
	
	timestamp := Time now asDateAndTime asUnixTime 
]
