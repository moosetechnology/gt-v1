Class {
	#name : #GTMetacellerInstaller,
	#superclass : #GTConfigurationBrowserTemplate,
	#category : #'GT-Metaceller-Glamour'
}

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

{ #category : #building }
GTMetacellerInstaller >> groupsFromConfigurationIn: aBrowser [
	(self groupsIn: aBrowser)
		beMultiple.
	(self packagesIn: aBrowser)
		beMultiple
]

{ #category : #building }
GTMetacellerInstaller >> groupsFromVersionIn: aBrowser [
	(self groupsIn: aBrowser)
		beMultiple.
	(self packagesIn: aBrowser)
		beMultiple.
	(self groupsIn: aBrowser)
		allowAllNil;
		beMultiple.
	(self packagesIn: aBrowser)
		allowAllNil;
		beMultiple.
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
