"
self open
"
Class {
	#name : #GTMetaceller,
	#superclass : #GLMGlobalBrowserTemplate,
	#instVars : [
		'announcer'
	],
	#category : #'GT-Metaceller'
}

{ #category : #actions }
GTMetaceller >> acceptCode: aText version: aVersion [ 
	aVersion methodClass compile: aText asString classified: aVersion methodCategory.
	self announce: GTConfigChanged
]

{ #category : #actions }
GTMetaceller >> actionsForItem: anItem [
	| retVal |
	retVal := OrderedCollection new.
 	retVal add: ((GLMGenericAction new) 
			action: [:list :version | self load: list selection fromVersion: version ];
			title: 'Load'
			yourself).
 	retVal add: ((GLMGenericAction new) 
			action: [:list | list selection inspect ];
			title: 'Inspect'
			yourself).
	(self isProject: anItem) ifTrue: [ retVal add: ((GLMGenericAction new) 
						action: [ :list | self fetchProject: list selection ];
						title: 'Load configuration'
						yourself) ].
	^retVal
]

{ #category : #accessing }
GTMetaceller >> announce: anAnnouncement [
	self announcer announce: anAnnouncement
]

{ #category : #accessing }
GTMetaceller >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #building }
GTMetaceller >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Metaceller'.
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
		to: #versions;
		andShow: [ :a | self versionBrowserOn: a ].
	browser transmit
		from: #configs;
		to: #details;
		andShow: [ :a | self detailsForConfiguration: a ].
	browser transmit
		from: #versions;
		to: #details;
		andShow: [ :a | self detailsForVersion: a ].
	browser transmit
		from: #versions;
		to: #packages;
		andShow: [ :a | self packageBrowserOn: a ].
	browser transmit
		from: #packages;
		to: #details;
		andShow: [ :a | self detailsForPackage: a ].
	^ browser
]

{ #category : #accessing }
GTMetaceller >> childrenForConfig: aConfigClass [
	[ ^(self projectsForVersion: aConfigClass project stableVersion) collect: [ :each | self configForProject: each ] thenSelect: [ :each | each notNil ] ] on: MetacelloSymbolicVersionDoesNotExistError do: [ ^#() ]
]

{ #category : #accessing }
GTMetaceller >> childrenForItem: anItem [
	anItem isString ifTrue: [ ^#() ].
	^anItem children
]

{ #category : #accessing }
GTMetaceller >> configForProject: aSpec [
	| projectReference |
	aSpec ifNil: [  ^nil ].
	(aSpec isKindOf: MetacelloProjectReferenceSpec)
		ifTrue: [ projectReference := aSpec projectReference ]
		ifFalse: [ projectReference := aSpec ].
	projectReference ifNil: [  ^nil ].
	projectReference className ifNil: [  ^nil ].
	^Smalltalk at: (projectReference className asSymbol) ifAbsent: [ nil ]
]

{ #category : #building }
GTMetaceller >> configurationsIn: a [
	^ a tree
		title: 'Configurations';
		format: [ :configClass | 
					| text label version |
					label := self shortNameOf: configClass ];
		children: [ :configClass |
			 self childrenForConfig: configClass ];
		updateOn: GTConfigLoaded from: self announcer;
		populate: #acceptedCode icon: GLMUIThemeExtraIcons glamorousRefresh on: $r entitled: 'Refresh' with: [ :pane | self announce: GTConfigLoaded ];
		selectionAct: [ :list | list selection browse ] entitled: 'Browse implementation';
		selectionAct: [ :list | list selection project inspect ] entitled: 'Inspect'
]

{ #category : #building }
GTMetaceller >> detailsForConfiguration: aBrowser [
	(aBrowser respondsTo: #roassal) ifTrue: [ 
		aBrowser roassal
			title: 'Imports';
			painting: [:view :config | self viewVersionMapOf: config on: view] ]
		ifFalse: [ 
			aBrowser text
				title: 'Imports';
				display: 'Please install roassal to see the imports' ]
]

{ #category : #building }
GTMetaceller >> detailsForMethod: aBrowser [
	aBrowser smalltalkCode
		smalltalkClass: [ :method | method methodClass ];
		display: [ :method | method asString ];
		populate: #acceptedCode icon: GLMUIThemeExtraIcons glamorousAccept on: $s entitled: 'Accept' with: [ :pane :method | self acceptCode: pane text method: method ]
]

{ #category : #building }
GTMetaceller >> detailsForPackage: aBrowser [
	aBrowser text
		title: 'Package spec';
		display: [ :package | package asString ]
]

{ #category : #building }
GTMetaceller >> detailsForVersion: aBrowser [
	aBrowser smalltalkCode
		title: 'Method';
		smalltalkClass: [ :version | version methodClass ];
		display: [ :version | version methodString ];
		populate: #acceptedCode icon: GLMUIThemeExtraIcons glamorousAccept on: $s entitled: 'Accept' with: [ :pane :version | self acceptCode: pane text version: version ].
	(aBrowser respondsTo: #roassal) ifTrue: [ 
		aBrowser roassal
			title: 'Dependencies';
			painting: [ :view :version | self viewDependenciesOf: version on: view ] ]
		ifFalse: [ 
			aBrowser text
				title: 'Dependencies';
				text: 'Please install roassal to view dependencies' ]
]

{ #category : #opening }
GTMetaceller >> entity [ 
	^ (Object subclasses select: [:each | self isMetacelloConfig: each]) sort: [:a :b | a name < b name]
]

{ #category : #actions }
GTMetaceller >> fetchProject: aProjectSpec [
	" this seems more stable then the alternative:
			aProjectSpec resolveToLoadableSpec load.	
			that also fethces the versions we need.
	"
	aProjectSpec loadUsing: aProjectSpec loader gofer: nil.
	self announce: GTConfigLoaded
]

{ #category : #actions }
GTMetaceller >> fetchVersion: aVersion [
	aVersion fetch.
	self announce: GTConfigLoaded
]

{ #category : #accessing }
GTMetaceller >> groupsForVersion: aVersion [
	aVersion ifNil: [ ^#() ].
	(aVersion isKindOf: Association) ifTrue: [  ^#() ].
	^aVersion groupsAndLoosePackages
]

{ #category : #private }
GTMetaceller >> helpText [
	^'Metaceller is a tool for browsing and editing the Metacello configurations present in the image.

The Configurations tab lists all the projects from the ConfigurationOfXXX present in the image. Double clicking on an item spawns the configuration details.

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

{ #category : #testing }
GTMetaceller >> isGroup: aSpec [ 
	^(aSpec isKindOf: MetacelloGroupSpec) or: [ aSpec isKindOf: GTMetacellerGroup ]
]

{ #category : #opening }
GTMetaceller >> isMetacelloConfig: anObject [
	(anObject respondsTo: #isMetacelloConfig) ifTrue: [  
		(anObject className beginsWith: 'Metacello') ifFalse: [ ^anObject isMetacelloConfig ] ].
	^false
]

{ #category : #testing }
GTMetaceller >> isPackage: aSpec [ 
	^(self isProject: aSpec) not and: [ (self isGroup: aSpec) not ]
]

{ #category : #testing }
GTMetaceller >> isProject: aSpec [ 
	^(aSpec isKindOf: MetacelloProjectReferenceSpec) or: [ (aSpec isKindOf: MetacelloProjectSpec) ]
]

{ #category : #accessing }
GTMetaceller >> itemsForVersion: aVersion [
	aVersion ifNil: [ ^#() ].
	(aVersion isKindOf: Association) ifTrue: [  ^#() ].
	^aVersion packagesAndProjects
]

{ #category : #actions }
GTMetaceller >> load: aSpec fromVersion: aVersion [
	aVersion load: aSpec name.
	self announce: GTConfigLoaded
]

{ #category : #actions }
GTMetaceller >> loadVersion: aVersion [
	aVersion load.
	self announce: GTConfigLoaded
]

{ #category : #display }
GTMetaceller >> nameForItem: anItem [
	^anItem labelAsText
]

{ #category : #testing }
GTMetaceller >> orderFor: anItemA and: anItemB [ 
	^anItemA label asLowercase < anItemB label asLowercase
]

{ #category : #building }
GTMetaceller >> packageBrowserOn: aBrowser [
	aBrowser tree
		title: 'Packages (load order)';
		display: [ :version | (self itemsForVersion: version) select: [ :each | each isGroup not ] ];
		children: [ :item | self childrenForItem: item ];
		format: [ :item | self nameForItem: item ];
		tags: [ :spec :version | self tagsOfSpec: spec in: version ];
		dynamicActionsOnSelection: [ :list | self actionsForItem: list selection ];
		updateOn: GTConfigChanged from: self announcer.
	aBrowser tree
		title: 'Groups';
		children: [ :item | self childrenForItem: item ];
		display: [ :version | self groupsForVersion: version ];
		updateOn: GTConfigChanged from: self announcer;
		format: [ :item | self nameForItem: item ].
	aBrowser tree
		title: 'Packages (alfabetical)';
		display: [ :version | (self itemsForVersion: version) asSortedCollection: [ :a :b | self orderFor: a and: b ] ];
		children: [ :item | (self childrenForItem: item) asSortedCollection: [ :a :b | self orderFor: a and: b ] ];
		format: [ :item | self nameForItem: item ];
		tags: [ :spec :version | self tagsOfSpec: spec in: version ];
		dynamicActionsOnSelection: [ :list | self actionsForItem: list selection ];
		updateOn: GTConfigChanged from: self announcer.

]

{ #category : #accessing }
GTMetaceller >> projectsForVersion: aVersion [
	aVersion ifNil: [ ^#() ].
	(aVersion isKindOf: Association) ifTrue: [ ^#() ].
	^aVersion spec packages packageSpecsInLoadOrder select: [  :each | self isProject: each ]
]

{ #category : #display }
GTMetaceller >> shortNameOf: config [
	"self new shortNameOf: ConfigurationOfAlien"
	^ ((config name beginsWith: 'ConfigurationOf') 
		ifTrue: [config name copyFrom: 'ConfigurationOf' size + 1 to: config name size ] 
		ifFalse: [config name]) asString
]

{ #category : #display }
GTMetaceller >> tagsOfSpec: aSpec in: aVersion [
	^aVersion tagsOf: aSpec
]

{ #category : #display }
GTMetaceller >> tagsOfVersion: aVersion [
	^aVersion tags
]

{ #category : #private }
GTMetaceller >> validCurrentVersion: version [

	version isNil ifTrue: [ ^false ].
	(version respondsTo: #versionStatus) 
		ifTrue: [ "Use #respondsTo: until 1.0-beta.23 is in general use"
			^#(allLoadedToSpec loadedToSpec loadedMatchConstraints) includes: version versionStatus ].
	^true
]

{ #category : #building }
GTMetaceller >> versionBrowserOn: aBrowser [
	aBrowser list
		title: 'Versions';
		display: [ :config | GTMetacellerVersion versionsForConfig: config ];
		updateOn: GTConfigChanged from: self announcer;
		dynamicActionsOnSelection: [ :list | list selection actions ];
		tags: [ :version | self tagsOfVersion: version ];
		format: [ :version | version textLabel ].
	aBrowser list 
		title: 'Methods';
		display: [ :config | GTMetacellerVersion allMethodsForConfig: config ];
		updateOn: GTConfigChanged from: self announcer;
		dynamicActionsOnSelection: [ :list | list selection actions ];
		format: [ :method | method selector ].
]

{ #category : #display }
GTMetaceller >> versionSourceFor: aVersion [
	^aVersion asString
]

{ #category : #roassal }
GTMetaceller >> viewDependenciesOf: version on: view [
	"| view |
	view := MOViewRenderer new.
	self new viewDependenciesOf: (ConfigurationOfMoose project version: 'default') on: view.
	view open"
	| all | 
	all := Dictionary new.
	version packages do: [:each | all at: each name put: each].
	version projects do: [:each | all at: each name put: each].
	view shape label text: [:each | each name ].
	view nodes: all values.
	view edges: version packages from: [:eachPackage | all at: eachPackage name] toAll: [:eachPackage |
		eachPackage requires
			collect: [:each | all at: each ifAbsent: [ nil ] ] 
			thenSelect: [ :each | each notNil ] ].
	view horizontalDominanceTreeLayout layered
]

{ #category : #roassal }
GTMetaceller >> viewVersionMapOf: configClass on: view [
	| nodes edges project |
	project := configClass project.
	nodes := Dictionary new.
	edges := OrderedCollection new.
	(Pragma allNamed: #version: in: configClass) do: [:prag | 
		nodes at: (prag argumentAt: 1) put: (project version: (prag argumentAt: 1)) ].
	(Pragma allNamed: #version:imports: in: configClass) do: [:prag | 
		| version imported |
		version := nodes at: (prag argumentAt: 1) put: (project version: (prag argumentAt: 1)).
		(prag argumentAt: 2) do: [:eachImportPrag |
			imported := nodes at: eachImportPrag ifAbsentPut: [ project version: eachImportPrag ].
			edges add: version -> imported ] ].
	view shape label text: [ :each | each versionNumber printString ].
	view nodes: nodes values.
	view edges: edges from: #key to: #value.
	view horizontalDominanceTreeLayout
]
