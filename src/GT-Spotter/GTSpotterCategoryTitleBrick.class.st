Class {
	#name : #GTSpotterCategoryTitleBrick,
	#superclass : #GLMBandBrick,
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

{ #category : #'as yet unclassified' }
GTSpotterCategoryTitleBrick >> doLayout [

	self amountBrick layoutProperties horizontalPercent: 100.
	super doLayout.
	
	self amountBrick isDotsAdded ifTrue: [
		self amountBrick layoutProperties horizontalPercent: 0. super doLayout ].
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

{ #category : #accessing }
GTSpotterCategoryTitleBrick >> setAmountVisible: visible all: all [

	self amountBrick text: (visible asString, '/', all asString)
]
