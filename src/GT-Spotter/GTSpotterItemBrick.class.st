Class {
	#name : #GTSpotterItemBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'iconBrick',
		'labelBrick',
		'stepModel',
		'candidateLink',
		'actionbarBrick'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #accessing }
GTSpotterItemBrick >> actionbarBrick [
	^ actionbarBrick
]

{ #category : #accessing }
GTSpotterItemBrick >> actionbarBrick: aBrick [

	actionbarBrick ifNotNil: [self removeBrick: actionbarBrick].
	actionbarBrick := aBrick.
	
	self theme spotterWidgetThemer itemActionbarStyleFor: aBrick.
	
	self addBrickBack: actionbarBrick
]

{ #category : #adding }
GTSpotterItemBrick >> addActActionButton [

	self actionbarBrick addActionButton: (self newActionButtonBrick
			icon: self theme spotterWidgetThemer iconAct;
			addUpAction: [ self beSelected. self stepModel act ];
			yourself)
		
]

{ #category : #adding }
GTSpotterItemBrick >> addDiveInActionButton [
		
	(self stepModel canDiveIn: self candidate) ifTrue: [
		self actionbarBrick addActionButton: (self newActionButtonBrick
			icon: self theme spotterWidgetThemer iconDiveIn;
			addUpAction: [ self beSelected. self stepModel diveIn ];
			yourself)]
]

{ #category : #actions }
GTSpotterItemBrick >> beSelected [
	self stepModel selected: self candidateLink
	
]

{ #category : #accessing }
GTSpotterItemBrick >> candidate [

	^ candidateLink value
]

{ #category : #accessing }
GTSpotterItemBrick >> candidateLink [

	^ candidateLink
]

{ #category : #accessing }
GTSpotterItemBrick >> candidateLink: aDoubleLink [ 

	candidateLink := aDoubleLink
]

{ #category : #'event handling' }
GTSpotterItemBrick >> check [

	self showActionbar.
	super check.
	self notifySelected
]

{ #category : #'event handling' }
GTSpotterItemBrick >> checkOrUncheck [

	self stepModel selected = self candidateLink
		ifTrue: [ self isChecked ifFalse: [ self check ] ]
		ifFalse: [ self isChecked ifTrue: [ self uncheck ] ]
]

{ #category : #'event handling' }
GTSpotterItemBrick >> doubleClick: evt [

	self stepModel act
]

{ #category : #'event handling' }
GTSpotterItemBrick >> handlesMouseDown: evt [
	^ true
]

{ #category : #actions }
GTSpotterItemBrick >> hideActionbar [
		
	self theme spotterWidgetThemer itemActionbarInvisibleStyleFor: self actionbarBrick.
	self doLayout.
]

{ #category : #actions }
GTSpotterItemBrick >> highlightQuery [

	self labelBrick label highlight: self stepModel query
]

{ #category : #accessing }
GTSpotterItemBrick >> icon: aForm [

	self iconBrick normalImage: aForm.
]

{ #category : #accessing }
GTSpotterItemBrick >> iconBrick [
	^ iconBrick
]

{ #category : #accessing }
GTSpotterItemBrick >> iconBrick: aBrick [

	iconBrick ifNotNil: [self removeBrick: iconBrick].
	iconBrick := aBrick.
	
	self theme spotterWidgetThemer itemIconStyleFor: iconBrick.
	
	self addBrickBack: iconBrick
]

{ #category : #initialization }
GTSpotterItemBrick >> initialize [
	super initialize.
	self enable.
	
	self theme spotterWidgetThemer itemNormalStyleFor: self.
	
	self iconBrick: self newIconBrick.
	self labelBrick: self newLabelBrick.
	self actionbarBrick: self newActionbarBrick.
]

{ #category : #accessing }
GTSpotterItemBrick >> labelBrick [
	^ labelBrick
]

{ #category : #accessing }
GTSpotterItemBrick >> labelBrick: aBrick [

	labelBrick ifNotNil: [self removeBrick: labelBrick].
	labelBrick := aBrick.
	
	self theme spotterWidgetThemer itemLabelStyleFor: labelBrick.
	
	self addBrickBack: labelBrick
]

{ #category : #'event handling' }
GTSpotterItemBrick >> mouseDown: evt [
	|selectors|
	
	self isEnabled ifFalse: [ ^ self ].
	
	selectors := Array
				with: #singleClick:
				with: #doubleClick:
				with: nil
				with: nil.
				
	evt hand
		waitForClicksOrDrag: self
		event: evt
		selectors: selectors
		threshold: 10
	
]

{ #category : #'instance creation' }
GTSpotterItemBrick >> newActionButtonBrick [

	^ GLMActionButtonBrick new
]

{ #category : #'instance creation' }
GTSpotterItemBrick >> newActionbarBrick [

	^ GTSpotterItemActionbarBrick new
]

{ #category : #'instance creation' }
GTSpotterItemBrick >> newIconBrick [

	^ GLMInteractableBrick new normalImage: ((Form extent: 16@16 depth: 32) fillAlpha: 0)
]

{ #category : #'instance creation' }
GTSpotterItemBrick >> newLabelBrick [

	^ GLMLabelBrick new text: 'Search result with very very long name'.
]

{ #category : #notifying }
GTSpotterItemBrick >> notifySelected [

	self announcer announce: (GTSpotterCandidateSelected new candidateBrick: self)
]

{ #category : #'event handling' }
GTSpotterItemBrick >> onSelectedChanged: ann [

	self checkOrUncheck
]

{ #category : #actions }
GTSpotterItemBrick >> showActionbar [

	self theme spotterWidgetThemer itemActionbarVisibleStyleFor: self actionbarBrick.
	self doLayout.
]

{ #category : #'event handling' }
GTSpotterItemBrick >> singleClick: evt [

	self beSelected
]

{ #category : #accessing }
GTSpotterItemBrick >> stepModel [

	^ stepModel
]

{ #category : #accessing }
GTSpotterItemBrick >> stepModel: aModel [

	stepModel := aModel.
	
	stepModel announcer subscribe: GTSpotterSelectedCandidateChanged send: #onSelectedChanged: to: self.
	
	self
		addActActionButton;
		addDiveInActionButton;
		highlightQuery;
		checkOrUncheck.
]

{ #category : #accessing }
GTSpotterItemBrick >> text: aString [

	self labelBrick text: aString.
]

{ #category : #'event handling' }
GTSpotterItemBrick >> uncheck [
	
	super uncheck.
	
	self hideActionbar
]
