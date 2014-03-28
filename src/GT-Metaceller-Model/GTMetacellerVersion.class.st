Class {
	#name : #GTMetacellerVersion,
	#superclass : #Object,
	#instVars : [
		'parent',
		'children',
		'version',
		'configuration',
		'cachedPackageMap',
		'project',
		'groups',
		'items',
		'wrappers',
		'isNew',
		'properties'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #conveniance }
GTMetacellerVersion class >> allMethodsForProject:aProject [
	^aProject configuration methods collect: [ :each |
		self on: aProject configuration method: each project: aProject ]
]

{ #category : #testing }
GTMetacellerVersion class >> isValidVersion: aVersion [
	aVersion pragmas do: [ :each |
		(each key beginsWith: 'version') ifTrue: [  ^true ] ].
	^false
]

{ #category : #actions }
GTMetacellerVersion class >> load: aString [ 
	self version ifNotNil: [ self version load: aString ]
]

{ #category : #'instance creation' }
GTMetacellerVersion class >> on: aConfiguration method: aMethod project: aProject [
	^self basicNew
		initialize: aConfiguration method: aMethod project: aProject;
		yourself
]

{ #category : #conveniance }
GTMetacellerVersion class >> versionsForProject: aProject [
	^(aProject configuration methods
		select: [ :each | self isValidVersion: each ]
		thenCollect: [ :each | self on: aProject configuration method: each project: aProject ]) 
			asSortedCollection: [ :a :b | a versionName > b versionName ]
]

{ #category : #actions }
GTMetacellerVersion >> actions [
	| retVal |
	retVal := OrderedCollection new.
	retVal add: ((GLMGenericAction new) 
			action: [ :list  | list selection inspect ];
			title: 'Inspect'
			yourself).
	retVal add: ((GLMGenericAction new) 
			action: [ :list  | list selection method browse ];
			title: 'Browse method'
			yourself).
	retVal add: ((GLMGenericAction new) 
			action: [ :list  | list selection load ];
			title: 'Load'
			yourself).
 	retVal add: ((GLMGenericAction new) 
			action: [ :list  | list selection fetch ];
			title: 'Fetch'
			yourself).
"
	This checks the current version, but it needs to update the ui without recreating the versions
 	retVal add: ((GLMGenericAction new) 
			action: [ :list  | list selection checkCurrentVersion ];
			title: 'Check current version'
			yourself).
"	self isDevelopment ifTrue: [ 
	 	retVal add: ((GLMGenericAction new) 
			action: [ :list  | list selection update ];
			title: 'Update'
			yourself) ].
	^retVal
]

{ #category : #accessing }
GTMetacellerVersion >> addChild: aVersion [
"	(self platformSymbol = #'common' and: [ #( pharo squeak ) includes: aVersion platformSymbol ]) 
		ifTrue: [ self halt ].
"	self children add: aVersion
]

{ #category : #accessing }
GTMetacellerVersion >> allGroups [
	^self packagesAndProjects select: [ :each | each isGroup ]
]

{ #category : #accessing }
GTMetacellerVersion >> allPackages [
	^self packagesAndProjects select: [ :each | each isPackage ]
]

{ #category : #accessing }
GTMetacellerVersion >> allProjects [
	^self packagesAndProjects select: [ :each | each isProject ]
]

{ #category : #'accessing version' }
GTMetacellerVersion >> author [
	^self propertyAt: #author ifAbsent: [ self version author ]
]

{ #category : #'accessing version' }
GTMetacellerVersion >> author: aString [ 
	self propertyAt: #author put: aString
]

{ #category : #accessing }
GTMetacellerVersion >> belongsToGroup: aSpec [
	^(self tagsOf: aSpec) notEmpty
]

{ #category : #'accessing version' }
GTMetacellerVersion >> blessing [
	^self propertyAt: #blessing ifAbsent: [ self version spec blessing value ]
]

{ #category : #'accessing version' }
GTMetacellerVersion >> blessing: aSymbol [ 
	self propertyAt: #blessing put: aSymbol
]

{ #category : #accessing }
GTMetacellerVersion >> buildGroups [
	self version ifNotNil: [ 
		^self version groups collect: [ :each | GTMetacellerGroup on: self spec: each ] ].
	^#()
]

{ #category : #initialization }
GTMetacellerVersion >> buildItems [
	^self packagesAndProjects collect: [ :each | self wrapperFor: each ] 
]

{ #category : #testing }
GTMetacellerVersion >> canModify [
	^self project hasAttributes
]

{ #category : #accessing }
GTMetacellerVersion >> category [
	^self method category
]

{ #category : #actions }
GTMetacellerVersion >> checkCurrentVersion [
	self project checkCurrentVersion
]

{ #category : #accessing }
GTMetacellerVersion >> children [
	^children ifNil: [ children := OrderedCollection new ]
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> commentInfoSelectors [
	^#( blessing author timestamp )
]

{ #category : #accessing }
GTMetacellerVersion >> commonVersion [
	^self parent commonVersion
]

{ #category : #accessing }
GTMetacellerVersion >> configuration [
	^ configuration
]

{ #category : #accessing }
GTMetacellerVersion >> configuration: anObject [
	configuration := anObject
]

{ #category : #'code generation' }
GTMetacellerVersion >> createNewVersionWith: aClass selector: aString [ 
	| newVersion |
	newVersion := self copy.
	newVersion methodName: aString.
	" set the default values "
	self blessing = #'baseline'
		ifTrue: [ newVersion blessing: #'baseline' ]
		ifFalse: [ newVersion blessing: #'development' ].
	newVersion author: Author fullName.
	newVersion timestamp: DateAndTime now asDate yyyymmdd.
	aClass new perform: aString with: newVersion.
	" eveluate the pragma "
	(aClass methodDict at: aString) pragmas do: [ :pragma |
		(pragma key beginsWith: #'version:') ifTrue: [ newVersion versionName: (pragma argumentAt: 1)  ].
		(pragma key = #'version:imports:') ifTrue: [ newVersion importedVersions: (pragma argumentAt: 2) ] ].
	newVersion saveVersion
]

{ #category : #private }
GTMetacellerVersion >> createWrapperFor: aSpec [
	(self isProject: aSpec) ifTrue: [  ^GTMetacellerProjectReference on: self spec: aSpec ].
	(self isGroup: aSpec) ifTrue: [  ^GTMetacellerGroup on: self spec: aSpec ].
	(self isPackage: aSpec) ifTrue: [ ^GTMetacellerPackage on: self spec: aSpec ].
	^aSpec
	
]

{ #category : #'accessing version' }
GTMetacellerVersion >> description [
	^self propertyAt: #description ifAbsent: [ 	self version description ]
]

{ #category : #'accessing version' }
GTMetacellerVersion >> description: aString [ 
	self propertyAt: #description put: aString
]

{ #category : #'magritte-description' }
GTMetacellerVersion >> descriptionAuthor [
	<magritteDescription>
	^MAStringDescription new
		accessor: #author;
		label: 'Author';
		priority: 400;
		yourself
]

{ #category : #'magritte-description' }
GTMetacellerVersion >> descriptionBlessing [
	<magritteDescription>
	^MASingleOptionDescription new
		accessor: #blessing;
		label: 'Blessing';
		priority: 300;
		options: self possibleBlessings;
		yourself
]

{ #category : #'magritte-description' }
GTMetacellerVersion >> descriptionDescription [
	<magritteDescription>
	^MAMemoDescription new
		accessor: #description;
		label: 'Description';
		priority: 200;
		yourself
]

{ #category : #'magritte-description' }
GTMetacellerVersion >> descriptionName [
	<magritteDescription>
	^MAStringDescription new
		accessor: #versionName;
		label: 'Name';
		priority: 100;
		readonly: self isExisting;
		yourself
]

{ #category : #accessing }
GTMetacellerVersion >> determineVersion [
	self project ifNil: [  ^nil ].
	self method pragmas do: [ :each |
		(each key beginsWith: 'version') ifTrue: [ ^self project metacelloVersion: (each arguments first) ] ].
	^nil
]

{ #category : #printing }
GTMetacellerVersion >> displayString [
	^self textLabel
]

{ #category : #cache }
GTMetacellerVersion >> ensureProjectsCreated [
	self project ensureProjectsCreated
]

{ #category : #actions }
GTMetacellerVersion >> fetch [
	self version ifNotNil: [ self version fetch ]
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> findItem: anItem in: aCollection [ 
	^aCollection detect: [ :each |
		each itemName = anItem itemName ] ifNone: [ nil ]
]

{ #category : #accessing }
GTMetacellerVersion >> groups [
	^groups ifNil: [ groups := self buildGroups ]
]

{ #category : #accessing }
GTMetacellerVersion >> groupsAndLoosePackages [
	^(OrderedCollection withAll: self packagesWithoutGroups)
		addAll: self groups;
		yourself
]

{ #category : #testing }
GTMetacellerVersion >> hasAuthor [
	^self version author notNil
]

{ #category : #testing }
GTMetacellerVersion >> hasBlessing [
	^self version blessing notNil
]

{ #category : #testing }
GTMetacellerVersion >> hasDescription [
	^self version description notNil
]

{ #category : #testing }
GTMetacellerVersion >> hasItem: aMetacellerItem [
	^self items contains: [ :each | each name = aMetacellerItem name ]
]

{ #category : #testing }
GTMetacellerVersion >> hasName: aString [ 
	^self versionName = aString
]

{ #category : #'accessing version' }
GTMetacellerVersion >> importedVersions [
	^self propertyAt: #importedVersions ifAbsent: [ self version importedVersions ]
]

{ #category : #'accessing version' }
GTMetacellerVersion >> importedVersions: aCollection [ 
	self propertyAt: #importedVersions put: aCollection
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> infoFor: aSymbol [
	| data parentData |
	data := self perform: aSymbol.
	parentData := self parent perform: aSymbol.
	data = parentData ifTrue: [ ^nil ].
	^data

]

{ #category : #printing }
GTMetacellerVersion >> infoText [
	| retVal |
	retVal := self asText.
	retVal
		append: String cr;
		append: self description.
	#( blessing author timestamp versionStatus importedVersions ) do: [ :symbol |
		retVal append: String cr; append: symbol capitalized; append: ': '; append: (self perform: symbol) asMetacellerLabel ].

	self rootVersion errorVersions do: [ :each |
		retVal append: String cr;
		append: (Text string: ('Unrecognized platform: ', each platformSymbol) attribute: TextColor red) ].

	self packagesAndProjects do: [ :each |
		each hasWarnings ifTrue: [ 
			retVal append: String cr; append: each warningText ] ].
	^retVal
		
]

{ #category : #initialization }
GTMetacellerVersion >> initialize: aConfiguration method: aMethod project: aProject [
	self initialize.
	parent := aProject parentVersionFor: aMethod.
	configuration := aConfiguration.
	project := aProject.
	parent addChild: self.

]

{ #category : #actions }
GTMetacellerVersion >> install: aCollection [
	aCollection ifNil: [ ^self load ].
	self load: (aCollection collect: [ :each | each itemName ])
]

{ #category : #testing }
GTMetacellerVersion >> isBaseline [
	^self blessing = #baseline
]

{ #category : #testing }
GTMetacellerVersion >> isBleedingEdge [
	self project ifNil: [  ^false ].
	self version ifNil: [ ^false ].
	^self version = self project bleedingEdge
]

{ #category : #testing }
GTMetacellerVersion >> isCurrent [
	self project ifNil: [  ^false ].
	self version ifNil: [ ^false ].
	^self project currentVersion = self version
]

{ #category : #testing }
GTMetacellerVersion >> isDevelopment [
	^self blessing = #development
]

{ #category : #testing }
GTMetacellerVersion >> isDevelopmentVersion [
	self project ifNil: [  ^false ].
	self version ifNil: [ ^false ].
	^self project privateDevelopment = self version
]

{ #category : #testing }
GTMetacellerVersion >> isExisting [
	^self isNew not
]

{ #category : #testing }
GTMetacellerVersion >> isGroup: aSpec [ 
	^aSpec isKindOf: MetacelloGroupSpec
]

{ #category : #testing }
GTMetacellerVersion >> isLatestVersion [
	^self project latest = self version
]

{ #category : #testing }
GTMetacellerVersion >> isNew [
	^isNew ifNil: [ false ]
]

{ #category : #testing }
GTMetacellerVersion >> isNew: aBoolean [
	isNew := aBoolean
]

{ #category : #testing }
GTMetacellerVersion >> isPackage: aSpec [ 
	^aSpec isKindOf: MetacelloPackageSpec
]

{ #category : #testing }
GTMetacellerVersion >> isProject: aSpec [ 
	^(aSpec isKindOf: MetacelloProjectReferenceSpec) or: [ aSpec isKindOf: MetacelloProjectSpec ]
]

{ #category : #testing }
GTMetacellerVersion >> isRelease [
	^self blessing = #release
]

{ #category : #testing }
GTMetacellerVersion >> isStable [
	self project ifNil: [  ^false ].
	self version ifNil: [ ^false ].
	^(self project privateStableVersion = self version)
]

{ #category : #accessing }
GTMetacellerVersion >> itemFor: aString [ 
	^self packagesAndProjects detect: [ :each | each itemName = aString ] ifNone: [ nil ]
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> itemSelectors [
	^#( allProjects allGroups allPackages )
]

{ #category : #accessing }
GTMetacellerVersion >> items [
	^items ifNil: [ items := self buildItems ]
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> itemsForSymbol: aSymbol [
	| retVal |
	retVal := self perform: aSymbol.
	self version importedVersions do: [ :importName |
		| importedVersion |
		importedVersion := self project version: importName.
		self updateItems: retVal with: (importedVersion perform: aSymbol) ].
	self updateItems: retVal with: (self parent perform: aSymbol).
	^retVal
]

{ #category : #accessing }
GTMetacellerVersion >> labelAsText [
	^self textLabel
]

{ #category : #actions }
GTMetacellerVersion >> load [
	self version ifNotNil: [ self version load ]
]

{ #category : #actions }
GTMetacellerVersion >> load: aString [ 
	self version ifNotNil: [ self version load: aString ]
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> mainInfoSelectors [
	^#( blessing description preLoadDoIt postLoadDoIt author timestamp )
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> mainInfoSelectorsForDisplay: aBoolean [
	aBoolean ifFalse: [ ^self mainInfoSelectors ].
	^self mainInfoSelectors reject: [ :each | self commentInfoSelectors includes: each ].
]

{ #category : #accessing }
GTMetacellerVersion >> method [
	^self parent method
]

{ #category : #accessing }
GTMetacellerVersion >> methodCategory [
	^self method category
]

{ #category : #accessing }
GTMetacellerVersion >> methodClass [
	^self configuration
]

{ #category : #accessing }
GTMetacellerVersion >> methodName [
	^self propertyAt: #methodName ifAbsent: [ self method selector ]
]

{ #category : #'accessing version' }
GTMetacellerVersion >> methodName: aString [ 
	self propertyAt: #methodName put: aString
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> methodNameFor: aString [
	(aString endsWith: 'baseline') ifTrue: [ 
		^(('baseline', (aString copyFrom: 1 to: (aString size-8))) asLegalSelector) greaseString ].
	^('version', aString) asLegalSelector greaseString
]

{ #category : #'code generation' }
GTMetacellerVersion >> methodSpec [
	^self parent methodSpecForVersion: self
]

{ #category : #accessing }
GTMetacellerVersion >> methodString [
	^self method asString
]

{ #category : #'code generation' }
GTMetacellerVersion >> methodWithVersionName: aString [ 
	^self parent methodWithVersionName: aString
]

{ #category : #accessing }
GTMetacellerVersion >> name [
	self halt.
	self method pragmas do: [  :each |
		(each key beginsWith: 'version') ifTrue: [ ^each arguments first ] ].
	^self method selector
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> needsGenerating [
	self needsGeneratingMainInfo ifTrue: [ ^true ].
	self needsGeneratingItems ifTrue: [ ^true ].
	^false
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> needsGeneratingItems [
	self itemSelectors do: [ :each |
		(self itemsForSymbol: each) ifNotEmpty: [ ^true ] ].
	self repositoriesToWrite ifNotEmpty: [ ^true ].
	^false
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> needsGeneratingMainInfo [
	self mainInfoSelectors do: [ :each |
		(self infoFor: each) ifNotNil: [ ^true ] ].
	^false
]

{ #category : #accessing }
GTMetacellerVersion >> package: aString [
	^self items detect: [ :each | each hasName: aString ] ifNone: [ nil ]
	
]

{ #category : #accessing }
GTMetacellerVersion >> packageNamed: aString ifAbsent: aBlock [ 
	self version ifNil: [ ^nil ].
	^self version packageNamed: aString ifAbsent: aBlock
]

{ #category : #accessing }
GTMetacellerVersion >> packages [
	self version ifNil: [ ^#() ].
	^self version packages
]

{ #category : #private }
GTMetacellerVersion >> packagesAndGroups [
	cachedPackageMap ifNil: [
		cachedPackageMap := Dictionary new.
		self version ifNotNil: [
			self groups do: [:eachGroup |
				eachGroup children do: [ :eachPackage |
					(cachedPackageMap at: eachPackage referenceSpec ifAbsentPut: [OrderedCollection new])
						add: eachGroup name ] ] ] ].
	^ cachedPackageMap
]

{ #category : #accessing }
GTMetacellerVersion >> packagesAndProjects [
	self version ifNil: [ ^#() ].
	^(self version spec packages packageSpecsInLoadOrder)
		collect: [ :each | self wrapperFor: each ]
]

{ #category : #accessing }
GTMetacellerVersion >> packagesForSpecNamed: aVersionString [ 
	self version ifNotNil: [ ^self version packagesForSpecNamed: aVersionString ].
	^#()
]

{ #category : #accessing }
GTMetacellerVersion >> packagesWithoutGroups [
	" make sure the groups are built first "
	self groups.
	^self packagesAndProjects select: [ :each | (each isPackage or: [ each isProject ]) and: [ (self belongsToGroup: each) not ] ]
]

{ #category : #accessing }
GTMetacellerVersion >> parent [
	^ parent
]

{ #category : #accessing }
GTMetacellerVersion >> platform [
	^self project platformSymbol asString
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> platformSymbol [
	^self project platformSymbol
]

{ #category : #accessing }
GTMetacellerVersion >> platformsFor: aMetacellerItem [
	^self project platformsFor: aMetacellerItem version: self versionName
]

{ #category : #'accessing magritte' }
GTMetacellerVersion >> possibleBlessings [
	^#( #baseline #bleedingEdge #development #stable #release )
]

{ #category : #copying }
GTMetacellerVersion >> postCopy [
	" remove aliases of references we might change: "
	super postCopy.
	properties := self properties copy.
	
]

{ #category : #'accessing version' }
GTMetacellerVersion >> postLoadDoIt [
	^self propertyAt: #postLoadDoIt ifAbsent: [ self version basicSpec postLoadDoIt ]
]

{ #category : #'accessing version' }
GTMetacellerVersion >> postLoadDoIt: aString [
	^self propertyAt: #postLoadDoIt put: aString
]

{ #category : #'accessing version' }
GTMetacellerVersion >> preLoadDoIt [
	^self propertyAt: #preLoadDoIt ifAbsent: [ self version basicSpec preLoadDoIt ]
]

{ #category : #'accessing version' }
GTMetacellerVersion >> preLoadDoIt: aString [
	^self propertyAt: #preLoadDoIt put: aString
]

{ #category : #printing }
GTMetacellerVersion >> printOn: aStream [
	aStream nextPutAll: self displayString
]

{ #category : #accessing }
GTMetacellerVersion >> project [
	^project
]

{ #category : #accessing }
GTMetacellerVersion >> projects [
	self version ifNil: [ ^#() ].
	^self version projects
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> projectsForVersion: aString [ 
	self shouldBeImplemented.
]

{ #category : #actions }
GTMetacellerVersion >> promoteToRelease [
	self commonVersion blessing: #release.
	self saveVersion.
	self updateReleases
]

{ #category : #accessing }
GTMetacellerVersion >> properties [
	^properties ifNil: [ properties := Dictionary new ]
]

{ #category : #'accessing version' }
GTMetacellerVersion >> propertyAt: aSymbol ifAbsent: aBlock [
	^self properties at: aSymbol ifAbsent: aBlock
]

{ #category : #'accessing version' }
GTMetacellerVersion >> propertyAt: aSymbol put: aValue [
	self canModify ifFalse: [ GTMetacellerStateError signal: 'Cannot change ', aSymbol asString, ' of the main version.' ].
	self properties at: aSymbol put: aValue
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> repositoriesToWrite [
	^(self repositorySpecs repositoryDescriptions collect: [ :each | each description ]) removeAll: self parent repositoriesToWrite.
]

{ #category : #accessing }
GTMetacellerVersion >> repositorySpecs [
	^self version loader spec repositories
]

{ #category : #accessing }
GTMetacellerVersion >> rootVersion [
	^self parent rootVersion
]

{ #category : #actions }
GTMetacellerVersion >> saveAs: aVersionName [
	" check if this version does not exist yet "
	(self project version: aVersionName) ifNotNil: [ GTMetacellerDuplicateVersion signal: 'Version with name ', aVersionName, ' already exists.' ].
	self project compileMethod: (self methodWithVersionName: aVersionName) category: self category
]

{ #category : #actions }
GTMetacellerVersion >> saveVersion [
	self project compileMethod: self methodSpec category: self category
]

{ #category : #actions }
GTMetacellerVersion >> saveWithSpecString: aString [
	| tempClass selector |
	tempClass := self project createTempClass.
	tempClass compile: aString classified: self category.
	tempClass methodDict size = 1 ifFalse: [ GTMetacellerCompilationError signal: 'No valid spec.' ].
	(self method selector = (tempClass methodDict keys anyOne))
		ifTrue: [ self updateVersionWith: tempClass selector: self selector ]
		ifFalse: [ self createNewVersionWith: tempClass selector: (tempClass methodDict keys anyOne) ]
]

{ #category : #accessing }
GTMetacellerVersion >> selector [
	^self method selector
]

{ #category : #accessing }
GTMetacellerVersion >> sortedChildren [
	^self children sort: [ :v1 :v2 | v1 platformSymbol > v2 platformSymbol ]
]

{ #category : #accessing }
GTMetacellerVersion >> spec [
	self version ifNotNil: [ ^self version spec ].
	^nil
]

{ #category : #'code generation' }
GTMetacellerVersion >> specString [
	^String streamContents: [ :s |
		self streamVersionHeaderWithName: self versionName on: s.
		self needsGeneratingMainInfo ifTrue: [
			self streamMainInfoOn: s indent: 1 forDisplay: true.
			s cr; tab: 2; nextPutAll: 'yourself' ] ].
]

{ #category : #'code generation' }
GTMetacellerVersion >> streamItemSpecsOn: aStream indent: anIndent first: aFirst [
	| first |
	first := aFirst.
	self itemSelectors do: [ :each |
		| data |
		data := self itemsForSymbol: each.
		data ifNotEmpty: [ 
			first ifFalse: [ 
				aStream cr; tab: anIndent +1; nextPutAll: 'yourself.'; cr ].
			aStream cr; tab: anIndent; nextPutAll: 'aSpec'.
			data do: [ :item |
				item streamSpecOn: aStream indent: anIndent +1 specName: 'aSpec' ].
			first := false ] ].
	^first
		
			
			
			
]

{ #category : #'code generation' }
GTMetacellerVersion >> streamMainInfoOn: aStream indent: anIndent forDisplay: aBoolean [
	self needsGeneratingMainInfo ifTrue: [
		anIndent = 0
			ifTrue: [ aStream nextPutAll: 'aSpec' ]
			ifFalse: [ aStream cr; tab: anIndent; nextPutAll: 'aSpec' ].
		(self mainInfoSelectorsForDisplay: aBoolean) do: [ :each |
			(self infoFor: each) ifNotNilDo: [ :data |
				aStream cr; tab: anIndent +1; nextPutAll: each asString; nextPutAll: ': '.
				data asCodeStringOn: aStream.
				aStream nextPut: $; ] ].
		self streamRepositoriesOn: aStream indent: anIndent +1.
		aBoolean ifTrue: [
			aStream cr; nextPutAll: '"Following lines will be automatically set by Metaceller if not overridden:'.
			self commentInfoSelectors do: [ :each |
				(self infoFor: each) ifNotNilDo: [ :data |
					aStream cr; tab: anIndent +1; nextPutAll: each asString; nextPutAll: ': '.
					data asCodeStringOn: aStream.
					aStream nextPut: $; ] ].
			aStream cr; nextPut:$" ].
		^true ].
	^false
]

{ #category : #'code generation' }
GTMetacellerVersion >> streamRepositoriesOn: aStream indent: anIndent [ 
	self repositoriesToWrite do: [ :each |
		aStream cr; tab: anIndent; nextPutAll: 'Repository: '.
		each asCodeStringOn: aStream ]
]

{ #category : #'code generation' }
GTMetacellerVersion >> streamVersion: aVersion on: aStream [ 
	(aVersion notNil and: [ aVersion platformSymbol = self platformSymbol]) ifTrue: [ ^aVersion streamVersionOn: aStream ].
	^self streamVersionOn: aStream
]

{ #category : #'code generation' }
GTMetacellerVersion >> streamVersionHeader: aVersion on: aStream [
	(aVersion notNil and: [ aVersion platformSymbol = self platformSymbol]) ifTrue: [ ^aVersion streamVersionHeaderOn: aStream ].
	^self streamVersionHeaderOn: aStream
]

{ #category : #'code generation' }
GTMetacellerVersion >> streamVersionHeaderOn: aStream [
	aStream nextPutAll: self methodName; nextPutAll: ' aSpec'; cr;
		tab; nextPutAll: '<version: '.
	self versionName asCodeStringOn: aStream.
	self importedVersions ifNotEmpty: [ 
		aStream nextPutAll: ' imports: '.
		self importedVersions asCodeStringOn: aStream ].
	aStream nextPut: $>
]

{ #category : #'code generation' }
GTMetacellerVersion >> streamVersionHeaderWithName: aString on: aStream [
	aStream nextPutAll: (self methodNameFor: aString); nextPutAll: ': aSpec'; cr;
		tab; nextPutAll: '<version: '.
	aString asCodeStringOn: aStream.
	self version importedVersions ifNotEmpty: [ 
		aStream nextPutAll: ' imports: '.
		self version importedVersions asCodeStringOn: aStream ].
	aStream nextPut: $>
]

{ #category : #'code generation' }
GTMetacellerVersion >> streamVersionOn: aStream [
	self needsGenerating ifTrue: [
		| first |
		aStream
			cr; tab; nextPutAll: 'aSpec for: '.
		self platformSymbol asCodeStringOn: aStream.
		aStream nextPutAll: ' do: ['.
		first := (self streamMainInfoOn: aStream indent: 2 forDisplay: false) not.
		self streamItemSpecsOn: aStream indent: 2 first: first.
		aStream cr; tab: 3; nextPutAll: 'yourself ].' ].
	self sortedChildren do: [ :each |
		each streamVersionOn: aStream ]
]

{ #category : #printing }
GTMetacellerVersion >> tags [
	self version ifNil: [  ^#() ].
	^Array with: self blessing
]

{ #category : #printing }
GTMetacellerVersion >> tagsOf: aSpec [
	(aSpec isKindOf: GTMetacellerItem) ifTrue: [ ^self tagsOf: aSpec referenceSpec ].
	(aSpec isKindOf: MetacelloProjectReferenceSpec) ifTrue: [  ^self tagsOf: aSpec projectReference ].
	^self packagesAndGroups at: aSpec ifAbsent: [OrderedCollection new]
]

{ #category : #actions }
GTMetacellerVersion >> testItem: anItem [
	anItem resetValidated.
	anItem testValid
]

{ #category : #actions }
GTMetacellerVersion >> testItems: aCollection [ 
	aCollection do: [ :each | self testItem: each ]
]

{ #category : #printing }
GTMetacellerVersion >> textLabel [
	| attributes |
	attributes := OrderedCollection new.
	self version ifNil: [ attributes add: TextColor red ].
	self isBleedingEdge ifTrue: [ attributes add: TextColor red  ].
	self isDevelopmentVersion ifTrue: [ attributes add: TextColor blue ].
	self isCurrent ifTrue: [ attributes add: TextEmphasis underlined ].
	self isStable ifTrue: [ attributes add: TextEmphasis bold ].
	^Text string: self versionName attributes: attributes
]

{ #category : #'accessing version' }
GTMetacellerVersion >> timestamp [
	^self propertyAt: #timestamp ifAbsent: [ self version timestamp ]
]

{ #category : #'accessing version' }
GTMetacellerVersion >> timestamp: aString [ 
	self propertyAt: #timestamp put: aString
]

{ #category : #printing }
GTMetacellerVersion >> title [
	^self project title, ' ', self versionName
]

{ #category : #actions }
GTMetacellerVersion >> update [
	self isDevelopment ifTrue: [
		MetacelloToolBox updateToLatestPackageVersionsIn: self configuration description: 'Please describe this version.' ]
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> updateItems: anItemsCollection with: aBaselineItems [
	aBaselineItems do: [ :each |
		| myItem |
		myItem := self findItem: each in: anItemsCollection.
		myItem ifNotNil: [ anItemsCollection remove: myItem.
			myItem := myItem differenceWith: each.
			myItem ifNotNil: [ anItemsCollection add: myItem ] ] ]
]

{ #category : #actions }
GTMetacellerVersion >> updateReleases [
	self project updateReleasesFor: self versionName
]

{ #category : #actions }
GTMetacellerVersion >> updateToCurrent [
	" walk our version to update "
	self allPackages do: [ :each | each updateToCurrent ]
]

{ #category : #actions }
GTMetacellerVersion >> updateToCurrentAndSave [
	self project updateVersionToCurrent: self versionName.
	self saveVersion
]

{ #category : #'code generation' }
GTMetacellerVersion >> updateVersionWith: aClass selector: aString [ 
	aClass new perform: aString with: self.
	" eveluate the pragma "
	(aClass methodDict at: aString) pragmas do: [ :pragma |
		(pragma key = #'version:imports:') ifTrue: [ self importedVersions: (pragma argumentAt: 2) ] ].
	self saveVersion
]

{ #category : #actions }
GTMetacellerVersion >> validate [
	self validate: nil
]

{ #category : #actions }
GTMetacellerVersion >> validate: aList [ 
	| toCheck |
	aList
		ifNil: [ toCheck := self packagesAndProjects ]
		ifNotNil: [ 
			aList 
				ifEmpty: [ toCheck := self packagesAndProjects ]
				ifNotEmpty: [ toCheck := aList ] ].
	toCheck do: [ :each |
				each resetValidated; validate ]

]

{ #category : #testing }
GTMetacellerVersion >> validateDependencies: aGTMetacellerPackage [ 
	" for now we leave this empty "
]

{ #category : #actions }
GTMetacellerVersion >> validateItem: anItem [
	anItem resetValidated.
	anItem validate
]

{ #category : #actions }
GTMetacellerVersion >> validateItems: aCollection [ 
	aCollection do: [ :each |
		self validateItem: each ]
]

{ #category : #accessing }
GTMetacellerVersion >> version [
	^ version ifNil: [ version := self determineVersion ]
]

{ #category : #accessing }
GTMetacellerVersion >> version: anObject [
	version := anObject
]

{ #category : #'accessing version' }
GTMetacellerVersion >> versionName [
	^self propertyAt: #versionName ifAbsent: [ self version name ]
]

{ #category : #'accessing version' }
GTMetacellerVersion >> versionName: aString [
	^self propertyAt: #versionName put: aString
]

{ #category : #accessing }
GTMetacellerVersion >> versionNumber [
	^self asString
]

{ #category : #'accessing version' }
GTMetacellerVersion >> versionStatus [
	[ ^self version versionStatus ] on: Exception do: [ :ex | ^ex description ]
]

{ #category : #'accessing version' }
GTMetacellerVersion >> versions [
	^#()
]

{ #category : #private }
GTMetacellerVersion >> wrapperFor: aSpec [
	^self wrappers at: aSpec ifAbsentPut: [ self createWrapperFor: aSpec ]
]

{ #category : #accessing }
GTMetacellerVersion >> wrappers [
	^wrappers ifNil: [ wrappers := Dictionary new ]
]
