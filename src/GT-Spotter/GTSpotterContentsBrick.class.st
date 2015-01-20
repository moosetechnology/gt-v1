Class {
	#name : #GTSpotterContentsBrick,
	#superclass : #GLMBandBrick,
	#instVars : [
		'headerBrick',
		'dropDownBrick',
		'spotterModel'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #accessing }
GTSpotterContentsBrick >> dropDownBrick [
	^ dropDownBrick
]

{ #category : #accessing }
GTSpotterContentsBrick >> dropDownBrick: aBrick [
	
	dropDownBrick ifNotNil: [self removeBrick: dropDownBrick].
	dropDownBrick := aBrick.
	
	dropDownBrick pagerModel: self spotterModel pagerModel.
	self theme spotterWidgetThemer dropDownPaneStyleFor: dropDownBrick.
	
	self addBrickBack: dropDownBrick
]

{ #category : #accessing }
GTSpotterContentsBrick >> headerBrick [
	^ headerBrick
]

{ #category : #accessing }
GTSpotterContentsBrick >> headerBrick: aBrick [
	
	headerBrick ifNotNil: [self removeBrick: headerBrick].
	headerBrick := aBrick.
	
	self theme spotterWidgetThemer headerStyleFor: headerBrick.
	
	self addBrickBack: headerBrick
]

{ #category : #initialization }
GTSpotterContentsBrick >> initialize [
	super initialize.
		
	self headerBrick: self newHeaderBrick.
]

{ #category : #testing }
GTSpotterContentsBrick >> isDropDownPaneVisible [

	^ self dropDownBrick isNotNil
]

{ #category : #'instance creation' }
GTSpotterContentsBrick >> newDropDownMorph [

	^ GTSpotterDropDownMorph new
]

{ #category : #'instance creation' }
GTSpotterContentsBrick >> newHeaderBrick [

	^ GTSpotterHeaderBrick new
]

{ #category : #'events-processing' }
GTSpotterContentsBrick >> onStepAdded [
	"as soon as step added I need to show drop down pane"
	self isDropDownPaneVisible ifTrue: [ ^ self ].
	
	self showDropDownPane
]

{ #category : #actions }
GTSpotterContentsBrick >> showDropDownPane [

	self dropDownBrick: self newDropDownMorph.
	self dropDownBrick spotterModel: self spotterModel.
	self brickRoot extent: self extent.
]

{ #category : #accessing }
GTSpotterContentsBrick >> spotterModel [

	^ spotterModel
]

{ #category : #accessing }
GTSpotterContentsBrick >> spotterModel: aModel [

	spotterModel := aModel.
	self headerBrick spotterModel: spotterModel.
	
	spotterModel steps isEmpty ifFalse: [ spotterModel currentStep isEmpty ifFalse: [ self showDropDownPane ] ].

	spotterModel announcer subscribe: GTSpotterStepAdded send: #onStepAdded to: self.
]
