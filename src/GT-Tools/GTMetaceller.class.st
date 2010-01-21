"
self open
"
Class {
	#name : #GTMetaceller,
	#superclass : #GLMGlobalBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #building }
GTMetaceller >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Metacello Browser'.
	browser column: #configs; column: #versions; column: #packages span: 2.
	self toConfigsAndShow.
	self toVersionsFromConfigsAndShow.
	self toPackagesFromVersionsAndShow.
	^ browser 
]

{ #category : #opening }
GTMetaceller >> entity [ 
	^ (Object subclasses select: [:each | (each class canUnderstand: #isMetacelloConfig) and: [
			each isMetacelloConfig ] ]) sort: [:a :b | a name < b name]
]

{ #category : #private }
GTMetaceller >> goferForVersion: version [
	| g |
	g := Gofer new.
	version spec repositories list do: [:each | g url: each name ].
	version spec packages do: [:each | 
		(each isKindOf: MetacelloPackageSpec) ifTrue: [ g package: each name]].
	^ g
]

{ #category : #private }
GTMetaceller >> packageSpec: packageSpec hasNewerVersionsFrom: version [
	| g |
	g := Gofer new.
	version spec repositories list do: [:each | g url: each name ].
	g package: packageSpec name.
	^ g resolved first name ~= packageSpec currentVersionInfo name
]

{ #category : #private }
GTMetaceller >> packageSpecHasNewerVersions: aPackageSpec [
	| copy |
	copy := aPackageSpec workingCopy.
	copy isNil ifTrue: [^ false ].
	^ copy possiblyNewerVersions notEmpty
]

{ #category : #private }
GTMetaceller >> packageSpecNeedsSaving: aPackageSpec [
	| copy |
	copy := aPackageSpec workingCopy.
	copy isNil ifTrue: [^ false ].
	^ copy needsSaving
]

{ #category : #private }
GTMetaceller >> packagesAndGroupsOf: version [
	| packageMap |
	packageMap := Dictionary new.
	version groups do: [:eachGroup |
		(version packagesForSpecNamed: eachGroup name) do: [:eachPackage |
			packageMap at: eachPackage ifAbsentPut: [OrderedCollection new].
			(packageMap at: eachPackage) add: eachGroup name ] ].
	^ packageMap
]

{ #category : #private }
GTMetaceller >> shortNameOf: config [
	"self new shortNameOf: ConfigurationOfAlien"
	^ ((config name beginsWith: 'ConfigurationOf') 
		ifTrue: [config name copyFrom: 'ConfigurationOf' size + 1 to: config name size ] 
		ifFalse: [config name]) asString
]

{ #category : #private }
GTMetaceller >> tagsOf: packageSpec in: version [
	^ (self packagesAndGroupsOf: version) at: packageSpec ifAbsent: [OrderedCollection new]
]

{ #category : #building }
GTMetaceller >> toConfigsAndShow [
	browser transmit to: #configs; andShow: [ :a |
		a title: 'Configurations'.
		a list
			format: [:configClass | | label version |
				label := self shortNameOf: configClass.
				(version := configClass project currentVersion) notNil
					ifTrue: [ 
						label := label, ' [', version versionString, ']'.
						label := Text string: label attribute: TextEmphasis bold ].
				label];
			act: [:list  | list selection browse ] entitled: 'Browse implementation';
			act: [:list  | list selection project inspect] entitled: 'Inspect';
			actions: [:list | 
				(GTOBCommandAdaptor new 
					actionsFrom: OBCmdMetacello subclasses 
					on: list selection 
					for: nil ) do: [:each | each category: 'OB Commands'] ] ]
]

{ #category : #building }
GTMetaceller >> toPackagesFromVersionsAndShow [
	browser transmit to: #packages; from: #versions; andShow: [ :a |
		a title: [:version | version name ].
		a list
			title: 'Items';
			display: [:version | version spec packages packageSpecsInLoadOrder];
			format: [:packageSpec | | text |
				text := ((packageSpec isKindOf: MetacelloPackageSpec) and: [
					self packageSpecNeedsSaving: packageSpec])
						ifTrue: [Text string: packageSpec name attribute: TextColor blue] 
						ifFalse: [  packageSpec name asText].
				packageSpec isLoaded ifTrue: [ text allBold ].
				(packageSpec isKindOf: MetacelloProjectReferenceSpec) 
					ifTrue: [ text addAttribute: TextEmphasis underlined from: 1 to: text size ].
				(packageSpec isKindOf: MetacelloGroupSpec) ifTrue: [ text addAttribute: TextEmphasis italic from: 1 to: text size ].
				text] ;
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
"			
			
		a list
			title: 'Newer in repository?';
			display: [:version | version spec packages packageSpecsInLoadOrder];
			format: [:packageSpec :version | ((packageSpec isKindOf: MetacelloPackageSpec) and: [
					self  packageSpecHasNewerVersions: packageSpec])
				ifTrue: [Text string: packageSpec name attribute: TextColor red] ifFalse: [packageSpec name]];
			act: [:list  | list selection inspect] entitled: 'Inspect'"
	]
]

{ #category : #building }
GTMetaceller >> toVersionsFromConfigsAndShow. [
	browser transmit to: #versions; from: #configs; andShow: [ :a |
		a title: [:config | self shortNameOf: config ].
		a list
			title: 'Versions';
			display: [:config | config project versions reverse ];
			format: [:each :config | | text |
				text := ([each isPossibleBaseline not] on: Error do: [true])
					ifTrue: [Text string: each versionNumber asString attribute: TextColor gray] 
					ifFalse: [each versionNumber asString asText].
				config project currentVersion = each ifTrue: [ text allBold ].
				text ];
			act: [:list | 
				(self goferForVersion: list selection) browseRemoteChanges ] entitled: 'Browse remote changes';
			act: [:list  | list selection inspect] entitled: 'Inspect'.
		a mondrian
			title: 'Imports';
			painting: [:view :config | self viewVersionMapOf: config on: view]]
]

{ #category : #private }
GTMetaceller >> viewDependenciesOf: version on: view [
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
GTMetaceller >> viewVersionMapOf: configClass on: view [

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
