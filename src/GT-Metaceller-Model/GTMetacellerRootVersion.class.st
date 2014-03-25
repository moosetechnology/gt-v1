Class {
	#name : #GTMetacellerRootVersion,
	#superclass : #Object,
	#instVars : [
		'method',
		'commonVersion',
		'mainVersion'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #'instance creation' }
GTMetacellerRootVersion class >> on: aMethod [ 
	^self new
		method: aMethod;
		yourself
]

{ #category : #accessing }
GTMetacellerRootVersion >> addChild: aVersion [
	aVersion platformSymbol ifNil: [ ^self mainVersion: aVersion ].
	aVersion platformSymbol = #'common' ifTrue: [ ^self commonVersion: aVersion ].
	GTMetacellerStateError signal: 'Unexpected child for root version, with platform ', aVersion platformSymbol asString
]

{ #category : #'accessing dummy' }
GTMetacellerRootVersion >> author [
	^''
]

{ #category : #'accessing dummy' }
GTMetacellerRootVersion >> blessing [
	^''
]

{ #category : #accessing }
GTMetacellerRootVersion >> commonVersion [
	commonVersion ifNil: [ 
		self mainVersion ifNil: [ ^nil ].
		" build project for all platforms "
		self mainVersion project projects do: [ :each | each versions ] ].
	^commonVersion
]

{ #category : #accessing }
GTMetacellerRootVersion >> commonVersion: aVersion [
	commonVersion ifNotNil: [ GTMetacellerStateError signal: 'There can only be one common version.' ].
	commonVersion := aVersion
]

{ #category : #'accessing dummy' }
GTMetacellerRootVersion >> description [
	^''
]

{ #category : #accessing }
GTMetacellerRootVersion >> mainVersion [
	^mainVersion
]

{ #category : #accessing }
GTMetacellerRootVersion >> mainVersion: aVersion [
	mainVersion ifNotNil: [ GTMetacellerStateError signal: 'There can only be one main version.' ].
	mainVersion := aVersion
]

{ #category : #accessing }
GTMetacellerRootVersion >> method [
	^ method
]

{ #category : #accessing }
GTMetacellerRootVersion >> method: aMethod [ 
	method := aMethod
]

{ #category : #'code generation' }
GTMetacellerRootVersion >> methodWithVersionName: aString [ 
	^String streamContents: [ :s | self streamVersionWithName: aString on: s ]
]

{ #category : #'accessing dummy' }
GTMetacellerRootVersion >> postLoadDoIt [
	^''
]

{ #category : #'accessing dummy' }
GTMetacellerRootVersion >> preLoadDoIt [
	^''
]

{ #category : #accessing }
GTMetacellerRootVersion >> repositoriesToWrite [
	^#()
]

{ #category : #'code generation' }
GTMetacellerRootVersion >> streamVersionWithName: aString on: aStream [
	" build project for all platforms "
	self mainVersion project projects do: [ :each | each versions ].
	" and the actual streaming "
	self commonVersion streamVersionHeaderWithName: aString on: aStream.
	self commonVersion streamVersionOn: aStream
]

{ #category : #'accessing dummy' }
GTMetacellerRootVersion >> timestamp [
	^''
]
