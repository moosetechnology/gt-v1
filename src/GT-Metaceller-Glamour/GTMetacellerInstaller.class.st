Class {
	#name : #GTMetacellerInstaller,
	#superclass : #GTConfigurationBrowserTemplate,
	#category : #'GT-Metaceller-Glamour'
}

{ #category : #building }
GTMetacellerInstaller >> buttonsForVersionsAndItems: aBrowser [
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

{ #category : #accessing }
GTMetacellerInstaller >> title [
	^'Install ', self configuration title
]

{ #category : #building }
GTMetacellerInstaller >> versionsIn: aBrowser [
	aBrowser list
		title: 'Versions';
		display: [ :config | config basicVersions ];
		format: #labelAsText;
		updateOn: GTConfigChanged from: self announcer;
		dynamicActionsOnSelection: [ :b | self versionActionsFor: b selection ];
		allowDeselection;
		yourself.
	super versionsIn: aBrowser
]
