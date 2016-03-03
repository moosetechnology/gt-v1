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

{ #category : #'as yet unclassified' }
GLMRecorderEvent >> infoAt: aSymbol [
	^ info at: aSymbol
]

{ #category : #'as yet unclassified' }
GLMRecorderEvent >> infoAt: key put: value [
	info ifNil: [ info := Dictionary new ].
	^ info at: key put: value
]
