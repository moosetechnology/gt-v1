"
I model the action of changing the selection in the stack pane of the debugger.
"
Class {
	#name : #GTDebuggerRecorderStackSelectionChangedEvent,
	#superclass : #GTDebuggerRecorderEvent,
	#instVars : [
		'debugger',
		'newContext'
	],
	#category : #'GT-Debugger-EventRecorder-Events'
}

{ #category : #initialization }
GTDebuggerRecorderStackSelectionChangedEvent >> fromAnnouncement: anAnnouncement [
	super fromAnnouncement: anAnnouncement.
	
	self infoAt: #newContext putHashForText: anAnnouncement newContext asString.
	self addWindowHashFor: anAnnouncement debugger.
]
