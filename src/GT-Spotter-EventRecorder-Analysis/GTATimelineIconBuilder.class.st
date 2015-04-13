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

{ #category : #'as yet unclassified' }
GTATimelineIconBuilder >> elementOn: aModel [ 
	^ (self shapeFor: aModel) elementOn: aModel
]

{ #category : #'as yet unclassified' }
GTATimelineIconBuilder >> elementsOn: models [
	^ models collect: [ :eachModel | (self elementOn: eachModel) ] as: RTGroup
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventKeyArrowDown: aGTSpotterEvent [ 
	^ aGTSpotterEvent isInTheSameCategoryAsPreviousSelection
		ifTrue: [ self newShapeForSelectionEventKeyArrowDownSameCategory: aGTSpotterEvent ]
		ifFalse: [ self newShapeForSelectionEventKeyArrowDownDifferentCategory: aGTSpotterEvent ]
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventKeyArrowDownDifferentCategory: aGTSpotterEvent [ 
	^ aGTSpotterEvent existsUserSelectionsOfTheSameElement
		ifTrue: [ self newShapeForSelectionEventKeyArrowDownDifferentCategoryRepetition: aGTSpotterEvent ]
		ifFalse: [ self newShapeForSelectionEventKeyArrowDownDifferentCategoryUnique: aGTSpotterEvent  ]
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventKeyArrowDownDifferentCategoryRepetition: aGTSpotterEvent [ 
	| s1 s2 c |
	s1 := RTPolygon new 
				vertices: { -5 @ 1. -2 @ 9. 2 @ 9. 5 @ 1. 5 @ -1. -5 @ -1 };
				yourself.
	s2 := RTBox new width: 10; height: 8; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c add: s2; add: s1; vertical.
	^ c
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventKeyArrowDownDifferentCategoryUnique: aGTSpotterEvent [ 
	| s1 s2 c |
	s1 := RTPolygon new 
				vertices: { -5 @ 1. 0 @ 9. 5 @ 1. 5 @ -1. -5 @ -1 };
				yourself.
	s2 := RTBox new width: 10; height: 8; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c add: s2; add: s1; vertical.
	^ c
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventKeyArrowDownSameCategory: aGTSpotterEvent [ 
	^ aGTSpotterEvent existsUserSelectionsOfTheSameElement
		ifTrue: [ self newShapeForSelectionEventKeyArrowDownSameCategoryRepetition: aGTSpotterEvent ]
		ifFalse: [ self newShapeForSelectionEventKeyArrowDownSameCategoryUnique: aGTSpotterEvent  ]
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventKeyArrowDownSameCategoryRepetition: aGTSpotterEvent [ 
	| s1 s2 c |
	s1 := RTPolygon new 
				vertices: { -5 @ 1. -2 @ 5. 2 @ 5. 5 @ 1. 5 @ -1. -5 @ -1 };
				yourself.
	s2 := RTBox new width: 10; height: 4; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c add: s2; add: s1; vertical.
	^ c
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventKeyArrowDownSameCategoryUnique: aGTSpotterEvent [ 
	| s1 s2 c |
	s1 := RTPolygon new 
				vertices: { -5 @ 1. 0 @ 5. 5 @ 1. 5 @ -1. -5 @ -1 };
				yourself.
	s2 := RTBox new width: 10; height: 4; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c add: s2; add: s1; vertical.
	^ c
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventKeyArrowUp: aGTSpotterEvent [
	^ aGTSpotterEvent isInTheSameCategoryAsPreviousSelection
		ifTrue: [ self newShapeForSelectionEventKeyArrowUpSameCategory: aGTSpotterEvent ]
		ifFalse: [ self newShapeForSelectionEventKeyArrowUpDifferentCategory: aGTSpotterEvent ]
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventKeyArrowUpDifferentCategory: aGTSpotterEvent [ 
	^ aGTSpotterEvent existsUserSelectionsOfTheSameElement
		ifTrue: [ self newShapeForSelectionEventKeyArrowUpDifferentCategoryRepetition: aGTSpotterEvent ]
		ifFalse: [ self newShapeForSelectionEventKeyArrowUpDifferentCategoryUnique: aGTSpotterEvent ]
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventKeyArrowUpDifferentCategoryRepetition: aGTSpotterEvent [ 
	| s1 s2 c |
	s1 := RTPolygon new 
				vertices: { -5 @ -2. -2 @ -10. 2 @ -10. 5 @ -2. 5 @ 0. -5 @ 0 };
				yourself.
	s2 := RTBox new width: 10; height: 13; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c add: s1; add: s2; vertical.
	^ c
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventKeyArrowUpDifferentCategoryUnique: aGTSpotterEvent [ 
	| s1 s2 c |
	s1 := RTPolygon new 
				vertices: { -5 @ -2. 0 @ -10. 5 @ -2. 5 @ 0. -5 @ 0 };
				yourself.
	s2 := RTBox new width: 10; height: 13; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c add: s1; add: s2; vertical.
	^ c
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventKeyArrowUpSameCategory: aGTSpotterEvent [ 
	^ aGTSpotterEvent existsUserSelectionsOfTheSameElement
		ifTrue: [ self newShapeForSelectionEventKeyArrowUpSameCategoryRepetition: aGTSpotterEvent ]
		ifFalse: [ self newShapeForSelectionEventKeyArrowUpSameCategoryUnique: aGTSpotterEvent ]
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventKeyArrowUpSameCategoryRepetition: aGTSpotterEvent [ 
	| s1 s2 c |
	s1 := RTPolygon new 
				vertices: { -5 @ -1. -2 @ -5. 2 @ -5. 5 @ -1. 5 @ 1. -5 @ 1 };
				yourself.
	s2 := RTBox new width: 10; height: 6; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c add: s1; add: s2; vertical.
	^ c
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventKeyArrowUpSameCategoryUnique: aGTSpotterEvent [ 
	| s1 s2 c |
	s1 := RTPolygon new 
				vertices: { -5 @ -1 . 0 @ -5 . 5 @ -1. 5 @ 1. -5 @ 1 };
				yourself.
	s2 := RTBox new width: 10; height: 6; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c add: s1; add: s2; vertical.
	^ c
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventSingleClick: aGTSpotterEvent [ 
	^ aGTSpotterEvent isInTheSameCategoryAsPreviousSelection
		ifTrue: [ self newShapeForSelectionEventSingleClickSameCategory: aGTSpotterEvent ]
		ifFalse: [ self newShapeForSelectionEventSingleClickDifferentCategory: aGTSpotterEvent ]
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventSingleClickDifferentCategory: aGTSpotterEvent [ 
	^ aGTSpotterEvent existsUserSelectionsOfTheSameElement
		ifTrue: [ self newShapeForSelectionEventSingleClickDifferentCategoryRepetition: aGTSpotterEvent ]
		ifFalse: [ self newShapeForSelectionEventSingleClickDifferentCategoryUnique: aGTSpotterEvent ]
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventSingleClickDifferentCategoryRepetition: aGTSpotterEvent [ 
	^ RTPolygon new 
			vertices: { -5 @ 0. -2 @ -9. 2 @ -9. 5 @ 0. 2 @ 9. -2 @ 9 };
			yourself
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventSingleClickDifferentCategoryUnique: aGTSpotterEvent [ 
	^ RTPolygon new 
			vertices: { -5 @ 0. 0 @ -9. 5 @ 0. 0 @ 9 };
			yourself
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventSingleClickSameCategory: aGTSpotterEvent [ 
	^ aGTSpotterEvent existsUserSelectionsOfTheSameElement
		ifTrue: [ self newShapeForSelectionEventSingleClickSameCategoryRepetition: aGTSpotterEvent ]
		ifFalse: [ self newShapeForSelectionEventSingleClickSameCategoryUnique: aGTSpotterEvent ]
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventSingleClickSameCategoryRepetition: aGTSpotterEvent [ 
	^ RTPolygon new 
			vertices: { -5 @ 0. -2 @ -5. 2 @ -5. 5 @ 0. 2 @ 5. -2 @ 5 };
			yourself
]

{ #category : #'instance creation' }
GTATimelineIconBuilder >> newShapeForSelectionEventSingleClickSameCategoryUnique: aGTSpotterEvent [ 
	^ RTPolygon new 
			vertices: { -5 @ 0 . 0 @ -5 . 5 @ 0. 0 @ 5 };
			yourself
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
	| s1 s2 s3 c |
	s1 := RTBox new height: 2; width: 5; yourself.
	s2 := RTBox new height: 2; width: 5; color: Color transparent; yourself.
	s3 := RTBox new height: 2; width: 5; yourself.
	c := RTCompositeShape new.
	c add: s1; add: s2; add: s3; vertical.
	^ c
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitDiveInElementEvent: aGTSpotterEvent [ 
	^ RTBox new
		height: 2;
		width: 5;
		yourself
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitDiveOutEvent: aGTSpotterEvent [ 
	^ RTBox new
		height: 2;
		width: 5;
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
		^ self newShapeForSelectionEventKeyArrowUp: aGTSpotterEvent ].

	type = #keyPressedArrowDown ifTrue: [ 
		^ self newShapeForSelectionEventKeyArrowDown: aGTSpotterEvent ].

	type = #singleClick ifTrue: [ 
		^ self newShapeForSelectionEventSingleClick: aGTSpotterEvent ].

	^ RTPolygon new 
			vertices: { -5 @ 0 . 0 @ -5 . 5 @ 0. 0 @ 5 };
			color: Color transparent;
			borderColor: RTPolygon new defaultColor;
			yourself
]

{ #category : #visitor }
GTATimelineIconBuilder >> visitShowPreviewEvent: aGTSpotterEvent [ 
	^ RTEllipse new size: 10; yourself
]
