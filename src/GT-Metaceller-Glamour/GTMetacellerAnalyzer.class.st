Class {
	#name : #GTMetacellerAnalyzer,
	#superclass : #GTConfigurationBrowserTemplate,
	#category : #'GT-Metaceller-Glamour'
}

{ #category : #building }
GTMetacellerAnalyzer >> buttonsForVersionsAndGroups: aBrowser [
	aBrowser actionList
		act: [ :entity :version :item | self validateVersion: version item: item ] entitled: 'Validate';
		act: [ :entity :version :item | self testVersion: version item: item ] entitled: 'Test';
		act: [ :entity :version :item | self newVersion: version ] entitled: 'New version...';
		allowNil;
		yourself.
	aBrowser actionList
		act: [ :entity :version :item | self validateVersion: version item: item ] entitled: 'Validate';
		act: [ :entity :version :item | self testVersion: version item: item ] entitled: 'Test';
		act: [ :entity :version :item | self newVersion: version ] entitled: 'New version...';
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
GTMetacellerAnalyzer >> commonItemEditIn: aBrowser [
	aBrowser text
		display: #commonVersion;
		format: #specString;
		act: [ :b :item | self save: b text in: item commonVersion ] icon: GLMUIThemeExtraIcons glamorousAccept on: $s entitled: 'save'
]

{ #category : #building }
GTMetacellerAnalyzer >> commonVersionEditIn: aBrowser [
	aBrowser text
		display: #commonVersion;
		format: #specString;
		act: [ :b :version | self save: b text in: version commonVersion ] icon: GLMUIThemeExtraIcons glamorousAccept on: $s entitled: 'save'
]

{ #category : #building }
GTMetacellerAnalyzer >> groupsIn: aBrowser [
	^(super groupsIn: aBrowser)
		dynamicActionsOnSelection: [ :b | self itemActionsFor: b selection ];
		yourself
]

{ #category : #accessing }
GTMetacellerAnalyzer >> helpText [
	^'Todo'
]

{ #category : #building }
GTMetacellerAnalyzer >> itemActionsFor: aSelection [
	| retVal |
	retVal := OrderedCollection new.
	aSelection ifNotNil: [ 
		retVal
"	This does not work yet!		add: (GLMGenericAction new title: 'Remove'; action: [ aSelection remove ]);
"			add: (GLMGenericAction new title: 'Explore'; action: [ aSelection explore ]);
			yourself ].
	^retVal
]

{ #category : #building }
GTMetacellerAnalyzer >> itemDetailsIn: aBrowser [
	super itemDetailsIn: aBrowser.
	aBrowser custom: self itemEditBrowser.
	aBrowser custom: self itemUpdateBrowser
]

{ #category : #building }
GTMetacellerAnalyzer >> itemEditBrowser [
	| retVal |
	retVal := GLMTabulator new.
	retVal
		title: 'Edit';
		column: #platforms;
		column: #editItem;
		yourself.
	retVal transmit
		to: #platforms;
		andShow: [ :a | self platformsIn: a ].
	retVal transmit
		from: #platforms;
		to: #editItem;
		andShow: [ :a | self itemEditIn: a ].
	retVal transmit
		to: #editItem;
		andShow: [ :a | self commonItemEditIn: a ].
	^retVal
]

{ #category : #building }
GTMetacellerAnalyzer >> itemEditIn: aBrowser [
	aBrowser text
		title: 'Edit';
		format: #specString;
		act: [ :b :item | self save: b text in: item ] icon: GLMUIThemeExtraIcons glamorousAccept on: $s entitled: 'save'
]

{ #category : #building }
GTMetacellerAnalyzer >> itemUpdateActionsIn: aBrowser [
	aBrowser actionList
		act: [ :entity :selected | self updateItemToLatest: selected ] entitled: 'Set to latest';
		act: [ :entity :selected | self updateItemToCurrent: selected ] entitled: 'Set to current';
		yourself
]

{ #category : #building }
GTMetacellerAnalyzer >> itemUpdateBrowser [
	| retVal |
	retVal := GLMTabulator new.
	retVal
		title: 'Update';
		column: #actions;
		yourself.
	retVal transmit
		to: #actions;
		andShow: [ :a | self itemUpdateActionsIn: a ].
	^retVal
]

{ #category : #building }
GTMetacellerAnalyzer >> packagesIn: aBrowser [
	^(super packagesIn: aBrowser)
		dynamicActionsOnSelection: [ :b | self itemActionsFor: b selection ];
		yourself
]

{ #category : #building }
GTMetacellerAnalyzer >> platformsIn: aBrowser [
	^aBrowser tree
		display: #commonVersion;
		children: #childVersions;
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
GTMetacellerAnalyzer >> test: anItemOrList [
	self configuration test: anItemOrList.
	GTMetacellerModel announce: (GTConfigChanged on: self configuration)
]

{ #category : #actions }
GTMetacellerAnalyzer >> testConfiguration [
	self configuration test.
	GTMetacellerModel announce: (GTConfigChanged on: self configuration)
]

{ #category : #actions }
GTMetacellerAnalyzer >> testVersion: aVersion item: anItem [
	aVersion ifNil: [ ^self test: anItem ].
	aVersion test: anItem.
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
GTMetacellerAnalyzer >> validate: aGroupList [
	self configuration validate: aGroupList.
	GTMetacellerModel announce: (GTConfigChanged on: self configuration)
]

{ #category : #actions }
GTMetacellerAnalyzer >> validateConfiguration [
	self configuration validate.
	GTMetacellerModel announce: (GTConfigChanged on: self configuration)
]

{ #category : #actions }
GTMetacellerAnalyzer >> validateVersion: aVersion item: anItem [
	aVersion ifNil: [ ^self validate: anItem ].
	aVersion validate: anItem.
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
