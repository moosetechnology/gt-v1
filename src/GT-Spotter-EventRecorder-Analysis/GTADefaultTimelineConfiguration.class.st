Class {
	#name : #GTADefaultTimelineConfiguration,
	#superclass : #Object,
	#instVars : [
		'lastBuilder',
		'withEdges',
		'layout',
		'shape'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #cleanup }
GTADefaultTimelineConfiguration class >> cleanUp [
	self reset.
]

{ #category : #accessing }
GTADefaultTimelineConfiguration class >> reset [
	"self reset"
	uniqueInstance := nil
]

{ #category : #accessing }
GTADefaultTimelineConfiguration class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #api }
GTADefaultTimelineConfiguration >> configure: builder [ 
	builder
		withEdges: self withEdges;
		layout: self layout.
	builder shape shape: self shape.
	builder interaction
		popupText: #asEventAnalysisString;
		draggable.
	builder interaction showEdge
		connectTo: [ :event | 
			event isUserSelection
				ifFalse: [ RTGroup new ]
				ifTrue: [ 
					builder view elements
						select: [ :eachElement | eachElement model isSpotterEvent
								and: [ eachElement model isUserSelection
								and: [ eachElement model elementName = event elementName ] ] ]
						thenCollect: #model ] ];
		shape: [ :el | RTLine new color: (Color blue alpha: 0.4) ] 
]

{ #category : #accessing }
GTADefaultTimelineConfiguration >> layout [
	^ layout ifNil: [ layout := GTAHorizontalDivingLineLayout new ]
]

{ #category : #accessing }
GTADefaultTimelineConfiguration >> layout: aLayout [ 
	layout := aLayout
]

{ #category : #accessing }
GTADefaultTimelineConfiguration >> shape [
	^ shape ifNil: [ shape := GTATimelineOrthogonalIconBuilder new ]
]

{ #category : #accessing }
GTADefaultTimelineConfiguration >> shape: aShape [ 
	shape := aShape
]

{ #category : #accessing }
GTADefaultTimelineConfiguration >> withEdges [
	^ withEdges ifNil: [ withEdges := false ]
]

{ #category : #accessing }
GTADefaultTimelineConfiguration >> withEdges: aBoolean [ 
	withEdges := aBoolean
]