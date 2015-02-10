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
	
	self themer spotterThemer itemActionbarStyleFor: aBrick.
	
	self addBrickBack: actionbarBrick
]

{ #category : #adding }
GTSpotterItemBrick >> addActActionButton [

	self actionbarBrick addActionButton: (self newActionButtonBrick
			icon: self themer spotterThemer iconAct;
			addUpAction: [ self beSelected. self stepModel act ];
			yourself)
		
]

{ #category : #adding }
GTSpotterItemBrick >> addDiveInActionButton [
		
	(self stepModel canDiveIn: self candidate) ifTrue: [
		self actionbarBrick addActionButton: (self newActionButtonBrick
			icon: self themer spotterThemer iconDiveIn;
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
		
	self themer spotterThemer itemActionbarInvisibleStyleFor: self actionbarBrick.
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
	
	self themer spotterThemer itemIconStyleFor: iconBrick.
	
	self addBrickBack: iconBrick
]

{ #category : #initialization }
GTSpotterItemBrick >> initialize [
	super initialize.
	self enable.
	
	self themer spotterThemer itemNormalStyleFor: self.
	
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
	
	self themer spotterThemer itemLabelStyleFor: labelBrick.
	
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
	self flag: 'find a better number, or at least a better place for the number :)'.

	^ GLMLabelBrick new 
		text: 'Search result with very very long name';
		paddingRight: 16
]

{ #category : #notifying }
GTSpotterItemBrick >> notifySelected [

	self stepModel spotter announce: (GTSpotterCandidateSelected new candidateBrick: self)
]

{ #category : #'brick-structure-events' }
GTSpotterItemBrick >> onRemoved [
	super onRemoved.
	"I must not receive any announcements as soon as i'm removed from dom"
	self stepModel ifNotNil: [ self stepModel announcer unsubscribe: self ]
]

{ #category : #'brick-structure-events' }
GTSpotterItemBrick >> onRemovedFrom: aBrick [
	super onRemovedFrom: aBrick.
	
	"I must not receive any announcements as soon as i'm removed from dom"
	self stepModel ifNotNil: [
		self stepModel announcer unsubscribe: self.
		self stepModel spotter announcer unsubscribe: self  ]
]

{ #category : #'event handling' }
GTSpotterItemBrick >> onSelectedChanged: ann [

	self checkOrUncheck
]

{ #category : #'event handling' }
GTSpotterItemBrick >> onStepPopped [

	
	(self stepModel spotter steps last = self stepModel) & self isChecked ifTrue: [
		self notifySelected ]
]

{ #category : #actions }
GTSpotterItemBrick >> showActionbar [

	self themer spotterThemer itemActionbarVisibleStyleFor: self actionbarBrick.
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
	
	stepModel announcer weak subscribe: GTSpotterSelectedCandidateChanged send: #onSelectedChanged: to: self.
	stepModel spotter announcer weak subscribe: GTSpotterStepPopped send: #onStepPopped to: self.
	
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
