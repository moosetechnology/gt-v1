Class {
	#name : #GTMetacellerMainProject,
	#superclass : #GTMetacellerProject,
	#instVars : [
		'platformSymbols',
		'projects',
		'rootVersions'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #initialization }
GTMetacellerMainProject >> addPlatformSymbolsTo: aSet versionSpec: aSpec pragma: aPragma in: aConstructor [
	aConstructor evaluatePragma: aPragma.
	aSet addAll: aConstructor attributeMap keys

]

{ #category : #initialization }
GTMetacellerMainProject >> buildProjects [
	^self platformSymbols collect: [ :each |
		GTMetacellerAtributedProject on: self configuration main: self platform: (GTPlatformDescription onSymbol: each) ]
]

{ #category : #accessing }
GTMetacellerMainProject >> childPlatformsFor: aPlatform [
	^(self projectFor: aPlatform) childPlatforms
]

{ #category : #initialization }
GTMetacellerMainProject >> createPlatformSymbols [
	| retVal constructor versionMap symbolicVersionMap executionBlock pragmaDict |
	retVal := Set new.
	constructor := MetacelloVersionConstructor new
		configuration: self configuration new;
		yourself.
	versionMap := Dictionary new.
	symbolicVersionMap := Dictionary new.
	executionBlock := [ :versionSpec :pragma | self addPlatformSymbolsTo: retVal versionSpec: versionSpec pragma: pragma in: constructor ].
	constructor collectAllVersionsFromVersionPragmasInto: versionMap using: executionBlock.
	pragmaDict := constructor extractVersionImportPragmas.
	constructor verifyVersionImportPragmas: pragmaDict definedIn: versionMap.
	constructor
		collectAllVersionsFromVersionImportPragmasInto: versionMap
		using: executionBlock
		satisfiedPragmas: pragmaDict.
	constructor collectAllSymbolicVersionsFromVersionPragmasInto: symbolicVersionMap using: executionBlock.
	^retVal

]

{ #category : #actions }
GTMetacellerMainProject >> createSnapshotVersion: aString baseline: aBaseline [
	(self version: aString) ifNotNil: [ 
		" do not create a version that exists already, perhalps an error is more appropriate "
		^self ].
	self configuration compile: (self snapshotVersion: aString baseline: aBaseline)
		classified: 'versions'
]

{ #category : #cache }
GTMetacellerMainProject >> ensureProjectsCreated [
	self ensureVersionsCreated.
	self projects do: [ :each | each ensureVersionsCreated ]
]

{ #category : #testing }
GTMetacellerMainProject >> hasPlatform: aPlatform [
	(#common compare: aPlatform caseSensitive: false) = 2 ifTrue: [ ^true ].
	^MetacelloPlatform current defaultPlatformAttributes contains: [ :each |
		(each compare: aPlatform caseSensitive: false) = 2 ]
]

{ #category : #accessing }
GTMetacellerMainProject >> itemsFor: aPlatform in: aVersion [ 
	(self hasPlatform: aPlatform)
		ifTrue: [ ^((self version: aVersion) items
			select: [ :each | (each hasPlatform: aPlatform) and: [ each isGroup not ] ]) ].
	^(self projectFor: aPlatform) itemsFor: aPlatform in: aVersion 
]

{ #category : #accessing }
GTMetacellerMainProject >> normalizePlatforms: aSet [
	| retVal |
	retVal := Set new.
	aSet do: [ :newItem | 
		(aSet contains: [ :each | each isParent: newItem])
			ifFalse: [ retVal add: newItem ] ].
	^retVal
]

{ #category : #accessing }
GTMetacellerMainProject >> parentProjectFor: aPlatformDescription [ 
	^self projectFor: (aPlatformDescription parentSymbolIn: self platformSymbols)
]

{ #category : #accessing }
GTMetacellerMainProject >> parentVersionFor: aMethod [ 
	^self rootVersions at: aMethod ifAbsentPut: [ GTMetacellerRootVersion on: aMethod ]
]

{ #category : #accessing }
GTMetacellerMainProject >> platformSymbol [
	^nil
]

{ #category : #accessing }
GTMetacellerMainProject >> platformSymbols [
	^platformSymbols ifNil: [ platformSymbols := self createPlatformSymbols ]
]

{ #category : #accessing }
GTMetacellerMainProject >> platformsFor: aMetacellerItem version: aVersionName [
	| platforms |
	platforms := Set new.
	self projects do: [ :each |
		(each hasItem: aMetacellerItem inVersion: aVersionName) ifTrue: [ 
			platforms add: each platformDescription ] ].
	^self normalizePlatforms: platforms
]

{ #category : #printing }
GTMetacellerMainProject >> printVersionsFor: aPlatform version: aVersion on: aStream [
	| items |
	items := (self itemsFor: aPlatform in: aVersion versionName).
	items ifNotEmpty: [ 
		| first |
		aStream tab; nextPutAll: 'aSpec for: '.
		aPlatform printOn: aStream.
		aStream nextPutAll: ' do: ['; cr.
		first := true.
		items do: [ :each |
			first 
				ifTrue: [ aStream tab; tab; nextPutAll: 'aSpec '.
					first := false ]
				ifFalse: [ aStream nextPut: $;; cr; tab; tab; tab ].
			each printVersionOn: aStream ].
		aStream nextPutAll: '].'; cr ]
]

{ #category : #accessing }
GTMetacellerMainProject >> projectFor: aPlatform [
	aPlatform ifNil: [ ^nil ].
	^self projects detect: [ :each | each hasPlatform: aPlatform ]
]

{ #category : #dummy }
GTMetacellerMainProject >> projects [
	^projects ifNil: [ projects := self buildProjects ]
]

{ #category : #accessing }
GTMetacellerMainProject >> rootVersions [
	^rootVersions ifNil: [ rootVersions := Dictionary new ]
]

{ #category : #printing }
GTMetacellerMainProject >> snapshotVersion: aString baseline: aBaseline [
	| version |
	" this method needs a baseline "
	version := self version: aBaseline.
	version ifNil: [ ^nil ].
	^String streamContents: [ :s |
		s nextPutAll: (('version', aString) asIdentifier: false); nextPutAll: ': aSpec'; cr;
			tab; nextPutAll: '<version:'''; nextPutAll: aString; nextPutAll: ''' imports: #( ''';nextPutAll: aBaseline; nextPutAll: ''' )>'; cr;
			cr.
		self platformSymbols do: [ :platform |
			self printVersionsFor: platform version: version on: s ] ]
]

{ #category : #actions }
GTMetacellerMainProject >> test [
	self releases do: [ :each | each test ]
]

{ #category : #display }
GTMetacellerMainProject >> title [
	^ ((self configuration name beginsWith: 'ConfigurationOf') 
		ifTrue: [self configuration name copyFrom: 'ConfigurationOf' size + 1 to: self configuration name size ] 
		ifFalse: [self configuration name]) asString
]

{ #category : #actions }
GTMetacellerMainProject >> updateVersionToCurrent: aVersionName [
	self projects do: [ :each |
		each updateVersionToCurrent: aVersionName ]
]
