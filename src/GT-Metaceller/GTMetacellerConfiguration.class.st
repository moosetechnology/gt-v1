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
	^GTMetacelloPlatform platforms collect: [ :each |
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

{ #category : #roassal }
GTMetacellerConfiguration >> viewVersionMapOn: view [
	self mainProject viewVersionMapOn: view
]
