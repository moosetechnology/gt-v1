Class {
	#name : #GTSpotterPreviewBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'compositeBrick',
		'spotterModel',
		'asyncTask'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #accessing }
GTSpotterPreviewBrick >> asyncTask [

	^ asyncTask ifNil: [ asyncTask := GLMAsyncTask new ]
]

{ #category : #accessing }
GTSpotterPreviewBrick >> compositeBrick [

	^ compositeBrick
]

{ #category : #accessing }
GTSpotterPreviewBrick >> compositeBrick: aBrick [

	self compositeBrick ifNotNil: [ self removeBrick: self compositeBrick ].
	compositeBrick := aBrick.
	self themer spotterThemer spotterPreviewCompositeStyleFor: self compositeBrick.
	self addBrickBack: self compositeBrick.
	self doLayoutForce
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
GTSpotterPreviewBrick >> onStepAdded [

	self removeBrick: self compositeBrick
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
	aSpotter announcer weak subscribe: GTSpotterSelectedCandidateChanged send: #onCandidateSelected: to: self.
	aSpotter announcer weak subscribe: GTSpotterStepPopped send: #onStepPopped to: self.
	aSpotter announcer weak subscribe: GTSpotterStepAdded send: #onStepAdded to: self
	
	
]

{ #category : #updating }
GTSpotterPreviewBrick >> updatePreviewWith: anObject [

	self spotterModel isPreviewVisible ifFalse: [ ^ self ].
	
	self asyncTask
		execute: [ :composite :entity |
				[ anObject spotterPreviewIn: composite inContext: self spotterModel ]
					on: Exception
					do: [ composite removeAllBricks ].
				 composite ]
		withArguments: { self newCompositeBrick . anObject }
		callback: [ :composite |
			self compositeBrick: composite.
			self changed ]
		priority: Processor userBackgroundPriority
		delay: 300
]
