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
	^ self subbricks isEmpty
		ifTrue: [ 0 ]
		ifFalse: [ super height ]
]

{ #category : #'instance creation' }
GTSpotterCategoryBrick >> on: aStepModel category: aProcessor [

	self stepModel: aStepModel.
	self category: aProcessor.
]

{ #category : #'brick-structure-events' }
GTSpotterCategoryBrick >> onRemoved [
	super onRemoved.
	
	self removeAllBricks
]

{ #category : #accessing }
GTSpotterCategoryBrick >> setAmountVisible: visible all: all [

	self titleBrick setAmountVisible: visible all: all
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

	titleBrick := aBrick
]
