Class {
	#name : #GTSpotterHeaderBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'stepsBrick',
		'searchField',
		'closeButton',
		'spotterModel',
		'settingsButton'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #accessing }
GTSpotterHeaderBrick >> closeButton [

	^ closeButton
]

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
	#GTSpotterEventRecorderSettings asClassIfPresent: [ 
		self settingsButton: self newSettingsButton ].
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
GTSpotterHeaderBrick >> newSettingsButton [

	^ GLMHintableActionButtonBrick new
]

{ #category : #'instance creation' }
GTSpotterHeaderBrick >> newStepsBand [

	^ GLMBrick new
]

{ #category : #'event handling' }
GTSpotterHeaderBrick >> onCurrentStepChanged [

	self searchField morph updateTextWith: self spotterModel currentStep context text.
	self searchField morph moveCursorAtTheEnd
]

{ #category : #'event handling' }
GTSpotterHeaderBrick >> onHideHints [

	self themer spotterThemer hintHideStyleFor: self settingsButton.
	self themer spotterThemer hintHideStyleFor: self closeButton.
]

{ #category : #'event handling' }
GTSpotterHeaderBrick >> onRevealHints [

	self themer spotterThemer hintRevealStyleFor: self settingsButton.
	self themer spotterThemer hintRevealStyleFor: self closeButton
]

{ #category : #accessing }
GTSpotterHeaderBrick >> openSettingsBrowserFor: aBrick [

	SettingBrowser new 
		changePackageSet: (RPackage organizer packageNamed: 'GT-Spotter-EventRecorder') asOrderedCollection; 
		open; 
      expandAll.
]

{ #category : #accessing }
GTSpotterHeaderBrick >> openSettingsFor: aBrick [

	^ GLMPopupDialogBrick new
			addContentBrick: (
				GLMPrivacyAgreementBrick new
					width: 250;
					padding: #(5 10);
					vShrinkWrap;
					yourself);
			with: [ :b | b contentBrick ];
			openBelowFor: aBrick;
			beRightToLeftWithOffset: 50
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
GTSpotterHeaderBrick >> settingsButton [

	^ settingsButton
]

{ #category : #accessing }
GTSpotterHeaderBrick >> settingsButton: aBrick [

	settingsButton ifNotNil: [self removeBrick: settingsButton].
	settingsButton := aBrick.
	
	self themer spotterThemer settingsButtonStyleFor: settingsButton.
	settingsButton
		hintTitle: 'Settings';
		hintText: 'Shows the settings UI';
		addUpAction: [ self openSettingsBrowserFor: settingsButton ].
	
	self addBrickBack: settingsButton
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
	
	self spotterModel announcer weak subscribe: GTSpotterRevealHints send: #onRevealHints to: self.
	self spotterModel announcer weak subscribe: GTSpotterHideHints send: #onHideHints to: self.
]
