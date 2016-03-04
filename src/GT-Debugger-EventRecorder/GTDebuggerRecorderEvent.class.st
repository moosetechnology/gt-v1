Class {
	#name : #GTDebuggerRecorderEvent,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'info',
		'changesContext'
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

{ #category : #testing }
GTDebuggerRecorderEvent >> changesContext [
	^ changesContext
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

{ #category : #testing }
GTDebuggerRecorderEvent >> isActionForClass: aClassName Method: aMethodName PC: anInteger [
	((self infoAt: #methodClass) == aClassName) ifFalse: [ ^ false ].
	((self infoAt: #methodSelector) == aMethodName) ifFalse: [ ^ false ].
	((self infoAt: #pc) == anInteger) ifFalse: [ ^ false ].
	^ true.
]
