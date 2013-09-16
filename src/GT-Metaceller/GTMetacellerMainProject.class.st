Class {
	#name : #GTMetacellerMainProject,
	#superclass : #GTMetacellerProject,
	#instVars : [
		'platformSymbols',
		'projects'
	],
	#category : #'GT-Metaceller'
}

{ #category : #initialization }
GTMetacellerMainProject >> addPlatformSymbolsTo: aSet versionSpec: aSpec pragma: aPragma in: aConstructor [
	aConstructor evaluatePragma: aPragma.
	aSet addAll: aConstructor attributeMap keys

]

{ #category : #initialization }
GTMetacellerMainProject >> buildProjects [
	^self platformSymbols collect: [ :each |
		GTMetacellerAtributedProject on: self configuration platform: (GTPlatformDescription onSymbol: each) ]
]

{ #category : #initialization }
GTMetacellerMainProject >> createPlatformSymbols [
	| retVal constructor versionMap symbolicVersionMap executionBlock |
	retVal := Set new.
	constructor := MetacelloVersionConstructor new
		configuration: self configuration new;
		yourself.
	versionMap := Dictionary new.
	symbolicVersionMap := Dictionary new.
	executionBlock := [ :versionSpec :pragma | self addPlatformSymbolsTo: retVal versionSpec: versionSpec pragma: pragma in: constructor ].
	constructor collectAllVersionsFromVersionPragmasInto: versionMap using: executionBlock.
	constructor
		collectAllVersionsFromVersionImportPragmasInto: versionMap
		using: executionBlock
		satisfiedPragmas: (constructor versionImportPragmasVerifiedDefinedIn: versionMap).
	constructor collectAllSymbolicVersionsFromVersionPragmasInto: symbolicVersionMap using: executionBlock.
	^retVal

]

{ #category : #actions }
GTMetacellerMainProject >> createSnapshotVersion: aString basedOn: aBaseline [
	(self version: aString) ifNotNil: [ 
		" do not create a version that exists already, perhalps an error is more appropriate "
		^self ].
	self configuration compile: (self snapshotVersion: aString basedOn: aBaseline)
		classified: 'snapshot-versions'
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

{ #category : #dummy }
GTMetacellerMainProject >> projects [
	^projects ifNil: [ projects := self buildProjects ]
]

{ #category : #actions }
GTMetacellerMainProject >> snapshotVersion: aString baseline: aBaseline [
	| version |
	" this method needs a baseline "
	version := self version: aBaseline.
	version ifNil: [ ^nil ].
	^String streamContents: [ :s |
		s nextPutAll: (('version', aString) asIdentifier: false); nextPutAll: ': aSpec'; lf;
			tab; nextPutAll: '<version:'''; nextPutAll: aString; nextPutAll: ''' imports: #( ''';nextPutAll: aBaseline; nextPutAll: ''' )>'; lf;
			lf.
		self platformSymbols do: [ :platform |
			s tab; nextPutAll: 'aSpec for: #'; nextPutAll: platform; nextPutAll: ' do: ['; lf.
			version items do: [ :each |
				| first |
				first := true.
				(each hasPlatform: platform) ifTrue: [
					first 
						ifTrue: [ s tab; tab; nextPutAll: 'aSpec '.
							first := true ]
						ifFalse: [ s nextPut: $;; lf; tab; tab; tab ].
					each printVersionOn: s ] ].
			s nextPutAll: '].'; lf ] ]
]
