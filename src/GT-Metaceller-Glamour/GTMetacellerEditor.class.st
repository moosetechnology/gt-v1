Class {
	#name : #GTMetacellerEditor,
	#superclass : #GTConfigurationBrowserTemplate,
	#category : #'GT-Metaceller-Glamour'
}

{ #category : #building }
GTMetacellerEditor >> analyzerButtonsIn: aBrowser [
	
]

{ #category : #building }
GTMetacellerEditor >> analyzerDetailsIn: aBrowser [
	self editItemsIn: aBrowser.
	(self editItemsIn: aBrowser)
		allowAllNil.
]

{ #category : #building }
GTMetacellerEditor >> buildBrowser [
	browser := GLMTabulator new.
	browser title: self title.
	browser
		act: [ :b | 
			Workspace new
				contents: self helpText;
				openLabel: 'Metaceller editor help' ]
		icon: GLMUIThemeExtraIcons glamorousHelp
		entitled: 'Help'.
	browser
		row: [ :r | r
			column: #versions;
			column: #platforms;
			column: #items ];
		row: #details;
		row: #buttons size: 30.
	browser transmit
		to: #versions;
		andShow: [ :a | self versionsIn: a ].
	browser transmit
		to: #platforms;
		andShow: [ :a | self platformsIn: a ].
	browser transmit
		to: #items;
		andShow: [ :a | self itemsFromConfigurationIn: a ].
	browser transmit
		to: #items;
		from: #versions;
		from: #platforms;
		andShow: [ :a | self itemsFromVersionAndPlatformsIn: a ].
	browser transmit
		to: #details;
		andShow: [ :a | self detailsIn: a ].
	browser transmit
		to: #details;
		from: #versions;
		from: #platforms;
		from: #items;
		andShow: [ :a | self analyzerDetailsIn: a ].
	browser transmit
		to: #buttons;
		andShow: [ :a | self analyzerButtonsIn: a ].
	browser transmit
		to: #buttons;
		from: #versions;
		from: #platforms;
		from: #items;
		andShow: [ :a | self analyzerButtonsIn: a ].
	^ browser
]

{ #category : #building }
GTMetacellerEditor >> buttonsForVersionsAndItems: aBrowser [
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
GTMetacellerEditor >> buttonsIn: aBrowser [
	aBrowser actionList
		act: [ :entity | self validateConfiguration ] entitled: 'Validate';
		act: [ :entity | self testConfiguration ] entitled: 'Test';
		act: [ :entity | self newVersion: nil ] entitled: 'New version...';
		yourself
]

{ #category : #building }
GTMetacellerEditor >> childPlatformsFor: aSymbol [
	(aSymbol = nil) ifTrue: [ ^#() ].
	^self configuration childPlatformsFor: aSymbol
]

{ #category : #building }
GTMetacellerEditor >> detailsIn: aBrowser [
	self editConfigurationIn: aBrowser
]

{ #category : #building }
GTMetacellerEditor >> editConfigurationIn: aBrowser [
	aBrowser text
		display: [ GTSpecEditor onConfiguration: self configuration ];
		title: 'Edit';
		format: #specString;
		act: [ :b :item | item save: b text ] icon: GLMUIThemeExtraIcons glamorousAccept on: $s entitled: 'save'
]

{ #category : #building }
GTMetacellerEditor >> editItemsIn: aBrowser [
	^aBrowser text
		display: [ :version :platforms :items | GTSpecEditor onConfiguration: self configuration version: version platforms: platforms items: items ];
		title: 'Edit';
		format: #specString;
		allowNil;
		act: [ :b :item | item save: b text ] icon: GLMUIThemeExtraIcons glamorousAccept on: $s entitled: 'save'
]

{ #category : #selection }
GTMetacellerEditor >> groupsFor: aVersion platform: aPlatform [ 
	| project |
	project := self projectForPlatforms: aPlatform.
	^(project version: aVersion ifAbsent: [ project defaultVersion ]) groups
]

{ #category : #building }
GTMetacellerEditor >> groupsFromVersionAndPlatformIn: aBrowser [
	^aBrowser list
		title: 'Groups';
		display: [ :version :platform | self groupsFor: version platform: platform ];
		format: #labelAsText;
		updateOn: GTConfigChanged from: self announcer;
		dynamicActionsOnSelection: [ :b | self itemActionsFor: b selection ];
		beMultiple;
		allowDeselection;
		allowNil;
		yourself
]

{ #category : #building }
GTMetacellerEditor >> groupsIn: aBrowser [
	^(super groupsIn: aBrowser)
		dynamicActionsOnSelection: [ :b | self itemActionsFor: b selection ];
		yourself
]

{ #category : #accessing }
GTMetacellerEditor >> helpText [
	^'Todo'
]

{ #category : #building }
GTMetacellerEditor >> itemActionsFor: aSelection [
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
GTMetacellerEditor >> itemDetailsIn: aBrowser [
	aBrowser
]

{ #category : #building }
GTMetacellerEditor >> itemsFromVersionAndPlatformsIn: aBrowser [
	self groupsFromVersionAndPlatformIn: aBrowser.
	self packagesFromVersionAndPlatformsIn: aBrowser.
	(self groupsFromVersionAndPlatformIn: aBrowser)
		allowAllNil;
		yourself.
	(self packagesFromVersionAndPlatformsIn: aBrowser)
		allowAllNil;
		yourself
]

{ #category : #selection }
GTMetacellerEditor >> packagesAndGroupsFor: aVersion platform: aPlatform [
	| project |
	project := self projectForPlatforms: aPlatform.
	^(project version: aVersion ifAbsent: [ project defaultVersion ]) groupsAndLoosePackages
]

{ #category : #building }
GTMetacellerEditor >> packagesFromVersionAndPlatformsIn: aBrowser [
	^aBrowser tree
		title: 'Packages';
		display: [ :version :platform | self packagesAndGroupsFor: version platform: platform ];
		children: [ :item | self childrenForItem: item ];
		format: #labelAsText;
		updateOn: GTConfigChanged from: self announcer;
		dynamicActionsOnSelection: [ :b | self itemActionsFor: b selection ];
		beMultiple;
		allowNil;
		allowDeselection;
		yourself
]

{ #category : #building }
GTMetacellerEditor >> packagesIn: aBrowser [
	^(super packagesIn: aBrowser)
		dynamicActionsOnSelection: [ :b | self itemActionsFor: b selection ];
		yourself
]

{ #category : #building }
GTMetacellerEditor >> platformsIn: aBrowser [
	^aBrowser tree
		title: 'Platform';
		display: [ Array with: nil with: #'common' ];
		children: [ :aSymbol | self childPlatformsFor: aSymbol ];
		format: [ :item | item
				ifNil: [ 'main' ]
				ifNotNil: [ item asString ] ];
		beMultiple;
		yourself
]

{ #category : #accessing }
GTMetacellerEditor >> projectForPlatform: aPlatform [
	aPlatform ifNil: [ ^self configuration mainProject ].
	^self configuration projectFor: aPlatform
]

{ #category : #accessing }
GTMetacellerEditor >> projectForPlatforms: aPlatformList [
	aPlatformList ifNil: [ ^self configuration mainProject ].
	aPlatformList isString ifTrue: [ ^self projectForPlatform: aPlatformList ].
	aPlatformList size = 1 ifTrue: [ ^self projectForPlatform: aPlatformList anyOne ].
	^self configuration mainProject
]

{ #category : #actions }
GTMetacellerEditor >> promoteToRelease: aVersion [
	aVersion promoteToRelease
]

{ #category : #actions }
GTMetacellerEditor >> save: aSpecString in: aVersion [
	aVersion saveWithSpecString: aSpecString asString
]

{ #category : #actions }
GTMetacellerEditor >> test: anItemOrList [
	self configuration test: anItemOrList.
	GTMetacellerModel announce: (GTConfigChanged on: self configuration)
]

{ #category : #actions }
GTMetacellerEditor >> testConfiguration [
	self configuration test.
	GTMetacellerModel announce: (GTConfigChanged on: self configuration)
]

{ #category : #actions }
GTMetacellerEditor >> testVersion: aVersion item: anItem [
	aVersion ifNil: [ ^self test: anItem ].
	aVersion test: anItem.
	GTMetacellerModel announce: (GTConfigChanged on: self configuration)
]

{ #category : #accessing }
GTMetacellerEditor >> title [
	^self configuration title
]

{ #category : #actions }
GTMetacellerEditor >> updateVersionToCurrent: aVersion [ 
	aVersion updateToCurrentAndSave
]

{ #category : #actions }
GTMetacellerEditor >> validate: aGroupList [
	self configuration validate: aGroupList.
	GTMetacellerModel announce: (GTConfigChanged on: self configuration)
]

{ #category : #actions }
GTMetacellerEditor >> validateConfiguration [
	self configuration validate.
	GTMetacellerModel announce: (GTConfigChanged on: self configuration)
]

{ #category : #actions }
GTMetacellerEditor >> validateVersion: aVersion item: anItem [
	aVersion ifNil: [ ^self validate: anItem ].
	aVersion validate: anItem.
	GTMetacellerModel announce: (GTConfigChanged on: self configuration)
]
