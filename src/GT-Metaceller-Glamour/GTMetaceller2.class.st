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
	self halt.
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
		row: #configs;
		row: #configButtons size: 30.
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
	^ browser
]

{ #category : #accessing }
GTMetaceller2 >> childrenForItem: anItem [
	anItem isString ifTrue: [ ^#() ].
	^anItem children
]

{ #category : #building }
GTMetaceller2 >> configActionsIn: a [
	^ a actionList
			act: [ :entity | self newConfiguration ] entitled: 'New...';
			act: [ :entity :selected | self openConfiguration: selected ] entitled: 'Open';
			act: [ :entity :selected | self installConfiguration: selected ] entitled: 'Install';
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
GTMetaceller2 >> initialExtent [
	| maxSize retVal |
	maxSize := RealEstateAgent maximumUsableArea extent - (RealEstateAgent scrollBarSetback @ RealEstateAgent screenTopSetback).
	retVal := RealEstateAgent standardWindowExtent.
	(self prefHeight < maxSize y )
		ifTrue: [ ^RealEstateAgent standardWindowExtent x@self prefHeight ]
		ifFalse: [ ^RealEstateAgent standardWindowExtent x@maxSize y ]	
]

{ #category : #actions }
GTMetaceller2 >> installConfiguration: aConfig [ 
	aConfig installDialog
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
