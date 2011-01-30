"
self open
"
Class {
	#name : #GTMetaceller,
	#superclass : #GLMGlobalBrowserTemplate,
	#instVars : [
		'metacelloCache'
	],
	#category : #'GT-Tools-Prototypes'
}

{ #category : #building }
GTMetaceller >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Metacello Browser'.
	browser act: [:b | 
		Workspace new 
			contents: self helpText; 
			openLabel: 'Metaceller help' ] icon: MenuIcons smallHelpIcon entitled: 'Help'.
	browser column: #configs; column: #details span: 4.
	self toConfigsAndShow.
	self toDetailsFromConfigsAndShow.
	^ browser 
]

{ #category : #opening }
GTMetaceller >> entity [ 
	^ (Object subclasses select: [:each | (each class canUnderstand: #isMetacelloConfig) and: [
			each isMetacelloConfig ] ]) sort: [:a :b | a name < b name]
]

{ #category : #private }
GTMetaceller >> helpText [
	^'Metaceller is a tool for browsing the Metacello configurations present in the image.

The Configurations tab lists all the projects from the ConfigurationOfXXX present in the image. Double clicking on an item spawns the configuration details.

The Versions tab lists all the versions defined in the configuration. The color coding shows:
- black = a possible baseline
- gray = not a possible baseline (probably due to packages no longer in the image)
- bold = the current version

The Imports tab shows how versions import from one another.

Upon selecting a version, the third pane shows the details of the specification of the version.

The Items tab shows the packages, groups and projects from the version. Each project can be expanded to display its items.

The color coding shows:
- blue = dirty packages 
- gray = packages that are not present in the image
- italics = groups

The "Newer in repository?" shows in red the packages that have newer versions published in the Monticello repository, thus indicating a possible need for update.'
]

{ #category : #accessing }
GTMetaceller >> metacelloCache [

	metacelloCache == nil ifTrue: [ metacelloCache := Dictionary new ].
	^metacelloCache
]

{ #category : #private }
GTMetaceller >> shortNameOf: config [
	"self new shortNameOf: ConfigurationOfAlien"
	^ ((config name beginsWith: 'ConfigurationOf') 
		ifTrue: [config name copyFrom: 'ConfigurationOf' size + 1 to: config name size ] 
		ifFalse: [config name]) asString
]

{ #category : #building }
GTMetaceller >> toConfigsAndShow [
	browser transmit to: #configs; andShow: [ :a |
		| configList |
		a title: 'Configurations'.
		configList := a list
			format: [:configClass | | text label version |
				label := self shortNameOf: configClass.
				self useCacheDuring: [ version := configClass project currentVersion ].
				text := (self validCurrentVersion: version)
					ifTrue: [ (label, ' [', version versionString, ']') ]
					ifFalse: [ Text string: label attribute: TextColor gray].
				text ];
			act: [:list  | list selection browse ] entitled: 'Browse implementation';
			act: [:list  | list selection project inspect] entitled: 'Inspect'.
			Smalltalk at: #OBCmdMetacello ifPresent: [ :x |
				configList dynamicActionsOnSelection: [:list | 
					(GLMOBCommandAdaptor new 
						actionsFrom: (Smalltalk at: #OBCmdMetacello) subclasses 
						on: list selection 
						for: nil ) do: [:each | each category: 'OB Commands'] ] ] ]
]

{ #category : #building }
GTMetaceller >> toDetailsFromConfigsAndShow [
	browser transmit from: #configs->#strongSelection; to: #details; andShowIfNone: [ :a |
		a custom: 
			(((GTMetacellerDetails new)
				master: self;
				yourself) browser noTitle )
		].
	browser transmit from: #configs; to: #details->#entityToSelect.
	browser transmit from: #details->#activeEntity; to: #configs->#selection.
]

{ #category : #private }
GTMetaceller >> useCacheDuring: aBlock [

	"Use #respondsTo: until 1.0-beta.23 is in general use"
	(MetacelloPlatform current respondsTo: #useStackCacheDuring:defaultDictionary:)
		ifTrue: [
			MetacelloPlatform current
				useStackCacheDuring: [:dict | ^aBlock value ] 
				defaultDictionary: self metacelloCache ]
		ifFalse: [ ^aBlock value ]
]

{ #category : #private }
GTMetaceller >> validCurrentVersion: version [

	version isNil ifTrue: [ ^false ].
	(version respondsTo: #versionStatus) 
		ifTrue: [ "Use #respondsTo: until 1.0-beta.23 is in general use"
			^#(allLoadedToSpec loadedToSpec loadedMatchConstraints) includes: version versionStatus ].
	^true
]
