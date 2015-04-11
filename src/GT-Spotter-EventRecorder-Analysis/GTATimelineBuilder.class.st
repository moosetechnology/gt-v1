Class {
	#name : #GTATimelineBuilder,
	#superclass : #Object,
	#instVars : [
		'data',
		'view'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #api }
GTATimelineBuilder class >> viewOn: objects [
	^ self new
			data: objects;
			build;
			view
]

{ #category : #building }
GTATimelineBuilder >> build [
	| previousElement edges icons elements visibleData levels shape element |
	view := RTView new.
	view @ RTDraggableView.
	icons := GTATimelineIconBuilder new.
	edges := RTGroup new.
	visibleData := self visibleData.
	previousElement := nil.
	elements := visibleData collect: [ :event |
		shape := icons shapeFor: event.
		element := shape elementOn: event.
		previousElement ifNotNil: [ 
			edges add: (RTLine edgeFrom: previousElement to: element) ].
		previousElement := element.
		element ] as: RTGroup.
	levels := visibleData deepestDiveIn.
	elements @ RTDraggable @ (RTPopup text: #asEventAnalysisString).
	"RTGridLayout on: elements."
	RTHorizontalLineLayout on: elements.
	RTMetricNormalizer new
		elements: elements;
"		normalizeX: [ :eachEvent | self xFor: eachEvent ] min: 0 max: 500;
"		normalizeY: [ :eachEvent | self yFor: eachEvent ] min: 0 max: (levels * 5).
	view addAll: elements; addAll: edges.
	view .
]

{ #category : #accessing }
GTATimelineBuilder >> data [
	^ data
]

{ #category : #accessing }
GTATimelineBuilder >> data: anObject [
	data := anObject
]

{ #category : #accessing }
GTATimelineBuilder >> view [
	^ view
]

{ #category : #accessing }
GTATimelineBuilder >> view: anObject [
	view := anObject
]

{ #category : #enumerating }
GTATimelineBuilder >> visibleData [
	^ self data select: #isForTimelineView
]

{ #category : #accessing }
GTATimelineBuilder >> xFor: aSpotterEvent [
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
GTATimelineBuilder >> yFor: aSpotterEvent [
	^ aSpotterEvent diveInLevel
]
