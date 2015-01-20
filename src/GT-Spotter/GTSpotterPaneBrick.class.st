Class {
	#name : #GTSpotterPaneBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'contentsBrick',
		'previewBrick'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #accessing }
GTSpotterPaneBrick >> contentsBrick [

	^ contentsBrick
]

{ #category : #accessing }
GTSpotterPaneBrick >> contentsBrick: aBrick [
	
	contentsBrick ifNotNil: [self removeBrick: contentsBrick].
	contentsBrick := aBrick.
		
	self theme spotterWidgetThemer spotterContentsStyleFor: contentsBrick.

	self addBrickBack: contentsBrick
]

{ #category : #action }
GTSpotterPaneBrick >> hidePreview [

	(self hasSubbrick: self previewBrick) ifFalse: [ ^ self ].

	self removeBrick: self previewBrick.
	self contentsBrick layout horizontalPercent: 100.
	self doLayout.
	self changed.
]

{ #category : #initialization }
GTSpotterPaneBrick >> initialize [
	super initialize.
	
	self contentsBrick: self newContentsBrick.
	self previewBrick: self newPreviewBrick
]

{ #category : #'instance creation' }
GTSpotterPaneBrick >> newContentsBrick [

	^ GTSpotterContentsBrick new
]

{ #category : #'instance creation' }
GTSpotterPaneBrick >> newPreviewBrick [

	^ GTSpotterPreviewBrick new
]

{ #category : #accessing }
GTSpotterPaneBrick >> previewBrick [

	^ previewBrick
]

{ #category : #accessing }
GTSpotterPaneBrick >> previewBrick: aBrick [

	previewBrick ifNotNil: [self removeBrick: aBrick].
	previewBrick := aBrick.
	
	self theme spotterWidgetThemer spotterPreviewStyleFor: previewBrick
]

{ #category : #action }
GTSpotterPaneBrick >> showPreview [
	
	(self hasSubbrick: self previewBrick) ifTrue: [ ^ self ].
	
	self addBrickBack: self previewBrick.
	self contentsBrick layout horizontalPercent: (100 - self previewBrick layout horizontalPercent).
	self doLayout.
	self changed.
]

{ #category : #accessing }
GTSpotterPaneBrick >> spotterModel: aSpotter [

	self contentsBrick spotterModel: aSpotter
]
