Class {
	#name : #GTMetacellerConfiguration,
	#superclass : #Object,
	#instVars : [
		'configuration',
		'mainProject',
		'platformSymbols',
		'status'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #'instance creation' }
GTMetacellerConfiguration class >> on: aConfiguration [
	^self basicNew
		initialize: aConfiguration;
		yourself
]

{ #category : #accessing }
GTMetacellerConfiguration >> basicVersions [
	| retVal |
	retVal := OrderedCollection new.
	self stableVersion ifNotNilDo: [ :ver | retVal add: ver ].
	self developmentVersion ifNotNilDo: [ :ver | 
		(retVal includes: ver) ifFalse: [ retVal add: ver ] ].
	self bleedingEdgeVersion ifNotNilDo: [ :ver | 
		(retVal includes: ver) ifFalse: [ retVal add: ver ] ].
	^retVal
]

{ #category : #accessing }
GTMetacellerConfiguration >> bleedingEdgeVersion [
	^self mainProject bleedingEdgeVersion
]

{ #category : #accessing }
GTMetacellerConfiguration >> children [
	^self mainProject childConfigurations collect: [ :each | GTMetacellerConfiguration on: each ]
]

{ #category : #'accessing-magritte' }
GTMetacellerConfiguration >> configName [
	^self shortName
]

{ #category : #accessor }
GTMetacellerConfiguration >> configuration [
	^configuration
]

{ #category : #'magritte-description' }
GTMetacellerConfiguration >> descriptionDevelopmentVersion [
	<magritteDescription>
	^MASingleOptionDescription new
		label: 'Development';
		accessor: #developmentVersion;
		priority: 300;
		options: self possibleSymbolicVersions;
		yourself
]

{ #category : #'magritte-description' }
GTMetacellerConfiguration >> descriptionName [
	<magritteDescription>
	^MAStringDescription new
		beReadonly;
		label: 'Name';
		accessor: #configName;
		priority: 100;
		yourself
]

{ #category : #'magritte-description' }
GTMetacellerConfiguration >> descriptionStableVersion [
	<magritteDescription>
	^MASingleOptionDescription new
		label: 'Stable';
		accessor: #stableVersion;
		priority: 200;
		options: self possibleSymbolicVersions;
		yourself
]

{ #category : #'magritte-description' }
GTMetacellerConfiguration >> descriptionStatus [
	<magritteDescription>
	^MAMemoDescription new
		beReadonly;
		label: 'Status';
		accessor: #status;
		priority: 150;
		yourself
]

{ #category : #'accessing-magritte' }
GTMetacellerConfiguration >> developmentVersion [
	^self mainProject developmentVersion
]

{ #category : #'accessing-magritte' }
GTMetacellerConfiguration >> developmentVersion: aVersion [
	" todo "
	self halt
]

{ #category : #accessor }
GTMetacellerConfiguration >> displayString [
	^self shortName
]

{ #category : #accessing }
GTMetacellerConfiguration >> groups [
	^self mainProject groups
]

{ #category : #accessing }
GTMetacellerConfiguration >> groupsAndLoosePackages [
	^self mainProject groupsAndLoosePackages
]

{ #category : #initialization }
GTMetacellerConfiguration >> initialize: aConfiguration [
	self initialize.
	configuration := aConfiguration
]

{ #category : #actions }
GTMetacellerConfiguration >> install: aGroupList [ 
	self mainProject install: aGroupList
]

{ #category : #accessing }
GTMetacellerConfiguration >> latestVersion [
	^self mainProject latestVersion
]

{ #category : #accessing }
GTMetacellerConfiguration >> mainMethods [
	^self mainProject allMethods 
]

{ #category : #accessor }
GTMetacellerConfiguration >> mainProject [
	^mainProject ifNil: [ mainProject := GTMetacellerMainProject on: self configuration ]
]

{ #category : #accessing }
GTMetacellerConfiguration >> mainVersions [
	^self mainProject versions
]

{ #category : #'accessing-magritte' }
GTMetacellerConfiguration >> possibleSymbolicVersions [
	^self mainProject versions sort: [ :a :b | a asString < b asString ]
]

{ #category : #accessing }
GTMetacellerConfiguration >> projectFor: aSymbol [
	^self mainProject projectFor: aSymbol
]

{ #category : #accessing }
GTMetacellerConfiguration >> projects [
	^self mainProject projects
]

{ #category : #accessing }
GTMetacellerConfiguration >> releases [
	^self mainProject releases
]

{ #category : #private }
GTMetacellerConfiguration >> reset [
	mainProject := nil.
	platformSymbols := nil.
	status := nil
]

{ #category : #display }
GTMetacellerConfiguration >> shortName [
	^ ((self configuration name beginsWith: 'ConfigurationOf') 
		ifTrue: [self configuration name copyFrom: 'ConfigurationOf' size + 1 to: self configuration name size ] 
		ifFalse: [self configuration name]) asString
]

{ #category : #'accessing-magritte' }
GTMetacellerConfiguration >> stableVersion [
	^self mainProject stableVersion
]

{ #category : #'accessing-magritte' }
GTMetacellerConfiguration >> stableVersion: aVersion [
	" todo "
]

{ #category : #'accessing-magritte' }
GTMetacellerConfiguration >> status [
	^status ifNil: [ 'Not tested' ]
]

{ #category : #actions }
GTMetacellerConfiguration >> test: aCollection [ 
	self mainProject test: aCollection
]

{ #category : #actions }
GTMetacellerConfiguration >> testConfiguration [
	status := #tested
]

{ #category : #display }
GTMetacellerConfiguration >> title [
	^self shortName
]

{ #category : #actions }
GTMetacellerConfiguration >> validate [
	self mainProject validate
]

{ #category : #actions }
GTMetacellerConfiguration >> validate: aCollection [ 
	self mainProject validate: aCollection
]

{ #category : #'accessing project' }
GTMetacellerConfiguration >> version: aString [ 
	^self mainProject version: aString
]

{ #category : #roassal }
GTMetacellerConfiguration >> viewVersionMapOn: view [
	self mainProject viewVersionMapOn: view
]
