Class {
	#name : #GTSpotterCategoryTitleBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'nameBrick',
		'amountBrick',
		'actionbarBrick',
		'stepModel',
		'categoryProcessor',
		'diveInButton'
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
	
	diveInButton := self newActionbarButton.
	self diveInButton
		icon: self themer spotterThemer iconDiveInCategory;
		pressedColor: (self themer spotterThemer itemActionSelectedBackgroundColor alpha: 0.5);
		action: [ self stepModel diveInCategory: self categoryProcessor dueTo: #actionButton ];
		beHelp;
		hintTitle: 'Show all';
		hintText: '<cmd+shift+right>'.
		
	self pushActionButton: self diveInButton
	
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

{ #category : #accessing }
GTSpotterCategoryTitleBrick >> diveInButton [
	^ diveInButton
]

{ #category : #actions }
GTSpotterCategoryTitleBrick >> hideActionbar [

	(self hasSubbrick: self actionbarBrick) ifTrue: [ 
		self removeBrick: self actionbarBrick ]
]

{ #category : #initialization }
GTSpotterCategoryTitleBrick >> initialize [
	super initialize.
	self enable.
	self announcer when: #onMouseHover send: #onHovered to: self.
	self announcer when: #onMouseUnhover send: #onUnhovered to: self
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
	self nameBrick text: '#', aProcessor title.
			
	self amountBrick: self newAmountBrick.
	self amountBrick text: '0/0'.
	
	self actionbarBrick: self newActionbarBrick.
	self addDiveInButton.
	
	self onCandidateSelected.
	
	self nameBrick wrappedBounds markWidthDirty.
	self nameBrick label wrappedBounds markWidthDirty.
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

{ #category : #'event-handling' }
GTSpotterCategoryTitleBrick >> onHideHints [

	(self hasSubbrick: self actionbarBrick) ifFalse: [ ^ self ].
	self themer spotterThemer hintHideStyleFor: self diveInButton
]

{ #category : #'event-handling' }
GTSpotterCategoryTitleBrick >> onHovered [
	self showActionbar
]

{ #category : #layouting }
GTSpotterCategoryTitleBrick >> onLayoutEvent: aLayoutEvent [
	super onLayoutEvent: aLayoutEvent.
	
	(aLayoutEvent isKindOf: GLMBrickLayoutStacked) ifTrue: [ "self enable" ]
]

{ #category : #'event-handling' }
GTSpotterCategoryTitleBrick >> onRevealHints [

	(self hasSubbrick: self actionbarBrick) ifFalse: [ ^ self ].
	self themer spotterThemer hintRevealStyleFor: self diveInButton
]

{ #category : #'brick-properties-events' }
GTSpotterCategoryTitleBrick >> onThemerChanged [
	super onThemerChanged.
	
	self themer spotterThemer categoryTitleWidgetStyleFor: self.
	self themer spotterThemer categoryAmountWidgetStyleFor: self amountBrick.
	self themer spotterThemer categoryTitleNameWidgetStyleFor: self nameBrick.
]

{ #category : #'event-handling' }
GTSpotterCategoryTitleBrick >> onUnhovered [
	self stepModel selectedCategory == self categoryProcessor
		ifFalse: [ self hideActionbar ]
]

{ #category : #adding }
GTSpotterCategoryTitleBrick >> pushActionButton: aButton [

	aButton
		width: [ :b | b icon width * 1.5 ];
		vSpaceFill.
		
	self actionbarBrick addBrickBack: aButton.
	
	self stepModel spotter isShiftPressed
		ifTrue: [ self themer spotterThemer hintRevealStyleFor: aButton ]
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
		self addBrickBack: self actionbarBrick.
		self toggleHints ]
]

{ #category : #accessing }
GTSpotterCategoryTitleBrick >> stepModel [

	^ stepModel
]

{ #category : #accessing }
GTSpotterCategoryTitleBrick >> stepModel: anObject [
	stepModel := anObject.
	
	self stepModel announcer when: GTSpotterSelectedCandidateChanged send: #onCandidateSelected to: self.
	self stepModel spotter announcer when: GTSpotterRevealHints send: #onRevealHints to: self.
	self stepModel spotter announcer when: GTSpotterHideHints send: #onHideHints to: self
]

{ #category : #actions }
GTSpotterCategoryTitleBrick >> toggleHints [

	(self hasSubbrick: self actionbarBrick) ifFalse: [ ^ self ].
	self stepModel spotter isShiftPressed
		ifTrue: [ self onRevealHints ]
		ifFalse: [ self onHideHints ]
]
