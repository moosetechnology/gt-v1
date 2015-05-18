Class {
	#name : #GTAIconBuilder,
	#superclass : #Object,
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Activity'
}

{ #category : #configuration }
GTAIconBuilder >> defaultHalfHeight [
	^ 5
]

{ #category : #configuration }
GTAIconBuilder >> defaultHeight [
	^ 10
]

{ #category : #configuration }
GTAIconBuilder >> defaultMinHeight [
	^ 2
]

{ #category : #configuration }
GTAIconBuilder >> defaultMinWidth [
	^ 1
]

{ #category : #configuration }
GTAIconBuilder >> defaultWidth [
	^ 10
]

{ #category : #public }
GTAIconBuilder >> elementOn: aModel [ 
	^ (self shapeFor: aModel) elementOn: aModel
]

{ #category : #public }
GTAIconBuilder >> elementsOn: models [
	^ models collect: [ :eachModel | (self elementOn: eachModel) ] as: RTGroup
]

{ #category : #'instance creation' }
GTAIconBuilder >> newContextChangedForOneWordEvent: aGTSpotterEvent [
	| shape sizes |
	shape := RTBox new height: self defaultHeight; width: self defaultMinWidth; yourself.
	sizes := aGTSpotterEvent currentTextSizes.	
	(sizes notNil and: [ sizes notEmpty ]) ifTrue: [ shape width: sizes sum ].
	aGTSpotterEvent hasCurrentTextSpecials ifTrue: [ shape height: self defaultHalfHeight ]. 
	^ shape
]

{ #category : #'instance creation' }
GTAIconBuilder >> newContextChangedForSeveralWordsEvent: aGTSpotterEvent [
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
			composition add: (RTBox new height: 1; width: 1; yourself) ].
	^ composition
]

{ #category : #'instance creation' }
GTAIconBuilder >> newCorrectDiveInElementEvent: aGTSpotterEvent [
	^ RTBox new
		height: 2;
		width: 5;
		yourself
]

{ #category : #'instance creation' }
GTAIconBuilder >> newMissStepDiveInElementEvent: aGTSpotterEvent [ 
	| s1 s3 s2 c |
	c := RTCompositeShape new.
	s1 := RTBox new
				height: 2;
				width: 2;
				yourself.
	s2 := RTBox new
				height: 2;
				width: 1;
				color: Color transparent;
				yourself.
	s3 := RTBox new
				height: 2;
				width: 2;
				yourself.
	c add: s1; add: s2; add: s3; horizontal.
	^ c
]

{ #category : #'instance creation' }
GTAIconBuilder >> newSearchFinishedForOneCategoryEvent: aGTSpotterEvent [
	| size sizes shapeAndSize |
	sizes := aGTSpotterEvent items.
	(sizes notNil and: [ sizes notEmpty ]) 
		ifTrue: [ size := sizes sum ]
		ifFalse: [ size := 1 ].
	shapeAndSize := self newShapeForQueryOfSize: size.
	^ shapeAndSize key
]

{ #category : #'instance creation' }
GTAIconBuilder >> newSearchFinishedForSeveralCategoriesEvent: aGTSpotterEvent [
	| composition categoriesAndItems offset |
	composition := RTCompositeShape new.
	categoriesAndItems := aGTSpotterEvent notEmptyCategories.
	offset := 0.
	categoriesAndItems 
		do: [ :categoryAndItems | | shapeAndSize size |
			size := categoryAndItems value.
			shapeAndSize := self newShapeForQueryOfSize: size.
			composition add: shapeAndSize key translateBy: offset @ 0.
			offset := offset + shapeAndSize value ]
		separatedBy: [ | connector |
			connector := RTCompositeShape new.
			connector 
				add: (RTBox new height: 1; width: 1; yourself);
				add: (RTBox new height: 1; width: 1; yourself)
					translateBy: 0 @ 6.
			composition 
				add: connector
				translateBy: offset @ 0.
				offset := offset + 2 ].
	^ composition
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForQueryOfSize: wordSize [
	| s1 s3 c size |
	size := wordSize // 10.
	size < 2 ifTrue: [ size := 2 ].
	size > 100 ifTrue: [ size := 100 ].
	c := RTCompositeShape new.
	s1 := RTBox new height: 4; width: size; yourself.
	s3 := RTBox new height: 4; width: size; yourself.	
	c 
		add: s1;
		add: s3 translateBy: 0 @ 6.
	^ c -> size
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventKeyArrowDown: aGTSpotterEvent [ 
	^ aGTSpotterEvent isInTheSameCategoryAsPreviousSelection
		ifTrue: [ self newShapeForSelectionEventKeyArrowDownSameCategory: aGTSpotterEvent ]
		ifFalse: [ self newShapeForSelectionEventKeyArrowDownDifferentCategory: aGTSpotterEvent ]
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventKeyArrowDownDifferentCategory: aGTSpotterEvent [ 
	^ aGTSpotterEvent existsUserSelectionsOfTheSameElement
		ifTrue: [ self newShapeForSelectionEventKeyArrowDownDifferentCategoryRepetition: aGTSpotterEvent ]
		ifFalse: [ self newShapeForSelectionEventKeyArrowDownDifferentCategoryUnique: aGTSpotterEvent  ]
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventKeyArrowDownDifferentCategoryRepetition: aGTSpotterEvent [ 
	| s1 s2 s3 c |
	s1 := RTPolygon new 
				vertices: { -5 @ 0. -2 @ 5. 2 @ 5. 5 @ 0 };
				yourself.
	s2 := RTPolygon new 
				vertices: { -5 @ 0. -2 @ 5. 2 @ 5. 5 @ 0 };
				yourself.
	s3 := RTBox new width: 10; height: 10; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c 
		add: s3;
		add: s2 translateBy: 0 @ 7; 
		add: s1 translateBy: 0 @ 12.
	^ c
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventKeyArrowDownDifferentCategoryUnique: aGTSpotterEvent [ 
	| s1 s2 s3 c |
	s1 := RTPolygon new 
				vertices: { -5 @ 0. 0 @ 5. 5 @ 0 };
				yourself.
	s2 := RTPolygon new 
				vertices: { -5 @ 0. 0 @ 5. 5 @ 0 };
				yourself.
	s3 := RTBox new width: 10; height: 10; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c 
		add: s3;
		add: s1 translateBy: 0 @ 7; 
		add: s2 translateBy: 0 @ 12.
	^ c
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventKeyArrowDownSameCategory: aGTSpotterEvent [ 
	^ aGTSpotterEvent existsUserSelectionsOfTheSameElement
		ifTrue: [ self newShapeForSelectionEventKeyArrowDownSameCategoryRepetition: aGTSpotterEvent ]
		ifFalse: [ self newShapeForSelectionEventKeyArrowDownSameCategoryUnique: aGTSpotterEvent  ]
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventKeyArrowDownSameCategoryRepetition: aGTSpotterEvent [ 
	| s1 s2 c |
	s1 := RTPolygon new 
				vertices: { -5 @ 0. -2 @ 5. 2 @ 5. 5 @ 0 };
				yourself.
	s2 := RTBox new width: 10; height: 4; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c add: s2; add: s1; vertical.
	^ c
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventKeyArrowDownSameCategoryUnique: aGTSpotterEvent [ 
	| s1 s2 c |
	s1 := RTPolygon new 
				vertices: { -5 @ 0. 0 @ 5. 5 @ 0 };
				yourself.
	s2 := RTBox new width: 10; height: 4; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c add: s2; add: s1; vertical.
	^ c
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventKeyArrowUp: aGTSpotterEvent [
	^ aGTSpotterEvent isInTheSameCategoryAsPreviousSelection
		ifTrue: [ self newShapeForSelectionEventKeyArrowUpSameCategory: aGTSpotterEvent ]
		ifFalse: [ self newShapeForSelectionEventKeyArrowUpDifferentCategory: aGTSpotterEvent ]
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventKeyArrowUpDifferentCategory: aGTSpotterEvent [ 
	^ aGTSpotterEvent existsUserSelectionsOfTheSameElement
		ifTrue: [ self newShapeForSelectionEventKeyArrowUpDifferentCategoryRepetition: aGTSpotterEvent ]
		ifFalse: [ self newShapeForSelectionEventKeyArrowUpDifferentCategoryUnique: aGTSpotterEvent ]
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventKeyArrowUpDifferentCategoryRepetition: aGTSpotterEvent [ 
	| s1 s2 s3 c |
	s1 := RTPolygon new 
				vertices: { -5 @ 0. -2 @ -5. 2 @ -5. 5 @ 0 };
				yourself.
	s2 := RTPolygon new 
				vertices: { -5 @ 0. -2 @ -5. 2 @ -5. 5 @ 0 };
				yourself.
	s3 := RTBox new width: 10; height: 10; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c 
		add: s1;
		add: s2 translateBy: 0 @ 5; 
		add: s3 translateBy: 0 @ 13.
	^ c
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventKeyArrowUpDifferentCategoryUnique: aGTSpotterEvent [ 
	| s1 s2 s3 c |
	s1 := RTPolygon new 
				vertices: { -5 @ 0 . 0 @ -5 . 5 @ 0 };
				yourself.
	s2 := RTPolygon new 
				vertices: { -5 @ 0 . 0 @ -5 . 5 @ 0 };
				yourself.
	s3 := RTBox new width: 10; height: 10; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c 
		add: s1;
		add: s2 translateBy: 0 @ 5; 
		add: s3 translateBy: 0 @ 13.
	^ c
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventKeyArrowUpSameCategory: aGTSpotterEvent [ 
	^ aGTSpotterEvent existsUserSelectionsOfTheSameElement
		ifTrue: [ self newShapeForSelectionEventKeyArrowUpSameCategoryRepetition: aGTSpotterEvent ]
		ifFalse: [ self newShapeForSelectionEventKeyArrowUpSameCategoryUnique: aGTSpotterEvent ]
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventKeyArrowUpSameCategoryRepetition: aGTSpotterEvent [ 
	| s1 s2 c |
	s1 := RTPolygon new 
				vertices: { -5 @ 0. -2 @ -5. 2 @ -5. 5 @ 0 };
				yourself.
	s2 := RTBox new width: 10; height: 9; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c add: s1; add: s2; vertical.
	^ c
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventKeyArrowUpSameCategoryUnique: aGTSpotterEvent [ 
	| s1 s2 c |
	s1 := RTPolygon new 
				vertices: { -5 @ 0 . 0 @ -5 . 5 @ 0 };
				yourself.
	s2 := RTBox new width: 10; height: 6; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c add: s1; add: s2; vertical.
	^ c
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventSingleClick: aGTSpotterEvent [ 
	^ aGTSpotterEvent isInTheSameCategoryAsPreviousSelection
		ifTrue: [ self newShapeForSelectionEventSingleClickSameCategory: aGTSpotterEvent ]
		ifFalse: [ self newShapeForSelectionEventSingleClickDifferentCategory: aGTSpotterEvent ]
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventSingleClickDifferentCategory: aGTSpotterEvent [ 
	^ aGTSpotterEvent existsUserSelectionsOfTheSameElement
		ifTrue: [ self newShapeForSelectionEventSingleClickDifferentCategoryRepetition: aGTSpotterEvent ]
		ifFalse: [ self newShapeForSelectionEventSingleClickDifferentCategoryUnique: aGTSpotterEvent ]
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventSingleClickDifferentCategoryRepetition: aGTSpotterEvent [ 
	| s1 s2 s3 s4 c |
	s1 := RTPolygon new 
				vertices: { -5 @ 0. -2 @ 5. 2 @ 5. 5 @ 0 };
				yourself.
	s2 := RTPolygon new 
				vertices: { -5 @ 0. -2 @ 5. 2 @ 5. 5 @ 0 };
				yourself.
	s3 := RTPolygon new 
				vertices: { -5 @ 0. -2 @ -5. 2 @ -5. 5 @ 0 };
				yourself.
	s4 := RTPolygon new 
				vertices: { -5 @ 0. -2 @ -5. 2 @ -5. 5 @ 0 };
				yourself.
	c := RTCompositeShape new.
	c 
		add: s3;
		add: s4 translateBy: 0 @ 5; 
		add: s1 translateBy: 0 @ 10;
		add: s2 translateBy: 0 @ 15.
	^ c
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventSingleClickDifferentCategoryUnique: aGTSpotterEvent [ 
	| s1 s2 s3 s4 c |
	s1 := RTPolygon new 
				vertices: { -5 @ 0. 0 @ 5. 5 @ 0 };
				yourself.
	s2 := RTPolygon new 
				vertices: { -5 @ 0. 0 @ 5. 5 @ 0 };
				yourself.
	s3 := RTPolygon new 
				vertices: { -5 @ 0. 0 @ -5. 5 @ 0 };
				yourself.
	s4 := RTPolygon new 
				vertices: { -5 @ 0. 0 @ -5. 5 @ 0 };
				yourself.
	c := RTCompositeShape new.
	c 
		add: s3;
		add: s4 translateBy: 0 @ 5; 
		add: s1 translateBy: 0 @ 10;
		add: s2 translateBy: 0 @ 15.
	^ c
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventSingleClickSameCategory: aGTSpotterEvent [ 
	^ aGTSpotterEvent existsUserSelectionsOfTheSameElement
		ifTrue: [ self newShapeForSelectionEventSingleClickSameCategoryRepetition: aGTSpotterEvent ]
		ifFalse: [ self newShapeForSelectionEventSingleClickSameCategoryUnique: aGTSpotterEvent ]
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventSingleClickSameCategoryRepetition: aGTSpotterEvent [ 
	^ RTPolygon new 
			vertices: { -5 @ 0. -2 @ -5. 2 @ -5. 5 @ 0. 2 @ 5. -2 @ 5 };
			yourself
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForSelectionEventSingleClickSameCategoryUnique: aGTSpotterEvent [ 
	^ RTPolygon new 
			vertices: { -5 @ 0 . 0 @ -5 . 5 @ 0. 0 @ 5 };
			yourself
]

{ #category : #'instance creation' }
GTAIconBuilder >> newShapeForWordOfSize: wordSize keyword: aBoolean [
	^ RTBox new 
			height: (aBoolean ifTrue: [ self defaultHalfHeight ] ifFalse: [ self defaultHeight ]); 
			width: wordSize; 
			yourself.
]

{ #category : #accessing }
GTAIconBuilder >> shapeFor: aGTSpotterEvent [ 
	^ aGTSpotterEvent accept: self
]

{ #category : #visitor }
GTAIconBuilder >> visitActOnEvent: aGTSpotterEvent [ 
	^ RTPolygon new vertices: { -5 @ -5. 5 @ 0. -5 @ 5 }; yourself
]

{ #category : #visitor }
GTAIconBuilder >> visitCategorySelectedEvent: aGTSpotterRecorderCategorySelectedEvent [ 
	^ nil
]

{ #category : #visitor }
GTAIconBuilder >> visitContextChangedEvent: aGTSpotterEvent [ 
	^ aGTSpotterEvent currentTextSizes size < 2
		ifTrue: [ self newContextChangedForOneWordEvent: aGTSpotterEvent ]
		ifFalse: [ self newContextChangedForSeveralWordsEvent: aGTSpotterEvent ]
]

{ #category : #visitor }
GTAIconBuilder >> visitDiveInCategoryEvent: aGTSpotterEvent [ 
	| s1 s2 s3 c |
	s1 := RTBox new height: 2; width: 5; yourself.
	s2 := RTBox new height: 2; width: 5; color: Color transparent; yourself.
	s3 := RTBox new height: 2; width: 5; yourself.
	c := RTCompositeShape new.
	c add: s1; add: s2; add: s3; vertical.
	^ c
]

{ #category : #visitor }
GTAIconBuilder >> visitDiveInElementEvent: aGTSpotterEvent [ 
	^ aGTSpotterEvent isMissStep 
		ifTrue: [ self newMissStepDiveInElementEvent: aGTSpotterEvent ]
		ifFalse: [ self newCorrectDiveInElementEvent: aGTSpotterEvent ]
]

{ #category : #visitor }
GTAIconBuilder >> visitDiveOutEvent: aGTSpotterEvent [ 
	^ RTBox new
		height: 2;
		width: 5;
		yourself
]

{ #category : #visitor }
GTAIconBuilder >> visitExitEvent: aGTSpotterEvent [ 
	^ RTPolygon new 
		vertices: { 
			-4 @ -5. 0 @ -1. 4 @ -5. 5 @ -4. 1 @ 0. 
			5 @ 4. 4 @ 5. 0 @ 1. -4 @ 5. -5 @ 4. -1 @ 0. -5 @ -4 };
		yourself
]

{ #category : #visitor }
GTAIconBuilder >> visitHidePreviewEvent: aGTSpotterEvent [ 
	^ RTArc new 
			innerRadius: 4;
			externalRadius: 5;
			outerAngle: 0 innerAngle: 360
]

{ #category : #visitor }
GTAIconBuilder >> visitOpenEvent: aGTSpotterRecorderOpenEvent [ 
	^ nil
]

{ #category : #visitor }
GTAIconBuilder >> visitSearchFinishedEvent: aGTSpotterEvent [ 
	^ RTPolygon new
			vertices: { -5 @ 0. -3 @ 0. -1 @ 4. 1 @ -3. 3 @ 0. 5 @ 0. 
							5 @ -1. 3 @ -1. 1 @ -4. -1 @ 3. -3 @ -1. -5 @ -1 };
			yourself
]

{ #category : #visitor }
GTAIconBuilder >> visitSelectedCandidateChangedEvent: aGTSpotterEvent [ 
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
GTAIconBuilder >> visitShowPreviewEvent: aGTSpotterEvent [ 
	^ RTEllipse new size: 10; yourself
]
