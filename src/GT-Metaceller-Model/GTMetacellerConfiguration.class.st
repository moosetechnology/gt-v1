Class {
	#name : #GTMetacellerConfiguration,
	#superclass : #Object,
	#instVars : [
		'configuration',
		'mainProject',
		'projects',
		'platformSymbols'
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
	^mainProject ifNil: [ mainProject := GTMetacellerMainProject on: self configuration ]
]

{ #category : #accessing }
GTMetacellerConfiguration >> mainVersions [
	^self mainProject versions
]

{ #category : #accessing }
GTMetacellerConfiguration >> projects [
	^self mainProject projects
]

{ #category : #private }
GTMetacellerConfiguration >> reset [
	mainProject := nil.
	projects := nil.
	platformSymbols := nil
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
