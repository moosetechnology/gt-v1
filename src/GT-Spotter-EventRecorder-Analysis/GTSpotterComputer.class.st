Class {
	#name : #GTSpotterComputer,
	#superclass : #GTSpotterEventCollection,
	#traits : 'TGTSpotterDurationView + TGTSpotterSessionsTable',
	#classTraits : 'TGTSpotterDurationView classTrait + TGTSpotterSessionsTable classTrait',
	#category : #'GT-Spotter-EventRecorder-Analysis'
}

{ #category : #'as yet unclassified' }
GTSpotterComputer >> numberOfEvents [
	^ self sum: #size
]

{ #category : #'as yet unclassified' }
GTSpotterComputer >> numberOfPreviews [
	^ self sessionsWithPreview size
]

{ #category : #'as yet unclassified' }
GTSpotterComputer >> sessions [
	^ self
]

{ #category : #'as yet unclassified' }
GTSpotterComputer >> sessionsWithPreview [
	^ self select: #isWithPreview
]

{ #category : #'as yet unclassified' }
GTSpotterComputer >> start [
	self ifEmpty: [ ^ 0 ].
	^ self first start
]

{ #category : #'as yet unclassified' }
GTSpotterComputer >> stop [
	self ifEmpty: [ ^ 0 ].
	^ self first stop
]
