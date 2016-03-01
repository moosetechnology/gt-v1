Class {
	#name : #DebuggerEventRecorded,
	#superclass : #Announcement,
	#instVars : [
		'recordedEvent'
	],
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #'instance creation' }
DebuggerEventRecorded class >> forEvent: aRecorderEvent [
	^ self new
		recordedEvent: aRecorderEvent;
		yourself.
]

{ #category : #accessing }
DebuggerEventRecorded >> recordedEvent [
	^ recordedEvent
]

{ #category : #accessing }
DebuggerEventRecorded >> recordedEvent: aRecorderEvent [
	recordedEvent := aRecorderEvent
]
