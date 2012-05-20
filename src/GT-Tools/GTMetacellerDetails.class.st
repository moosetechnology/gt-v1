"
self openOn: ConfigurationOfGlamour
"
Class {
	#name : #GTMetacellerDetails,
	#superclass : #GLMBrowserTemplate,
	#instVars : [
		'master'
	],
	#category : #'GT-Tools-Prototypes'
}

{ #category : #building }
GTMetacellerDetails >> buildBrowser [
	| innerBrowser |
	browser := GLMAccumulator new.
	browser title: 'Glamorous Metaceller'.

	innerBrowser := GLMTabulator new.
	innerBrowser column: #versions; column: #packages span: 2.
	innerBrowser transmit to: #versions; andShow: [ :a |
		self versionsIn: a ].
	innerBrowser transmit to: #packages; from: #versions; andShow: [ :a | 
		self packagesIn: a ].

	browser show: [ :a |
		a title: 	[:config | self shortNameOf: config ].
		a custom: innerBrowser ].
	browser transmit toOutsidePort: #entity; fromOutsidePort: #strongSelection.

]

{ #category : #private }
GTMetacellerDetails >> goferForVersion: version [
	| g |
	g := Gofer new.
	version spec repositories list do: [:each | g url: each name ].
	version packages do: [:each | 
		(each isKindOf: MetacelloPackageSpec) ifTrue: [ g package: each name]].
	^ g
]

{ #category : #private }
GTMetacellerDetails >> labelOfItemSpec: packageSpec [

	| label text |
	label := packageSpec name.
	(packageSpec isKindOf: MetacelloPackageSpec) ifTrue: [label := packageSpec file].
	(packageSpec isKindOf: MetacelloProjectReferenceSpec) ifTrue: [label := packageSpec name, ' ', packageSpec versionString].
	
	text := ((packageSpec isKindOf: MetacelloPackageSpec) and: [
		self packageSpecNeedsSaving: packageSpec])
			ifTrue: [Text string: label attribute: TextColor blue] 
			ifFalse: [ 
				Text fromString: label
				"Text 
					string: label
					attribute: ((self master useCacheDuring: [ packageSpec isLoaded ]) 
					ifTrue: [TextColor black] 
					ifFalse: [TextColor gray])"].
	(packageSpec isKindOf: MetacelloGroupSpec) ifTrue: [ 
		text addAttribute: TextEmphasis italic from: 1 to: text size ].
	^ text
]

{ #category : #accessing }
GTMetacellerDetails >> master [
	^ master
]

{ #category : #accessing }
GTMetacellerDetails >> master: anObject [
	master := anObject
]

{ #category : #private }
GTMetacellerDetails >> packageSpec: packageSpec hasNewerVersionsFrom: version [
	| g |
	g := Gofer new.
	version spec repositories list do: [:each | g url: each name ].
	g package: packageSpec name.
	^ g resolved first name ~= packageSpec currentVersionInfo name
]

{ #category : #private }
GTMetacellerDetails >> packageSpecNeedsSaving: aPackageSpec [
	| copy |
	copy := aPackageSpec workingCopy.
	copy isNil ifTrue: [^ false ].
	^ copy needsSaving
]

{ #category : #private }
GTMetacellerDetails >> packagesAndGroupsOf: version [
	| packageMap |
	packageMap := Dictionary new.
	version groups do: [:eachGroup |
		(version packagesForSpecNamed: eachGroup name) do: [:eachPackage |
			packageMap at: eachPackage ifAbsentPut: [OrderedCollection new].
			(packageMap at: eachPackage) add: eachGroup name ] ].
	^ packageMap
]

{ #category : #building }
GTMetacellerDetails >> packagesIn: a [
	a title: [ :version | version name ].
	(a tree)
		title: 'Items';
		display: [ :version | version spec packages packageSpecsInLoadOrder ];
		format: [ :packageSpec | self labelOfItemSpec: packageSpec ];
		children: [ :spec | 
					(spec isKindOf: MetacelloProjectReferenceSpec)
						ifTrue: [ spec projectReference version spec packages packageSpecsInLoadOrder ]
						ifFalse: [ #() ] ];
		tags: [ :packageSpec :version | self tagsOf: packageSpec in: version ];
		act: [ :list | list selection inspect ] entitled: 'Inspect';
		act: [ :list :version | version load: list selection name ] entitled: 'Load'.
	(a mondrian)
		title: 'Dependencies';
		painting: [ :view :version | self viewDependenciesOf: version on: view ].
	(a smalltalkCode)
		title: 'Script';
		variableBindings: {#spec -> MetacelloProjectReferenceSpec new};
		display: [ :version | version spec printString ].
"	(a list)
		title: 'Newer in repository?';
		display: [ :version | version spec packages packageSpecsInLoadOrder ];
		format: [ :packageSpec :version | 
					((packageSpec isKindOf: MetacelloPackageSpec) and: [ self packageSpec: packageSpec hasNewerVersionsFrom: version ])
						ifTrue: [ Text string: packageSpec name attribute: TextColor red ]
						ifFalse: [ packageSpec name ] ];
		act: [ :list | list selection inspect ] entitled: 'Inspect'."
"	(innerBrowser transmit)
		toOutside: #strongSelection;
		from: #packages port: #strongSelection;
		when: [ :selection | selection isKindOf: MetacelloProjectReferenceSpec ];
		transformed: [ :selection | selection projectReference projectClass ]"
]

{ #category : #private }
GTMetacellerDetails >> shortNameOf: config [
	"self new shortNameOf: ConfigurationOfAlien"
	^ ((config name beginsWith: 'ConfigurationOf') 
		ifTrue: [config name copyFrom: 'ConfigurationOf' size + 1 to: config name size ] 
		ifFalse: [config name]) asString
]

{ #category : #private }
GTMetacellerDetails >> spawnNewVersionFrom: sourceVersion in: aSmalltalkClass [
	| vn targetVersionString selector |
	vn := sourceVersion versionString asMetacelloVersionNumber copy incrementMinorVersionNumber.
	targetVersionString := OBTextRequest prompt: 'Enter the target version number (source: ', sourceVersion versionString, ').' template: vn printString.
	selector := OBTextRequest prompt: 'Enter the new method selector' template: ('version', (targetVersionString copyWithout: $.) copyWithout: $-), ':'.
	selector numArgs ~~ 1 ifTrue: [ ^ self error: 'Selector must take a single argument: ', selector ].
	MetacelloVersionConstructor 
		spawnPackageMethodIn: aSmalltalkClass new 
		named: selector asSymbol
		sourceVersion: sourceVersion versionString
		targetVersion: targetVersionString 
]

{ #category : #private }
GTMetacellerDetails >> tagsOf: packageSpec in: version [
	^ (self packagesAndGroupsOf: version) at: packageSpec ifAbsent: [OrderedCollection new]
]

{ #category : #building }
GTMetacellerDetails >> versionsIn: composer [
	composer list
		title: 'Versions';
		display: [:config | config project versions reverse ];
		format: [:each :config | each versionNumber asString ];
		selectionAct: [:list :config | 
			self spawnNewVersionFrom: list selection in: config.
			list update.
			] entitled: 'Spawn new version';
		selectionAct: [:list | 
			(self goferForVersion: list selection) browseRemoteChanges ] entitled: 'Browse remote changes';
		selectionAct: [:list  | list selection inspect] entitled: 'Inspect'.
	composer mondrian
		title: 'Imports';
		painting: [:view :config | self viewVersionMapOf: config on: view]
]

{ #category : #private }
GTMetacellerDetails >> viewDependenciesOf: version on: view [
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
		eachPackage requires collect: [:each | all at: each ]].
	view horizontalDominanceTreeLayout layered
]

{ #category : #private }
GTMetacellerDetails >> viewVersionMapOf: configClass on: view [

	| prag1 prag2 nodes edges version imported |
	prag1 := Pragma allNamed: #version:imports: in: configClass.
	prag2 := Pragma allNamed: #version: in: configClass.
	nodes := Dictionary new.
	edges := OrderedCollection new.
	prag2 do: [:prag | 
		nodes at: (prag argumentAt: 1) put: (configClass project version: (prag argumentAt: 1)) ].
	prag1 do: [:prag | 
		version := nodes at: (prag argumentAt: 1) put: (configClass project version: (prag argumentAt: 1)).
		(prag argumentAt: 2) do: [:eachImportPrag |
			imported := nodes at: eachImportPrag ifAbsentPut: [configClass project version: eachImportPrag].
			edges add: version -> imported.
			]
		].
	view shape label text: [:each | each versionNumber printString].
	view nodes: nodes values.
	view edges: edges from: #key to: #value.
	view horizontalDominanceTreeLayout
]
