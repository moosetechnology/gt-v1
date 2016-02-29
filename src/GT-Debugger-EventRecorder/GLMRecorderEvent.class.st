Class {
	#name : #GLMRecorderEvent,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'info'
	],
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #'as yet unclassified' }
GLMRecorderEvent >> fromAnnouncement: anAnnouncement [

]

{ #category : #'as yet unclassified' }
GLMRecorderEvent >> infoAt: key put: value [
	info ifNil: [ info := Dictionary new ].
	^ info at: key put: value
]
