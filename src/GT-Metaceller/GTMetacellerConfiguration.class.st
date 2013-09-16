Class {
	#name : #GTMetacellerConfiguration,
	#superclass : #Object,
	#instVars : [
		'configuration',
		'mainProject',
		'projects',
		'platformSymbols'
	],
	#category : #'GT-Metaceller'
}

{ #category : #'instance creation' }
GTMetacellerConfiguration class >> on: aConfiguration [
	^self basicNew
		initialize: aConfiguration;
		yourself
]

{ #category : #initialization }
GTMetacellerConfiguration >> addPlatformSymbolsTo: aSet versionSpec: aSpec pragma: aPragma in: aConstructor [
	aConstructor evaluatePragma: aPragma.
	aSet addAll: aConstructor attributeMap keys

]

{ #category : #initialization }
GTMetacellerConfiguration >> buildProjects [
	^self platformSymbols collect: [ :each |
		GTMetacellerAtributedProject on: self configuration platform: (GTPlatformDescription onSymbol: each) ]
]

{ #category : #accessing }
GTMetacellerConfiguration >> children [
	^self mainProject childConfigurations collect: [ :each | GTMetacellerConfiguration on: each ]
]

{ #category : #accessor }
GTMetacellerConfiguration >> configuration [
	^configuration
]

{ #category : #initialization }
GTMetacellerConfiguration >> createPlatformSymbols [
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

{ #category : #accessor }
GTMetacellerConfiguration >> displayString [
	^self shortName
]

{ #category : #initialization }
GTMetacellerConfiguration >> initialize: aConfiguration [
	self initialize.
	configuration := aConfiguration
]

{ #category : #accessing }
GTMetacellerConfiguration >> mainMethods [
	^self mainProject allMethods 
]

{ #category : #accessor }
GTMetacellerConfiguration >> mainProject [
	^mainProject ifNil: [ mainProject := GTMetacellerProject on: self configuration ]
]

{ #category : #accessing }
GTMetacellerConfiguration >> mainVersions [
	^self mainProject versions
]

{ #category : #accessing }
GTMetacellerConfiguration >> platformSymbols [
	self shouldBeImplemented.createPlatformSymbols
]

{ #category : #accessor }
GTMetacellerConfiguration >> projects [
	^projects ifNil: [ projects := self buildProjects ]
]

{ #category : #display }
GTMetacellerConfiguration >> shortName [
	^ ((self configuration name beginsWith: 'ConfigurationOf') 
		ifTrue: [self configuration name copyFrom: 'ConfigurationOf' size + 1 to: self configuration name size ] 
		ifFalse: [self configuration name]) asString
]

{ #category : #roassal }
GTMetacellerConfiguration >> viewVersionMapOn: view [
	self mainProject viewVersionMapOn: view
]
