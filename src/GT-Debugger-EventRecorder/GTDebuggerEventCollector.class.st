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
	"Privacy sendDiagnosticsAndUsageData ifFalse: [ ^ self ]."	
	self add: (GTDebuggerRecorderOpenEvent new fromDebugger: aDebugger)
]

{ #category : #'as yet unclassified' }
GTDebuggerEventCollector >> runDebugActionsIn: aDebugger [
	| action event events |
	
	events := recordedEvents copy.
	[events isEmpty] whileFalse: [
		event := events next.
		(event class == GTDebuggerDebugActionEvent) ifTrue: [
			action := event asDebugActionFor: aDebugger.
			(action isNil or: [action class == RedoDebugAction]) ifFalse: [
				action executeAction.
				aDebugger updateBrowser
			].
		].
	].
	
]
