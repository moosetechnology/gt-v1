"
self open
"
Class {
	#name : #GTMetaceller,
	#superclass : #GLMGlobalBrowserTemplate,
	#instVars : [
		'announcer'
	],
	#category : #'GT-Tools-Metaceller'
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

{ #category : #display }
GTMetaceller >> attributesForPackageSpec: aPackage [
	| retVal |
	retVal := OrderedCollection new.
	(self isPackageLoaded: aPackage) ifTrue: [ 
		retVal add: TextEmphasis underlined.
		(self isPackageNewer: aPackage) ifTrue: [ retVal add: TextEmphasis bold ] ].
	^retVal
]

{ #category : #building }
GTMetaceller >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Metacello Browser'.
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
				column: #packages span: 3 ];
		row: #details.
	browser transmit
		to: #configs;
		andShow: [ :a | self configurationsIn: a ].
	browser transmit
		from: #configs;
		to: #versions;
		andShow: [ :a | self versionBrowserOn: a ].
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
GTMetaceller >> childrenForGroup: aGroupSpec version: aVersion [
	^aVersion packagesForSpecNamed: aGroupSpec name
]

{ #category : #accessing }
GTMetaceller >> childrenForItem: aSpec version: aVersion [
	(self isProject: aSpec) ifTrue: [  ^self childrenForProject: aSpec ].
	(self isGroup: aSpec) ifTrue: [ ^self childrenForGroup: aSpec version: aVersion ].
	^#()

]

{ #category : #accessing }
GTMetaceller >> childrenForProject: aProjectReference [
	(self isProject: aProjectReference) ifFalse: [ ^#() ].
	(self isProjectLoaded: aProjectReference)
		ifTrue: [ ^aProjectReference version spec packages packageSpecsInLoadOrder ]
		ifFalse: [ ^#() ]
]

{ #category : #accessing }
GTMetaceller >> configForProject: aReferenceSpec [ 
	aReferenceSpec ifNil: [  ^nil ].
	aReferenceSpec projectReference ifNil: [  ^nil ].
	aReferenceSpec projectReference className ifNil: [  ^nil ].
	^Smalltalk at: (aReferenceSpec projectReference className asSymbol) ifAbsent: [ ]
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
GTMetaceller >> detailsForMethod: aBrowser [
	aBrowser smalltalkCode
		smalltalkClass: [ :method | method methodClass ];
		display: [ :method | method asString ];
		populate: #acceptedCode icon: GLMUIThemeExtraIcons glamorousAccept on: $s entitled: 'Accept' with: [ :pane :method | self acceptCode: pane text method: method ]
]

{ #category : #building }
GTMetaceller >> detailsForPackage: aBrowser [
	aBrowser text
		display: [ :package | package asString ]
]

{ #category : #building }
GTMetaceller >> detailsForVersion: aBrowser [
	aBrowser smalltalkCode
		smalltalkClass: [ :version | version methodClass ];
		display: [ :version | version methodString ];
		populate: #acceptedCode icon: GLMUIThemeExtraIcons glamorousAccept on: $s entitled: 'Accept' with: [ :pane :version | self acceptCode: pane text version: version ]
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
	^aVersion spec packages packageSpecsInLoadOrder select: [  :each | self isGroup: each ]
]

{ #category : #private }
GTMetaceller >> helpText [
	^'Metaceller is a tool for browsing the Metacello configurations present in the image.

The Configurations tab lists all the projects from the ConfigurationOfXXX present in the image. Double clicking on an item spawns the configuration details.

The Versions tab lists all the versions defined in the configuration. The color coding shows:
- blue = the current bleeding edge
- bold = the stable version
- italic = the development version

The Imports tab shows how versions import from one another.

Upon selecting a version, the third pane shows the details of the specification of the version.

The Items tab shows the packages, groups and projects from the version. Each project can be expanded to display its items.

The color coding shows:
- blue = project
- bold = newer package in version
- underlined = package / project loaded in image
- italic = groups
.'
]

{ #category : #testing }
GTMetaceller >> isGroup: aSpec [ 
	^aSpec isKindOf: MetacelloGroupSpec
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
GTMetaceller >> isPackageLoaded: aPackageSpec [ 
	^aPackageSpec isPackageLoaded
]

{ #category : #testing }
GTMetaceller >> isPackageNewer: aPackageSpec [ 
	^false
]

{ #category : #testing }
GTMetaceller >> isPackageOlder: aPackageSpec [ 
	aPackageSpec isPackageLoaded ifFalse: [ ^false ].
	^aPackageSpec needsSaving
]

{ #category : #testing }
GTMetaceller >> isProject: aSpec [ 
	^aSpec isKindOf: MetacelloProjectReferenceSpec
]

{ #category : #testing }
GTMetaceller >> isProjectLoaded: aProjectSpec [ 
	(aProjectSpec isKindOf: MetacelloProjectReferenceSpec) ifFalse: [ ^aProjectSpec isPackageLoaded ]. 
	^(self configForProject: aProjectSpec) notNil
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
GTMetaceller >> nameForGroup: aGroup [
	^Text string: aGroup label attribute: TextEmphasis italic
]

{ #category : #display }
GTMetaceller >> nameForItem: anItem [
	(self isProject: anItem) ifTrue: [  ^self nameForProject: anItem ].
	(self isGroup: anItem) ifTrue: [  ^self nameForGroup: anItem ].
	^self nameForPackageSpec: anItem
]

{ #category : #display }
GTMetaceller >> nameForPackageSpec: aPackage [
"	(self isPackageLoaded: aPackage) ifFalse: [ ^aPackage label  ].
	(self isPackageOlder: aPackage) ifTrue: [ ^
		Text string: aPackage label attributes: (Array with: TextEmphasis underlined with: TextEmphasis bold) ].
	^aPackage label
"
	^Text string: aPackage file attributes: (self attributesForPackageSpec: aPackage)
]

{ #category : #display }
GTMetaceller >> nameForProject: aProjectReference [
	| attributes |
	attributes := OrderedCollection new.
	(self isProjectLoaded: aProjectReference) ifTrue: [ attributes add: TextEmphasis underlined ].
	attributes add: TextColor blue.
	aProjectReference versionString 
		ifNil: [ ^(Text string: aProjectReference label attributes: attributes), (Text string: ' No version' attribute: TextColor red) ]
		ifNotNil: [ ^(Text string: aProjectReference label attributes: attributes), (Text string: (' ', aProjectReference versionString) attribute: TextColor blue) ].
	
]

{ #category : #building }
GTMetaceller >> packageBrowserOn: aBrowser [
	aBrowser tree
		title: 'Packages';
		display: [ :version | self itemsForVersion: version ];
		children: [ :item | self childrenForProject: item ];	"note: asking children of a group in a subproject is buggy, so we do not expand groups here."
		format: [ :item | self nameForItem: item ];
		tags: [ :packageSpec :version | self tagsOf: packageSpec in: version ];
		dynamicActionsOnSelection: [ :list | self actionsForItem: list selection ];
		updateOn: GTConfigChanged from: self announcer.
	aBrowser tree
		title: 'Groups';
		children: [ :item :version | self childrenForItem: item version: version ];
		display: [ :version | self groupsForVersion: version ];
		updateOn: GTConfigChanged from: self announcer;
		format: [ :item | self nameForItem: item ].
	aBrowser roassal
		title: 'Dependencies';
		painting: [ :view :version | self viewDependenciesOf: version on: view ]
]

{ #category : #accessing }
GTMetaceller >> packagesForVersion: aVersion [
	aVersion ifNil: [ ^#() ].
	(aVersion isKindOf: Association) ifTrue: [  ^#() ].
	^aVersion spec packages packageSpecsInLoadOrder select: [  :each | self isPackage: each ]
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
GTMetaceller >> tagsOf: aPackageSpec in: aVersion [
	^aVersion tagsOf: aPackageSpec
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
		selectionAct: [ :list | list selection inspect ] entitled: 'Inspect version';
		format: [ :version | version textLabel ].
	aBrowser roassal
		title: 'Imports';
		painting: [:view :config | self viewVersionMapOf: config on: view].
	aBrowser list 
		title: 'Methods';
		display: [ :config | GTMetacellerVersion allMethodsForConfig: config ];
		updateOn: GTConfigChanged from: self announcer;
		selectionAct: [ :list | list selection method browse ] entitled: 'Browse method';
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
