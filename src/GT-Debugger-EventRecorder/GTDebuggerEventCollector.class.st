Class {
	#name : #GTDebuggerEventCollector,
	#superclass : #GTEventCollector,
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #'as yet unclassified' }
GTDebuggerEventCollector >> initialize [
	super initialize.	
	recordedEvents := SharedQueue  new.
	creationTime := DateAndTime now.
]

{ #category : #'as yet unclassified' }
GTDebuggerEventCollector >> linkToDebugger: aDebugger [

	aDebugger announcer weak when: Announcement send: #recordAnnouncement: to: self
]

{ #category : #'as yet unclassified' }
GTDebuggerEventCollector >> recordAnnouncement: anAnnouncement [
	"Privacy sendDiagnosticsAndUsageData ifFalse: [ ^ self ]."	
	(anAnnouncement respondsTo: #asRecorderEvent) ifTrue: [	
		self add: anAnnouncement asRecorderEvent ]
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
