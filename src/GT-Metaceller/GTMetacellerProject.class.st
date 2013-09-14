Class {
	#name : #GTMetacellerProject,
	#superclass : #Object,
	#instVars : [
		'configuration',
		'project',
		'stableVersion',
		'bleedingEdge',
		'development',
		'currentVersion',
		'platform'
	],
	#category : #'GT-Metaceller'
}

{ #category : #'instance creation' }
GTMetacellerProject class >> on: aConfiguration [
	^self basicNew
		initialize: aConfiguration;
		yourself
]

{ #category : #'instance creation' }
GTMetacellerProject class >> on: aConfiguration platform: aPlatform [
	^self basicNew
		initialize: aConfiguration platform: aPlatform;
		yourself
]

{ #category : #accessing }
GTMetacellerProject >> allMethods [
	^GTMetacellerVersion allMethodsForProject: self
]

{ #category : #accessing }
GTMetacellerProject >> bleedingEdge [
	bleedingEdge ifNil: [
		[ bleedingEdge := self project bleedingEdge ] on: MetacelloVersionDoesNotExistError ].
	^bleedingEdge
]

{ #category : #accessing }
GTMetacellerProject >> checkCurrentVersion [
	currentVersion ifNil: [ currentVersion := self project currentVersion ]
]

{ #category : #accessing }
GTMetacellerProject >> childConfigurations [
	[ ^(self projectsForVersion: self project stableVersion) collect: [ :each | self configForProject: each ] thenSelect: [ :each | each notNil ] ] on: MetacelloSymbolicVersionDoesNotExistError do: [ ^#() ]
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

{ #category : #accessing }
GTMetacellerProject >> currentVersion [
	^ currentVersion
]

{ #category : #accessing }
GTMetacellerProject >> development [
	development ifNil: [ 
		[ development := self project development ] on: MetacelloVersionDoesNotExistError do: [ ] ].
	^development
]

{ #category : #accessing }
GTMetacellerProject >> displayString [
	self platform ifNil: [ ^'current' ].
	^self platform
]

{ #category : #initialization }
GTMetacellerProject >> initialize: aConfiguration [
	self initialize.
	configuration := aConfiguration
]

{ #category : #initialization }
GTMetacellerProject >> initialize: aConfiguration platform: aPlatform [
	self initialize: aConfiguration.
	platform := aPlatform
]

{ #category : #testing }
GTMetacellerProject >> isProject: aSpec [ 
	^(aSpec isKindOf: MetacelloProjectReferenceSpec) or: [ (aSpec isKindOf: MetacelloProjectSpec) ]
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
GTMetacellerProject >> platform [
	^ platform
]

{ #category : #accessing }
GTMetacellerProject >> platformSelector [
	self platform ifNil: [ ^nil ].
	^(self platform asString, 'Attributes') asSymbol
]

{ #category : #accessing }
GTMetacellerProject >> project [
	^project ifNil: [ 
		GTMetacelloPlatform defaultPlatformSelector: self platformSelector.
		[ project := configuration project ] ensure: [ GTMetacelloPlatform defaultPlatformSelector: nil ] ]
]

{ #category : #dummy }
GTMetacellerProject >> projects [
	^#()
]

{ #category : #accessing }
GTMetacellerProject >> projectsForVersion: aVersion [
	aVersion ifNil: [ ^#() ].
	(aVersion isKindOf: Association) ifTrue: [ ^#() ].
	^aVersion spec packages packageSpecsInLoadOrder select: [  :each | self isProject: each ]
]

{ #category : #accessing }
GTMetacellerProject >> stableVersion [
	stableVersion ifNil: [ 
		[ stableVersion := self project stableVersion ] on: MetacelloVersionDoesNotExistError do: [ ] ].
	^stableVersion
]

{ #category : #accessing }
GTMetacellerProject >> version: aStringOrSymbol [
	self project ifNil: [ ^nil ].
	^self project version: aStringOrSymbol
]

{ #category : #accessing }
GTMetacellerProject >> versions [
	^GTMetacellerVersion versionsForProject: self
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
