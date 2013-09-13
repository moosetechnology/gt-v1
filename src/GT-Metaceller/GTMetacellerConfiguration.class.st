Class {
	#name : #GTMetacellerConfiguration,
	#superclass : #Object,
	#instVars : [
		'configuration',
		'mainProject',
		'projects'
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
GTMetacellerConfiguration >> buildProjects [
	^GTMetacelloProject platforms collect: [ :each |
		GTMetacellerProject on: self configuration platform: each ]
]

{ #category : #accessing }
GTMetacellerConfiguration >> children [
	^self mainProject childConfigurations collect: [ :each | GTMetacellerConfiguration on: each ]
]

{ #category : #accessor }
GTMetacellerConfiguration >> configuration [
	^configuration
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

{ #category : #display }
GTMetacellerConfiguration >> shortNameOf: config [
	"self new shortNameOf: ConfigurationOfAlien"
	^ ((config name beginsWith: 'ConfigurationOf') 
		ifTrue: [config name copyFrom: 'ConfigurationOf' size + 1 to: config name size ] 
		ifFalse: [config name]) asString
]

{ #category : #roassal }
GTMetacellerConfiguration >> viewVersionMapOn: view [
	| nodes edges project |
	project := self mainProject project.
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
