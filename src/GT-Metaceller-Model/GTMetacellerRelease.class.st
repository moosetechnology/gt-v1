Class {
	#name : #GTMetacellerRelease,
	#superclass : #Object,
	#instVars : [
		'project',
		'version',
		'method',
		'symbolicVersion'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #testing }
GTMetacellerRelease class >> isValidRelease: aMethod [ 
	aMethod pragmas do: [ :each | 
		(each key beginsWith: 'symbolicVersion') ifTrue: [ ^true ] ].
	^false
]

{ #category : #'instance creation' }
GTMetacellerRelease class >> on: aProject method: aMethod [
	^self new
		project: aProject;
		method: aMethod;
		yourself
]

{ #category : #convenience }
GTMetacellerRelease class >> releasesForProject: aProject [
	^(aProject configuration methods
		select: [ :each | self isValidRelease: each ]
		thenCollect: [ :each | self on: aProject method: each ]) 
			asSortedCollection: [ :a :b | a releaseName > b releaseName ]
]

{ #category : #initialization }
GTMetacellerRelease >> determineVersion [
	self project ifNil: [  ^nil ].
	self releaseName ifNotNil: [ :aSymbol | ^self project version: aSymbol ].
	^nil
]

{ #category : #accessing }
GTMetacellerRelease >> method [
	^ method
]

{ #category : #accessing }
GTMetacellerRelease >> method: anObject [
	method := anObject
]

{ #category : #printing }
GTMetacellerRelease >> printOn: aStream [
	self releaseName printOn: aStream
]

{ #category : #accessing }
GTMetacellerRelease >> project [
	^ project
]

{ #category : #accessing }
GTMetacellerRelease >> project: anObject [
	project := anObject
]

{ #category : #accessing }
GTMetacellerRelease >> releaseName [
	self project ifNil: [  ^nil ].
	self method pragmas do: [ :each |
		(each key beginsWith: 'symbolicVersion') ifTrue: [ ^each arguments first ] ].
	^nil
]

{ #category : #accessing }
GTMetacellerRelease >> symbolicVersion [
	^symbolicVersion ifNil: [ symbolicVersion := self determineVersion ]
]

{ #category : #accessing }
GTMetacellerRelease >> version [
	^ version ifNil: [ version := self project version: self versionName ]
]

{ #category : #accessing }
GTMetacellerRelease >> version: anObject [
	version := anObject
]

{ #category : #accessing }
GTMetacellerRelease >> versionName [
	^self version versionName
]
