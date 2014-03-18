Class {
	#name : #GTMetacellerBrowserTemplate,
	#superclass : #GLMGlobalBrowserTemplate,
	#instVars : [
		'announcer',
		'configuration'
	],
	#category : #'GT-Metaceller-Glamour'
}

{ #category : #events }
GTMetacellerBrowserTemplate >> announce: anAnnouncement [
	self announcer announce: anAnnouncement
]

{ #category : #events }
GTMetacellerBrowserTemplate >> announcer [
	^announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #building }
GTMetacellerBrowserTemplate >> buttonsForVersionsAndGroups: aBrowser [
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
GTMetacellerBrowserTemplate >> buttonsIn: aBrowser [
	aBrowser actionList
		act: [ :entity | self install ] entitled: 'Install';
		yourself	
]

{ #category : #selection }
GTMetacellerBrowserTemplate >> childrenForItem: anItem [
	anItem isString ifTrue: [ ^#() ].
	^anItem children
]

{ #category : #accessing }
GTMetacellerBrowserTemplate >> configuration [
	^configuration
]

{ #category : #building }
GTMetacellerBrowserTemplate >> details: aBrowser [
	aBrowser text
		title: 'Details';
		format: [ :item | self detailsForItem: item ];
		updateOn: GTConfigChanged from: self announcer;
		yourself
		
]

{ #category : #building }
GTMetacellerBrowserTemplate >> detailsForItem: anItem [
	anItem ifNil: [ ^self configuration infoText ].
	anItem isCollection ifTrue: [
		anItem ifEmpty: [ ^self configuration infoText ].
		^anItem inject: Text new into: [ :retVal :each | retVal append: each infoText; append: String cr; yourself ] ].
	^anItem infoText
]

{ #category : #opening }
GTMetacellerBrowserTemplate >> entity [
	^self configuration
]

{ #category : #selection }
GTMetacellerBrowserTemplate >> groupsFor: aConfigOrVersion [
	aConfigOrVersion ifNil: [ ^self configuration groups ].
	^aConfigOrVersion groups
]

{ #category : #building }
GTMetacellerBrowserTemplate >> groupsIn: aBrowser [
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
GTMetacellerBrowserTemplate >> initialize [
	super initialize.
	self register
]

{ #category : #actions }
GTMetacellerBrowserTemplate >> install [
	self install: nil
]

{ #category : #actions }
GTMetacellerBrowserTemplate >> install: aGroups [
	self configuration install: aGroups
]

{ #category : #actions }
GTMetacellerBrowserTemplate >> installVersion: aVersion groups: aGroups [
	aVersion ifNil: [ ^self install: aGroups ].
	aVersion install: aGroups
]

{ #category : #building }
GTMetacellerBrowserTemplate >> openOn: aConfiguration [
	configuration := aConfiguration.
	super openOn: aConfiguration
]

{ #category : #selection }
GTMetacellerBrowserTemplate >> packagesAndGroupsFor: aConfigOrVersion [
	aConfigOrVersion ifNil: [ ^self configuration groupsAndLoosePackages ].
	^aConfigOrVersion groupsAndLoosePackages
]

{ #category : #events }
GTMetacellerBrowserTemplate >> register [
	GTMetacellerModel default announcer weak
		on: GTConfigChanged send: #updateConfig: to: self
]

{ #category : #events }
GTMetacellerBrowserTemplate >> updateConfig: anAnnouncement [
	anAnnouncement config = self configuration ifTrue: [ self announce: anAnnouncement ]
]

{ #category : #building }
GTMetacellerBrowserTemplate >> versionsIn: aBrowser [
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
