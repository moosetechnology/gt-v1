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
		'wrappers'
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
			asSortedCollection: [ :a :b | a name > b name ]
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
	self children add: aVersion
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
	^self version author
]

{ #category : #accessing }
GTMetacellerVersion >> belongsToGroup: aSpec [
	^(self tagsOf: aSpec) notEmpty
]

{ #category : #accessing }
GTMetacellerVersion >> blessing [
	^self version spec blessing value
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

{ #category : #accessing }
GTMetacellerVersion >> configuration [
	^ configuration
]

{ #category : #accessing }
GTMetacellerVersion >> configuration: anObject [
	configuration := anObject
]

{ #category : #tool }
GTMetacellerVersion >> createWrapperFor: aSpec [
	(self isProject: aSpec) ifTrue: [  ^GTMetacellerProjectReference on: self spec: aSpec ].
	(self isGroup: aSpec) ifTrue: [  ^GTMetacellerGroup on: self spec: aSpec ].
	(self isPackage: aSpec) ifTrue: [ ^GTMetacellerPackage on: self spec: aSpec ].
	^aSpec
	
]

{ #category : #'accessing version' }
GTMetacellerVersion >> description [
	^self version description
]

{ #category : #accessing }
GTMetacellerVersion >> determineVersion [
	self project ifNil: [  ^nil ].
	self method pragmas do: [ :each |
		(each key beginsWith: 'version') ifTrue: [ ^self project metacelloVersion: (each arguments first) ] ].
	^nil
]

{ #category : #accessing }
GTMetacellerVersion >> displayString [
	^self textLabel
]

{ #category : #actions }
GTMetacellerVersion >> fetch [
	self version ifNotNil: [ self version fetch ]
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

{ #category : #'accessing generation' }
GTMetacellerVersion >> groupsToGenerate [
	self version importedVersions ifEmpty: [ ^self allGroups ].
	^#()
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
	^self name = aString
]

{ #category : #'accessing version' }
GTMetacellerVersion >> importedVersions [
	^self version importedVersions
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> infoFor: aSymbol [
	| data parentData |
	data := self version perform: aSymbol.
	parentData := self parent perform: aSymbol.
	data = parentData ifTrue: [ ^nil ].
	^data

]

{ #category : #display }
GTMetacellerVersion >> infoText [
	| retVal |
	retVal := self asText.
	retVal
		append: String cr;
		append: self description.
	#( blessing author versionStatus importedVersions ) do: [ :symbol |
		retVal append: String cr; append: symbol capitalized; append: ': '; append: (self perform: symbol) asString ].

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
GTMetacellerVersion >> isGroup: aSpec [ 
	^aSpec isKindOf: MetacelloGroupSpec
]

{ #category : #testing }
GTMetacellerVersion >> isLatestVersion [
	^self project latest = self version
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
	^#( projectsToGenerate groupsToGenerate packagesToGenerate )
]

{ #category : #accessing }
GTMetacellerVersion >> items [
	^items ifNil: [ items := self buildItems ]
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
	^#( blessing author description )
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

{ #category : #'accessing generation' }
GTMetacellerVersion >> methodNameFor: aString [
	(aString endsWith: 'baseline') ifTrue: [ 
		^(('baseline', (aString copyFrom: 1 to: (aString size-8))) asLegalSelector) greaseString ].
	^('version', aString) asLegalSelector greaseString
]

{ #category : #accessing }
GTMetacellerVersion >> methodString [
	^self method asString
]

{ #category : #'code generation' }
GTMetacellerVersion >> methodWithVersionName: aString [ 
	^self parent methodWithVersionName: aString
]

{ #category : #testing }
GTMetacellerVersion >> name [
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
		(self perform: each) ifNotEmpty: [ ^true ] ].
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

{ #category : #caching }
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

{ #category : #'accessing generation' }
GTMetacellerVersion >> packagesToGenerate [
	self version importedVersions ifEmpty: [ ^self allPackages ].
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

{ #category : #'accessing generation' }
GTMetacellerVersion >> platformSymbol [
	^self project platformSymbol
]

{ #category : #accessing }
GTMetacellerVersion >> platformsFor: aMetacellerItem [
	^self project platformsFor: aMetacellerItem version: self name
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
GTMetacellerVersion >> projectsToGenerate [
	self version importedVersions ifEmpty: [ ^self allProjects ].
	^#()
]

{ #category : #'accessing generation' }
GTMetacellerVersion >> repositoriesToWrite [
	^(self repositorySpecs repositoryDescriptions collect: [ :each | each description ]) removeAll: self parent repositoriesToWrite.
]

{ #category : #accessing }
GTMetacellerVersion >> repositorySpecs [
	^self version loader spec repositories
]

{ #category : #actions }
GTMetacellerVersion >> saveAs: aVersionName [
	" check if this version does not exist yet "
	(self project version: aVersionName) ifNotNil: [ GTMetacellerDuplicateVersion signal: 'Version with name ', aVersionName, ' already exists.' ].
	self project compileMethod: (self methodWithVersionName: aVersionName) category: self category
]

{ #category : #accessing }
GTMetacellerVersion >> selector [
	^self method selector
]

{ #category : #accessing }
GTMetacellerVersion >> spec [
	self version ifNotNil: [ ^self version spec ].
	^nil
]

{ #category : #'code generation' }
GTMetacellerVersion >> streamItemSpecsOn: aStream [
	#( projectsToGenerate groupsToGenerate packagesToGenerate ) do: [ :each |
		| data |
		data := self perform: each.
		data ifNotEmpty: [ 
			aStream cr; tab: 3; nextPutAll: 'yourself.'; cr; cr;
				tab: 2; nextPutAll: 'aSpec'.
			data do: [ :item |
				item streamSpecOn: aStream specName: 'aSpec' ] ] ]		
		
			
			
			
]

{ #category : #'code generation' }
GTMetacellerVersion >> streamMainInfoOn: aStream [
	self needsGeneratingMainInfo ifTrue: [
		aStream cr; tab: 2; nextPutAll: ' aSpec'.
		self mainInfoSelectors do: [ :each |
			(self infoFor: each) ifNotNilDo: [ :data |
				aStream cr; tab: 3; nextPutAll: each asString; nextPutAll: ': '.
				data asCodeStringOn: aStream.
				aStream nextPut: $; ] ] ]
]

{ #category : #'code generation' }
GTMetacellerVersion >> streamRepositoriesOn: aStream [
	self repositoriesToWrite do: [ :each |
		aStream cr; tab: 3; nextPutAll: 'Repository: '.
		each asCodeStringOn: aStream ]
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
		aStream
			cr; tab; nextPutAll: 'aSpec for: '.
		self platformSymbol asCodeStringOn: aStream.
		aStream nextPutAll: ' do: ['.
		self streamMainInfoOn: aStream.
		self streamRepositoriesOn: aStream.
		self streamItemSpecsOn: aStream.
		aStream cr; tab: 3; nextPutAll: 'yourself ].'.
		self children do: [ :each |
			each streamVersionOn: aStream ] ]
]

{ #category : #display }
GTMetacellerVersion >> tags [
	self version ifNil: [  ^#() ].
	^Array with: self blessing
]

{ #category : #display }
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

{ #category : #display }
GTMetacellerVersion >> textLabel [
	| attributes |
	attributes := OrderedCollection new.
	self version ifNil: [ attributes add: TextColor red ].
	self isBleedingEdge ifTrue: [ attributes add: TextColor red  ].
	self isDevelopmentVersion ifTrue: [ attributes add: TextColor blue ].
	self isCurrent ifTrue: [ attributes add: TextEmphasis underlined ].
	self isStable ifTrue: [ attributes add: TextEmphasis bold ].
	^Text string: self name attributes: attributes
]

{ #category : #actions }
GTMetacellerVersion >> update [
	self isDevelopment ifTrue: [
		MetacelloToolBox updateToLatestPackageVersionsIn: self configuration description: 'Please describe this version.' ]
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

{ #category : #validating }
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

{ #category : #accessing }
GTMetacellerVersion >> versionNumber [
	^self asString
]

{ #category : #'accessing version' }
GTMetacellerVersion >> versionStatus [
	^self version versionStatus
]

{ #category : #dummy }
GTMetacellerVersion >> versions [
	^#()
]

{ #category : #tool }
GTMetacellerVersion >> wrapperFor: aSpec [
	^self wrappers at: aSpec ifAbsentPut: [ self createWrapperFor: aSpec ]
]

{ #category : #accessing }
GTMetacellerVersion >> wrappers [
	^wrappers ifNil: [ wrappers := Dictionary new ]
]
