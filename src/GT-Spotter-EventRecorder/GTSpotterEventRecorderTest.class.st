"
A GTSpotterEventRecorderTest is a test class for testing the behavior of GTSpotterEventRecorder
"
Class {
	#name : #GTSpotterEventRecorderTest,
	#superclass : #TestCase,
	#instVars : [
		'recorder'
	],
	#category : #'GT-Spotter-EventRecorder-Tests'
}

{ #category : #'as yet unclassified' }
GTSpotterEventRecorderTest >> recordedData [
	^ GTSpotterRecorderEvent allSubclasses collect: #new
]

{ #category : #'as yet unclassified' }
GTSpotterEventRecorderTest >> setUp [
	super setUp.
	recorder := GTSpotterEventRecorder new.
	recorder stopDelivering.
]

{ #category : #'as yet unclassified' }
GTSpotterEventRecorderTest >> testSerializedAnnouncementFrom [
	| byteArray announcement |
	byteArray := recorder serializedAnnouncementFrom: self recordedData.
	announcement := recorder materializedAnnouncementFrom: byteArray.
	self assert: announcement class equals: GTSpotterRecorderDataAnnouncement.
	self assert: announcement materializedData isCollection.
	self assert: announcement materializedData size equals: self recordedData size.
]
