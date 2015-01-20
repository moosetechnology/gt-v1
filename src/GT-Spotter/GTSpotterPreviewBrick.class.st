Class {
	#name : #GTSpotterPreviewBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'compositeBrick'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #accessing }
GTSpotterPreviewBrick >> compositeBrick [

	^ compositeBrick
]

{ #category : #accessing }
GTSpotterPreviewBrick >> compositeBrick: aBrick [

	compositeBrick := aBrick.
	self theme spotterWidgetThemer spotterPreviewCompositeStyleFor: compositeBrick.
	self addBrickBack: compositeBrick
]

{ #category : #initialization }
GTSpotterPreviewBrick >> initialize [
	super initialize.
	
	self compositeBrick: self newCompositeBrick
]

{ #category : #'instance creation' }
GTSpotterPreviewBrick >> newCompositeBrick [

	^ GLMCompositeBrick new
]

{ #category : #'event handling' }
GTSpotterPreviewBrick >> onCandidateSelected: ann [

	self compositeBrick removeAllBricks.
	ann selected spotterPreviewIn: self compositeBrick.
	self doLayout.
	self changed
]

{ #category : #accessing }
GTSpotterPreviewBrick >> spotterModel: aSpotter [
	
	aSpotter announcer subscribe: GTSpotterSelectedCandidateChanged send: #onCandidateSelected: to: self
]
