Class {
	#name : #GTMetacellerItem,
	#superclass : #Object,
	#instVars : [
		'version',
		'referenceSpec'
	],
	#category : #'GT-Metaceller'
}

{ #category : #'instance creation' }
GTMetacellerItem class >> on: aVersion spec: aSpec [
	^self basicNew
		initialize: aVersion spec: aSpec;
		yourself
]

{ #category : #accessing }
GTMetacellerItem >> asString [
	^self referenceSpec asString 
]

{ #category : #initialization }
GTMetacellerItem >> initialize: aVersion [
	self initialize.
	version := aVersion
]

{ #category : #initialization }
GTMetacellerItem >> initialize: aVersion spec: aSpec [
	self initialize.
	version := aVersion.
	referenceSpec := aSpec
]

{ #category : #testing }
GTMetacellerItem >> isGroup: aSpec [ 
	^aSpec isKindOf: MetacelloGroupSpec
]

{ #category : #testing }
GTMetacellerItem >> isPackage: aSpec [ 
	^aSpec isKindOf: MetacelloPackageSpec
]

{ #category : #testing }
GTMetacellerItem >> isProject: aSpec [ 
	^(aSpec isKindOf: MetacelloProjectReferenceSpec) or: [ aSpec isKindOf: MetacelloProjectSpec ]
]

{ #category : #accessing }
GTMetacellerItem >> name [
	^self referenceSpec name
]

{ #category : #initialization }
GTMetacellerItem >> referenceSpec [
	^referenceSpec
]

{ #category : #accessing }
GTMetacellerItem >> version [
	^version
]

{ #category : #tool }
GTMetacellerItem >> wrapperFor: aSpec version: aVersion [
	(self isProject: aSpec) ifTrue: [  ^GTMetacellerProjectReference on: aVersion spec: aSpec ].
	(self isGroup: aSpec) ifTrue: [  ^GTMetacellerGroup on: aVersion spec: aSpec ].
	^aSpec
]
