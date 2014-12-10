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
	self theme spotterWidgetThemer categoryTitleStyleFor: titleBrick.
	self addBrickBack: titleBrick.
	
	categoryBrick := (self newCategoryBrick on: self stepModel category: aProcessor) titleBrick: titleBrick.
	self theme spotterWidgetThemer categoryStyleFor: categoryBrick .
	self addBrickBack: categoryBrick.
	
	^ categoryBrick
]

{ #category : #adding }
GTSpotterResultsBrick >> buildItemFor: aCandidateLink in: aProcessor [
	|itemBrick|
	itemBrick := (aProcessor render: aCandidateLink value)
			candidateLink: aCandidateLink;
			stepModel: self stepModel;
			yourself.
			
	itemBrick announcer subscribe: GTSpotterCandidateSelected send: #onCandidateSelected: to: self.
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

	self doLayout.
	self changed.
]

{ #category : #'event handling' }
GTSpotterResultsBrick >> onAllCandidatesRemoved [
	
	self band removeAllBricks.
	categories := nil.
	
	self band fullReleaseCachedState.
	self band releaseCachedState.
	
	self doLayout.
	self changed.
	
]

{ #category : #'event handling' }
GTSpotterResultsBrick >> onCandidateAdded: ann [
	
	(self categoryMorphOf: ann category)
		addBrickBack: (self buildItemFor: ann candidateLink in: ann category);
		setAmountVisible: ((self categoryMorphOf: ann category) submorphs size) all: self waitingText.

	self doLayout.
	self changed.
]

{ #category : #'event handling' }
GTSpotterResultsBrick >> onCandidateSelected: ann [

	self scrollTo: ann candidateBrick.
]

{ #category : #'event handling' }
GTSpotterResultsBrick >> onCandidatesAmountChanged: ann [
	|categoryMorph|
	
	ann amount < 1 ifTrue: [ ^ self ].
	
	categoryMorph := self categoryMorphOf: ann category.
	categoryMorph ifNil: [ ^ self ].
	
	categoryMorph titleBrick setAmountVisible: (categoryMorph submorphs size) all: ann amount.
	
	
]

{ #category : #'event handling' }
GTSpotterResultsBrick >> onSelectedCandidateChanged: ann [
]

{ #category : #accessing }
GTSpotterResultsBrick >> stepModel [
	^ stepModel
]

{ #category : #accessing }
GTSpotterResultsBrick >> stepModel: aModel [
	stepModel := aModel.
	
	stepModel candidates announcer subscribe: GTSpotterCandidateAdded send: #onCandidateAdded: to: self.
	stepModel candidates announcer subscribe: GTSpotterAllCandidatesRemoved send: #onAllCandidatesRemoved to: self.
	stepModel candidates announcer subscribe: GTSpotterAllCandidatesAdded send: #onAllCandidatesAdded: to: self.
	stepModel candidates announcer subscribe: GTSpotterSelectedCandidateChanged send: #onSelectedCandidateChanged: to: self.
	stepModel candidates announcer subscribe: GTSpotterCandidatesAmountChanged send: #onCandidatesAmountChanged: to: self.
]

{ #category : #accessing }
GTSpotterResultsBrick >> waitingText [

	^ '...'
]
