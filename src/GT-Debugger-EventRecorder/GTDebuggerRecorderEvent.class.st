Class {
	#name : #GTDebuggerRecorderEvent,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'info'
	],
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #'instance creation' }
GTDebuggerRecorderEvent class >> fromAnnouncement: anAnnouncement [

	^ self new fromAnnouncement: anAnnouncement
]

{ #category : #'as yet unclassified' }
GTDebuggerRecorderEvent >> addWindowHashFor: aPresentation [

	aPresentation window ifNotNil: [ :aWindow |
		self infoAt: #windowHash put: aWindow identityHash ]
]

{ #category : #initialization }
GTDebuggerRecorderEvent >> fromAnnouncement: anAnnouncement [

]

{ #category : #accessing }
GTDebuggerRecorderEvent >> infoAt: aSymbol [
	^ info at: aSymbol
]

{ #category : #accessing }
GTDebuggerRecorderEvent >> infoAt: key put: value [
	info ifNil: [ info := Dictionary new ].
	^ info at: key put: value
]

{ #category : #initialization }
GTDebuggerRecorderEvent >> initialize [
	super initialize.
	timestamp := DateAndTime now.
]

{ #category : #accessing }
GTDebuggerRecorderEvent >> timestamp [
	^ timestamp
]
