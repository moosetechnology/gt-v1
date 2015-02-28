Class {
	#name : #GTSpotterMorph,
	#superclass : #GLMFoundationBrick,
	#instVars : [
		'focusedMorph',
		'breadcrumbBrick',
		'paneBrick',
		'spotterModel',
		'autoHide',
		'agreementButton'
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
GTSpotterMorph >> autoHide [

	^ autoHide ifNil: [ autoHide := true ]
]

{ #category : #accessing }
GTSpotterMorph >> autoHide: aBoolean [

	autoHide := aBoolean
]

{ #category : #accessing }
GTSpotterMorph >> breadcrumbBrick [
	
	^ breadcrumbBrick
]

{ #category : #accessing }
GTSpotterMorph >> breadcrumbBrick: aBrick [

	breadcrumbBrick ifNotNil: [self removeBrick: breadcrumbBrick].
	breadcrumbBrick := aBrick.
	
	breadcrumbBrick announcer subscribe: GTSpotterBreadcrumbVisibilityChanged send: #onBreadcrumbVisibilityChanged to: self.
	self themer spotterThemer breadcrumbStyleFor: breadcrumbBrick.
	breadcrumbBrick width: [ self paneBrick contentsBrick width ].
	breadcrumbBrick layout widthDependency: [ self paneBrick contentsBrick ].
	self addBrickBack: breadcrumbBrick
]

{ #category : #actions }
GTSpotterMorph >> closeSpotter [

	self autoHide ifTrue: [ self delete ]
]

{ #category : #'accessing-defaults' }
GTSpotterMorph >> defaultLabel [
	^ 'Spotter'
]

{ #category : #actions }
GTSpotterMorph >> diveIn [

	self spotterModel isEmpty ifFalse: [ 
		self spotterModel currentStep isEmpty ifFalse: [ 
			self spotterModel currentStep diveIn ] ]
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

{ #category : #'events-processing' }
GTSpotterMorph >> handleListenEvent: anEvent [
		
	anEvent type = #mouseDown ifTrue: [ 
		((self fullBoundsInWorld containsPoint: anEvent position) not and: [ self autoHide ])
			ifTrue: [ self spotterModel exit ] ].
		
	anEvent type = #keyDown ifTrue: [ 
		anEvent keyValue = 56
			ifTrue: [ self spotterModel ifNotNil: [ :s | s shiftPressed: (
					anEvent shiftPressed | ( self spotterModel isShiftPressed not ) ) ] ] ].
]

{ #category : #'event handling' }
GTSpotterMorph >> handlesMouseDown: evt [
	^ true
]

{ #category : #actions }
GTSpotterMorph >> hidePreview [
	
	self spotterModel hidePreview
]

{ #category : #initialization }
GTSpotterMorph >> initialize [
	super initialize.
	"setting custom brick themer for the whole spotter"
	self themer: self themer spotterThemer themer.
	
	self initializeListeners.
	self themer spotterThemer spotterStyleFor: self.
	self breadcrumbBrick: self newBreadcrumbBrick.
	self paneBrick: self newPaneBrick
]

{ #category : #initialize }
GTSpotterMorph >> initializeListeners [

	self activeHand addEventListener: self.
	
	Morph announcer weak on: MorphLostFocus send: #onLostFocus: to: self.
	
	self bindKeyCombination: Character escape toAction: [ self spotterModel exit ].
	self bindKeyCombination: $w command toAction: [ self spotterModel exit ].
	self bindKeyCombination: $p command toAction: [ self togglePreview ].
	
	self bindKeyCombination: Character arrowUp toAction: [ self selectPreviousCandidate ].
	self bindKeyCombination: Character arrowDown toAction: [ self selectNextCandidate ].
	self bindKeyCombination: Character arrowUp command toAction: [ self selectPreviousCandidate ].
	self bindKeyCombination: Character arrowDown command toAction: [ self selectNextCandidate ].
	self bindKeyCombination: Character arrowUp shift toAction: [ self selectPreviousCandidate ].
	self bindKeyCombination: Character arrowDown shift toAction: [ self selectNextCandidate ].
	
	self bindKeyCombination: Character arrowUp command shift toAction: [ self selectPreviousCategory ].
	self bindKeyCombination: Character arrowDown command shift toAction: [ self selectNextCategory ].
	
	self bindKeyCombination: Character arrowRight command toAction: [ self diveIn ].
	self bindKeyCombination: Character arrowLeft command toAction: [ self diveOut ].

	self bindKeyCombination: Character arrowRight command shift toAction: [ self diveInCategory ].
	self bindKeyCombination: Character arrowLeft command shift toAction: [ self diveOut ].
	
	self bindKeyCombination: Character arrowUp alt toAction: [ self stepScrollPageUp ].
	self bindKeyCombination: Character arrowDown alt toAction: [ self stepScrollPageDown ].
	self bindKeyCombination: Character pageUp toAction: [ self stepScrollPageUp ].
	self bindKeyCombination: Character pageDown toAction: [ self stepScrollPageDown ].
	
	self 
		bindKeyCombination: Character cr asKeyCombination 
		toAction: [ self act ].
		
	self 
		bindKeyCombination: $p command shift 
		toAction: [ self exportAsPNGSilently ]
]

{ #category : #'instance creation' }
GTSpotterMorph >> newBreadcrumbBrick [

	^ GTSpotterStepsBreadcrumb new
]

{ #category : #'instance creation' }
GTSpotterMorph >> newPaneBrick [

	^ GTSpotterPaneBrick new
]

{ #category : #'events-processing' }
GTSpotterMorph >> onBreadcrumbVisibilityChanged [

	self changed.
]

{ #category : #'events-processing' }
GTSpotterMorph >> onHidePreview [
	|delta|
	self paneBrick isPreviewShown ifFalse: [ ^ self ].
	delta := ((self width - ((self width / 100) * (100 - self themer spotterThemer previewWidthPercent)))@0) negated / 2.
	self bounds: (self bounds expandBy: delta).
	self paneBrick hidePreview.
	self doLayout
]

{ #category : #'events-processing' }
GTSpotterMorph >> onLostFocus: event [

	focusedMorph ifNil: [ focusedMorph := event morph ]
]

{ #category : #'events-processing' }
GTSpotterMorph >> onShowPreview [

	|delta|
	self paneBrick isPreviewShown ifTrue: [ ^ self ].
	delta := (((self width * 100) / (100 - self themer spotterThemer previewWidthPercent) - self width)@0) / 2.
	self bounds: (self bounds expandBy: delta).
	self paneBrick showPreview.
	self doLayout
]

{ #category : #opening }
GTSpotterMorph >> openInWindowLabeled: aString inWorld: aWorld [
	self autoHide: false.
	^ super openInWindowLabeled: aString inWorld: aWorld
]

{ #category : #initialize }
GTSpotterMorph >> outOfWorld: aWorld [
	super outOfWorld: aWorld.
	self unsubscribeListeners.
	
	self spotterModel ifNotNil: [:m | m terminateProcessors].
	
	"restoring previous focus"
	focusedMorph ifNotNil: [ focusedMorph takeKeyboardFocus ]
]

{ #category : #accessing }
GTSpotterMorph >> paneBrick [

	^ paneBrick
]

{ #category : #accessing }
GTSpotterMorph >> paneBrick: aBrick [
	
	paneBrick ifNotNil: [self removeBrick: paneBrick].
	paneBrick := aBrick.
		
	self themer spotterThemer spotterPaneStyleFor: paneBrick.

	self addBrickBack: paneBrick
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

{ #category : #actions }
GTSpotterMorph >> showPreview [
	
	self spotterModel showPreview
]

{ #category : #accessing }
GTSpotterMorph >> spotterModel [

	^ spotterModel
]

{ #category : #accessing }
GTSpotterMorph >> spotterModel: aSpotter [

	spotterModel := aSpotter.
	
	spotterModel announcer weak subscribe: GTSpotterExitAnnouncement send: #closeSpotter to: self.
	spotterModel announcer weak subscribe: GTSpotterShowPreview send: #onShowPreview to: self.
	spotterModel announcer weak subscribe: GTSpotterHidePreview send: #onHidePreview to: self.
	
	self breadcrumbBrick spotterModel: spotterModel.
	self paneBrick spotterModel: spotterModel.
	
	spotterModel class isPreviewVisible ifTrue: [ spotterModel showPreview ].
	
	"expanding drop down pane"
	self spotterModel setText: '' from: nil.
	self spotterModel currentStep process: nil.
	
	
	
]

{ #category : #actions }
GTSpotterMorph >> stepScrollPageDown [

	self spotterModel currentStep announcer announce: (GTSpotterScrollPageDown new)
]

{ #category : #actions }
GTSpotterMorph >> stepScrollPageUp [

	self spotterModel currentStep announcer announce: (GTSpotterScrollPageUp new)
]

{ #category : #actions }
GTSpotterMorph >> togglePreview [

	self spotterModel togglePreview
]

{ #category : #initialize }
GTSpotterMorph >> unsubscribeListeners [

	self activeHand removeEventListener: self.
	Morph announcer unsubscribe: self.
]
