Class {
	#name : #GTMetacellerAnalyzer,
	#superclass : #GTConfigurationBrowserTemplate,
	#category : #'GT-Metaceller-Glamour'
}

{ #category : #building }
GTMetacellerAnalyzer >> buttonsForVersionsAndGroups: aBrowser [
	aBrowser actionList
		act: [ :entity :version :groups | self validateVersion: version groups: groups ] entitled: 'Validate';
		act: [ :entity :version :groups | self testVersion: version groups: groups ] entitled: 'Test';
		act: [ :entity :version :groups | self newVersion: version ] entitled: 'New version...';
		allowNil;
		yourself.
	aBrowser actionList
		act: [ :entity :version :groups | self validateVersion: version groups: groups ] entitled: 'Validate';
		act: [ :entity :version :groups | self testVersion: version groups: groups ] entitled: 'Test';
		act: [ :entity :version :groups | self newVersion: version ] entitled: 'New version...';
		allowAllNil;
		yourself	
]

{ #category : #building }
GTMetacellerAnalyzer >> buttonsIn: aBrowser [
	aBrowser actionList
		act: [ :entity | self validateConfiguration ] entitled: 'Validate';
		act: [ :entity | self testConfiguration ] entitled: 'Test';
		act: [ :entity | self newVersion: nil ] entitled: 'New version...';
		yourself
]

{ #category : #building }
GTMetacellerAnalyzer >> commonVersionEditIn: aBrowser [
	aBrowser text
		display: #commonVersion;
		format: #specString;
		act: [ :b :version | self save: b text in: version commonVersion ] icon: GLMUIThemeExtraIcons glamorousAccept on: $s entitled: 'save'
]

{ #category : #accessing }
GTMetacellerAnalyzer >> helpText [
	^'Todo'
]

{ #category : #building }
GTMetacellerAnalyzer >> platformsIn: aBrowser [
	^aBrowser tree
		display: #commonVersion;
		children: #children;
		format: #platform;
		yourself
]

{ #category : #actions }
GTMetacellerAnalyzer >> promoteToRelease [
	self shouldBeImplemented.
]

{ #category : #actions }
GTMetacellerAnalyzer >> promoteToRelease: aVersion [
	aVersion promoteToRelease
]

{ #category : #actions }
GTMetacellerAnalyzer >> save: aSpecString in: aVersion [
	aVersion saveWithSpecString: aSpecString asString
]

{ #category : #actions }
GTMetacellerAnalyzer >> testConfiguration [
	self configuration test.
	GTMetacellerModel announce: (GTConfigChanged on: self configuration)
]

{ #category : #actions }
GTMetacellerAnalyzer >> testItems: aGroupList [
	self configuration testItems: aGroupList.
	GTMetacellerModel announce: (GTConfigChanged on: self configuration)
]

{ #category : #actions }
GTMetacellerAnalyzer >> testVersion: aVersion groups: aGroupList [
	aVersion ifNil: [ ^self testItems: aGroupList ].
	aVersion test: aGroupList.
	GTMetacellerModel announce: (GTConfigChanged on: self configuration)
]

{ #category : #accessing }
GTMetacellerAnalyzer >> title [
	^self configuration title
]

{ #category : #actions }
GTMetacellerAnalyzer >> updateVersionToCurrent: aVersion [ 
	aVersion updateToCurrentAndSave
]

{ #category : #actions }
GTMetacellerAnalyzer >> validateConfiguration [
	self configuration validate.
	GTMetacellerModel announce: (GTConfigChanged on: self configuration)
]

{ #category : #actions }
GTMetacellerAnalyzer >> validateItems: aGroupList [
	self configuration validateItems: aGroupList.
	GTMetacellerModel announce: (GTConfigChanged on: self configuration)
]

{ #category : #actions }
GTMetacellerAnalyzer >> validateVersion: aVersion groups: aGroupList [
	aVersion ifNil: [ ^self validateItems: aGroupList ].
	aVersion validate: aGroupList.
	GTMetacellerModel announce: (GTConfigChanged on: self configuration)
]

{ #category : #building }
GTMetacellerAnalyzer >> versionActionsFor: aVersion [
	aVersion ifNil: [ ^super versionActionsFor: aVersion ].
	^(super versionActionsFor: aVersion)
		add: (GLMGenericAction new title: 'Copy...'; action: [ self newVersion: aVersion ]);
		yourself
	
]

{ #category : #building }
GTMetacellerAnalyzer >> versionDetailsIn: aBrowser [
	super versionDetailsIn: aBrowser.
	aBrowser custom: self versionEditBrowser.
	aBrowser custom: self versionUpdateBrowser
]

{ #category : #building }
GTMetacellerAnalyzer >> versionEditBrowser [
	| retVal |
	retVal := GLMTabulator new.
	retVal
		title: 'Edit';
		column: #platforms;
		column: #editVersion;
		yourself.
	retVal transmit
		to: #platforms;
		andShow: [ :a | self platformsIn: a ].
	retVal transmit
		from: #platforms;
		to: #editVersion;
		andShow: [ :a | self versionEditIn: a ].
	retVal transmit
		to: #editVersion;
		andShow: [ :a | self commonVersionEditIn: a ].
	^retVal
]

{ #category : #building }
GTMetacellerAnalyzer >> versionEditIn: aBrowser [
	aBrowser text
		title: 'Edit';
		format: #specString;
		act: [ :b :version | self save: b text in: version ] icon: GLMUIThemeExtraIcons glamorousAccept on: $s entitled: 'save'
]

{ #category : #building }
GTMetacellerAnalyzer >> versionUpdateActionsIn: aBrowser [
	aBrowser actionList
			act: [ :entity :selected | self updateVersionToLatest: selected ] entitled: 'Set to latest';
			act: [ :entity :selected | self updateVersionToCurrent: selected ] entitled: 'Set to current';
			act: [ :entity :selected | self promoteToRelease: selected ] entitled: 'Release';
		yourself
]

{ #category : #building }
GTMetacellerAnalyzer >> versionUpdateBrowser [
	| retVal |
	retVal := GLMTabulator new.
	retVal
		title: 'Update';
		column: #actions;
		yourself.
	retVal transmit
		to: #actions;
		andShow: [ :a | self versionUpdateActionsIn: a ].
	^retVal
]
