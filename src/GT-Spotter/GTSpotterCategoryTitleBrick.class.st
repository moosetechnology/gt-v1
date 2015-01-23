Class {
	#name : #GTSpotterCategoryTitleBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'nameBrick',
		'amountBrick',
		'stepModel'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #accessing }
GTSpotterCategoryTitleBrick >> amountBrick [

	^ amountBrick
]

{ #category : #accessing }
GTSpotterCategoryTitleBrick >> amountBrick: aBrick [

	amountBrick ifNotNil: [self removeBrick: amountBrick].
	amountBrick := aBrick.
	
	self theme spotterWidgetThemer categoryAmountStyleFor: amountBrick.
	
	self addBrickBack: amountBrick
]

{ #category : #layouting }
GTSpotterCategoryTitleBrick >> doLayout [
	
	super doLayout.
	
	self amountBrick isDotsAdded ifTrue: [
		self amountBrick layoutProperties horizontalPercent: 0.
		self layoutProperties paddingLeft: (((self width - self nameBrick width) / 2) ceiling max: 0).
		super doLayout ].
]

{ #category : #accessing }
GTSpotterCategoryTitleBrick >> nameBrick [

	^ nameBrick
]

{ #category : #accessing }
GTSpotterCategoryTitleBrick >> nameBrick: aBrick [

	nameBrick ifNotNil: [self removeBrick: nameBrick].
	nameBrick := aBrick.
	
	self theme spotterWidgetThemer categoryTitleNameStyleFor: nameBrick.
	
	self addBrickBack: nameBrick
]

{ #category : #'instance creation' }
GTSpotterCategoryTitleBrick >> newAmountBrick [

	^ GLMLabelBrick new
]

{ #category : #'instance creation' }
GTSpotterCategoryTitleBrick >> newNameBrick [

	^ GLMLabelBrick new
]

{ #category : #'instance creation' }
GTSpotterCategoryTitleBrick >> on: aStepModel category: aProcessor [

	stepModel := aStepModel.
	
	self nameBrick: self newNameBrick.
	self nameBrick text: aProcessor title.
			
	self amountBrick: self newAmountBrick.
	self amountBrick text: '0/0'.


	^ self
]

{ #category : #layouting }
GTSpotterCategoryTitleBrick >> onLayoutEvent: aLayoutEvent [
	super onLayoutEvent: aLayoutEvent.
	
	(aLayoutEvent isKindOf: GLMBrickLayoutStacked) ifTrue: [ "self enable" ]
]

{ #category : #layouting }
GTSpotterCategoryTitleBrick >> onPrepareLayout [
	super onPrepareLayout.
	
	self amountBrick layoutProperties horizontalPercent: 100.
	self layoutProperties paddingLeft: (self theme spotterWidgetThemer categoryNameMarginLeft).
	self disable.
]

{ #category : #accessing }
GTSpotterCategoryTitleBrick >> setAmountVisible: visible all: all [

	self amountBrick text: (visible asString, '/', all asString)
]
