Class {
	#name : #GTMetacellerProject,
	#superclass : #Object,
	#instVars : [
		'configuration',
		'project',
		'stableVersion',
		'bleedingEdge',
		'development',
		'currentVersion'
	],
	#category : #'GT-Metaceller'
}

{ #category : #'instance creation' }
GTMetacellerProject class >> on: aConfiguration [
	^self basicNew
		initialize: aConfiguration;
		yourself
]

{ #category : #accessing }
GTMetacellerProject >> bleedingEdge [
	^ bleedingEdge ifNil: [ bleedingEdge := self project bleedingEdge ]
]

{ #category : #accessing }
GTMetacellerProject >> configuration [
	^ configuration
]

{ #category : #accessing }
GTMetacellerProject >> currentVersion [
	^ currentVersion ifNil: [ currentVersion := self project currentVersion ]
]

{ #category : #accessing }
GTMetacellerProject >> development [
	^ development ifNil: [ development := self project development ]
]

{ #category : #initialization }
GTMetacellerProject >> initialize: aConfiguration [
	self initialize.
	configuration := aConfiguration
]

{ #category : #accessing }
GTMetacellerProject >> project [
	^ project ifNil: [ project := configuration project ]
]

{ #category : #accessing }
GTMetacellerProject >> stableVersion [
	^ stableVersion ifNil: [ stableVersion := self project stableVersion ]
]

{ #category : #accessing }
GTMetacellerProject >> version: aStringOrSymbol [
	self project ifNil: [ ^nil ].
	^self project version: aStringOrSymbol
]
