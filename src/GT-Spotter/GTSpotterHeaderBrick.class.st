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
	
	self themer spotterThemer closeButtonStyleFor: closeButton.
	closeButton
		hintTitle: 'Close Spotter';
		hintText: '<escape>';
		addUpAction: [ self spotterModel exit ].
	
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

	^ GLMHintableActionButtonBrick new
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

	self searchField morph updateTextWith: self spotterModel currentStep query.
	self searchField morph moveCursorAtTheEnd
]

{ #category : #accessing }
GTSpotterHeaderBrick >> searchField [

	^ searchField
]

{ #category : #accessing }
GTSpotterHeaderBrick >> searchField: aMorph [

	searchField ifNotNil: [self removeBrick: searchField].
	searchField := aMorph asBrick.
	
	self themer spotterThemer searchFieldStyleFor: searchField.
	
	searchField morph takeKeyboardFocus.
	
	self addBrickBack: searchField
]

{ #category : #accessing }
GTSpotterHeaderBrick >> spotterModel [

	^ spotterModel
]

{ #category : #accessing }
GTSpotterHeaderBrick >> spotterModel: aModel [ 

	spotterModel := aModel.
	self searchField morph on: spotterModel.

	spotterModel announcer weak subscribe: GTSpotterCurrentStepChanged send: #onCurrentStepChanged to: self.
]
