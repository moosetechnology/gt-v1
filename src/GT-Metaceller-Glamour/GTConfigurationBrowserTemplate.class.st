Class {
	#name : #GTConfigurationBrowserTemplate,
	#superclass : #GLMBrowserTemplate,
	#instVars : [
		'announcer',
		'configuration'
	],
	#category : #'GT-Metaceller-Glamour'
}

{ #category : #events }
GTConfigurationBrowserTemplate >> announce: anAnnouncement [
	self announcer announce: anAnnouncement
]

{ #category : #events }
GTConfigurationBrowserTemplate >> announcer [
	^announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #building }
GTConfigurationBrowserTemplate >> buildBrowser [
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
			column: #groups ];
		row: #details;
		row: #buttons size: 30.
	browser transmit
		to: #versions;
		andShow: [ :a | self versionsIn: a ].
	browser transmit
		to: #groups;
		andShow: [ :a | self groupsFromConfigurationIn: a ].
	browser transmit
		to: #groups;
		from: #versions;
		andShow: [ :a | self groupsFromVersionIn: a ].
	browser transmit
		to: #details;
		andShow: [ :a | self detailsIn: a ].
	browser transmit
		from: #versions;
		to: #details;
		andShow: [ :a | self versionDetailsIn: a ].
	browser transmit
		from: #groups;
		to: #details;
		andShow: [ :a | self itemDetailsIn: a ].
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
GTConfigurationBrowserTemplate >> buttonsForVersionsAndGroups: aBrowser [
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
GTConfigurationBrowserTemplate >> buttonsIn: aBrowser [
	self subclassResponsibility
]

{ #category : #selection }
GTConfigurationBrowserTemplate >> childrenForItem: anItem [
	anItem isString ifTrue: [ ^#() ].
	^anItem children
]

{ #category : #accessing }
GTConfigurationBrowserTemplate >> configuration [
	^configuration
]

{ #category : #building }
GTConfigurationBrowserTemplate >> detailsForItem: anItem [
	anItem ifNil: [ ^self configuration infoText ].
	anItem isCollection ifTrue: [
		anItem ifEmpty: [ ^self configuration infoText ].
		^anItem inject: Text new into: [ :retVal :each | retVal append: each infoText; append: String cr; yourself ] ].
	^anItem infoText
]

{ #category : #building }
GTConfigurationBrowserTemplate >> detailsIn: aBrowser [
	aBrowser text
		title: 'Info';
		format: [ :item | self detailsForItem: item ];
		updateOn: GTConfigChanged from: self announcer;
		yourself
]

{ #category : #selection }
GTConfigurationBrowserTemplate >> groupsFor: aConfigOrVersion [
	aConfigOrVersion ifNil: [ ^self configuration groups ].
	^aConfigOrVersion groups
]

{ #category : #building }
GTConfigurationBrowserTemplate >> groupsFromConfigurationIn: aBrowser [
	self groupsIn: aBrowser.
	self packagesIn: aBrowser
]

{ #category : #building }
GTConfigurationBrowserTemplate >> groupsFromVersionIn: aBrowser [
	self groupsIn: aBrowser.
	self packagesIn: aBrowser.
	(self groupsIn: aBrowser)
		allowAllNil.
	(self packagesIn: aBrowser)
		allowAllNil
]

{ #category : #building }
GTConfigurationBrowserTemplate >> groupsIn: aBrowser [
	^aBrowser list
		title: 'Groups';
		display: [ self groupsFor: self configuration ];
		format: #labelAsText;
		updateOn: GTConfigChanged from: self announcer;
		allowDeselection;
		yourself
]

{ #category : #initialization }
GTConfigurationBrowserTemplate >> initialize [
	super initialize.
	self register
]

{ #category : #actions }
GTConfigurationBrowserTemplate >> install [
	self install: nil
]

{ #category : #actions }
GTConfigurationBrowserTemplate >> install: aGroups [
	self configuration install: aGroups
]

{ #category : #actions }
GTConfigurationBrowserTemplate >> installVersion: aVersion groups: aGroups [
	aVersion ifNil: [ ^self install: aGroups ].
	aVersion install: aGroups
]

{ #category : #building }
GTConfigurationBrowserTemplate >> itemDetailsIn: aBrowser [
	self detailsIn: aBrowser
]

{ #category : #actions }
GTConfigurationBrowserTemplate >> newVersion: aVersion [ 
	" create a dialog box for a version name and allow to select a base version "
	self halt
]

{ #category : #building }
GTConfigurationBrowserTemplate >> openOn: aConfiguration [
	configuration := aConfiguration.
	super openOn: aConfiguration
]

{ #category : #selection }
GTConfigurationBrowserTemplate >> packagesAndGroupsFor: aConfigOrVersion [
	aConfigOrVersion ifNil: [ ^self configuration groupsAndLoosePackages ].
	^aConfigOrVersion groupsAndLoosePackages
]

{ #category : #building }
GTConfigurationBrowserTemplate >> packagesIn: aBrowser [
	^aBrowser tree
		title: 'Packages';
		display: [ self packagesAndGroupsFor: self configuration ];
		children: [ :item | self childrenForItem: item ];
		format: #labelAsText;
		updateOn: GTConfigChanged from: self announcer;
		allowDeselection;
		yourself.

]

{ #category : #events }
GTConfigurationBrowserTemplate >> register [
	GTMetacellerModel default announcer weak
		on: GTConfigChanged send: #updateConfig: to: self
]

{ #category : #events }
GTConfigurationBrowserTemplate >> updateConfig: anAnnouncement [
	anAnnouncement config = self configuration ifTrue: [ self announce: anAnnouncement ]
]

{ #category : #building }
GTConfigurationBrowserTemplate >> versionActionsFor: aSelection [
	| retVal |
	retVal := OrderedCollection new.
	aSelection ifNotNil: [ 
		retVal
			add: (GLMGenericAction new title: 'Inspect'; action: [ aSelection inspect ]);
			add: (GLMGenericAction new title: 'Explore'; action: [ aSelection explore ]);
			yourself ].
	^retVal
]

{ #category : #building }
GTConfigurationBrowserTemplate >> versionDetailsIn: aBrowser [
	self detailsIn: aBrowser.
]

{ #category : #building }
GTConfigurationBrowserTemplate >> versionsIn: aBrowser [
	aBrowser list
		title: 'Versions';
		display: [ :config | config basicVersions ];
		format: #labelAsText;
		updateOn: GTConfigChanged from: self announcer;
		dynamicActionsOnSelection: [ :b | self versionActionsFor: b selection ];
		allowDeselection;
		yourself.
	aBrowser list
		title: 'Releases';
		display: [ :config | config releases ];
		format: #labelAsText;
		updateOn: GTConfigChanged from: self announcer;
		dynamicActionsOnSelection: [ :b | self versionActionsFor: b selection ];
		allowDeselection;
		yourself.
	aBrowser list
		title: 'All versions';
		display: [ :config | config mainVersions ];
		format: #labelAsText;
		updateOn: GTConfigChanged from: self announcer;
		dynamicActionsOnSelection: [ :b | self versionActionsFor: b selection ];
		allowDeselection;
		yourself.

]
