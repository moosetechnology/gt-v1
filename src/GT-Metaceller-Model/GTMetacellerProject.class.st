Class {
	#name : #GTMetacellerProject,
	#superclass : #Object,
	#instVars : [
		'configuration',
		'project',
		'versions',
		'releases',
		'stableVersion',
		'bleedingEdge',
		'development',
		'currentVersion',
		'latest'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #'instance creation' }
GTMetacellerProject class >> on: aConfiguration [
	^self basicNew
		initialize: aConfiguration;
		yourself
]

{ #category : #accessing }
GTMetacellerProject >> allMethods [
	^GTMetacellerVersion allMethodsForProject: self
]

{ #category : #accessing }
GTMetacellerProject >> bleedingEdge [
	bleedingEdge ifNil: [
		[ bleedingEdge := self project bleedingEdge ] on: MetacelloVersionDoesNotExistError do: [] ].
	^bleedingEdge
]

{ #category : #accessing }
GTMetacellerProject >> bleedingEdgeVersion [
	^self versions detect: [ :each | each isBleedingEdge ] ifNone: [ nil ]
]

{ #category : #initialization }
GTMetacellerProject >> buildReleases [
	^GTMetacellerRelease releasesForProject: self
]

{ #category : #initialization }
GTMetacellerProject >> buildVersions [
	^GTMetacellerVersion versionsForProject: self
]

{ #category : #accessing }
GTMetacellerProject >> checkCurrentVersion [
	currentVersion ifNil: [ currentVersion := self project currentVersion ]
]

{ #category : #accessing }
GTMetacellerProject >> childConfigurations [
	[ ^(self projectsForVersion: self project stableVersion) collect: [ :each | self configForProject: each ] thenSelect: [ :each | each notNil ] ] on: MetacelloSymbolicVersionDoesNotExistError do: [ ^#() ]
]

{ #category : #actions }
GTMetacellerProject >> compileMethod: aMethodDef category: aCategory [ 
	self configuration compile: aMethodDef classified: aCategory asString
]

{ #category : #accessing }
GTMetacellerProject >> configForProject: aSpec [
	| projectReference |
	aSpec ifNil: [  ^nil ].
	(aSpec isKindOf: MetacelloProjectReferenceSpec)
		ifTrue: [ projectReference := aSpec projectReference ]
		ifFalse: [ projectReference := aSpec ].
	projectReference ifNil: [  ^nil ].
	projectReference className ifNil: [  ^nil ].
	^Smalltalk at: (projectReference className asSymbol) ifAbsent: [ nil ]
]

{ #category : #accessing }
GTMetacellerProject >> configuration [
	^ configuration
]

{ #category : #actions }
GTMetacellerProject >> createRelease: aReleaseName version: aVersionName [
	" we should refactor this to use the 'symbolicVersions' properly "
	| releaseSymbol |
	self compileMethod: (String streamContents: [ :s |
		releaseSymbol := ('release', aReleaseName) asSymbol.
		s nextPutAll: releaseSymbol asLegalSelector; nextPutAll: ': aSpec'; cr;
			tab; nextPutAll: '<symbolicVersion:'.
		releaseSymbol asCodeStringOn: s.
		s nextPut: $>; cr;
			tab; nextPutAll: 'aSpec for: #''common'' version: '.
		aVersionName asCodeStringOn: s ]) category: 'releases'
]

{ #category : #accessing }
GTMetacellerProject >> currentVersion [
	^ currentVersion
]

{ #category : #accessing }
GTMetacellerProject >> defaultVersion [
	self stableVersion ifNotNil: [ ^self stableVersion ].
	self developmentVersion ifNotNil: [ ^self developmentVersion ].
	self bleedingEdgeVersion ifNotNil: [ ^self bleedingEdgeVersion ].
	self addError: 'Could not determine a default version'.
	^nil
]

{ #category : #accessing }
GTMetacellerProject >> developmentVersion [
	^self versions detect: [ :each | each isDevelopmentVersion ] ifNone: [ nil ]
]

{ #category : #cache }
GTMetacellerProject >> ensureVersionsCreated [
	self versions
]

{ #category : #accessing }
GTMetacellerProject >> groups [
	self defaultVersion ifNotNil: [ ^self defaultVersion groups ].
	^#()
]

{ #category : #accessing }
GTMetacellerProject >> groupsAndLoosePackages [
	self defaultVersion ifNotNil: [ ^self defaultVersion groupsAndLoosePackages ].
	^#()
]

{ #category : #testing }
GTMetacellerProject >> hasAttributes [
	^false
]

{ #category : #testing }
GTMetacellerProject >> hasItem: aMetacellerItem inVersion: aVersion [
	^((self version: aVersion) ifNil: [ ^false ]) hasItem: aMetacellerItem
]

{ #category : #initialization }
GTMetacellerProject >> initialize: aConfiguration [
	self initialize.
	configuration := aConfiguration
]

{ #category : #actions }
GTMetacellerProject >> install: aCollection [ 
	self defaultVersion ifNotNil: [ ^self defaultVersion install: aCollection ].
	" could not determine a version "
	GTMetacellerNoVersion signal: 'Could not dermine a default version for ', self configuration configName
]

{ #category : #testing }
GTMetacellerProject >> isProject: aSpec [ 
	^(aSpec isKindOf: MetacelloProjectReferenceSpec) or: [ (aSpec isKindOf: MetacelloProjectSpec) ]
]

{ #category : #accessing }
GTMetacellerProject >> metacelloVersion: aStringOrSymbol [
	self project ifNil: [ ^nil ].
	^self project version: aStringOrSymbol
]

{ #category : #dummy }
GTMetacellerProject >> methodClass [
	^self configuration
]

{ #category : #dummy }
GTMetacellerProject >> methodString [
	^''
]

{ #category : #dummy }
GTMetacellerProject >> packages [
	^#()
]

{ #category : #dummy }
GTMetacellerProject >> packagesAndProjects [
	^#()
]

{ #category : #accessing }
GTMetacellerProject >> privateDevelopment [
	development ifNil: [ 
		[ development := self project development ] on: MetacelloVersionDoesNotExistError do: [ ] ].
	^development
]

{ #category : #accessing }
GTMetacellerProject >> privateStableVersion [
	stableVersion ifNil: [ 
		[ stableVersion := self project stableVersion ] on: MetacelloVersionDoesNotExistError do: [ ] ].
	^stableVersion
]

{ #category : #accessing }
GTMetacellerProject >> project [
	^project ifNil: [ project := configuration project ]
]

{ #category : #accessing }
GTMetacellerProject >> projectsForVersion: aVersion [
	aVersion ifNil: [ ^#() ].
	(aVersion isKindOf: Association) ifTrue: [ ^#() ].
	^aVersion spec packages packageSpecsInLoadOrder select: [  :each | self isProject: each ]
]

{ #category : #accessing }
GTMetacellerProject >> release: aString [ 
	^self releases detect: [ :each | each releaseName = aString ] ifNone: [ nil ]
]

{ #category : #accessing }
GTMetacellerProject >> releases [
	^releases ifNil: [ releases := self buildReleases ]
]

{ #category : #accessing }
GTMetacellerProject >> stableVersion [
	^self versions detect: [ :each | each isStable ] ifNone: [ nil ]
]

{ #category : #accessing }
GTMetacellerProject >> tags [
	^#()
]

{ #category : #actions }
GTMetacellerProject >> testItems: aCollection [ 
	self defaultVersion ifNotNil: [ self defaultVersion testItems: aCollection ]
]

{ #category : #accessing }
GTMetacellerProject >> textLabel [
	^self displayString
]

{ #category : #actions }
GTMetacellerProject >> updateRelease: aReleaseNumber version: aVersionString [ 
	(self release: aReleaseNumber)
		ifNil: [ self createRelease: aReleaseNumber version: aVersionString ]
		ifNotNilDo: [ :release | release updateWith: aVersionString ]
]

{ #category : #actions }
GTMetacellerProject >> updateReleasesFor: aString [ 
	| versionList releaseNumber |
	versionList := aString subStrings: '.'.
	releaseNumber := nil.
	1 to: versionList size-1 do: [ :index |
		releaseNumber
			ifNil: [ releaseNumber := versionList at: index ]
			ifNotNil: [ releaseNumber := releaseNumber, '.', versionList at: index ].
			self updateRelease: releaseNumber version: aString ]
	
]

{ #category : #actions }
GTMetacellerProject >> validate [
	self defaultVersion ifNotNil: [ self defaultVersion validate ]
]

{ #category : #actions }
GTMetacellerProject >> validateItems: aCollection [ 
	self defaultVersion ifNotNil: [ ^self defaultVersion validateItems: aCollection ]
]

{ #category : #accessing }
GTMetacellerProject >> version: aStringOrSymbol [
	self project ifNil: [ ^nil ].
	^self versions detect: [ :each | each hasName: aStringOrSymbol ] ifNone: [ nil ]
]

{ #category : #accessing }
GTMetacellerProject >> versionFor: aMethod [
	^self versions detect: [ :each | each method = aMethod ]
]

{ #category : #accessing }
GTMetacellerProject >> versions [
	^versions ifNil: [ versions := self buildVersions ]
]

{ #category : #roassal }
GTMetacellerProject >> viewVersionMapOn: view [
	| nodes edges |
	nodes := Dictionary new.
	edges := OrderedCollection new.
	(Pragma allNamed: #version: in: self configuration) do: [:prag | 
		nodes at: (prag argumentAt: 1) put: (project version: (prag argumentAt: 1)) ].
	(Pragma allNamed: #version:imports: in: self configuration) do: [:prag | 
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
