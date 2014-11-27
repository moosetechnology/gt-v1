Class {
	#name : #GTSpotterResultsBrick,
	#superclass : #GLMScrollPaneBrick,
	#instVars : [
		'stepModel',
		'categories'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #'instance creation' }
GTSpotterResultsBrick >> buildCategory: aProcessorClass [

	^ self newCategoryBrick on: self stepModel category: aProcessorClass
	
]

{ #category : #accessing }
GTSpotterResultsBrick >> categories [

	^ categories ifNil: [ categories := HashTable new ]
]

{ #category : #accessing }
GTSpotterResultsBrick >> categoryMorphOf: aProcessor [

	^ self categories at: aProcessor ifAbsent: [ nil ]
]

{ #category : #'instance creation' }
GTSpotterResultsBrick >> newCategoryBrick [

	^ GTSpotterCategoryBrick new
]

{ #category : #'event handling' }
GTSpotterResultsBrick >> onAllCandidatesRemoved: ann [

	(self categoryMorphOf: ann category) listBrick removeAllBricks.
	
	self doLayout.
	self changed.
	
]

{ #category : #'event handling' }
GTSpotterResultsBrick >> onCandidateAdded: ann [
	|categoryMorph candidateBrick|
	
	categoryMorph := self categoryMorphOf: ann category.
	categoryMorph ifNil: [ ^ self ].
	
	candidateBrick := (ann category render: ann candidate) candidateLink: ann candidateLink; stepModel: self stepModel; yourself.
	candidateBrick announcer subscribe: GTSpotterCandidateSelected send: #onCandidateSelected: to: self.
	categoryMorph listBrick addBrickBack: candidateBrick.
	
	categoryMorph titleBrick setAmountVisible: (categoryMorph listBrick submorphs size) all: self waitingText.

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
	
	categoryMorph := self categoryMorphOf: ann category.
	categoryMorph ifNil: [ ^ self ].
	
	categoryMorph titleBrick setAmountVisible: (categoryMorph listBrick submorphs size) all: ann amount.
	
	
]

{ #category : #'event handling' }
GTSpotterResultsBrick >> onCategoryAdded: ann [
	|categoryBrick|
		
	categoryBrick := self buildCategory: ann category.
	
	self categories isEmpty
		ifFalse: [ self theme spotterWidgetThemer categoryStyleFor: categoryBrick ]
		ifTrue: [ self theme spotterWidgetThemer categoryFirstStyleFor: categoryBrick ].
		
	self categories add: (ann category -> categoryBrick).
		
	self addBrickBack: categoryBrick.
	
	self doLayout.
	self changed.
	
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
	
	stepModel candidates announcer subscribe: GTSpotterCategoryAdded send: #onCategoryAdded: to: self.
	stepModel candidates announcer subscribe: GTSpotterCandidateAdded send: #onCandidateAdded: to: self.
	stepModel candidates announcer subscribe: GTSpotterAllCandidatesRemoved send: #onAllCandidatesRemoved: to: self.
	stepModel candidates announcer subscribe: GTSpotterSelectedCandidateChanged send: #onSelectedCandidateChanged: to: self.
	stepModel candidates announcer subscribe: GTSpotterCandidatesAmountChanged send: #onCandidatesAmountChanged: to: self.
]

{ #category : #accessing }
GTSpotterResultsBrick >> waitingText [

	^ '...'
]
