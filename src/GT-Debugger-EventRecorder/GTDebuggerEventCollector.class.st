Class {
	#name : #GTDebuggerEventCollector,
	#superclass : #GTEventCollector,
	#instVars : [
		'announcer'
	],
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #initialization }
GTDebuggerEventCollector >> initialize [
	super initialize.	
	recordedEvents := SharedQueue  new.
]

{ #category : #initialization }
GTDebuggerEventCollector >> linkToDebugger: aDebugger [

	aDebugger announcer weak when: Announcement send: #recordAnnouncement: to: self
]

{ #category : #'as yet unclassified' }
GTDebuggerEventCollector >> recordAnnouncement: anAnnouncement [
	| event |
	"Privacy sendDiagnosticsAndUsageData ifFalse: [ ^ self ]."	
	(anAnnouncement respondsTo: #asRecorderEvent) ifTrue: [	
		event := anAnnouncement asRecorderEvent.
		self add: event.
		GTEventRecorder uniqueInstance announcer announce: (DebuggerEventRecorded forEvent: event). ]
]

{ #category : #'as yet unclassified' }
GTDebuggerEventCollector >> recordDebuggerOpenEventFor: aDebugger [
	| event |
	"Privacy sendDiagnosticsAndUsageData ifFalse: [ ^ self ]."	
	event := GTDebuggerRecorderOpenEvent new fromDebugger: aDebugger.
	self add: event.
	GTEventRecorder uniqueInstance announcer announce: (DebuggerEventRecorded forEvent: event).
]
