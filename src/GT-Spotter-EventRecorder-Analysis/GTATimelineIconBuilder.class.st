Class {
	#name : #GTATimelineIconBuilder,
	#superclass : #Object,
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #accessing }
GTATimelineIconBuilder >> shapeFor: aGTSpotterEvent [ 
	^ aGTSpotterEvent accept: self
]

{ #category : #accessing }
GTATimelineIconBuilder >> svgPathFor: aGTSpotterEvent [ 
	^ aGTSpotterEvent accept: self
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitActOnEvent: aGTSpotterEvent [ 
	^ RTPolygon new vertices: { -5 @ -5. 5 @ 0. -5 @ 5 }; yourself
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitCategorySelectedEvent: aGTSpotterRecorderCategorySelectedEvent [ 
	^ nil
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitContextChangedEvent: aGTSpotterEvent [ 
	| sizes |
	sizes := aGTSpotterEvent currentTextSizes.
	"^ String streamContents: [ :aStream |
		aStream nextPutAll: 'M -5 0 C -5 -5 5 -5 5 0'.
		aGTSpotterEvent isRefinement ifTrue: [
			aStream nextPutAll: ' M -5 2 L 5 2' ]
	]."
	^ RTBox new size: 10; yourself
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitDiveInCategoryEvent: aGTSpotterEvent [ 
	^ "RTPolygon new vertices: { -5 @ -3. 5 @ 2. 5 @ 3. -5 @ -2 }; yourself."
		RTBox new size: 5; yourself
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitDiveInElementEvent: aGTSpotterEvent [ 
	^ RTBox new size: 5; yourself
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitDiveOutEvent: aGTSpotterEvent [ 
	^ RTBox new size: 5; yourself
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitExitEvent: aGTSpotterEvent [ 
	^ RTPolygon new 
		vertices: { 
			-4 @ -5. 0 @ -1. 4 @ -5. 5 @ -4. 1 @ 0. 
			5 @ 4. 4 @ 5. 0 @ 1. -4 @ 5. -5 @ 4. -1 @ 0. -5 @ -4 };
		yourself
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitHidePreviewEvent: aGTSpotterEvent [ 
	^ RTBox new size: 10; yourself
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitOpenEvent: aGTSpotterRecorderOpenEvent [ 
	^ nil
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitSearchFinishedEvent: aGTSpotterRecorderSearchFinishedEvent [ 
	^ nil
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitSelectedCandidateChangedEvent: aGTSpotterEvent [ 
	^ RTEllipse new size: 10; yourself
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitShowPreviewEvent: aGTSpotterEvent [ 
	^ RTBox new size: 10; yourself
]
