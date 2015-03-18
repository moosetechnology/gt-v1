Class {
	#name : #GTSpotterPrivacyAgreementNotificationBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'messageBrick',
		'settingsButtonBrick'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #examples }
GTSpotterPrivacyAgreementNotificationBrick class >> example [
	<example: 'Simple agreement'>
	^ self new
]

{ #category : #examples }
GTSpotterPrivacyAgreementNotificationBrick class >> exampleOpen [

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

{ #category : #utils }
GTSpotterPrivacyAgreementNotificationBrick class >> openSettingsBrowser [
	| settingsBrowser window node nodePath |
	settingsBrowser := SettingBrowser new 
		changePackageSet: (RPackage organizer packageNamed: 'GT-Spotter-EventRecorder') asOrderedCollection;
		yourself.
	window := settingsBrowser open.
	window position: Display extent - window extent // 2.
	settingsBrowser expandAll.
	node := settingsBrowser treeHolder nodeNamed: #sendUsageData.
	nodePath := Array 
		with: (settingsBrowser treeHolder nodeNamed: node parentName)
		with: node.
	settingsBrowser selection: (MorphTreeMorphSingleSelection new selectedNodePath: nodePath).
]

{ #category : #initialization }
GTSpotterPrivacyAgreementNotificationBrick >> initialize [
	super initialize.
	
	self useHorizontalLinearLayout.
	self hSpaceFill.
	self vShrinkWrap.
	self messageBrick: self newTitleBrick.
	self settingsButtonBrick: self newButtonBrick.
]

{ #category : #accessing }
GTSpotterPrivacyAgreementNotificationBrick >> messageBrick [
	^ messageBrick
]

{ #category : #accessing }
GTSpotterPrivacyAgreementNotificationBrick >> messageBrick: anObject [

	messageBrick := anObject.
	self messageBrick
		hSpaceFill;
		margin:10;
		text: self privacyMessage.

	self addBrickBack: self messageBrick.
]

{ #category : #'instance creation' }
GTSpotterPrivacyAgreementNotificationBrick >> newButtonBrick [

	^ GLMButtonBrick new
]

{ #category : #'instance creation' }
GTSpotterPrivacyAgreementNotificationBrick >> newTitleBrick [

	^ GLMRubTextAreaBrick new
]

{ #category : #actions }
GTSpotterPrivacyAgreementNotificationBrick >> openSettingsBrowser [
	self class openSettingsBrowser.
	self owner owner closeSpotter.
]

{ #category : #accessing }
GTSpotterPrivacyAgreementNotificationBrick >> privacyMessage [

	^ self sendUsageData 
		ifTrue: [ 'You are sending anonymous usage data to help us improve Spotter. Thanks!' ]
		ifFalse: 	['No usage data is being sent. Would you like to send anonymous usage data to help us improve Spotter?']
]

{ #category : #preferences }
GTSpotterPrivacyAgreementNotificationBrick >> sendUsageData [
	| settingsClass |
	settingsClass := #GTSpotterEventRecorderSettings asClassIfAbsent: [ ^ false ].
	^ settingsClass sendUsageData
]

{ #category : #preferences }
GTSpotterPrivacyAgreementNotificationBrick >> sendUsageData: aBoolean [
	| settingsClass |
	settingsClass := #GTSpotterEventRecorderSettings asClassIfAbsent: [ ^ self ].
	^ settingsClass sendUsageData: aBoolean
]

{ #category : #accessing }
GTSpotterPrivacyAgreementNotificationBrick >> settingsButtonBrick [
	^ settingsButtonBrick
]

{ #category : #accessing }
GTSpotterPrivacyAgreementNotificationBrick >> settingsButtonBrick: anObject [
	settingsButtonBrick := anObject.
	
	self settingsButtonBrick
		text: self settingsButtonLabel;
		hShrinkWrap;
		margin:10;
		when: #onClicked do: [ self openSettingsBrowser ].
	
	self addBrickBack: self settingsButtonBrick
]

{ #category : #accessing }
GTSpotterPrivacyAgreementNotificationBrick >> settingsButtonLabel [
	
	^ self sendUsageData 
		ifTrue: [ 'Change preferences' ]
		ifFalse: [  'Go to settings' ]
]
