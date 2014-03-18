Class {
	#name : #GTMetacellerInstaller,
	#superclass : #GLMGlobalBrowserTemplate,
	#instVars : [
		'announcer',
		'configuration'
	],
	#category : #'GT-Metaceller-Glamour'
}

{ #category : #events }
GTMetacellerInstaller >> announce: anAnnouncement [
	self halt.
	self announcer announce: anAnnouncement
]

{ #category : #events }
GTMetacellerInstaller >> announcer [
	^announcer ifNil: [ announcer := Announcer new ]
]

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
		to: #details;
		andShow: [ :a | self detailsIn: a ].
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

{ #category : #selection }
GTMetacellerInstaller >> childrenForItem: anItem [
	anItem isString ifTrue: [ ^#() ].
	^anItem children
]

{ #category : #accessing }
GTMetacellerInstaller >> configuration [
	^configuration
]

{ #category : #building }
GTMetacellerInstaller >> detailsIn: aBrowser [
	aBrowser text
		title: 'Details';
		format: #infoText;
		updateOn: GTConfigChanged from: self announcer;
		yourself
		
]

{ #category : #opening }
GTMetacellerInstaller >> entity [
	^self configuration
]

{ #category : #selection }
GTMetacellerInstaller >> groupsFor: aConfigOrVersion [
	aConfigOrVersion ifNil: [ ^self configuration groups ].
	^aConfigOrVersion groups
]

{ #category : #building }
GTMetacellerInstaller >> groupsIn: aBrowser [
	aBrowser list
		title: 'Groups';
		display: [ :configOrVersion | self groupsFor: configOrVersion ];
		format: #labelAsText;
		updateOn: GTConfigChanged from: self announcer;
		allowDeselection;
		allowNil;
		beMultiple;
		yourself.
	aBrowser tree
		title: 'Packages';
		display: [ :configOrVersion | self packagesAndGroupsFor: configOrVersion ];
		children: [ :item | self childrenForItem: item ];
		format: #labelAsText;
		updateOn: GTConfigChanged from: self announcer;
		allowDeselection;
		allowNil;
		beMultiple;
		yourself

		
]

{ #category : #initialization }
GTMetacellerInstaller >> initialize [
	super initialize.
	self register
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

{ #category : #building }
GTMetacellerInstaller >> openOn: aConfiguration [
	configuration := aConfiguration.
	super openOn: aConfiguration
]

{ #category : #selection }
GTMetacellerInstaller >> packagesAndGroupsFor: aConfigOrVersion [
	aConfigOrVersion ifNil: [ ^self configuration groupsAndLoosePackages ].
	^aConfigOrVersion groupsAndLoosePackages
]

{ #category : #events }
GTMetacellerInstaller >> register [
	GTMetacellerModel default announcer weak
		on: GTConfigChanged send: #updateConfig: to: self
]

{ #category : #events }
GTMetacellerInstaller >> updateConfig: anAnnouncement [
	anAnnouncement configuration = self configuration ifTrue: [ self announce: anAnnouncement ]
]

{ #category : #building }
GTMetacellerInstaller >> versionsIn: aBrowser [
	aBrowser list
		title: 'Versions';
		display: [ :config | config basicVersions ];
		format: #labelAsText;
		updateOn: GTConfigChanged from: self announcer;
		allowDeselection;
		yourself.
	aBrowser list
		title: 'All versions';
		display: [ :config | config mainVersions ];
		format: #labelAsText;
		updateOn: GTConfigChanged from: self announcer;
		allowDeselection;
		yourself.

]
