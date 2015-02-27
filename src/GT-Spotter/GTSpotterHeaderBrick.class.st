Class {
	#name : #GTSpotterHeaderBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'stepsBrick',
		'searchField',
		'closeButton',
		'spotterModel',
		'agreementButton'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #accessing }
GTSpotterHeaderBrick >> agreementButton: aBrick [

	agreementButton ifNotNil: [self removeBrick: agreementButton].
	agreementButton := aBrick.
	
	self themer spotterThemer agreementButtonStyleFor: agreementButton.
	agreementButton
		addHoverAction: [ :b | self openAgreementFor: b ].
	
	self addBrickBack: agreementButton
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
	self agreementButton: self newAgreementButton.
	self closeButton: self newCloseButton.
	
]

{ #category : #'instance creation' }
GTSpotterHeaderBrick >> newAgreementButton [
	^ GLMActionButtonBrick new
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

	self searchField morph updateTextWith: self spotterModel currentStep context text.
	self searchField morph moveCursorAtTheEnd
]

{ #category : #'event-handling' }
GTSpotterHeaderBrick >> openAgreementFor: aBrick [
	^ GLMPopupDialogBrick new
			addContentBrick: (
				GLMPrivacyAgreementBrick new
					padding: 2;
					borderColor: Color lightGray;
					borderWidth: 2;
					margin: 10;
					width: 300;
					vShrinkWrap;
					applicationName: 'Spotter';
					buttonText: 'Save as default';
					buttonAction: [ self inform: 'You have agreed.' ];
					checkboxAction: [ :boolean | 
						self inform: 'Send anonymous data set to ', boolean asString ];
					with: [ :brick |
						brick advancedOption
							text: 'Include search query and selected search results';
							action: [ :boolean | 
								self inform: 'Include search query set to ', boolean asString ].
						brick advancedOption
							text: 'Include developer name';
							uncheck;
							action: [ :boolean | 
								self inform: 'Include developer name set to ', boolean asString ].
						];					
					yourself);
			openBelowFor: aBrick
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
