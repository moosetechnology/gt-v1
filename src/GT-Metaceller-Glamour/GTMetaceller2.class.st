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
		row: [  :r | r
				column: #configs;
				column: #info ] span: 3;
		row: [ :r | r
			column: #configButtons;
			column: #infoButtons ] size: 30;
		row: #details.
	browser transmit
		to: #configs;
		andShow: [ :a | self configurationsIn: a ].
	browser transmit
		to: #configButtons;
		andShow: [ :a | self configActionsIn: a ].
	browser transmit
		from: #configs;
		to: #infoButtons;
		andShow: [ :a | self infoActionsIn: a ].
	browser transmit
		from: #configs;
		to: #info;
		andShow: [ :a | self infoForConfiguration: a ].
	^ browser
]

{ #category : #building }
GTMetaceller2 >> configActionsIn: a [
	^ a actionList
			act: [:entity | self newConfiguration ] entitled: 'New...'
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

{ #category : #building }
GTMetaceller2 >> detailsForConfiguration: aBrowser [
	aBrowser magritte
		title: 'Details';
		description: [ :config | config magritteDescription ];
		updateOn: GTConfigChanged from: self announcer;
		onAnswer: [ :config :presentation | self announce: (GTConfigChanged on: config) ] . 

]

{ #category : #opening }
GTMetaceller2 >> entity [ 
	^ GTMetacellerModel default
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
GTMetaceller2 >> infoActionsIn: a [
	^ a actionList
			act: [:entity :config | self validateConfiguration: config ] entitled: 'Validate';
			act: [:entity :config | self testConfiguration: config ] entitled: 'Test';
			act: [:entity :config | self installConfiguration: config ] entitled: 'Install';
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
GTMetaceller2 >> newConfiguration [
	" todo: add a wizard to add a configuration "
]

{ #category : #building }
GTMetaceller2 >> prefHeight [
	^900
]

{ #category : #actions }
GTMetaceller2 >> testConfiguration: config [
	config testConfiguration.
	self announce: (GTConfigChanged on: config)
]
