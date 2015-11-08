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
GTSpotterPrivacyAgreementNotificationBrick class >> exampleOpen [

	(GLMBrick new
		hSpaceFill;
		vSpaceFill;
		addBrickBack: (
			self gtExample
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

{ #category : #examples }
GTSpotterPrivacyAgreementNotificationBrick class >> gtExample [
	<gtExample>
	<label: 'Simple agreement'>
	
	^ self new
]

{ #category : #utils }
GTSpotterPrivacyAgreementNotificationBrick class >> openSettingsBrowser [
	| settingsBrowser window node nodePath |
	settingsBrowser := SettingBrowser new 
		changePackageSet: (RPackage organizer packageNamed: 'GT-EventRecorder') asOrderedCollection;
		yourself.
	window := settingsBrowser open.
	window position: Display extent - window extent // 2.
	settingsBrowser expandAll.
	node := settingsBrowser treeHolder nodeNamed: #sendDiagnosticsAndUsageData.
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
		ifTrue: [ 'You are sending diagnostic and usage data to help us improve Pharo. Thanks!' ]
		ifFalse: 	['No diagnostic and usage data is being sent. Would you like to send diagnostic and usage data to help us improve Pharo?']
]

{ #category : #preferences }
GTSpotterPrivacyAgreementNotificationBrick >> sendUsageData [
	| settingsClass |
	settingsClass := #Privacy asClassIfAbsent: [ ^ false ].
	^ settingsClass sendDiagnosticsAndUsageData
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
		vAlign: #center;
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
