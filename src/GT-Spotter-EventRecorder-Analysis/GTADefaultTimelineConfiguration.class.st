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
	^ shape ifNil: [ shape := GTATimelineIconBuilder new ]
]

{ #category : #accessing }
GTADefaultTimelineConfiguration >> shape: aShape [ 
	shape := aShape
]

{ #category : #accessing }
GTADefaultTimelineConfiguration >> withEdges [
	^ withEdges ifNil: [ withEdges := true ]
]

{ #category : #accessing }
GTADefaultTimelineConfiguration >> withEdges: aBoolean [ 
	withEdges := aBoolean
]
