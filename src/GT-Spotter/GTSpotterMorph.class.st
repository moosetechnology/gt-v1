Class {
	#name : #GTSpotterMorph,
	#superclass : #GLMFoundationBrick,
	#instVars : [
		'focusedMorph',
		'breadcrumbBrick',
		'breadcrumbWrapperBrick',
		'contentsBrick',
		'spotterModel'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #actions }
GTSpotterMorph >> act [
	self spotterModel isEmpty ifTrue: [ ^self ].
	self spotterModel currentStep isEmpty ifTrue: [ ^ self ].
	self spotterModel currentStep act
]

{ #category : #accessing }
GTSpotterMorph >> breadcrumbBrick [
	
	^ breadcrumbBrick
]

{ #category : #accessing }
GTSpotterMorph >> breadcrumbBrick: aBrick [

	breadcrumbBrick ifNotNil: [self removeBrick: breadcrumbWrapperBrick].
	breadcrumbBrick := aBrick.
	
	breadcrumbBrick announcer subscribe: GTSpotterBreadcrumbVisibilityChanged send: #onBreadcrumbVisibilityChanged to: self.
	
	self theme spotterWidgetThemer breadcrumbStyleFor: breadcrumbBrick.
	
	breadcrumbWrapperBrick := GLMBandBrick new.
	self theme spotterWidgetThemer breadcrumbWrapperStyleFor: breadcrumbWrapperBrick.
	breadcrumbWrapperBrick addBrickBack: breadcrumbBrick.
	
	self addBrickBack: breadcrumbWrapperBrick
]

{ #category : #accessing }
GTSpotterMorph >> contentsBrick [

	^ contentsBrick
]

{ #category : #accessing }
GTSpotterMorph >> contentsBrick: aBrick [
	
	contentsBrick ifNotNil: [self removeBrick: contentsBrick].
	contentsBrick := aBrick.
		
	self theme spotterWidgetThemer spotterContentsStyleFor: contentsBrick.

	self addBrickBack: contentsBrick
]

{ #category : #actions }
GTSpotterMorph >> diveIn [

	self spotterModel isEmpty
		ifFalse: [ self spotterModel currentStep isEmpty ifFalse: [ self spotterModel currentStep diveIn ] ]
]

{ #category : #actions }
GTSpotterMorph >> diveInCategory [

	self spotterModel isEmpty
		ifFalse: [ self spotterModel currentStep isEmpty ifFalse: [ self spotterModel currentStep diveInCategory ] ]
]

{ #category : #actions }
GTSpotterMorph >> diveOut [

	self spotterModel popStep
]

{ #category : #geometry }
GTSpotterMorph >> doLayout [
	self extent: self extent.
	super doLayout.
]

{ #category : #actions }
GTSpotterMorph >> escapePressed [

	self delete
]

{ #category : #geometry }
GTSpotterMorph >> extent: aPoint [
	super extent: (aPoint x @ (self brickRoot height))
]

{ #category : #'events-processing' }
GTSpotterMorph >> handleListenEvent: anEvent [
	
	anEvent type = #mouseDown ifTrue: [ 
		(self fullBoundsInWorld containsPoint: anEvent position) not
			ifTrue: [ self delete ] ]
]

{ #category : #'event handling' }
GTSpotterMorph >> handlesMouseDown: evt [
	^ true
]

{ #category : #initialization }
GTSpotterMorph >> initialize [
	super initialize.
	self initializeListeners.
	
	self theme spotterWidgetThemer spotterStyleFor: self.
	
	self breadcrumbBrick: self newBreadcrumbBrick.
	self contentsBrick: self newContentsBrick.
]

{ #category : #initialize }
GTSpotterMorph >> initializeListeners [

	self activeHand addMouseListener: self.
	Morph announcer weak on: MorphLostFocus send: #onLostFocus: to: self.
	
	self bindKeyCombination: Character escape toAction: [ self escapePressed ].
	
	self bindKeyCombination: Character arrowUp toAction: [ self selectPreviousCandidate ].
	self bindKeyCombination: Character arrowDown toAction: [ self selectNextCandidate ].
	self bindKeyCombination: Character arrowUp command toAction: [ self selectPreviousCandidate ].
	self bindKeyCombination: Character arrowDown command toAction: [ self selectNextCandidate ].
	
	self bindKeyCombination: Character arrowUp command shift toAction: [ self selectPreviousCategory ].
	self bindKeyCombination: Character arrowDown command shift toAction: [ self selectNextCategory ].
	
	self bindKeyCombination: Character arrowRight command toAction: [ self diveIn ].
	self bindKeyCombination: Character arrowLeft command toAction: [ self diveOut ].

	self bindKeyCombination: Character arrowRight command shift toAction: [ self diveInCategory ].
	
	self 
		bindKeyCombination: Character cr asKeyCombination 
		toAction: [ self act ]
]

{ #category : #'instance creation' }
GTSpotterMorph >> newBreadcrumbBrick [

	^ GTSpotterStepsBreadcrumb new
]

{ #category : #'instance creation' }
GTSpotterMorph >> newContentsBrick [

	^ GTSpotterContentsBrick new
]

{ #category : #'events-processing' }
GTSpotterMorph >> onBreadcrumbVisibilityChanged [
	|translate|
	
	translate := 0@self breadcrumbBrick defaultBreadcrumbHeight.
	
	self breadcrumbBrick isVisible	ifTrue: [ translate := translate negated ].
		
	self bounds: (self bounds translateBy: (translate))
]

{ #category : #'events-processing' }
GTSpotterMorph >> onLostFocus: event [

	focusedMorph ifNil: [ focusedMorph := event morph ]
]

{ #category : #initialize }
GTSpotterMorph >> outOfWorld: aWorld [
	super outOfWorld: aWorld.
	self unsubscribeListeners.
	
	self spotterModel terminateProcessors.
	
	"restoring previous focus"
	focusedMorph ifNotNil: [ focusedMorph takeKeyboardFocus ]
]

{ #category : #actions }
GTSpotterMorph >> selectNextCandidate [

	self spotterModel isEmpty
		ifFalse: [ self spotterModel currentStep selectNext ]
	
]

{ #category : #actions }
GTSpotterMorph >> selectNextCategory [

	self spotterModel isEmpty
		ifFalse: [ self spotterModel currentStep selectNextCategory ]
	
]

{ #category : #actions }
GTSpotterMorph >> selectPreviousCandidate [

	self spotterModel isEmpty
		ifFalse: [ self spotterModel currentStep selectPrevious ]
	
]

{ #category : #actions }
GTSpotterMorph >> selectPreviousCategory [

	self spotterModel isEmpty
		ifFalse: [ self spotterModel currentStep selectPreviousCategory ]
	
]

{ #category : #accessing }
GTSpotterMorph >> spotterModel [

	^ spotterModel
]

{ #category : #accessing }
GTSpotterMorph >> spotterModel: aSpotter [

	spotterModel := aSpotter.
	
	spotterModel announcer subscribe: GTSpotterExitAnnouncement send: #delete to: self.
	
	self breadcrumbBrick spotterModel: spotterModel.
	self contentsBrick spotterModel: spotterModel
	
	
]

{ #category : #initialize }
GTSpotterMorph >> unsubscribeListeners [

	self activeHand removeMouseListener: self.
	Morph announcer unsubscribe: self.
]
