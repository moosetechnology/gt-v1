"
A GTSpotterEventRecorderSendUsageDataChanged informs about changes of sendUsageData settings.

Instance Variables
	newValue:		<Boolean>

newValue
	- the value of current sendUsageData settings

"
Class {
	#name : #GTSpotterEventRecorderSendUsageDataChanged,
	#superclass : #Announcement,
	#instVars : [
		'newValue'
	],
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #accessing }
GTSpotterEventRecorderSendUsageDataChanged >> newValue [
	^ newValue
]

{ #category : #accessing }
GTSpotterEventRecorderSendUsageDataChanged >> newValue: anObject [
	newValue := anObject
]
