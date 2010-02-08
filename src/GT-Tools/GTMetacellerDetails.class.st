"
self openOn: ConfigurationOfGlamour
"
Class {
	#name : #GTMetacellerDetails,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #building }
GTMetacellerDetails >> buildBrowser [
	| innerBrowser |
	browser := GLMAccumulator new.
	browser title: 'Metaceller Configuration Browser'.
	innerBrowser := GLMTabulator new.
	innerBrowser column: #versions; column: #packages span: 2.
	self toPackagesFromVersionsAndShow: innerBrowser.
	self toVersionsAndShow: innerBrowser.
	browser show: [ :a |
		a title: 	[:config | self shortNameOf: config ].
		a custom: innerBrowser ].
	browser transmit toOutside: #entity; fromOutside: #strongSelection.

]

{ #category : #private }
GTMetacellerDetails >> goferForVersion: version [
	| g |
	g := Gofer new.
	version spec repositories list do: [:each | g url: each name ].
	version spec packages do: [:each | 
		(each isKindOf: MetacelloPackageSpec) ifTrue: [ g package: each name]].
	^ g
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
GTMetacellerDetails >> toPackagesFromVersionsAndShow: innerBrowser [
	innerBrowser transmit to: #packages; from: #versions; andShow: [ :a |
		a title: [:version | version name ].
		a tree
			title: 'Items';
			display: [:version | version spec packages packageSpecsInLoadOrder];
			format: [:packageSpec | | text |
				text := ((packageSpec isKindOf: MetacelloPackageSpec) and: [
					self packageSpecNeedsSaving: packageSpec])
						ifTrue: [Text string: packageSpec name attribute: TextColor blue] 
						ifFalse: [ Text string: packageSpec name attribute: (packageSpec isLoaded ifTrue: [TextColor black] ifFalse: [TextColor gray])].
				(packageSpec isKindOf: MetacelloGroupSpec) ifTrue: [ text addAttribute: TextEmphasis italic from: 1 to: text size ].
				text] ;
			children: [:spec | 
				(spec isKindOf: MetacelloProjectReferenceSpec) 
					ifTrue: [ spec projectReference version spec packages packageSpecsInLoadOrder ]
					ifFalse: [	#() ]
				];
			tags: [:packageSpec :version | 
				self tagsOf: packageSpec in: version  ]; 
			act: [:list  | list selection inspect] entitled: 'Inspect';
			act: [:list :version | version load: list selection name ] entitled: 'Load'.
 		a mondrian
			title: 'Dependencies';
			painting: [:view :version | self viewDependenciesOf: version on: view].
		a text 
			title: 'Script';
			forSmalltalk;
			display: [:version |
				version spec printString ].
		a list
			title: 'Newer in repository?';
			display: [:version | version spec packages packageSpecsInLoadOrder ];
			format: [:packageSpec :version | ((packageSpec isKindOf: MetacelloPackageSpec) and: [
					self  packageSpec: packageSpec hasNewerVersionsFrom: version])
				ifTrue: [Text string: packageSpec name attribute: TextColor red] ifFalse: [packageSpec name]];
			act: [:list  | list selection inspect] entitled: 'Inspect'
	].
	innerBrowser transmit 
		toOutside: #strongSelection; from: #packages->#strongSelection; 
		when: [:selection | selection isKindOf: MetacelloProjectReferenceSpec ]; 
		transformed: [:selection | selection projectReference projectClass ]
]

{ #category : #building }
GTMetacellerDetails >> toVersionsAndShow: innerBrowser [
	innerBrowser transmit to: #versions; andShow: [ :a |
		a list
			title: 'Versions';
			display: [:config | config project versions reverse ];
			format: [:each :config | | text |
				text := ([each isPossibleBaseline not] on: Error do: [true])
					ifTrue: [Text string: each versionNumber asString attribute: TextColor gray] 
					ifFalse: [each versionNumber asString asText].
				config project currentVersion = each ifTrue: [ text allBold ].
				text ];
			act: [:list :config | 
				self spawnNewVersionFrom: list selection in: config.
				] entitled: 'Spawn new version';
			act: [:list | 
				(self goferForVersion: list selection) browseRemoteChanges ] entitled: 'Browse remote changes';
			act: [:list  | list selection inspect] entitled: 'Inspect'.
		a mondrian
			title: 'Imports';
			painting: [:view :config | self viewVersionMapOf: config on: view]]
]

{ #category : #private }
GTMetacellerDetails >> viewDependenciesOf: version on: view [
	| all | 
	all := Dictionary new.
	version packages do: [:each | all at: each name put: each].
	version projects do: [:each | all at: each name put: each].
	view shape label text: [:each | each name ].
	view nodes: all values.
	view shape curvedLine.
	view edges: version packages from: [:eachPackage | all at: eachPackage name] toAll: [:eachPackage |
		eachPackage requires collect: [:each | all at: each ]].
	view horizontalDominanceTreeLayout
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
