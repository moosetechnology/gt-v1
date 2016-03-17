Class {
	#name : #GTGenericStackDebuggerSelectionChangedEvent,
	#superclass : #GTDebuggerRecorderEvent,
	#instVars : [
		'debugger',
		'newContext'
	],
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #initialization }
GTGenericStackDebuggerSelectionChangedEvent >> fromAnnouncement: anAnnouncement [
	super fromAnnouncement: anAnnouncement.
	
	self infoAt: #newContext putHashForText: anAnnouncement newContext asString.
	self addWindowHashFor: anAnnouncement debugger.
]
