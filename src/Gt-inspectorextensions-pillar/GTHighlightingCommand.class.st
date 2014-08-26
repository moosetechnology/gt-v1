Class {
	#name : #GTHighlightingCommand,
	#superclass : #Object,
	#instVars : [
		'start',
		'stop'
	],
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #accessing }
GTHighlightingCommand >> start [
	^ start
]

{ #category : #accessing }
GTHighlightingCommand >> start: anObject [
	start := anObject
]

{ #category : #accessing }
GTHighlightingCommand >> stop [
	^ stop
]

{ #category : #accessing }
GTHighlightingCommand >> stop: anObject [
	stop := anObject
]
