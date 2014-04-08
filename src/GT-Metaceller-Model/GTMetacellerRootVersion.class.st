Class {
	#name : #GTMetacellerRootVersion,
	#superclass : #Object,
	#instVars : [
		'method',
		'commonVersion',
		'mainVersion',
		'errorVersions'
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
	self errorVersions add: aVersion
]

{ #category : #'accessing dummy' }
GTMetacellerRootVersion >> allGroups [
	^#()
]

{ #category : #'accessing dummy' }
GTMetacellerRootVersion >> allPackages [
	^#()
]

{ #category : #'accessing dummy' }
GTMetacellerRootVersion >> allProjects [
	^#()
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

{ #category : #'code generation' }
GTMetacellerRootVersion >> ensureProjectsCreated [
	self mainVersion ensureProjectsCreated
]

{ #category : #accessing }
GTMetacellerRootVersion >> errorVersions [
	^errorVersions ifNil: [ errorVersions := OrderedCollection new ]
]

{ #category : #'accessing dummy' }
GTMetacellerRootVersion >> item: aString [ 
	^nil
]

{ #category : #accessing }
GTMetacellerRootVersion >> mainVersion [
	mainVersion ifNil: [ commonVersion ifNotNil: [ commonVersion ensureProjectsCreated ] ].
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
GTMetacellerRootVersion >> methodSpecForVersion: aVersion [
	| updatedVersion |
	(aVersion = self mainVersion)
		ifTrue: [ updatedVersion := nil]
		ifFalse: [ updatedVersion := aVersion ].
	^String codeStreamContents: [ :s |
		self methodSpecForVersion: updatedVersion on: s ]
]

{ #category : #'code generation' }
GTMetacellerRootVersion >> methodSpecForVersion: aVersion on: aStream [
	self ensureProjectsCreated.
	" and the actual streaming "
	self commonVersion streamVersionHeader: aVersion on: aStream.
	self commonVersion streamVersion: aVersion on: aStream
]

{ #category : #'code generation' }
GTMetacellerRootVersion >> methodWithVersionName: aString [ 
	^String codeStreamContents: [ :s | self streamVersionWithName: aString on: s ]
]

{ #category : #'accessing dummy' }
GTMetacellerRootVersion >> postLoadDoIt [
	^''
]

{ #category : #'accessing dummy' }
GTMetacellerRootVersion >> preLoadDoIt [
	^''
]

{ #category : #'accessing dummy' }
GTMetacellerRootVersion >> repositories [
	^#()
]

{ #category : #accessing }
GTMetacellerRootVersion >> repositoriesToWrite [
	^#()
]

{ #category : #accessing }
GTMetacellerRootVersion >> rootVersion [
	^self
]

{ #category : #'code generation' }
GTMetacellerRootVersion >> streamVersionWithName: aString on: aStream [
	self ensureProjectsCreated.
	" and the actual streaming "
	self commonVersion streamVersionHeaderWithName: aString on: aStream.
	self commonVersion streamVersion: nil on: aStream
]

{ #category : #'accessing dummy' }
GTMetacellerRootVersion >> timestamp [
	^''
]
