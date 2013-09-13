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
	^GTMetacellerVersion allMethodsForConfig: self configuration
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
		GTMetacelloProject defaultPlatformSelector: self platformSelector.
		[ project := configuration project ] ensure: [ GTMetacelloProject defaultPlatformSelector: nil ] ]
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
	^GTMetacellerVersion versionsForConfig: self configuration
]
