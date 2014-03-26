Class {
	#name : #GTMetacellerAtributedProject,
	#superclass : #GTMetacellerProject,
	#instVars : [
		'platformDescription',
		'mainProject'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #'instance creation' }
GTMetacellerAtributedProject class >> on: aConfigurationClass main: aMainProject platform: aPlatformDescription [
	^self basicNew
		initialize: aConfigurationClass main: aMainProject platform: aPlatformDescription;
		yourself
]

{ #category : #'code generation' }
GTMetacellerAtributedProject >> createTempClass [
	^AnonymousClassInstaller make: [ :builder |
		builder
			superclass: self configuration;
			buildNewClass ]
]

{ #category : #accessing }
GTMetacellerAtributedProject >> displayString [
	^self platformDescription symbol asString
]

{ #category : #testing }
GTMetacellerAtributedProject >> hasAttributes [
	^true
]

{ #category : #testing }
GTMetacellerAtributedProject >> hasPlatform: aPlatform [
	^self platformDescription hasSymbol: aPlatform
]

{ #category : #initialization }
GTMetacellerAtributedProject >> initialize: aConfigurationClass main: aMainProject platform: aPlatformDescription [
	self initialize: aConfigurationClass.
	mainProject := aMainProject.
	platformDescription := aPlatformDescription
]

{ #category : #accessing }
GTMetacellerAtributedProject >> itemsFor: aPlatform in: aVersion [ 
	^(self version: aVersion) items select: [ :each | (each hasPlatform: aPlatform) and: [ each isGroup not ] ]
]

{ #category : #accessing }
GTMetacellerAtributedProject >> mainProject [
	^mainProject
]

{ #category : #accessing }
GTMetacellerAtributedProject >> parentProject [
	^self mainProject parentProjectFor: self platformDescription
]

{ #category : #accessing }
GTMetacellerAtributedProject >> parentVersionFor: aMethod [ 
	^self parentProject
		ifNil: [ self mainProject parentVersionFor: aMethod ]
		ifNotNilDo: [ :parentProject | parentProject versionFor: aMethod ]
]

{ #category : #accessing }
GTMetacellerAtributedProject >> platformDescription [
	^ platformDescription
]

{ #category : #accessing }
GTMetacellerAtributedProject >> platformSymbol [
	^self platformDescription symbol
]

{ #category : #accessing }
GTMetacellerAtributedProject >> platformsFor: anItem version: aVersion [ 
	^self mainProject platformsFor: anItem version: aVersion
]

{ #category : #accessing }
GTMetacellerAtributedProject >> project [
	^project ifNil: [ 
		GTMetacelloPlatform defaultPlatformDescription: self platformDescription.
		[ project := configuration project ] ensure: [ GTMetacelloPlatform defaultPlatformDescription: nil ] ]
]
