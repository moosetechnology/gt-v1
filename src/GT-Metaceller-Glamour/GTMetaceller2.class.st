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
		entitled: 'Help'.
	browser
		row: [  :r | r
				column: #configs;
				column: #versions;
				column: #packages span: 2 ];
		row: #details.
	browser transmit
		to: #configs;
		andShow: [ :a | self configurationsIn: a ].
	browser transmit
		from: #configs;
		to: #details;
		andShow: [ :a | self detailsForConfiguration: a ].
	^ browser
]

{ #category : #building }
GTMetaceller2 >> configurationsIn: a [
	^ a tree
		title: 'Configurations';
		display: #configurations;
		format: [ :configuration | configuration shortName ];
		children: [ :configuration | configuration children ];
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

The Configurations tab lists all the projects from the ConfigurationOfXXX present in the image. Selecting a configuration causes it to analyse this configuration and display information about it.

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
