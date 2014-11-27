Class {
	#name : #GTSpotterCategoryBrick,
	#superclass : #GLMBandBrick,
	#instVars : [
		'listBrick',
		'titleBrick',
		'stepModel',
		'category'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #accessing }
GTSpotterCategoryBrick >> amount: anInteger [
]

{ #category : #accessing }
GTSpotterCategoryBrick >> category [

	^ category
]

{ #category : #accessing }
GTSpotterCategoryBrick >> category: aProcessorClass [

	category := aProcessorClass
]

{ #category : #geometry }
GTSpotterCategoryBrick >> height [
	"instead of deleting brick when empty, just make it invisible"
	^ self listBrick subbricks isEmpty
		ifTrue: [ 0 ]
		ifFalse: [ super height ]
]

{ #category : #accessing }
GTSpotterCategoryBrick >> listBrick [
	^ listBrick
]

{ #category : #accessing }
GTSpotterCategoryBrick >> listBrick: aBrick [
	
	listBrick ifNotNil: [self removeBrick: listBrick].
	listBrick := aBrick.
	
	self theme spotterWidgetThemer categoryCandidatesListStyleFor: listBrick.
	
	self addBrickBack: listBrick
]

{ #category : #'instance creation' }
GTSpotterCategoryBrick >> newListBrick [

	^ GLMBandBrick new
]

{ #category : #'instance creation' }
GTSpotterCategoryBrick >> newTitleBrick [

	^ GTSpotterCategoryTitleBrick new
]

{ #category : #'instance creation' }
GTSpotterCategoryBrick >> on: aStepModel category: aProcessor [

	self stepModel: aStepModel.
	self category: aProcessor.
	
	self titleBrick: (self newTitleBrick on: aStepModel category: aProcessor).
	self listBrick: self newListBrick.
]

{ #category : #accessing }
GTSpotterCategoryBrick >> stepModel [
	^ stepModel
]

{ #category : #accessing }
GTSpotterCategoryBrick >> stepModel: anObject [
	stepModel := anObject.
]

{ #category : #accessing }
GTSpotterCategoryBrick >> titleBrick [
	^ titleBrick
]

{ #category : #accessing }
GTSpotterCategoryBrick >> titleBrick: aBrick [

	titleBrick ifNotNil: [self removeBrick: titleBrick].
	titleBrick := aBrick.
	
	self theme spotterWidgetThemer categoryTitleStyleFor: titleBrick.
	
	self addBrickBack: titleBrick
]
