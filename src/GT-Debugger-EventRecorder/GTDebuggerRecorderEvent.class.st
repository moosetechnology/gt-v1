Class {
	#name : #GTDebuggerRecorderEvent,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'info'
	],
	#category : #'GT-Debugger-EventRecorder-Events'
}

{ #category : #'instance creation' }
GTDebuggerRecorderEvent class >> fromAnnouncement: anAnnouncement [

	^ self new fromAnnouncement: anAnnouncement
]

{ #category : #accessing }
GTDebuggerRecorderEvent >> addWindowHashFor: aPresentation [

	aPresentation window ifNotNil: [ :aWindow |
		self infoAt: #windowHash put: aWindow identityHash ]
]

{ #category : #initialization }
GTDebuggerRecorderEvent >> fromAnnouncement: anAnnouncement [

]

{ #category : #accessing }
GTDebuggerRecorderEvent >> hashForText: aString [
	^ self settings obfuscateIfNecessary: aString
]

{ #category : #accessing }
GTDebuggerRecorderEvent >> infoAt: aSymbol [
	^ info at: aSymbol
]

{ #category : #accessing }
GTDebuggerRecorderEvent >> infoAt: key ifAbsent: absentBlock [
	info ifNil: [ ^ absentBlock value].
	^ info at: key ifAbsent: absentBlock
]

{ #category : #accessing }
GTDebuggerRecorderEvent >> infoAt: key ifAbsentPut: putBlock [
	info ifNil: [ info := Dictionary new ].
	^ info at: key ifAbsentPut: putBlock
]

{ #category : #accessing }
GTDebuggerRecorderEvent >> infoAt: key ifPresent: presentBlock ifAbsent: absentBlock [
	info ifNil: [ ^ absentBlock value].
	^ info at: key ifPresent: presentBlock ifAbsent: absentBlock
]

{ #category : #accessing }
GTDebuggerRecorderEvent >> infoAt: key put: value [
	info ifNil: [ info := Dictionary new ].
	^ info at: key put: value
]

{ #category : #accessing }
GTDebuggerRecorderEvent >> infoAt: key putHashForText: valueString [ 
	^ self 
		infoAt: key 
		put: (self hashForText: valueString)
]

{ #category : #initialization }
GTDebuggerRecorderEvent >> initialize [
	super initialize.
	timestamp := DateAndTime now.
]

{ #category : #initialization }
GTDebuggerRecorderEvent >> initializeObfuscated [
	self obfuscated: Privacy sendEntityNames not.
]

{ #category : #accessing }
GTDebuggerRecorderEvent >> obfuscated [
	^ self infoAt: #obfuscated ifAbsent: true
]

{ #category : #accessing }
GTDebuggerRecorderEvent >> obfuscated: aBoolean [
	^ self infoAt: #obfuscated put: aBoolean
]

{ #category : #accessing }
GTDebuggerRecorderEvent >> settings [
	^ GlobalIdentifier uniqueInstance
]

{ #category : #accessing }
GTDebuggerRecorderEvent >> timestamp [
	^ timestamp
]
