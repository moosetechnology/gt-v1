Class {
	#name : #GTATimelineIconBuilder,
	#superclass : #Object,
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #accessing }
GTATimelineIconBuilder >> shapeFor: aGTSpotterEvent [ 
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
	| sizes size |
	sizes := aGTSpotterEvent currentTextSizes.
	(sizes isNil or: [ sizes isEmpty ]) ifTrue: [ ^ RTBox new height: 10; width: 1; yourself ].
	size := sizes sum.
	
	^ RTBox new height: 10; width: size; yourself
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitDiveInCategoryEvent: aGTSpotterEvent [ 
	| s1 s2 c |
	s1 := RTPolygon new 
		vertices: { -3 @ 4. 2 @ -5. 3 @ -4. -2 @ 5 };
		yourself.
	s2 := RTPolygon new 
		vertices: { -3 @ 4. 2 @ -5. 3 @ -4. -2 @ 5 };
		yourself.
	c := RTCompositeShape new.
	c add: s1; add: s2; horizontal.
	^ c
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitDiveInElementEvent: aGTSpotterEvent [ 
	^ RTPolygon new 
		vertices: { -3 @ 4. 2 @ -5. 3 @ -4. -2 @ 5 };
		yourself
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitDiveOutEvent: aGTSpotterEvent [ 
	^ RTPolygon new 
		vertices: { 3 @ 4. -2 @ -5. -3 @ -4. 2 @ 5 };
		yourself
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
	| type |
	type := aGTSpotterEvent eventType. 
	type = #keyPressedArrowUp ifTrue: [ 
		^ self visitSelectedCandidateChangedEventKeyPressedArrowUp: aGTSpotterEvent ].

	type = #keyPressedArrowDown ifTrue: [ 
		^ self visitSelectedCandidateChangedEventKeyPressedArrowDown: aGTSpotterEvent ].

	type = #singleClick ifTrue: [ 
		^ self visitSelectedCandidateChangedEventSingleClick: aGTSpotterEvent ].

	^ RTPolygon new 
			vertices: { -5 @ 0 . 0 @ -5 . 5 @ 0. 0 @ 5 };
			color: Color transparent;
			borderColor: RTPolygon new defaultColor;
			yourself
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitSelectedCandidateChangedEventKeyPressedArrowDown: aGTSpotterEvent [ 
	| s1 s2 c |
	s1 := RTPolygon new 
				vertices: { -5 @ 1 . 0 @ 5 . 5 @ 1. 5 @ -1. -5 @ -1 };
				yourself.
	s2 := RTBox new width: 10; height: 4; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c add: s2; add: s1; vertical.
	^ c
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitSelectedCandidateChangedEventKeyPressedArrowUp: aGTSpotterEvent [ 
	| s1 s2 c |
	s1 := RTPolygon new 
				vertices: { -5 @ -1 . 0 @ -5 . 5 @ -1. 5 @ 1. -5 @ 1 };
				yourself.
	s2 := RTBox new width: 10; height: 4; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c add: s1; add: s2; vertical.
	^ c
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitSelectedCandidateChangedEventSingleClick: aGTSpotterEvent [ 
	^ RTPolygon new 
			vertices: { -5 @ 0 . 0 @ -5 . 5 @ 0. 0 @ 5 };
			yourself
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitShowPreviewEvent: aGTSpotterEvent [ 
	^ RTBox new 
			size: 10;
			color: Color transparent;
			borderColor: RTBox new defaultColor;
	 		yourself
]
