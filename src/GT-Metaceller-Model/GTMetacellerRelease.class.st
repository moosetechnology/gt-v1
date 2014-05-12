Class {
	#name : #GTMetacellerRelease,
	#superclass : #Object,
	#instVars : [
		'project',
		'version',
		'method',
		'metacelloVersion',
		'isCopy',
		'properties'
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

{ #category : #accessing }
GTMetacellerRelease >> canModify [
	^self isCopy
]

{ #category : #accessing }
GTMetacellerRelease >> commonVersion [
	^self version commonVersion
]

{ #category : #initialization }
GTMetacellerRelease >> determineMetacelloVersion [
	self project ifNil: [  ^nil ].
	self releaseName ifNotNil: [ :aSymbol | ^self project metacelloVersion: aSymbol ].
	^nil
]

{ #category : #initialization }
GTMetacellerRelease >> determineVersion [
	self project ifNil: [  ^nil ].
	self versionName ifNotNil: [ :aString | ^self project version: aString ].
	^nil
]

{ #category : #'accessing version' }
GTMetacellerRelease >> groups [
	self version ifNil: [ ^#() ].
	^self version groups
]

{ #category : #'accessing version' }
GTMetacellerRelease >> groupsAndLoosePackages [
	self version ifNil: [ ^#() ].
	^self version groupsAndLoosePackages
]

{ #category : #printing }
GTMetacellerRelease >> infoText [
	| retVal |
	retVal := self labelAsText.
	retVal append: String cr.
	self version
		ifNil: [ 
			(self metacelloVersion isKindOf: Exception)
				ifTrue: [ retVal append: (Text string: self metacelloVersion name attribute: TextColor red) ]
				ifFalse: [ retVal append: (Text string: ('Could not determine version', self versionName asString, '.') attribute: TextColor red) ] ]
		ifNotNil: [ retVal append: self version infoText ].
	^retVal
]

{ #category : #accessing }
GTMetacellerRelease >> isCopy [
	^isCopy ifNil: [ false ]
]

{ #category : #testing }
GTMetacellerRelease >> isMetacellerRelease [
	^true
]

{ #category : #testing }
GTMetacellerRelease >> isRelease [
	^true
]

{ #category : #printing }
GTMetacellerRelease >> labelAsText [
	| retVal | 
	retVal := Text fromString: ('#', self releaseName).
	self version 
		ifNil: [ retVal append: (Text string: ' (no version)' attribute: TextColor red) ]
		ifNotNil: [ retVal append: (Text string: (' (', self versionName, ')') attribute: TextColor gray) ].
	^retVal
]

{ #category : #accessing }
GTMetacellerRelease >> metacelloVersion [
	^metacelloVersion ifNil: [ metacelloVersion := self determineMetacelloVersion ]
]

{ #category : #accessing }
GTMetacellerRelease >> method [
	^ method
]

{ #category : #accessing }
GTMetacellerRelease >> method: anObject [
	method := anObject
]

{ #category : #copying }
GTMetacellerRelease >> postCopy [
	super postCopy.
	properties := self properties copy.
	isCopy := true
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

{ #category : #'accessing version' }
GTMetacellerRelease >> properties [
	^ properties ifNil: [ properties := Dictionary new ]
]

{ #category : #'accessing version' }
GTMetacellerRelease >> propertyAt: aKey ifAbsent: aBlock [
	^self properties at: aKey ifAbsent: aBlock
]

{ #category : #'accessing version' }
GTMetacellerRelease >> propertyAt: aKey put: aValue [ 
	self canModify ifFalse: [ GTMetacellerStateError signal: 'Please create a copy before changing values' ].
	self properties at: aKey put: aValue
]

{ #category : #accessing }
GTMetacellerRelease >> releaseName [
	self project ifNil: [  ^nil ].
	self method pragmas do: [ :each |
		(each key beginsWith: 'symbolicVersion') ifTrue: [ ^each arguments first ] ].
	^nil
]

{ #category : #actions }
GTMetacellerRelease >> saveVersion [
	self project createRelease: self releaseName version: self versionName
]

{ #category : #'accessing version' }
GTMetacellerRelease >> test: aCollection [ 
	self version ifNil: [ ^self ].
	self version test: aCollection
]

{ #category : #actions }
GTMetacellerRelease >> updateWith: aString [ 
	(aString asMetacellerVersion > self versionName asMetacellerVersion)
		ifTrue: [ | newVersion |
			newVersion := self copy.
			newVersion versionName: aString.
			newVersion saveVersion ]
]

{ #category : #'accessing version' }
GTMetacellerRelease >> validate: aCollection [ 
	self version ifNil: [ ^self ].
	self version validate: aCollection
]

{ #category : #accessing }
GTMetacellerRelease >> version [
	^version ifNil: [ version := self determineVersion ]
]

{ #category : #accessing }
GTMetacellerRelease >> version: anObject [
	version := anObject
]

{ #category : #'accessing version' }
GTMetacellerRelease >> versionFor: aString [ 
	^self version versionFor: aString
]

{ #category : #'accessing version' }
GTMetacellerRelease >> versionName [
	^self propertyAt: #versionName ifAbsent: [ self metacelloVersion name ]
]

{ #category : #'accessing version' }
GTMetacellerRelease >> versionName: aString [
	self propertyAt: #versionName put: aString
]
