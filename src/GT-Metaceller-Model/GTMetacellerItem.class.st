Class {
	#name : #GTMetacellerItem,
	#superclass : #Object,
	#instVars : [
		'version',
		'referenceSpec'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #'instance creation' }
GTMetacellerItem class >> on: aVersion spec: aSpec [
	^self basicNew
		initialize: aVersion spec: aSpec;
		yourself
]

{ #category : #building }
GTMetacellerItem >> addAll: aString to: aCollection version: aVersion [
	| spec |
	aVersion ifNil: [ ^self ].
	spec := aVersion packageNamed: aString ifAbsent: [ ^self ].
	(aCollection includes: spec) ifTrue: [ ^self ].
	(self isProject: spec) ifFalse: [ spec requires do: [ :each | self addAll: each to: aCollection version: aVersion ] ].
	(self isGroup: spec) ifFalse: [ aCollection add: spec ].
	(self isProject: spec) ifFalse: [ spec includes do: [ :each | self addAll: each to: aCollection version: aVersion ] ]
]

{ #category : #accessing }
GTMetacellerItem >> asString [
	^self referenceSpec asString 
]

{ #category : #accessing }
GTMetacellerItem >> children [
	^#()
]

{ #category : #testing }
GTMetacellerItem >> hasName: aString [ 
	^self name = aString
]

{ #category : #testing }
GTMetacellerItem >> hasPlatform: aSymbol [ 
	^self platforms contains: [ :each | each hasSymbol: aSymbol ]
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
GTMetacellerItem >> isGroup [
	^false
]

{ #category : #testing }
GTMetacellerItem >> isGroup: aSpec [ 
	^aSpec isKindOf: MetacelloGroupSpec
]

{ #category : #testing }
GTMetacellerItem >> isPackage [
	^false
]

{ #category : #testing }
GTMetacellerItem >> isPackage: aSpec [ 
	^aSpec isKindOf: MetacelloPackageSpec
]

{ #category : #testing }
GTMetacellerItem >> isProject [
	^false
]

{ #category : #testing }
GTMetacellerItem >> isProject: aSpec [ 
	^(aSpec isKindOf: MetacelloProjectReferenceSpec) or: [ aSpec isKindOf: MetacelloProjectSpec ]
]

{ #category : #accessing }
GTMetacellerItem >> itemName [
	^self referenceSpec name
]

{ #category : #accessing }
GTMetacellerItem >> labelAsText [
	^self referenceSpec label
]

{ #category : #accessing }
GTMetacellerItem >> name [
	^self referenceSpec name
]

{ #category : #accessing }
GTMetacellerItem >> platforms [
	^self version platformsFor: self
]

{ #category : #accessing }
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
	(self isPackage: aSpec) ifTrue: [ ^GTMetacellerPackage on: aVersion spec: aSpec ].
	^aSpec
]
