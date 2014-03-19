Class {
	#name : #GTMetacellerInstaller,
	#superclass : #GTMetacellerBrowserTemplate,
	#category : #'GT-Metaceller-Glamour'
}

{ #category : #building }
GTMetacellerInstaller >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Install ', self configuration configName.
	browser
		act: [ :b | 
			Workspace new
				contents: self helpText;
				openLabel: 'Metaceller install help' ]
		icon: GLMUIThemeExtraIcons glamorousHelp
		entitled: 'Help'.
	browser
		row: [ :r | r
			column: #versions;
			column: #groups ];
		row: #details;
		row: #buttons size: 30.
	browser transmit
		to: #versions;
		andShow: [ :a | self versionsIn: a ].
	browser transmit
		to: #groups;
		andShow: [ :a | self groupsIn: a ].
	browser transmit
		from: #versions;
		to: #details;
		andShow: [ :a | self details: a ].
	browser transmit
		from: #groups;
		to: #details;
		andShow: [ :a | self details: a ].
	browser transmit
		to: #details;
		andShow: [ :a | self details: a ].
	browser transmit
		to: #buttons;
		andShow: [ :a | self buttonsIn: a ].
	browser transmit
		from: #versions; from: #groups;
		to: #buttons;
		andShow: [ :a | self buttonsForVersionsAndGroups: a ].
	^ browser
]

{ #category : #building }
GTMetacellerInstaller >> buttonsForVersionsAndGroups: aBrowser [
	aBrowser actionList
		act: [ :entity :version :groups | self installVersion: version groups: groups ] entitled: 'Install';
		allowNil;
		yourself.
	aBrowser actionList
		act: [ :entity :version :groups | self installVersion: version groups: groups ] entitled: 'Install';
		allowAllNil;
		yourself	
]

{ #category : #building }
GTMetacellerInstaller >> buttonsIn: aBrowser [
	aBrowser actionList
		act: [ :entity | self install ] entitled: 'Install';
		yourself	
]

{ #category : #accessing }
GTMetacellerInstaller >> helpText [
	^'The metaceller installer is a graphical ui to install an existing configuration.
You can select a version and from this version one or more groups.
If no version is selected the following version ordering is used to determine a default version: stable, development, bleedingedge.
If no group is selected the "default" group is used (see Metacello documentation).
If installation fails, please use the Metaceller analyzer to determine the problem.'
]

{ #category : #actions }
GTMetacellerInstaller >> install [
	self install: nil
]

{ #category : #actions }
GTMetacellerInstaller >> install: aGroups [
	self configuration install: aGroups
]

{ #category : #actions }
GTMetacellerInstaller >> installVersion: aVersion groups: aGroups [
	aVersion ifNil: [ ^self install: aGroups ].
	aVersion install: aGroups
]
