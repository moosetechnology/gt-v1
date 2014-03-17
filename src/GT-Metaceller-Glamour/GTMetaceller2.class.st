"
GTMetaceller is a tool for browsing configurations. For more information see helpText
"
Class {
	#name : #GTMetaceller2,
	#superclass : #GLMGlobalBrowserTemplate,
	#instVars : [
		'announcer'
	],
	#category : #'GT-Metaceller-Glamour'
}

{ #category : #announcements }
GTMetaceller2 >> announce: anAnnouncement [
	self announcer announce: anAnnouncement
]

{ #category : #announcements }
GTMetaceller2 >> announcer [
	^ announcer ifNil: [ announcer := GTMetacellerModel default announcer ]
]

{ #category : #building }
GTMetaceller2 >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'New Metaceller'.
	browser
		act: [ :b | 
			Workspace new
				contents: self helpText;
				openLabel: 'Metaceller help' ]
		icon: GLMUIThemeExtraIcons glamorousHelp
		entitled: 'Help';
		initialExtent: self initialExtent.
	browser
		column: [ :c | c
			row: #configs;
			row: #configButtons size: 30 ];
		column: [ :c | c
			row: #info;
			row: [ :r | r
				column: #versions;
				column: #groups ] span: 2;
			row: #infoButtons size: 30 ] span: 2.
	browser transmit
		to: #configs;
		andShow: [ :a | self configurationsIn: a ].
	browser transmit
		to: #configButtons;
		andShow: [ :a | self startConfigActionsIn: a ].
	browser transmit
		from: #configs;
		to: #configButtons;
		andShow: [ :a | self configActionsIn: a ].
	browser transmit
		from: #configs;
		to: #versions;
		andShow: [ :a | self versionsForConfiguration: a ].
	browser transmit
		from: #configs;
		to: #info;
		andShow: [ :a | self infoForConfiguration: a ].
	browser transmit
		from: #configs; from: #versions;
		to: #groups;
		andShow: [ :a | self groupsForVersion: a ].
	browser transmit
		from: #versions; from: #groups;
		to: #infoButtons;
		andShow: [ :a | self infoActions: a ].
	^ browser
]

{ #category : #building }
GTMetaceller2 >> configActionsIn: a [
	^ a actionList
			act: [ :entity | self newConfiguration ] entitled: 'New...';
			act: [ :entity :selected | self openConfiguration: selected ] entitled: 'Open';
			yourself
]

{ #category : #building }
GTMetaceller2 >> configurationsIn: a [
	^ a list
		title: 'Configurations';
		display: #configurations;
		format: [ :configuration | configuration shortName ];
		updateOn: GTConfigLoaded from: self announcer;
		populate: #acceptedCode icon: GLMUIThemeExtraIcons glamorousRefresh on: $r entitled: 'Refresh' with: [ :pane | self announce: GTConfigLoaded ];
		selectionAct: [ :list | list selection browse ] entitled: 'Browse implementation';
		selectionAct: [ :list | list selection mainProject inspect ] entitled: 'Inspect'
]

{ #category : #opening }
GTMetaceller2 >> entity [ 
	^ GTMetacellerModel default
]

{ #category : #building }
GTMetaceller2 >> groupsForVersion: aBrowser [
	aBrowser list
		title: 'Groups';
		updateOn: GTConfigChanged from: self announcer;
		display: [ :config :version | version
			ifNil: [ config groups ]
			ifNotNil: [ version groups ] ];
		format: #labelAsText;
		allowNil;
		allowDeselection;
		yourself. 

]

{ #category : #accessing }
GTMetaceller2 >> helpText [
	^'Metaceller is a tool for browsing and editing the Metacello configurations present in the image.

The Configurations tab lists all the projects from the ConfigurationOfXXX present in the image. Selecting a configuration causes it to display information about it. The color of the version give information about the blessing:
- bold = a release version
- blue = a development version
- red  = a baseline

For most configurations the stable version should be a release and a development version should be blessed with "development".

Most common actions are listed with a version. Not that the default group is "default", the default version is "#stable".
- Validate: performs a test of the version and configurations used that are loaded in image.
- Test: performs a test of the version and configurations used. Note that this installs used configurations.
- Install: Installs the selected version and group.
- Open: Opens the configuration for more details and possibilities.

.....

The Versions tab lists all the versions defined in the configuration. The color coding shows:
- bold = the stable version
- blue = the development version
- red  = the current bleeding edge
The tag shows the blessing of the configuration.

The Imports tab shows how versions import from one another.

Upon selecting a version, the third pane shows the details of the specification of the version.

The Items tab shows the packages, groups and projects from the version. Each project can be expanded to display its items.

The color coding shows:
- blue = project
- bold = newer package in version than loaded in image
- underlined = package / project loaded in image
- italic = groups
- gray = older package in version than loaded in image
.'
]

{ #category : #building }
GTMetaceller2 >> infoActions: a [
	^ a actionList
			act: [:entity :version :group | self validateVersion: version group: group ] entitled: 'Validate';
			act: [:entity :version :group | self testVersion: version group: group ] entitled: 'Test';
			act: [:entity :version :group | self installVersion: version group: group ] entitled: 'Install';
			yourself
]

{ #category : #building }
GTMetaceller2 >> infoActionsIn: a [
	^ a actionList
			act: [:entity :config | self validateConfiguration: config ] entitled: 'Validate';
			act: [:entity :config | self testConfiguration: config ] entitled: 'Test';
			act: [:entity :config | self installConfiguration: config ] entitled: 'Install';
			allowNil;
			allowAllNil;
			yourself
]

{ #category : #building }
GTMetaceller2 >> infoForConfiguration: aBrowser [
	aBrowser text
		title: 'Details';
		updateOn: GTConfigChanged from: self announcer;
		format: [ :config | config infoText ]
		yourself. 

]

{ #category : #building }
GTMetaceller2 >> initialExtent [
	| maxSize retVal |
	maxSize := RealEstateAgent maximumUsableArea extent - (RealEstateAgent scrollBarSetback @ RealEstateAgent screenTopSetback).
	retVal := RealEstateAgent standardWindowExtent.
	(self prefHeight < maxSize y )
		ifTrue: [ ^RealEstateAgent standardWindowExtent x@self prefHeight ]
		ifFalse: [ ^RealEstateAgent standardWindowExtent x@maxSize y ]	
]

{ #category : #actions }
GTMetaceller2 >> installVersion: aVersion group: aGroup [
	aVersion install: aGroup.
	self announce: (GTConfigChanged on: aVersion configuration)
]

{ #category : #actions }
GTMetaceller2 >> newConfiguration [
	" todo: add a wizard to add a configuration "
]

{ #category : #actions }
GTMetaceller2 >> openConfiguration: aConfig [ 
	aConfig openMetacellerDetails
]

{ #category : #building }
GTMetaceller2 >> prefHeight [
	^900
]

{ #category : #building }
GTMetaceller2 >> startConfigActionsIn: a [
	^ a actionList
			act: [ :entity | self newConfiguration ] entitled: 'New...';
			yourself
]

{ #category : #actions }
GTMetaceller2 >> testVersion: aVersion group: aGroup [
	aVersion test: aGroup.
	self announce: (GTConfigChanged on: aVersion configuration)
]

{ #category : #actions }
GTMetaceller2 >> validateVersion: aVersion group: aGroup [
	aVersion validate: aGroup.
	self announce: (GTConfigChanged on: aVersion configuration)
]

{ #category : #building }
GTMetaceller2 >> versionsForConfiguration: aBrowser [
	aBrowser list
		title: 'Versions';
		updateOn: GTConfigChanged from: self announcer;
		display: [ :config | config basicVersions ];
		format: #labelAsText;
		allowDeselection;
		yourself. 

]
