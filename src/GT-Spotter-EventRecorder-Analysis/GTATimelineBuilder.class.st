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

{ #category : #adding }
GTATimelineBuilder >> addEdges [
	self edges ifNotEmpty: [ ^ self ].
	self buildEdges.
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
GTATimelineBuilder >> buildEdges [
	| size |
	size := self elements size.
	size < 2
		ifTrue: [ ^ #() ].
	self elements
		withIndexDo: [ :element :index | 
			index < size
				ifTrue: [ self edgeFrom: element to: (self elements at: index + 1) ] ].
	^ self edges
]

{ #category : #private }
GTATimelineBuilder >> buildEdgesIfRequested [
	withEdges
		ifFalse: [ ^ #() ].
	^ self buildEdges
]

{ #category : #private }
GTATimelineBuilder >> buildElements [
	| visibleEvents |
	visibleEvents := self visibleEvents.
	elements := self elementsWithInteractionOn: visibleEvents.

]

{ #category : #accessing }
GTATimelineBuilder >> configuration: aGTADefaultTimelineConfiguration [ 
	aGTADefaultTimelineConfiguration configure: self
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
	edges add: newEdge.
	^ newEdge
]

{ #category : #accessing }
GTATimelineBuilder >> edgeShapeBuilder [
	^ edgeShapeBuilder ifNil: [ edgeShapeBuilder := self newEdgeShapeBuilder ]
]

{ #category : #accessing }
GTATimelineBuilder >> edges [
	^ edges
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
	edges := OrderedCollection new.
	analyze := false.
	withEdges := false.
]

{ #category : #testing }
GTATimelineBuilder >> isWithEdges [
	^ withEdges 
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

{ #category : #configuration }
GTATimelineBuilder >> logicalLayout [
	^ self layout: GTAHorizontalDivingLineLayout new
]

{ #category : #'instance creation' }
GTATimelineBuilder >> newEdgeShapeBuilder [
	^ self createShapeBuilder
		line;
		horizontalAttachPoint; 
		width: 1;
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

{ #category : #configuration }
GTATimelineBuilder >> realLayout [
	^ self layout: GTAHorizontalRealTimelineLayout new
]

{ #category : #removing }
GTATimelineBuilder >> removeAllElementsAndEdges [
	self
		removeEdges;
		removeElements
]

{ #category : #removing }
GTATimelineBuilder >> removeEdges [
	self edges ifEmpty: [ ^ self ].
	"view removeEdges: self edges."
	self edges do: #remove.
	edges := OrderedCollection new.
]

{ #category : #removing }
GTATimelineBuilder >> removeElements [
	elements ifNil: [ ^ self ].
	self elements ifEmpty: [ ^ self ].
	self elements do: #remove.
	elements := nil
]

{ #category : #hooks }
GTATimelineBuilder >> renderIn: aView [
	self removeAllElementsAndEdges.
	self analyzeEventsIfRequested.
	aView addAll: self elements.
	self buildEdgesIfRequested.
	self layoutElements.
]

{ #category : #signalling }
GTATimelineBuilder >> signalUpdate [
	view signalUpdate 
]

{ #category : #layout }
GTATimelineBuilder >> smoothLayoutTranslator [
	self layout translator: (RTSmoothLayoutTranslator new nbCycles: 1).
]

{ #category : #enumerating }
GTATimelineBuilder >> visibleEvents [
	^ self eventFilter cull: self events cull: self
]

{ #category : #configuration }
GTATimelineBuilder >> withEdges [
	withEdges := true
]

{ #category : #accessing }
GTATimelineBuilder >> withEdges: aBoolean [ 
	withEdges := aBoolean
]

{ #category : #configuration }
GTATimelineBuilder >> withoutEdges [
	withEdges := false
]
