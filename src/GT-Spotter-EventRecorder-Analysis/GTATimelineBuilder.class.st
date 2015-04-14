Class {
	#name : #GTATimelineBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'events',
		'elements',
		'eventAnalyzer',
		'eventFilter',
		'analyze',
		'edges',
		'edgeShapeBuilder',
		'withEdges'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #api }
GTATimelineBuilder class >> viewOn: objects [
	| instance |
	instance := self new.
	instance
		events: objects;
		withEdges.
	instance interaction
		popupText: #asEventAnalysisString;
		draggable.
	^ instance
		build;
		view
]

{ #category : #configuration }
GTATimelineBuilder >> analyze [
	analyze := true
]

{ #category : #private }
GTATimelineBuilder >> analyzeEvents [
	self eventAnalyzer analyze: self events
]

{ #category : #private }
GTATimelineBuilder >> analyzeEventsIfRequested [
	analyze ifTrue: [ self analyzeEvents ]
]

{ #category : #private }
GTATimelineBuilder >> buildEdgesIfRequested [
	| size |
	withEdges ifFalse: [ ^ #() ].
	size := self elements size.
	size < 2 ifTrue: [ ^ #() ].
	self shape line withHorizontalAttachPoint; width: 2.
	self elements withIndexDo: [ :element :index |
		index < size ifTrue: [
			self edgeFrom: element to: (self elements at: index + 1) ]
	]
]

{ #category : #private }
GTATimelineBuilder >> buildElements [
	| visibleEvents |
	visibleEvents := self visibleEvents.
	elements := self elementsWithInteractionOn: visibleEvents.

]

{ #category : #hooks }
GTATimelineBuilder >> createShapeBuilder [
	^ super createShapeBuilder event; yourself
]

{ #category : #hooks }
GTATimelineBuilder >> createView [
	^ super createView @ RTDraggableView @ RTZoomableView.
]

{ #category : #public }
GTATimelineBuilder >> edgeFrom: source to: target [ 
	"source and target are elements"
	| newEdge |
	newEdge := self edgeShapeBuilder edgeFrom: source to: target.
	view add: newEdge.
	^ newEdge
]

{ #category : #accessing }
GTATimelineBuilder >> edgeShapeBuilder [
	^ edgeShapeBuilder ifNil: [ edgeShapeBuilder := self newEdgeShapeBuilder ]
]

{ #category : #accessing }
GTATimelineBuilder >> elements [
	elements ifNil: [ self buildElements ].
	^ elements
]

{ #category : #accessing }
GTATimelineBuilder >> eventAnalyzer [
	^ eventAnalyzer ifNil: [ eventAnalyzer := self newEventAnalyzer ]
]

{ #category : #accessing }
GTATimelineBuilder >> eventFilter [
	^ eventFilter ifNil: [ eventFilter := self newEventFilter ]
]

{ #category : #accessing }
GTATimelineBuilder >> events [
	^ events
]

{ #category : #accessing }
GTATimelineBuilder >> events: aCollection [ 
	events := aCollection
]

{ #category : #initialization }
GTATimelineBuilder >> initialize [
	super initialize.
	analyze := false.
	withEdges := false.
]

{ #category : #accessing }
GTATimelineBuilder >> layout [
	^ layoutBuilder ifNil: [ layoutBuilder := self newLayoutBuilder ]
]

{ #category : #accessing }
GTATimelineBuilder >> layout: aLayout [
	^ layoutBuilder := aLayout
]

{ #category : #private }
GTATimelineBuilder >> layoutElements [
	self layoutElements: self elements
]

{ #category : #private }
GTATimelineBuilder >> layoutElements: aCollection [ 
	self layout on: aCollection 
]

{ #category : #'instance creation' }
GTATimelineBuilder >> newEdgeShapeBuilder [
	^ self createShapeBuilder
		line;
		horizontalAttachPoint; 
		width: 2;
		yourself
]

{ #category : #'instance creation' }
GTATimelineBuilder >> newEventAnalyzer [
	^ GTSpotterSessionAnalysis new
]

{ #category : #'instance creation' }
GTATimelineBuilder >> newEventFilter [
	^ [ :session | session select: #isForTimelineView ]
]

{ #category : #'instance creation' }
GTATimelineBuilder >> newLayoutBuilder [
	^ GTAHorizontalDivingLineLayout new center; yourself
]

{ #category : #hooks }
GTATimelineBuilder >> renderIn: aView [
	self analyzeEventsIfRequested.
	aView addAll: self elements.
	self buildEdgesIfRequested.
	self layoutElements.
]

{ #category : #enumerating }
GTATimelineBuilder >> visibleEvents [
	^ self eventFilter cull: self events cull: self
]

{ #category : #configuration }
GTATimelineBuilder >> withEdges [
	withEdges := true
]
