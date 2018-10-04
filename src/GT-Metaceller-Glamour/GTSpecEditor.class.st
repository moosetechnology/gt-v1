Class {
	#name : #GTSpecEditor,
	#superclass : #Object,
	#instVars : [
		'configuration',
		'mainVersion',
		'platforms',
		'items'
	],
	#category : #'GT-Metaceller-Glamour'
}

{ #category : #'instance creation' }
GTSpecEditor class >> onConfiguration: aConfiguration [
	^self new
		configuration: aConfiguration;
		yourself
]

{ #category : #'instance creation' }
GTSpecEditor class >> onConfiguration: aConfig version: aVersion platforms: aPlatforms items: anItems [ 
	^self new
		configuration: aConfig;
		mainVersion: aVersion;
		platforms: aPlatforms;
		items: anItems;
		yourself
]

{ #category : #accessing }
GTSpecEditor >> configuration [
	^configuration
]

{ #category : #accessing }
GTSpecEditor >> configuration: aConfiguration [
	configuration := aConfiguration
]

{ #category : #testing }
GTSpecEditor >> hasItems [
	self items ifEmpty: [ ^false ].
	^true
]

{ #category : #testing }
GTSpecEditor >> hasPlatform [
	^self platform notNil
]

{ #category : #testing }
GTSpecEditor >> hasPlatforms [
	self platforms ifEmpty: [ ^false ].
	self platforms size = 1 ifTrue: [ ^false ].
	^true
]

{ #category : #accessing }
GTSpecEditor >> items [
	^ items ifNil: [ #() ]
]

{ #category : #accessing }
GTSpecEditor >> items: aCollection [ 
	items := aCollection
]

{ #category : #accessing }
GTSpecEditor >> mainVersion [
	^ mainVersion ifNil: [ configuration defaultVersion ]
]

{ #category : #accessing }
GTSpecEditor >> mainVersion: aVersion [ 
	mainVersion := aVersion
]

{ #category : #accessing }
GTSpecEditor >> platform [
	self platforms size = 1 ifTrue: [ ^self platforms anyOne ].
	^nil
]

{ #category : #accessing }
GTSpecEditor >> platforms [
	^ platforms ifNil: [ #() ]
]

{ #category : #accessing }
GTSpecEditor >> platforms: aPlatforms [
	platforms := aPlatforms
]

{ #category : #accessing }
GTSpecEditor >> specString [
	self hasPlatforms
		ifTrue: [ 
			self hasItems ifTrue: [ ^self version specStringFor: self items platforms: self platforms ].
			^self version specStringForPlatforms: self platforms ].
	self hasItems ifTrue: [ ^self version specStringFor: self items ].
	^self version specString
]

{ #category : #accessing }
GTSpecEditor >> version [
	self hasPlatform ifTrue: [ self mainVersion versionFor: self platform ].
	self mainVersion isMetacellerRelease ifTrue: [ ^self mainVersion version ].
	^self mainVersion
]
