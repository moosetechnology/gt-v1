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
