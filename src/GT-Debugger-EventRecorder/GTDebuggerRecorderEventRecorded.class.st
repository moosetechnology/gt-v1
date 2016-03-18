Class {
	#name : #GTDebuggerRecorderEventRecorded,
	#superclass : #Announcement,
	#instVars : [
		'recordedEvent'
	],
	#category : #'GT-Debugger-EventRecorder-Base'
}

{ #category : #'instance creation' }
GTDebuggerRecorderEventRecorded class >> forEvent: aRecorderEvent [
	^ self new
		recordedEvent: aRecorderEvent;
		yourself.
]

{ #category : #accessing }
GTDebuggerRecorderEventRecorded >> recordedEvent [
	^ recordedEvent
]

{ #category : #accessing }
GTDebuggerRecorderEventRecorded >> recordedEvent: aRecorderEvent [
	recordedEvent := aRecorderEvent
]
