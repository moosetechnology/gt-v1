Class {
	#name : #GTSpotterHeaderBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'stepsBrick',
		'searchField',
		'closeButton',
		'spotterModel'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #accessing }
GTSpotterHeaderBrick >> closeButton: aBrick [

	closeButton ifNotNil: [self removeBrick: closeButton].
	closeButton := aBrick.
	
	self theme spotterWidgetThemer closeButtonStyleFor: closeButton.
	
	closeButton layoutProperties staticWidth: self height.	"to make button being a square"
	closeButton addUpAction: [ self spotterModel exit ].
	
	self addBrickBack: closeButton
]

{ #category : #initialization }
GTSpotterHeaderBrick >> initialize [
	super initialize.
	
	self searchField: self newSearchField.
	self closeButton: self newCloseButton.
	
]

{ #category : #'instance creation' }
GTSpotterHeaderBrick >> newCloseButton [

	^ GLMActionButtonBrick new
]

{ #category : #'instance creation' }
GTSpotterHeaderBrick >> newSearchField [

	^ GTSpotterSearchFieldMorph new
]

{ #category : #'instance creation' }
GTSpotterHeaderBrick >> newStepsBand [

	^ GLMBrick new
]

{ #category : #'event handling' }
GTSpotterHeaderBrick >> onCurrentStepChanged [

	self searchField updateTextWith: self spotterModel currentStep query.
	self searchField moveCursorAtTheEnd
]

{ #category : #accessing }
GTSpotterHeaderBrick >> searchField [

	^ searchField
]

{ #category : #accessing }
GTSpotterHeaderBrick >> searchField: aMorph [

	searchField ifNotNil: [self removeBrick: searchField].
	searchField := aMorph.
	
	self theme spotterWidgetThemer searchFieldStyleFor: searchField.
	
	searchField takeKeyboardFocus.
	
	self addBrickBack: searchField
]

{ #category : #accessing }
GTSpotterHeaderBrick >> spotterModel [

	^ spotterModel
]

{ #category : #accessing }
GTSpotterHeaderBrick >> spotterModel: aModel [ 

	spotterModel := aModel.
	self searchField on: spotterModel.

	spotterModel announcer subscribe: GTSpotterCurrentStepChanged send: #onCurrentStepChanged to: self.
]
