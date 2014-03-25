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

{ #category : #accessing }
GTMetacellerAnalyzer >> helpText [
	^'Todo'
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
	self versionEditIn: aBrowser
]

{ #category : #building }
GTMetacellerAnalyzer >> versionEditIn: aBrowser [
	aBrowser text
		title: 'Edit';
		format: #specString;
		act: [ :b :version | self save: b text in: version ] icon: GLMUIThemeExtraIcons glamorousAccept on: $s entitled: 'save'
]
