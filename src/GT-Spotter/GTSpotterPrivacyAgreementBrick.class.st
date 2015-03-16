Class {
	#name : #GTSpotterPrivacyAgreementBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'basicAgreeCheckboxBrick',
		'defaultSettingsInfoBrick',
		'saveDefaultSettingsButtonBrick',
		'messageBrick',
		'settingsButtonBrick'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #examples }
GTSpotterPrivacyAgreementBrick class >> example [
	<example: 'Simple agreement'>
	^ self new
]

{ #category : #examples }
GTSpotterPrivacyAgreementBrick class >> exampleOpen [

	(GLMBrick new
		hSpaceFill;
		vSpaceFill;
		addBrickBack: (
			self example
				padding: 2;
				borderColor: Color lightGray;
				borderWidth: 2;
				margin: 10;
				hSpaceFill;
				vShrinkWrap;
				yourself);
		yourself)
			openInBrickWindow
			extent: 600@400
]

{ #category : #initialization }
GTSpotterPrivacyAgreementBrick >> initialize [
	super initialize.
	
	self useHorizontalLinearLayout.
	self hSpaceFill.
	self vShrinkWrap.
	self messageBrick: self newTitleBrick.
	self settingsButtonBrick: self newButtonBrick.
]

{ #category : #accessing }
GTSpotterPrivacyAgreementBrick >> messageBrick [
	^ messageBrick
]

{ #category : #accessing }
GTSpotterPrivacyAgreementBrick >> messageBrick: anObject [

	messageBrick := anObject.
	self messageBrick
		hSpaceFill;
		margin:10;
		text: self privacyMessage.

	self addBrickBack: self messageBrick.
]

{ #category : #'instance creation' }
GTSpotterPrivacyAgreementBrick >> newButtonBrick [

	^ GLMButtonBrick new
]

{ #category : #'instance creation' }
GTSpotterPrivacyAgreementBrick >> newTitleBrick [

	^ GLMRubTextAreaBrick new
]

{ #category : #actions }
GTSpotterPrivacyAgreementBrick >> openSettingsBrowser [

	(SettingBrowser new 
		changePackageSet: (RPackage organizer packageNamed: 'GT-Spotter-EventRecorder') asOrderedCollection; 
		expandAll;
		open) position: self owner owner positionInWorld.
	self owner owner closeSpotter.
]

{ #category : #accessing }
GTSpotterPrivacyAgreementBrick >> privacyMessage [

	^ self sendUsageData 
		ifTrue: [ 'You are sending anonymous usage data to help us improve spotter. Thanks!' ]
		ifFalse: 	['Would you like to send anonymous usage data to help us improve Spotter?']
]

{ #category : #preferences }
GTSpotterPrivacyAgreementBrick >> sendUsageData [
	| settingsClass |
	settingsClass := #GTSpotterEventRecorderSettings asClassIfAbsent: [ ^ false ].
	^ settingsClass sendUsageData
]

{ #category : #preferences }
GTSpotterPrivacyAgreementBrick >> sendUsageData: aBoolean [
	| settingsClass |
	settingsClass := #GTSpotterEventRecorderSettings asClassIfAbsent: [ ^ self ].
	^ settingsClass sendUsageData: aBoolean
]

{ #category : #accessing }
GTSpotterPrivacyAgreementBrick >> settingsButtonBrick [
	^ settingsButtonBrick
]

{ #category : #accessing }
GTSpotterPrivacyAgreementBrick >> settingsButtonBrick: anObject [
	settingsButtonBrick := anObject.
	
	self settingsButtonBrick
		text: self settingsButtonLabel;
		hShrinkWrap;
		margin:10;
		when: #onClicked do: [ self openSettingsBrowser ].
	
	self addBrickBack: self settingsButtonBrick
]

{ #category : #accessing }
GTSpotterPrivacyAgreementBrick >> settingsButtonLabel [
	
	^ self sendUsageData 
		ifTrue: [ 'Change preferences' ]
		ifFalse: [  'Go to settings' ]
]
