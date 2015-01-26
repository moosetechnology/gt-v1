Class {
	#name : #GTSpotterPreviewArrowBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'triangleBrick',
		'selectedItemBrick',
		'spotterModel',
		'selfBounds'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #'brick-layout' }
GTSpotterPreviewArrowBrick >> doLayout [
	super doLayout.
	
	selfBounds := nil.
]

{ #category : #actions }
GTSpotterPreviewArrowBrick >> hideTriangle [

	self triangleBrick color: Color transparent.
	self changed
]

{ #category : #initialization }
GTSpotterPreviewArrowBrick >> initialize [
	super initialize.
	
	self triangleBrick: self newTriangleBrick
]

{ #category : #actions }
GTSpotterPreviewArrowBrick >> moveTo: anItemBrick [
	|itemBounds delta|
	anItemBrick ifNil: [ ^ self ].
	
	itemBounds := anItemBrick globalBounds.
	delta := ((itemBounds top - self selfBounds top) max: 0) min: (self selfBounds height - self triangleBrick height).
	self triangleBrick brickBounds top = delta ifTrue: [ ^ self ].
	
	self triangleBrick translateY: (delta - self triangleBrick brickBounds top).
	self changed
	
]

{ #category : #'instance creation' }
GTSpotterPreviewArrowBrick >> newTriangleBrick [

	^ GLMActionButtonBrick new
]

{ #category : #'event handling' }
GTSpotterPreviewArrowBrick >> onAllCandidatesRemoved [

	self selectedItemBrick: nil
]

{ #category : #'event handling' }
GTSpotterPreviewArrowBrick >> onCandidateMoved [
	
	self moveTo: self selectedItemBrick
]

{ #category : #'event handling' }
GTSpotterPreviewArrowBrick >> onCandidateSelected: ann [

	self selectedItemBrick: ann candidateBrick.
	self moveTo: self selectedItemBrick.
	self brickRoot changed
]

{ #category : #'event handling' }
GTSpotterPreviewArrowBrick >> onHidePreview [

	self color: Color transparent.
	self brickRoot changed
]

{ #category : #'event handling' }
GTSpotterPreviewArrowBrick >> onShowPreview [

	self color: self theme spotterWidgetThemer backgroundColor.
	self changed
]

{ #category : #'event handling' }
GTSpotterPreviewArrowBrick >> onStepAdded [
	
	self selectedItemBrick: nil.
	self spotterModel steps last candidates announcer subscribe: GTSpotterAllCandidatesRemoved send: #onAllCandidatesRemoved to: self.
]

{ #category : #accessing }
GTSpotterPreviewArrowBrick >> selectedItemBrick [
	
	^ selectedItemBrick
]

{ #category : #accessing }
GTSpotterPreviewArrowBrick >> selectedItemBrick: aBrick [
	
	selectedItemBrick isNil & aBrick isNotNil ifTrue: [ self showTriangle ].
	selectedItemBrick isNotNil & aBrick isNil ifTrue: [ self hideTriangle ].
	
	selectedItemBrick := aBrick
]

{ #category : #accessing }
GTSpotterPreviewArrowBrick >> selfBounds [

	^ selfBounds ifNil: [ selfBounds := self globalBounds ]
]

{ #category : #actions }
GTSpotterPreviewArrowBrick >> showTriangle [

	self triangleBrick color: self theme spotterWidgetThemer previewArrowColor.
	self changed
]

{ #category : #accessing }
GTSpotterPreviewArrowBrick >> spotterModel [

	^ spotterModel
]

{ #category : #accessing }
GTSpotterPreviewArrowBrick >> spotterModel: aSpotterModel [

	spotterModel := aSpotterModel.
	
	self spotterModel announcer subscribe: GTSpotterCandidateSelected send: #onCandidateSelected: to: self.
	self spotterModel announcer subscribe: GTSpotterCandidateSelectedMoved send: #onCandidateMoved to: self.
	self spotterModel announcer subscribe: GTSpotterStepAdded send: #onStepAdded to: self.
	self spotterModel announcer subscribe: GTSpotterShowPreview send: #onShowPreview to: self.
	self spotterModel announcer subscribe: GTSpotterHidePreview send: #onHidePreview to: self
]

{ #category : #accessing }
GTSpotterPreviewArrowBrick >> triangleBrick [

	^ triangleBrick
]

{ #category : #accessing }
GTSpotterPreviewArrowBrick >> triangleBrick: aBrick [

	triangleBrick := aBrick.
	self triangleBrick addUpAction: [ self spotterModel togglePreview ].
	self theme spotterWidgetThemer spotterPreviewArrowStyleFor: self triangleBrick.
	self addBrickBack: self triangleBrick
	
]
