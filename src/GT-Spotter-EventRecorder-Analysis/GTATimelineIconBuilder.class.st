Class {
	#name : #GTATimelineIconBuilder,
	#superclass : #Object,
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #configuration }
GTATimelineIconBuilder >> defaultHalfHeight [
	^ 5
]

{ #category : #configuration }
GTATimelineIconBuilder >> defaultHeight [
	^ 10
]

{ #category : #configuration }
GTATimelineIconBuilder >> defaultMinHeight [
	^ 2
]

{ #category : #configuration }
GTATimelineIconBuilder >> defaultMinWidth [
	^ 1
]

{ #category : #configuration }
GTATimelineIconBuilder >> defaultWidth [
	^ 10
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForWordOfSize: wordSize keyword: aBoolean [
	^ RTBox new 
			height: (aBoolean ifTrue: [ self defaultHalfHeight ] ifFalse: [ self defaultHeight ]); 
			width: wordSize; 
			yourself.
]

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
	^ aGTSpotterEvent currentTextSizes size < 2
		ifTrue: [ self visitContextChangedForOneWordEvent: aGTSpotterEvent ]
		ifFalse: [ self visitContextChangedForSeveralWordsEvent: aGTSpotterEvent ]
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitContextChangedForOneWordEvent: aGTSpotterEvent [
	| shape sizes |
	shape := RTBox new height: self defaultHeight; width: self defaultMinWidth; yourself.
	sizes := aGTSpotterEvent currentTextSizes.	
	(sizes notNil and: [ sizes notEmpty ]) ifTrue: [ shape width: sizes sum ].
	aGTSpotterEvent hasCurrentTextSpecials ifTrue: [ shape height: self defaultHalfHeight ]. 
	^ shape
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitContextChangedForSeveralWordsEvent: aGTSpotterEvent [
	| composition sizes keywords shapes |
	composition := RTCompositeShape new horizontal; yourself.
	sizes := aGTSpotterEvent currentTextSizes.	
	keywords := aGTSpotterEvent currentTextSpecials.
	shapes := OrderedCollection new.
	sizes with: keywords do: [ :size :keyword |
		shapes add: (self newShapeForWordOfSize: size keyword: keyword) ].
	shapes 
		do: [ :shape | composition add: shape ]
		separatedBy: [ 
			composition add: (RTBox new height: 5; width: 1; color: Color transparent; yourself) ].
	^ composition
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
	^ RTArc new 
			innerRadius: 4;
			externalRadius: 5;
			outerAngle: 0 innerAngle: 360
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
	s2 := RTBox new width: 10; height: 6; color: Color transparent; yourself.
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
	^ RTEllipse new size: 10; yourself
]
