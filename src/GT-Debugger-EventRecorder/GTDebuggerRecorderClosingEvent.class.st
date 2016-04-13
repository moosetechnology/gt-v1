"
I model the action of closing the debugger.
"
Class {
	#name : #GTDebuggerRecorderClosingEvent,
	#superclass : #GTDebuggerRecorderEvent,
	#category : #'GT-Debugger-EventRecorder-Events'
}

{ #category : #initialization }
GTDebuggerRecorderClosingEvent >> fromAnnouncement: anAnnouncement [
	super fromAnnouncement: anAnnouncement.
	
	self addWindowHashFor: anAnnouncement presentation.
]

{ #category : #testing }
GTDebuggerRecorderClosingEvent >> isCloseDebugger [
	^ true
]

{ #category : #accessing }
GTDebuggerRecorderClosingEvent >> windowHash [
	^ self infoAt: #windowHash
]
