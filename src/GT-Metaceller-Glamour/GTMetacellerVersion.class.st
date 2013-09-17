Class {
	#name : #GTMetacellerVersion,
	#superclass : #Object,
	#instVars : [
		'method',
		'version',
		'configuration',
		'cachedPackageMap',
		'project',
		'groups',
		'items'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #conveniance }
GTMetacellerVersion class >> allMethodsForProject:aProject [
	^aProject configuration methods collect: [ :each |
		self on: aProject configuration method: each project: aProject ]
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
GTMetacellerVersion class >> on: aConfiguration method: aMethod project: aProject [
	^self basicNew
		initialize: aConfiguration method: aMethod project: aProject;
		yourself
]

{ #category : #conveniance }
GTMetacellerVersion class >> versionsForProject: aProject [
	^(aProject configuration methods
		select: [ :each | self isValidVersion: each ]
		thenCollect: [ :each | self on: aProject configuration method: each project: aProject ]) 
			asSortedCollection: [ :a :b | a name > b name ]
]

{ #category : #actions }
GTMetacellerVersion >> actions [
	| retVal |
	retVal := OrderedCollection new.
	retVal add: ((GLMGenericAction new) 
			action: [ :list  | list selection inspect ];
			title: 'Inspect'
			yourself).
	retVal add: ((GLMGenericAction new) 
			action: [ :list  | list selection method browse ];
			title: 'Browse method'
			yourself).
	retVal add: ((GLMGenericAction new) 
			action: [ :list  | list selection load ];
			title: 'Load'
			yourself).
 	retVal add: ((GLMGenericAction new) 
			action: [ :list  | list selection fetch ];
			title: 'Fetch'
			yourself).
"
	This checks the current version, but it needs to update the ui without recreating the versions
 	retVal add: ((GLMGenericAction new) 
			action: [ :list  | list selection checkCurrentVersion ];
			title: 'Check current version'
			yourself).
"	self isDevelopment ifTrue: [ 
	 	retVal add: ((GLMGenericAction new) 
			action: [ :list  | list selection update ];
			title: 'Update'
			yourself) ].
	^retVal
]

{ #category : #accessing }
GTMetacellerVersion >> belongsToGroup: aSpec [
	^(self tagsOf: aSpec) notEmpty
]

{ #category : #accessing }
GTMetacellerVersion >> blessing [
	^self version spec blessing value
]

{ #category : #accessing }
GTMetacellerVersion >> buildGroups [
	self version ifNotNil: [ 
		^self version groups collect: [ :each | GTMetacellerGroup on: self version spec: each ] ].
	^#()
]

{ #category : #initialization }
GTMetacellerVersion >> buildItems [
	^self packagesAndProjects collect: [ :each | self wrapperFor: each ] 
]

{ #category : #actions }
GTMetacellerVersion >> checkCurrentVersion [
	self project checkCurrentVersion
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
	self project ifNil: [  ^nil ].
	self method pragmas do: [ :each |
		(each key beginsWith: 'version') ifTrue: [ ^self project metacelloVersion: (each arguments first) ] ].
	^nil
]

{ #category : #accessing }
GTMetacellerVersion >> displayString [
	^self textLabel
]

{ #category : #actions }
GTMetacellerVersion >> fetch [
	self version ifNotNil: [ self version fetch ]
]

{ #category : #accessing }
GTMetacellerVersion >> groups [
	^groups ifNil: [ groups := self buildGroups ]
]

{ #category : #accessing }
GTMetacellerVersion >> groupsAndLoosePackages [
	^(OrderedCollection withAll: self packagesWithoutGroups)
		addAll: self groups;
		yourself
]

{ #category : #testing }
GTMetacellerVersion >> hasItem: aMetacellerItem [
	^self items contains: [ :each | each name = aMetacellerItem name ]
]

{ #category : #testing }
GTMetacellerVersion >> hasName: aString [ 
	^self name = aString
]

{ #category : #initialization }
GTMetacellerVersion >> initialize: aConfiguration method: aMethod project: aProject [
	self initialize.
	method := aMethod.
	configuration := aConfiguration.
	project := aProject
]

{ #category : #testing }
GTMetacellerVersion >> isBleedingEdge [
	self project ifNil: [  ^false ].
	self version ifNil: [ ^false ].
	^false
	"
	This should be this code ... but this is a bit slow
	[ ^(self project bleedingEdge = self version) ] on: MetacelloSymbolicVersionDoesNotExistError do: [ ^false ]."
]

{ #category : #testing }
GTMetacellerVersion >> isCurrent [
	self project ifNil: [  ^false ].
	self version ifNil: [ ^false ].
	^self project currentVersion = self version
]

{ #category : #testing }
GTMetacellerVersion >> isDevelopment [
	^self blessing = #development
]

{ #category : #testing }
GTMetacellerVersion >> isDevelopmentVersion [
	self project ifNil: [  ^false ].
	self version ifNil: [ ^false ].
	^self project development = self version
]

{ #category : #testing }
GTMetacellerVersion >> isGroup: aSpec [ 
	^aSpec isKindOf: MetacelloGroupSpec
]

{ #category : #testing }
GTMetacellerVersion >> isPackage: aSpec [ 
	^aSpec isKindOf: MetacelloPackageSpec
]

{ #category : #testing }
GTMetacellerVersion >> isProject: aSpec [ 
	^(aSpec isKindOf: MetacelloProjectReferenceSpec) or: [ aSpec isKindOf: MetacelloProjectSpec ]
]

{ #category : #testing }
GTMetacellerVersion >> isStable [
	self project ifNil: [  ^false ].
	self version ifNil: [ ^false ].
	[ ^(self project stableVersion = self version) ] on: MetacelloSymbolicVersionDoesNotExistError do: [ ^false ].
]

{ #category : #accessing }
GTMetacellerVersion >> items [
	^items ifNil: [ items := self buildItems ]
]

{ #category : #actions }
GTMetacellerVersion >> load [
	self version ifNotNil: [ self version load ]
]

{ #category : #actions }
GTMetacellerVersion >> load: aString [ 
	self version ifNotNil: [ self version load: aString ]
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
GTMetacellerVersion >> package: aString [
	^self items detect: [ :each | each hasName: aString ] ifNone: [ nil ]
	
]

{ #category : #accessing }
GTMetacellerVersion >> packageNamed: aString ifAbsent: aBlock [ 
	self version ifNil: [ ^nil ].
	^self version packageNamed: aString ifAbsent: aBlock
]

{ #category : #accessing }
GTMetacellerVersion >> packages [
	self version ifNil: [ ^#() ].
	^self version packages
]

{ #category : #caching }
GTMetacellerVersion >> packagesAndGroups [
	cachedPackageMap ifNil: [
		cachedPackageMap := Dictionary new.
		self version ifNotNil: [
			self groups do: [:eachGroup |
				eachGroup children do: [ :eachPackage |
					(cachedPackageMap at: eachPackage ifAbsentPut: [OrderedCollection new])
						add: eachGroup name ] ] ] ].
	^ cachedPackageMap
]

{ #category : #accessing }
GTMetacellerVersion >> packagesAndProjects [
	self version ifNil: [ ^#() ].
	^(self version spec packages packageSpecsInLoadOrder)
		collect: [ :each | self wrapperFor: each ]
]

{ #category : #accessing }
GTMetacellerVersion >> packagesForSpecNamed: aVersionString [ 
	self version ifNotNil: [ ^self version packagesForSpecNamed: aVersionString ].
	^#()
]

{ #category : #accessing }
GTMetacellerVersion >> packagesWithoutGroups [
	" make sure the groups are built first "
	self groups.
	^self packagesAndProjects select: [ :each | (each isPackage or: [ each isProject ]) and: [ (self belongsToGroup: each) not ] ]
]

{ #category : #accessing }
GTMetacellerVersion >> platformsFor: aMetacellerItem [
	^self project platformsFor: aMetacellerItem version: self name
]

{ #category : #accessing }
GTMetacellerVersion >> project [
	^project
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

{ #category : #display }
GTMetacellerVersion >> tags [
	self version ifNil: [  ^#() ].
	^Array with: self blessing
]

{ #category : #display }
GTMetacellerVersion >> tagsOf: aSpec [
	(aSpec isKindOf: GTMetacellerItem) ifTrue: [ ^self tagsOf: aSpec referenceSpec ].
	(aSpec isKindOf: MetacelloProjectReferenceSpec) ifTrue: [  ^self tagsOf: aSpec projectReference ].
	^self packagesAndGroups at: aSpec ifAbsent: [OrderedCollection new]
]

{ #category : #display }
GTMetacellerVersion >> textLabel [
	| attributes |
	attributes := OrderedCollection new.
	self version ifNil: [ attributes add: TextColor red ].
	self isBleedingEdge ifTrue: [ attributes add: TextColor red  ].
	self isDevelopmentVersion ifTrue: [ attributes add: TextColor blue ].
	self isCurrent ifTrue: [ attributes add: TextEmphasis underlined ].
	self isStable ifTrue: [ attributes add: TextEmphasis bold ].
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

{ #category : #dummy }
GTMetacellerVersion >> versions [
	^#()
]

{ #category : #tool }
GTMetacellerVersion >> wrapperFor: aSpec [
	(self isProject: aSpec) ifTrue: [  ^GTMetacellerProjectReference on: self spec: aSpec ].
	(self isGroup: aSpec) ifTrue: [  ^GTMetacellerGroup on: self spec: aSpec ].
	(self isPackage: aSpec) ifTrue: [ ^GTMetacellerPackage on: self spec: aSpec ].
	^aSpec
	
]
