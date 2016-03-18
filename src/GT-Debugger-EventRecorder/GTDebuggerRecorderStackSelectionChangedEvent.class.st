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
	
	self infoAt: #methodClass putHashForText: anAnnouncement newContext methodClass name.
	self infoAt: #methodSelector putHashForText: anAnnouncement newContext methodSelector.
	self infoAt: #pc put: anAnnouncement newContext pc.
	self infoAt: #stackPosition put: anAnnouncement newContext stack size.
	self addWindowHashFor: anAnnouncement debugger.
]
