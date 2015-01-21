Class {
	#name : #GTSpotterPreviewBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'compositeBrick',
		'spotterModel'
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

	self updatePreviewWith: ann selected
]

{ #category : #'event handling' }
GTSpotterPreviewBrick >> onStepPopped [

	self updatePreviewWith: self spotterModel steps last selectedCandidate
]

{ #category : #accessing }
GTSpotterPreviewBrick >> spotterModel [

	^ spotterModel
]

{ #category : #accessing }
GTSpotterPreviewBrick >> spotterModel: aSpotter [
	
	spotterModel := aSpotter.
	aSpotter announcer subscribe: GTSpotterSelectedCandidateChanged send: #onCandidateSelected: to: self.
	aSpotter announcer subscribe: GTSpotterStepPopped send: #onStepPopped to: self
	
]

{ #category : #updating }
GTSpotterPreviewBrick >> updatePreviewWith: anObject [

	self owner ifNil: [ ^ self ].

	self compositeBrick removeAllBricks.
	anObject spotterPreviewIn: self compositeBrick.
	self doLayout.
	self changed
]
