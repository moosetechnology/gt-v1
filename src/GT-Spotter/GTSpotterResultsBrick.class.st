Class {
	#name : #GTSpotterResultsBrick,
	#superclass : #GLMStackedScrollPaneBrick,
	#instVars : [
		'stepModel',
		'categories'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #adding }
GTSpotterResultsBrick >> addCategory: aProcessor [
	|titleBrick categoryBrick|
	
	titleBrick := self newTitleBrick on: self stepModel category: aProcessor.
	self themer spotterThemer categoryTitleStyleFor: titleBrick.
	self addBrickBack: titleBrick.
	
	categoryBrick := (self newCategoryBrick on: self stepModel category: aProcessor) titleBrick: titleBrick.
	self themer spotterThemer categoryStyleFor: categoryBrick .
	self addBrickBack: categoryBrick.
	
	self changed.
	
	^ categoryBrick
]

{ #category : #adding }
GTSpotterResultsBrick >> buildItemFor: aCandidateLink in: aProcessor [
	|itemBrick|
	itemBrick := (aCandidateLink renderingProcessor render: aCandidateLink value)
			candidateLink: aCandidateLink;
			stepModel: self stepModel;
			yourself.
	^ itemBrick
	
]

{ #category : #accessing }
GTSpotterResultsBrick >> categories [

	^ categories ifNil: [ categories := Dictionary new ]
]

{ #category : #accessing }
GTSpotterResultsBrick >> categoryMorphOf: aProcessor [

	^ self categories at: aProcessor ifAbsentPut: [ self addCategory: aProcessor ]
]

{ #category : #initialization }
GTSpotterResultsBrick >> initialize [
	super initialize.
	self band hSpaceFill.
	self announcer weak subscribe: GLMBrickScrollPositionChanged send: #onScrolled to: self
]

{ #category : #'instance creation' }
GTSpotterResultsBrick >> newCategoryBrick [

	^ GTSpotterCategoryBrick new
]

{ #category : #'instance creation' }
GTSpotterResultsBrick >> newTitleBrick [

	^ GTSpotterCategoryTitleBrick new
]

{ #category : #'event handling' }
GTSpotterResultsBrick >> onAllCandidatesAdded: ann [
	|categoryMorph|
	ann candidateLinks isEmpty ifTrue: [ ^ self ].
	
	categoryMorph := self categoryMorphOf: ann category.
	
	ann candidateLinks do: [ :each | categoryMorph addBrickBack: (self buildItemFor: each in: ann category)	].
	
	categoryMorph titleBrick setAmountVisible: (categoryMorph submorphs size) all: self waitingText.

	self band doLayoutForce.
	self changed.
]

{ #category : #'event handling' }
GTSpotterResultsBrick >> onAllCandidatesRemoved [
	
	self removeAllBricks.
	categories := nil.
	
	self band fullReleaseCachedState.
	self band releaseCachedState.
	self changed.
	
]

{ #category : #'event handling' }
GTSpotterResultsBrick >> onCandidateAdded: ann [
	
	(self categoryMorphOf: ann category)
		addBrickBack: (self buildItemFor: ann candidateLink in: ann category);
		setAmountVisible: ((self categoryMorphOf: ann category) submorphs size) all: self waitingText.

	self band doLayoutForce.
	self changed.
]

{ #category : #'event handling' }
GTSpotterResultsBrick >> onCandidateSelected: ann [

	self scrollTo: ann candidateBrick.
	self brickRoot changed.
]

{ #category : #'event handling' }
GTSpotterResultsBrick >> onCandidatesAmountChanged: ann [
	|categoryMorph|
	
	ann amount < 1 ifTrue: [ ^ self changed ].
	
	categoryMorph := self categoryMorphOf: ann category.
	categoryMorph ifNil: [ ^ self ].
	
	categoryMorph titleBrick setAmountVisible: (categoryMorph submorphs size) all: ann amount.
	
]

{ #category : #'brick-structure-events' }
GTSpotterResultsBrick >> onLayouted [
	super onLayouted.
]

{ #category : #'brick-structure-events' }
GTSpotterResultsBrick >> onRemovedFrom: aBrick [
	super onRemovedFrom: aBrick.
	
	self stepModel spotter announcer unsubscribe: self.
	self stepModel announcer unsubscribe: self.
]

{ #category : #'event handling' }
GTSpotterResultsBrick >> onScrolled [

	self stepModel spotter announce: GTSpotterCandidateSelectedMoved new
]

{ #category : #accessing }
GTSpotterResultsBrick >> stepModel [
	^ stepModel
]

{ #category : #accessing }
GTSpotterResultsBrick >> stepModel: aModel [
	stepModel := aModel.
	
	stepModel candidates announcer weak subscribe: GTSpotterCandidateAdded send: #onCandidateAdded: to: self.
	stepModel candidates announcer weak subscribe: GTSpotterAllCandidatesRemoved send: #onAllCandidatesRemoved to: self.
	stepModel candidates announcer weak subscribe: GTSpotterAllCandidatesAdded send: #onAllCandidatesAdded: to: self.
	stepModel candidates announcer weak subscribe: GTSpotterCandidatesAmountChanged send: #onCandidatesAmountChanged: to: self.
	stepModel announcer weak subscribe: GTSpotterScrollPageDown send: #scrollPageDown to: self.
	stepModel announcer weak subscribe: GTSpotterScrollPageUp send: #scrollPageUp to: self.
	stepModel spotter announcer weak subscribe: GTSpotterCandidateSelected send: #onCandidateSelected: to: self.
]

{ #category : #accessing }
GTSpotterResultsBrick >> waitingText [

	^ '...'
]
