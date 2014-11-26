Class {
	#name : #GTSpotterItemBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'iconBrick',
		'labelBrick',
		'stepModel',
		'candidateLink'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #accessing }
GTSpotterItemBrick >> candidate [

	^ candidateLink value
]

{ #category : #accessing }
GTSpotterItemBrick >> candidateLink [

	^ candidateLink
]

{ #category : #accessing }
GTSpotterItemBrick >> candidateLink: aDoubleLink [ 

	candidateLink := aDoubleLink
]

{ #category : #'event handling' }
GTSpotterItemBrick >> doubleClick: evt [

	self stepModel act
]

{ #category : #'event handling' }
GTSpotterItemBrick >> handlesMouseDown: evt [
	^ true
]

{ #category : #accessing }
GTSpotterItemBrick >> icon: aForm [

	self iconBrick normalImage: aForm.
]

{ #category : #accessing }
GTSpotterItemBrick >> iconBrick [
	^ iconBrick
]

{ #category : #accessing }
GTSpotterItemBrick >> iconBrick: aBrick [

	iconBrick ifNotNil: [self removeBrick: iconBrick].
	iconBrick := aBrick.
	
	self theme spotterWidgetThemer itemIconStyleFor: iconBrick.
	
	self addBrickBack: iconBrick
]

{ #category : #initialization }
GTSpotterItemBrick >> initialize [
	super initialize.
	
	self theme spotterWidgetThemer itemNormalStyleFor: self.
	
	self iconBrick: self newIconBrick.
	self labelBrick: self newLabelBrick.
]

{ #category : #accessing }
GTSpotterItemBrick >> labelBrick [
	^ labelBrick
]

{ #category : #accessing }
GTSpotterItemBrick >> labelBrick: aBrick [

	labelBrick ifNotNil: [self removeBrick: labelBrick].
	labelBrick := aBrick.
	
	self theme spotterWidgetThemer itemLabelStyleFor: labelBrick.
	
	self addBrickBack: labelBrick
]

{ #category : #'event handling' }
GTSpotterItemBrick >> mouseDown: evt [
	|selectors|
	
	selectors := Array
				with: #singleClick:
				with: #doubleClick:
				with: nil
				with: nil.
				
	evt hand
		waitForClicksOrDrag: self
		event: evt
		selectors: selectors
		threshold: 10
	
]

{ #category : #'instance creation' }
GTSpotterItemBrick >> newIconBrick [

	^ GLMInteractableBrick new normalImage: ((Form extent: 16@16 depth: 32) fillAlpha: 0)
]

{ #category : #'instance creation' }
GTSpotterItemBrick >> newLabelBrick [

	^ GLMLabelBrick new text: 'Search result with very very long name'.
]

{ #category : #notifying }
GTSpotterItemBrick >> notifySelected [

	self announcer announce: (GTSpotterCandidateSelected new candidateBrick: self)
]

{ #category : #'event handling' }
GTSpotterItemBrick >> onSelectedChanged: ann [

	self selectOrDeselect
]

{ #category : #'event handling' }
GTSpotterItemBrick >> selectOrDeselect [

	self stepModel selected = self candidateLink
		ifTrue: [ self theme spotterWidgetThemer itemSelectedStyleFor: self. self notifySelected ]
		ifFalse: [ self theme spotterWidgetThemer itemNormalStyleFor: self ]
]

{ #category : #'event handling' }
GTSpotterItemBrick >> singleClick: evt [

	self stepModel selected: self candidateLink
]

{ #category : #accessing }
GTSpotterItemBrick >> stepModel [

	^ stepModel
]

{ #category : #accessing }
GTSpotterItemBrick >> stepModel: aModel [

	stepModel := aModel.
	
	stepModel announcer subscribe: GTSpotterSelectedCandidateChanged send: #onSelectedChanged: to: self.
	
	self selectOrDeselect
]

{ #category : #accessing }
GTSpotterItemBrick >> text: aString [

	self labelBrick text: aString.
]
