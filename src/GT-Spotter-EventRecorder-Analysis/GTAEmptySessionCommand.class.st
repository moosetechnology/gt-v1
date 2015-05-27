Class {
	#name : #GTAEmptySessionCommand,
	#superclass : #GTSpotterAnalysisCommand,
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #execute }
GTAEmptySessionCommand >> clean [
	self session removeIsEmptySession
]

{ #category : #execute }
GTAEmptySessionCommand >> execute [
	| displayed |
	self session ifEmpty: [ ^ self setEmpty ].
	self session last isCloseSpotter ifFalse: [ ^ self ].
	displayed := (self session select: #isForTimelineView).
	displayed size > 2 ifTrue: [ ^ self ].
	self setEmpty.
]

{ #category : #api }
GTAEmptySessionCommand >> setEmpty [
	self session setIsEmptySession
]
