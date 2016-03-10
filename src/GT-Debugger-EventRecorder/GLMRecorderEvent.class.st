Class {
	#name : #GLMRecorderEvent,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'info'
	],
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #initialization }
GLMRecorderEvent >> fromAnnouncement: anAnnouncement [

]

{ #category : #accessing }
GLMRecorderEvent >> infoAt: aSymbol [
	^ info at: aSymbol
]

{ #category : #accessing }
GLMRecorderEvent >> infoAt: key put: value [
	info ifNil: [ info := Dictionary new ].
	^ info at: key put: value
]

{ #category : #initialization }
GLMRecorderEvent >> initialize [
	super initialize.
	timestamp := DateAndTime now.
]

{ #category : #accessing }
GLMRecorderEvent >> timestamp [
	^ timestamp
]
