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
		'properties',
		'isCopy',
		'errors',
		'warnings'
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
	^self items select: [ :each | each isGroup ]
]

{ #category : #accessing }
GTMetacellerVersion >> allPackages [
	^self items select: [ :each | each isPackage ]
]

{ #category : #accessing }
GTMetacellerVersion >> allProjects [
	^self items select: [ :each | each isProject ]
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
	self hasError ifTrue: [ ^#() ].
	self version ifNotNil: [ 
		^self version groups collect: [ :each | GTMetacellerGroup on: self spec: each ] ].
	^#()
]

{ #category : #initialization }
GTMetacellerVersion >> buildItems [
	^self packagesAndProjects sort: [ :a :b | a itemName < b itemName ]
]

{ #category : #testing }
GTMetacellerVersion >> canModify [
	^self project hasAttributes and: [ self isCopy ]
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
GTMetacellerVersion >> childVersions [
	^self children
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
	newVersion repositories: OrderedCollection new.
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

{ #category : #'accessing error' }
GTMetacellerVersion >> errorMessage [
	^self version asString
]

{ #category : #accessing }
GTMetacellerVersion >> errors [
	^errors ifNil: [ errors := OrderedCollection new ]
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

{ #category : #'accessing generation' }
GTMetacellerVersion >> generatedItemFor: aString [
	| retVal |
	retVal := self item: aString.
	self version importedVersions do: [ :importName |
		| importedVersion |
		importedVersion := self project version: importName.
		retVal := self updateItem: retVal with: (importedVersion item: aString) ].
	self updateItem: retVal with: (self parent item: aString).
	^retVal
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
GTMetacellerVersion >> hasError [
	^self version isKindOf: Error
]

{ #category : #testing }
GTMetacellerVersion >> hasItem: aMetacellerItem [
	^self items contains: [ :each | each itemName = aMetacellerItem name ]
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
	self errors do: [ :each |
		retVal append: String cr; append: (Text string: each attribute: TextColor red) ].
	self warnings do: [ :each |
		retVal append: String cr; append: (Text string: each attribute: TextColor orange) ].
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

{ #category : #accessing }
GTMetacellerVersion >> isCopy [
	^isCopy ifNil: [ false ]
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
GTMetacellerVersion >> isMetacellerRelease [
	^false
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
GTMetacellerVersion >> item: aName [ 
	^self items detect: [ :each | each itemName = aName ] ifNone: [ nil ]
]

{ #category : #actions }
GTMetacellerVersion >> itemListFrom: anItemOrList [
	anItemOrList
		ifNil: [ ^self items ].
	anItemOrList isCollection ifFalse: [ ^Array with: anItemOrList ].
	anItemOrList ifEmpty: [ ^self items ].
	^anItemOrList
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> itemSelectors [
	^#( allProjects allPackages allGroups )
]

{ #category : #accessing }
GTMetacellerVersion >> items [
	^items ifNil: [ items := self buildItems ]
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> itemsFilteredOn: aSymbol [
	^self items select: [ :each | each perform: aSymbol ]
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

{ #category : #'accessing generation' }
GTMetacellerVersion >> itemsFrom: aCollection filterOn: aSymbol [
	| retVal |
	retVal := aCollection select: [:each | each perform: aSymbol ].
	self version importedVersions do: [ :importName |
		| importedVersion |
		importedVersion := self project version: importName.
		self updateItems: retVal with: (importedVersion itemsFilteredOn: aSymbol) ].
	self updateItems: retVal with: (self parent itemsFilteredOn: aSymbol).
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

{ #category : #'code generation' }
GTMetacellerVersion >> methodSpec [
	^self parent methodSpecForVersion: self
]

{ #category : #'code generation' }
GTMetacellerVersion >> methodSpecForVersion: aVersion [ 
	^self parent methodSpecForVersion: aVersion
]

{ #category : #accessing }
GTMetacellerVersion >> methodString [
	^self method asString
]

{ #category : #'code generation' }
GTMetacellerVersion >> methodWithVersionName: aString [ 
	^self parent methodWithVersionName: aString
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
	^false
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> needsGeneratingMainInfo [
	self mainInfoSelectors do: [ :each |
		(self infoFor: each) ifNotNil: [ ^true ] ].
	self repositoriesToWrite ifNotEmpty: [ ^true ].
	^false
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
	properties := properties copy.
	items := items copy.
	groups := groups copy.
	isCopy := true
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
	| newVersion |
	newVersion := self commonVersion copy.
	newVersion blessing: #release.
	newVersion saveVersion.
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
	self canModify ifFalse: [ 
		self isCopy
			ifTrue: [ GTMetacellerStateError signal: 'Cannot change ', aSymbol asString, ' of the main version.' ]
			ifFalse: [ GTMetacellerStateError signal: 'Only copy of version should be modified.' ] ].
	self properties at: aSymbol put: aValue
]

{ #category : #'accessing version' }
GTMetacellerVersion >> replaceOrAddItem: anItem [
	self canModify ifFalse: [ GTMetacellerStateError signal: 'Can only change a copy of a version.' ].
	self items removeAllSuchThat: [ :each | each itemName = anItem itemName ].
	self items add: anItem
]

{ #category : #'accessing version' }
GTMetacellerVersion >> repositories [
	^self propertyAt: #repostories
		ifAbsent: [ (self repositorySpecs repositoryDescriptions) asSet ]
]

{ #category : #'accessing version' }
GTMetacellerVersion >> repositories: aCollection [
	self propertyAt: #repostories put: aCollection
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> repositoriesToWrite [
	| retVal |
	retVal := self repositories
		removeAllFoundIn: self parent repositories;
		yourself.
	self importedVersions do: [ :each |
		retVal removeAllFoundIn: (self project version: each) repositories ].
	^retVal

]

{ #category : #'accessing version' }
GTMetacellerVersion >> repository: aString [ 
	(self propertyAt: #repositories ifAbsent: [ GTMetacellerStateError signal: 'Repositories were not initialized properly in this copy' ]) add: aString
]

{ #category : #'accessing version' }
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
GTMetacellerVersion >> saveWithItem: anItem [
	| newVersion |
	newVersion := self copy.
	newVersion replaceOrAddItem: anItem.
	newVersion saveVersion
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
	self hasError ifTrue: [ ^self errorMessage ].
	^String codeStreamContents: [ :s |
		(self streamVersionHeaderWithName: self versionName on: s)
			with: [
				self needsGeneratingMainInfo ifTrue: [
					self streamMainInfoOn: s forDisplay: true ] ] ]
]

{ #category : #'code generation' }
GTMetacellerVersion >> specStringFor: aCollection [ 
	self hasError ifTrue: [ ^self errorMessage ].
	^String codeStreamContents: [ :s |
		(self streamVersionHeaderWithName: self versionName on: s)
			with: [
				self needsGeneratingMainInfo ifTrue: [
					self streamMainInfoOn: s forDisplay: true ] ].
		self streamItems: aCollection on: s ]
]

{ #category : #'code generation' }
GTMetacellerVersion >> streamItemSpecsOn: aStream [
	self itemSelectors do: [ :each |
		| data |
		data := self itemsForSymbol: each.
		data ifNotEmpty: [ 
			| cascade |
			cascade := aStream startCascade: 'aSpec'.
			data do: [ :item |
				item streamSpecOn: aStream specName: 'aSpec' ].
			cascade close ] ]
]

{ #category : #'code generation' }
GTMetacellerVersion >> streamItems: aCollection on: aStream [
	#( isProject isPackage isGroup ) do: [ :each |
		| data |
		data := self itemsFrom: aCollection filterOn: each.
		data ifNotEmpty: [ 
			| cascade |
			cascade := aStream startCascade: 'aSpec'.
			data do: [ :item |
				item streamSpecOn: aStream specName: 'aSpec' ].
			cascade close ] ]
]

{ #category : #'code generation' }
GTMetacellerVersion >> streamMainInfoOn: aStream forDisplay: aBoolean [
	self needsGeneratingMainInfo ifTrue: [
		| cascade |
		cascade := aStream startCascade: 'aSpec'.
		(self mainInfoSelectorsForDisplay: aBoolean) do: [ :each |
			(self infoFor: each) ifNotNilDo: [ :data |
				cascade assign: each value: data ] ].
		self streamRepositoriesOn: cascade.
		aBoolean ifTrue: [
			| comment |
			comment := aStream startComment: 'Following lines will be automatically set by Metaceller if not overridden:'.
			self commentInfoSelectors do: [ :each |
				(self infoFor: each) ifNotNilDo: [ :data |
					comment assign: each value: data ] ] ].
		cascade close ]
]

{ #category : #'code generation' }
GTMetacellerVersion >> streamRepositoriesOn: aCascade [
	self repositoriesToWrite do: [ :each |
		aCascade assign: 'repository' value: each ]
]

{ #category : #'code generation' }
GTMetacellerVersion >> streamVersion: aVersion on: aStream [ 
	(aVersion notNil and: [ aVersion platformSymbol = self platformSymbol])
		ifTrue: [ aVersion streamVersionOn: aStream ]
		ifFalse: [ self streamVersionOn: aStream ].
	self sortedChildren do: [ :each |
		each streamVersion: aVersion on: aStream ]
]

{ #category : #'code generation' }
GTMetacellerVersion >> streamVersionHeader: aVersion on: aStream [
	(aVersion notNil and: [ aVersion platformSymbol = self platformSymbol]) ifTrue: [ ^aVersion streamVersionHeaderOn: aStream ].
	^self streamVersionHeaderOn: aStream
]

{ #category : #'code generation' }
GTMetacellerVersion >> streamVersionHeaderOn: aStream [
	^aStream method: self methodName versionName: self versionName importedVersions: self version importedVersions
]

{ #category : #'code generation' }
GTMetacellerVersion >> streamVersionHeaderWithName: aString on: aStream [
	^aStream version: aString importedVersions: self version importedVersions
]

{ #category : #'code generation' }
GTMetacellerVersion >> streamVersionOn: aStream [
	self needsGenerating ifTrue: [
		(aStream openPlatform: self platformSymbol)
			with: [
				self streamMainInfoOn: aStream forDisplay: false.
				self streamItemSpecsOn: aStream ] ]
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
GTMetacellerVersion >> test [
	self test: nil
]

{ #category : #actions }
GTMetacellerVersion >> test: anItemOrList [
	errors := nil.
	warnings := nil.
	[ :job |
		| itemList loadList |
		job title: ('Testing version ', self version asString).
		itemList := (self itemListFrom: anItemOrList).
		job max: itemList size.
		loadList := GTMetacellerLoadList new.
		itemList 
			withIndexDo: [ :item :index |
				item resetValidated.
				item testValid.
				loadList add: item.
				job currentValue: index ].
		loadList errorMap keysAndValuesDo: [ :key :value |
			key = #'errors' ifTrue: [ self errors addAll: value ].
			key = #'warnings' ifTrue: [ self warnings addAll: value ].
			key isSymbol ifFalse: [
				key addErrorsAndWarnings: value ] ] ] asJob run

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
GTMetacellerVersion >> updateItem: anItem with: aBaselineItem [
	anItem ifNil: [ ^nil ].
	aBaselineItem ifNil: [ ^anItem ].
	^anItem differenceWith: aBaselineItem
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
	| updatedVersion |
	updatedVersion := self copy.
	aClass new perform: aString with: updatedVersion.
	" eveluate the pragma "
	(aClass methodDict at: aString) pragmas do: [ :pragma |
		(pragma key = #'version:imports:') ifTrue: [ updatedVersion importedVersions: (pragma argumentAt: 2) ] ].
	updatedVersion saveVersion
]

{ #category : #actions }
GTMetacellerVersion >> validate [
	self validate: nil
]

{ #category : #actions }
GTMetacellerVersion >> validate: anItemOrList [ 
	(self itemListFrom: anItemOrList) do: [ :each |
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

{ #category : #'accessing project' }
GTMetacellerVersion >> versionFor: aString [ 
	^(self project projectFor: aString) version: self versionName
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

{ #category : #accessing }
GTMetacellerVersion >> warnings [
	^warnings ifNil: [ warnings := OrderedCollection new ]
]

{ #category : #private }
GTMetacellerVersion >> wrapperFor: aSpec [
	^self wrappers at: aSpec ifAbsentPut: [ self createWrapperFor: aSpec ]
]

{ #category : #accessing }
GTMetacellerVersion >> wrappers [
	^wrappers ifNil: [ wrappers := Dictionary new ]
]
