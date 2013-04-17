Class {
	#name : #GTMetacellerVersion,
	#superclass : #Object,
	#instVars : [
		'method',
		'version',
		'configuration',
		'cachedPackageMap',
		'attributes'
	],
	#category : #'GT-Tools-Metaceller'
}

{ #category : #conveniance }
GTMetacellerVersion class >> allMethodsForConfig: aConfiguration [
	^aConfiguration methods collect: [ :each |
		self on: aConfiguration method: each ]
]

{ #category : #testing }
GTMetacellerVersion class >> isValidVersion: aVersion [
	aVersion pragmas do: [ :each |
		(each key beginsWith: 'version') ifTrue: [  ^true ] ].
	^false
]

{ #category : #actions }
GTMetacellerVersion class >> load: aString [ 
	self version ifNotNil: [ self version load: aString ]
]

{ #category : #'instance creation' }
GTMetacellerVersion class >> on: aConfiguration method: aMethod [
	^self basicNew
		initialize: aConfiguration method: aMethod;
		yourself
]

{ #category : #conveniance }
GTMetacellerVersion class >> versionsForConfig: aConfiguration [
	^(aConfiguration methods
		select: [ :each | self isValidVersion: each ]
		thenCollect: [ :each | self on: aConfiguration method: each ]) 
			asSortedCollection: [ :a :b | a name > b name ]
]

{ #category : #actions }
GTMetacellerVersion >> actions [
	| retVal |
	retVal := OrderedCollection new.
 	retVal add: ((GLMGenericAction new) 
			action: [ :list  | list selection load ];
			title: 'Load'
			yourself).
 	retVal add: ((GLMGenericAction new) 
			action: [ :list  | list selection fetch ];
			title: 'Fetch'
			yourself).
	self isDevelopment ifTrue: [ 
	 	retVal add: ((GLMGenericAction new) 
			action: [ :list  | list selection update ];
			title: 'Update'
			yourself) ].
	^retVal
]

{ #category : #accessing }
GTMetacellerVersion >> configuration [
	^ configuration
]

{ #category : #accessing }
GTMetacellerVersion >> configuration: anObject [
	configuration := anObject
]

{ #category : #accessing }
GTMetacellerVersion >> determineVersion [
	self method pragmas do: [ :each |
		(each key beginsWith: 'version') ifTrue: [ ^self configuration project version: (each arguments first) ] ].
	^nil
]

{ #category : #actions }
GTMetacellerVersion >> fetch [
	self version ifNotNil: [ self version fetch ]
]

{ #category : #accessing }
GTMetacellerVersion >> groups [
	self version ifNotNil: [ ^self version groups ].
	^#()
]

{ #category : #testing }
GTMetacellerVersion >> initialize: aConfiguration method: aMethod [
	self initialize.
	method := aMethod.
	configuration := aConfiguration
]

{ #category : #testing }
GTMetacellerVersion >> isBleedingEdge [
	self version ifNil: [ ^false ].
	[ ^(self version project bleedingEdge = self version) ] on: MetacelloSymbolicVersionDoesNotExistError do: [ ^false ].
]

{ #category : #testing }
GTMetacellerVersion >> isCurrent [
	self version ifNil: [ ^false ].
	[ ^(self version project currentVersion = self version) ] on: MetacelloSymbolicVersionDoesNotExistError do: [ ^false ].
]

{ #category : #testing }
GTMetacellerVersion >> isDevelopment [
	self version ifNil: [ ^false ].
	[ ^(self version project development = self version) ] on: MetacelloSymbolicVersionDoesNotExistError do: [ ^false ].
]

{ #category : #testing }
GTMetacellerVersion >> isGroup: aSpec [ 
	^aSpec isKindOf: MetacelloGroupSpec
]

{ #category : #testing }
GTMetacellerVersion >> isStable [
	self version ifNil: [ ^false ].
	[ ^(self version project stableVersion = self version) ] on: MetacelloSymbolicVersionDoesNotExistError do: [ ^false ].
]

{ #category : #actions }
GTMetacellerVersion >> load [
	self version ifNotNil: [ self version load ]
]

{ #category : #accessing }
GTMetacellerVersion >> method [
	^ method
]

{ #category : #accessing }
GTMetacellerVersion >> method: anObject [
	method := anObject
]

{ #category : #accessing }
GTMetacellerVersion >> methodCategory [
	^self method category
]

{ #category : #accessing }
GTMetacellerVersion >> methodClass [
	^self configuration
]

{ #category : #accessing }
GTMetacellerVersion >> methodString [
	^self method asString
]

{ #category : #testing }
GTMetacellerVersion >> name [
	method pragmas do: [  :each |
		(each key beginsWith: 'version') ifTrue: [ ^each arguments first ] ].
	^method selector
]

{ #category : #accessing }
GTMetacellerVersion >> packages [
	self version ifNil: [ ^#() ].
	^self version packages
]

{ #category : #caching }
GTMetacellerVersion >> packagesAndGroup [
	cachedPackageMap ifNil: [
		cachedPackageMap := Dictionary new.
		self version ifNotNil: [
			self version groups do: [:eachGroup |
			[ (self version packagesForSpecNamed: eachGroup name) do: [:eachPackage |
				cachedPackageMap at: eachPackage ifAbsentPut: [OrderedCollection new].
				(cachedPackageMap at: eachPackage) add: eachGroup name ] ]
			on: Exception do: [ "we eat exceptions for now" ] ] ] ].
	^ cachedPackageMap
]

{ #category : #accessing }
GTMetacellerVersion >> packagesAndProjects [
	self version ifNil: [ ^#() ].
	^(self version spec packages packageSpecsInLoadOrder) select: [  :each | (self isGroup: each) not ]
]

{ #category : #accessing }
GTMetacellerVersion >> packagesForSpecNamed: aVersionString [ 
	self version ifNotNil: [ ^self version packagesForSpecNamed: aVersionString ].
	^#()
]

{ #category : #accessing }
GTMetacellerVersion >> projects [
	self version ifNil: [ ^#() ].
	^self version projects
]

{ #category : #accessing }
GTMetacellerVersion >> selector [
	^self method selector
]

{ #category : #accessing }
GTMetacellerVersion >> spec [
	self version ifNotNil: [ ^self version spec ].
	^nil
]

{ #category : #accessing }
GTMetacellerVersion >> tagsOf: aPackageSpec [ 
	^self packagesAndGroup at: aPackageSpec ifAbsent: [OrderedCollection new]
]

{ #category : #accessing }
GTMetacellerVersion >> tagsOf: aMetacelloPackageSpec in: aGTMetacellerVersion [ 
	self shouldBeImplemented.
]

{ #category : #accessing }
GTMetacellerVersion >> textLabel [
	attributes ifNil: [
		attributes := OrderedCollection new.
		self version ifNil: [ attributes add: TextColor red ].
		self isBleedingEdge ifTrue: [ attributes add: TextColor blue ].
		self isStable ifTrue: [ attributes add: TextEmphasis underlined ].
		self isDevelopment ifTrue: [ attributes add: TextEmphasis italic ].
		self isCurrent ifTrue: [ attributes add: TextEmphasis bold ] ].
	^Text string: self name attributes: attributes
]

{ #category : #actions }
GTMetacellerVersion >> update [
	self isDevelopment ifTrue: [
		MetacelloToolBox updateToLatestPackageVersionsIn: self configuration description: 'Please describe this version.' ]
]

{ #category : #accessing }
GTMetacellerVersion >> version [
	^ version ifNil: [ version := self determineVersion ]
]

{ #category : #accessing }
GTMetacellerVersion >> version: anObject [
	version := anObject
]
