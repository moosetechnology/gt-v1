Class {
	#name : #GTSpotterStepPane,
	#superclass : #GLMFoundationBrick,
	#instVars : [
		'resultsBrick',
		'stepModel'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #'as yet unclassified' }
GTSpotterStepPane >> initialize [
	super initialize.
		
	self resultsBrick: self newResultsBrick.
]

{ #category : #'instance creation' }
GTSpotterStepPane >> newResultsBrick [

	^ GTSpotterResultsBrick new
]

{ #category : #accessing }
GTSpotterStepPane >> resultsBrick [
	^ resultsBrick
]

{ #category : #accessing }
GTSpotterStepPane >> resultsBrick: aBrick [
	
	resultsBrick ifNotNil: [self removeBrick: resultsBrick].
	resultsBrick := aBrick.

	self theme spotterWidgetThemer resultsPaneStyleFor: resultsBrick.
	
	self addBrickBack: resultsBrick
]

{ #category : #accessing }
GTSpotterStepPane >> stepModel [
	^ stepModel
]

{ #category : #accessing }
GTSpotterStepPane >> stepModel: anObject [
	stepModel := anObject.
	
	self resultsBrick stepModel: stepModel.
]
