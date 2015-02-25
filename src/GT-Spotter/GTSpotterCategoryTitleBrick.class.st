Class {
	#name : #GTSpotterCategoryTitleBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'nameBrick',
		'amountBrick',
		'actionbarBrick',
		'stepModel',
		'categoryProcessor'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #accessing }
GTSpotterCategoryTitleBrick >> actionbarBrick [
	^ actionbarBrick
]

{ #category : #accessing }
GTSpotterCategoryTitleBrick >> actionbarBrick: anObject [
	actionbarBrick := anObject.

	self actionbarBrick
		vSpaceFill;
		hShrinkWrap.
]

{ #category : #adding }
GTSpotterCategoryTitleBrick >> addDiveInButton [
	|button|
	
	button := self newActionbarButton.
	button
		icon: self themer spotterThemer iconDiveInCategory;
		pressedColor: (self themer spotterThemer itemActionSelectedBackgroundColor alpha: 0.5);
		addUpAction: [ self stepModel diveInCategory ];
		beHelp;
		hintTitle: 'Show all';
		hintText: '<cmd+shift+right>'.
		
	self pushActionButton: button.
	
]

{ #category : #accessing }
GTSpotterCategoryTitleBrick >> amountBrick [

	^ amountBrick
]

{ #category : #accessing }
GTSpotterCategoryTitleBrick >> amountBrick: aBrick [

	amountBrick ifNotNil: [self removeBrick: amountBrick].
	amountBrick := aBrick.
	
	self themer spotterThemer categoryAmountStyleFor: amountBrick.
	
	self addBrickBack: amountBrick
]

{ #category : #accessing }
GTSpotterCategoryTitleBrick >> categoryProcessor [
	^ categoryProcessor
]

{ #category : #accessing }
GTSpotterCategoryTitleBrick >> categoryProcessor: anObject [
	categoryProcessor := anObject
]

{ #category : #actions }
GTSpotterCategoryTitleBrick >> hideActionbar [

	(self hasSubbrick: self actionbarBrick) ifTrue: [ 
		self removeBrick: self actionbarBrick ]
]

{ #category : #accessing }
GTSpotterCategoryTitleBrick >> nameBrick [

	^ nameBrick
]

{ #category : #accessing }
GTSpotterCategoryTitleBrick >> nameBrick: aBrick [

	nameBrick ifNotNil: [self removeBrick: nameBrick].
	nameBrick := aBrick.
	
	self themer spotterThemer categoryTitleNameStyleFor: nameBrick.
	
	self addBrickBack: nameBrick
]

{ #category : #'instance creation' }
GTSpotterCategoryTitleBrick >> newActionbarBrick [

	^ GLMBrick new
]

{ #category : #'instance creation' }
GTSpotterCategoryTitleBrick >> newActionbarButton [

	^ GLMHintableActionButtonBrick new
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

	self stepModel: aStepModel.
	self categoryProcessor: aProcessor.
	
	self nameBrick: self newNameBrick.
	self nameBrick text: aProcessor title.
			
	self amountBrick: self newAmountBrick.
	self amountBrick text: '0/0'.
	
	self actionbarBrick: self newActionbarBrick.
	self addDiveInButton.
	
	self onCandidateSelected.
	
	self doLayoutForce.

	^ self
]

{ #category : #'event-handling' }
GTSpotterCategoryTitleBrick >> onCandidateSelected [
	
	self stepModel selected ifNil: [ ^ self ].
	self stepModel selectedCategory = self categoryProcessor
		ifTrue: [ self showActionbar ]
		ifFalse: [ self hideActionbar ]
]

{ #category : #layouting }
GTSpotterCategoryTitleBrick >> onLayoutEvent: aLayoutEvent [
	super onLayoutEvent: aLayoutEvent.
	
	(aLayoutEvent isKindOf: GLMBrickLayoutStacked) ifTrue: [ "self enable" ]
]

{ #category : #adding }
GTSpotterCategoryTitleBrick >> pushActionButton: aButton [

	aButton
		width: [ :b | b icon width * 1.5 ];
		vSpaceFill.
		
	self actionbarBrick addBrickBack: aButton
]

{ #category : #accessing }
GTSpotterCategoryTitleBrick >> setAmountVisible: visible all: all [

	self amountBrick text: (visible asString, '/', all asString).
	self amountBrick wrappedBounds markWidthDirty.
	self amountBrick doLayout.
	self doLayoutForce
]

{ #category : #actions }
GTSpotterCategoryTitleBrick >> showActionbar [

	(self hasSubbrick: self actionbarBrick) ifFalse: [ 
		self addBrickBack: self actionbarBrick ]
]

{ #category : #accessing }
GTSpotterCategoryTitleBrick >> stepModel [

	^ stepModel
]

{ #category : #accessing }
GTSpotterCategoryTitleBrick >> stepModel: anObject [
	stepModel := anObject.
	
	self stepModel announcer weak
		on: GTSpotterSelectedCandidateChanged send: #onCandidateSelected to: self
]
