Class {
	#name : #GTSpotterTimeline,
	#superclass : #Object,
	#instVars : [
		'data',
		'view'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Support'
}

{ #category : #api }
GTSpotterTimeline class >> viewOn: objects [
	^ self new
			data: objects;
			build;
			view
]

{ #category : #building }
GTSpotterTimeline >> build [
	| shape elements visibleData levels |
	view := RTView new.
	shape := RTBitmap new.
	shape form: #analysisIcon.
	visibleData := self visibleData.
	levels := visibleData deepestDiveIn.
	elements := shape elementsOn: visibleData.
	elements @ RTDraggable @ (RTPopup text: #asEventAnalysisString).
	"RTGridLayout on: elements."
	RTMetricNormalizer new
		elements: elements;
		normalizeX: [ :eachEvent | self xFor: eachEvent ] min: 0 max: 500;
		normalizeY: [ :eachEvent | self yFor: eachEvent ] min: 0 max: (levels * 4).
	view addAll: elements.
]

{ #category : #accessing }
GTSpotterTimeline >> data [
	^ data
]

{ #category : #accessing }
GTSpotterTimeline >> data: anObject [
	data := anObject
]

{ #category : #accessing }
GTSpotterTimeline >> view [
	^ view
]

{ #category : #accessing }
GTSpotterTimeline >> view: anObject [
	view := anObject
]

{ #category : #enumerating }
GTSpotterTimeline >> visibleData [
	^ self data select: #isForTimelineView
]

{ #category : #accessing }
GTSpotterTimeline >> xFor: aSpotterEvent [
	| currentTimeStamp index events nextTimestamp duration relIndex relDuration xPosition |
	aSpotterEvent relativeXPosition ifNotNil: [ :value | ^ value ].
	currentTimeStamp := aSpotterEvent timestampWithFixedTimeZone.
	index := aSpotterEvent myPositionAmongSameTimeEvents - 1.
	events := aSpotterEvent sameTimeEvents size.
	events < 2 ifTrue: [ 
		aSpotterEvent relativeXPosition: currentTimeStamp. 
		^ currentTimeStamp ].
	relIndex := index / events.
	nextTimestamp := aSpotterEvent followingDifferentTime.
	duration := nextTimestamp - currentTimeStamp / 2.
	relDuration := duration * relIndex.
	xPosition := currentTimeStamp + relDuration.
	aSpotterEvent relativeXPosition: xPosition.
	^ xPosition
]

{ #category : #accessing }
GTSpotterTimeline >> yFor: aSpotterEvent [
	^ aSpotterEvent diveInLevel
]
