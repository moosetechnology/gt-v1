Class {
	#name : #GLMRecorderBrowserClosingEvent,
	#superclass : #GTDebuggerRecorderEvent,
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #initialization }
GLMRecorderBrowserClosingEvent >> fromAnnouncement: anAnnouncement [
	super fromAnnouncement: anAnnouncement.
	
	self addWindowHashFor: anAnnouncement presentation.
]
