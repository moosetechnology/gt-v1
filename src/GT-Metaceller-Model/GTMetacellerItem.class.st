Class {
	#name : #GTMetacellerItem,
	#superclass : #GTMetacellerSpec,
	#instVars : [
		'version',
		'referenceSpec',
		'isValidated',
		'errors',
		'warnings',
		'properties',
		'isCopy',
		'parentTrace'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #'instance creation' }
GTMetacellerItem class >> copyFrom: anItem withName: aString [ 
	^self basicNew
		copyFrom: anItem withName: aString;
		yourself
]

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

{ #category : #private }
GTMetacellerItem >> addAllTo: aLoadList [
	aLoadList add: self children: self children.
	^aLoadList
]

{ #category : #accessing }
GTMetacellerItem >> addError: aString [
	(self errors includes: aString)
		ifFalse: [ self errors add: aString ]
]

{ #category : #accessing }
GTMetacellerItem >> addErrorsAndWarnings: aDictionary [ 
	aDictionary keysAndValuesDo: [ :key :value |
		key isSymbol ifFalse: [ self halt ].
		key = #'errors' ifTrue: [ self errors addAll: value ].
		key = #'warnings' ifTrue: [ self warnings addAll: value ] ]
]

{ #category : #accessing }
GTMetacellerItem >> addWarning: aString [
	(self warnings includes: aString)
		ifFalse: [ self warnings add: aString ]
]

{ #category : #convenience }
GTMetacellerItem >> arrayFrom: anOriginal with: aStringOrArray [ 
	aStringOrArray ifNil: [ ^anOriginal ].
	aStringOrArray isString ifTrue: [ 
		anOriginal
			ifNil: [ ^Array with: aStringOrArray ]
			ifNotNil: [ anOriginal copyWith: aStringOrArray ] ].
	anOriginal
		ifNil: [ ^aStringOrArray ].
	^OrderedCollection new
		addAll: anOriginal;
		addAll: aStringOrArray;
		yourself
]

{ #category : #accessing }
GTMetacellerItem >> asString [
	^self referenceSpec asString 
]

{ #category : #accessing }
GTMetacellerItem >> childVersions [
	^self version children collect: [ :each | each item: self itemName ] 
]

{ #category : #accessing }
GTMetacellerItem >> children [
	^#()
]

{ #category : #accessing }
GTMetacellerItem >> commonVersion [
	^self version commonVersion item: self itemName
]

{ #category : #initialization }
GTMetacellerItem >> copyFrom: anItem withName: aString [ 
	self initialize.
	isCopy := true.
	referenceSpec := anItem referenceSpec.
	version := anItem version.
	self resetProperties.
	self itemName: aString

]

{ #category : #'code generation' }
GTMetacellerItem >> createGroupWithName: aString [ 
	^GTMetacellerGroup copyFrom: self withName: aString
]

{ #category : #'code generation' }
GTMetacellerItem >> createPackageWithName: aString [ 
	^GTMetacellerPackage copyFrom: self withName: aString
]

{ #category : #'code generation' }
GTMetacellerItem >> createProjectWithName: aString [ 
	^GTMetacellerProject copyFrom: self withName: aString
]

{ #category : #'accessing spec' }
GTMetacellerItem >> dataFor: aSymbol [
	| retVal |
	retVal := self perform: aSymbol.
	retVal isCollection ifTrue: [ 
		retVal ifEmpty: [ ^nil ] ].
	^retVal value
]

{ #category : #'code generation' }
GTMetacellerItem >> defaultItemKindString [
	^self subclassResponsibility
]

{ #category : #'code generation' }
GTMetacellerItem >> differenceWith: anItem [ 
	(self isDifferentFrom: anItem) ifTrue: [ ^GTMetacellerItemDifference on: self parent: anItem ].
	^nil
]

{ #category : #accessing }
GTMetacellerItem >> errors [
	^errors ifNil: [ errors := OrderedCollection new ]
]

{ #category : #accessing }
GTMetacellerItem >> fullTrace [
	self parentTrace ifNil: [ ^self itemName ].
	^self parentTrace fullTrace, '/', self itemName
]

{ #category : #testing }
GTMetacellerItem >> hasBaselineBlessing [
	^#( baseline ) includes: self blessing
]

{ #category : #testing }
GTMetacellerItem >> hasErrors [
	^self errors notEmpty
]

{ #category : #testing }
GTMetacellerItem >> hasName: aString [ 
	^self name = aString
]

{ #category : #testing }
GTMetacellerItem >> hasPlatform: aSymbol [ 
	^self platforms contains: [ :each | each hasSymbol: aSymbol ]
]

{ #category : #testing }
GTMetacellerItem >> hasStableBlessing [
	^#( stable release ) includes: self blessing
]

{ #category : #testing }
GTMetacellerItem >> hasWarnings [
	^self warnings notEmpty or: [ self hasErrors ]
]

{ #category : #'accessing spec' }
GTMetacellerItem >> includes [
	^self propertyAt: #includes ifAbsent: [ self referenceSpec includes asSet ]
]

{ #category : #accessing }
GTMetacellerItem >> infoText [
	| retVal |
	retVal := Text fromString: self referenceSpec asString.
	self errors do: [ :each | retVal
		append: String cr;
		append: (Text string: each attribute: TextColor red) ].
	self warnings do: [ :each | retVal
		append: String cr;
		append: (Text string: each attribute: TextColor orange) ].
	^retVal
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
GTMetacellerItem >> isCompatibleWith: anItem [
	(self class = anItem class) ifFalse: [ ^false ].
	^true
]

{ #category : #accessing }
GTMetacellerItem >> isCopy [
	^isCopy ifNil: [ false ]
]

{ #category : #testing }
GTMetacellerItem >> isDifferentFrom: anItem [
	self itemName = anItem itemName ifFalse: [ ^true ].
	self specAccessors do: [ :each |
		((self perform: each) value) = ((anItem perform: each) value) ifFalse: [ ^true ] ].
	^false
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

{ #category : #'code generation' }
GTMetacellerItem >> itemKindString [
	^self propertyAt: #itemKind ifAbsent: [ self defaultItemKindString ]
]

{ #category : #'accessing spec' }
GTMetacellerItem >> itemName [
	^self propertyAt: #itemName ifAbsent: [ self referenceSpec name ]
]

{ #category : #'accessing spec' }
GTMetacellerItem >> itemName: aString [
	self propertyAt: #itemName put: aString
]

{ #category : #accessing }
GTMetacellerItem >> labelAsText [
	^self referenceSpec label
]

{ #category : #actions }
GTMetacellerItem >> loadList [
	^GTMetacellerLoadList new
		add: self;
		yourself
]

{ #category : #'code generation' }
GTMetacellerItem >> mergeSpec: anItem [
	^(self referenceSpec mergeSpec: anItem referenceSpec)
]

{ #category : #'code generation' }
GTMetacellerItem >> mergeWith: anItem [
	| retVal |
	(self class == anItem class) ifFalse: [ GTMetacellerStateError signal: 'Cannot merge two items of different class.' ].
	retVal := self copy.
	retVal referenceSpec: (self mergeSpec: anItem).
	^retVal
]

{ #category : #accessing }
GTMetacellerItem >> name [
	^self referenceSpec name
]

{ #category : #'accessing spec' }
GTMetacellerItem >> parent [
	^(self version parent item: self itemName)
]

{ #category : #accessing }
GTMetacellerItem >> parentTrace [
	^parentTrace
]

{ #category : #accessing }
GTMetacellerItem >> parentTrace: anItem [ 
	parentTrace := anItem
]

{ #category : #accessing }
GTMetacellerItem >> platform [
	^self version platform
]

{ #category : #accessing }
GTMetacellerItem >> platforms [
	^self version platformsFor: self
]

{ #category : #copying }
GTMetacellerItem >> postCopy [
	super postCopy.
	properties := self properties copy.
	isCopy := true
]

{ #category : #printing }
GTMetacellerItem >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(; nextPutAll: self itemName; nextPut: $)
]

{ #category : #'accessing spec' }
GTMetacellerItem >> properties [
	^properties ifNil: [ properties := Dictionary new ]
]

{ #category : #'accessing spec' }
GTMetacellerItem >> propertyAt: aKey ifAbsent: aBlock [ 
	^self properties at: aKey ifAbsent: aBlock
]

{ #category : #'accessing spec' }
GTMetacellerItem >> propertyAt: aKey put: aValue [
	self isCopy ifFalse: [ GTMetacellerStateError signal: 'Only copyies can be modified' ].
	self properties at: aKey put: aValue
]

{ #category : #accessing }
GTMetacellerItem >> referenceSpec [
	^referenceSpec
]

{ #category : #accessing }
GTMetacellerItem >> referenceSpec: aSpec [ 
	referenceSpec := aSpec
]

{ #category : #actions }
GTMetacellerItem >> remove [
	self isCopy
		ifTrue: [ self removed: true; saveVersion ]
		ifFalse: [ self copy remove ]
]

{ #category : #'accessing spec' }
GTMetacellerItem >> removed [
	^self propertyAt: #removed ifAbsent: [ false ]
]

{ #category : #'accessing spec' }
GTMetacellerItem >> removed: aBoolean [
	self propertyAt: #removed put: aBoolean
]

{ #category : #accessing }
GTMetacellerItem >> repositories [
	self referenceSpec hasRepository ifFalse: [ ^#() ].
	^self referenceSpec repositorySpecs
]

{ #category : #'accessing spec' }
GTMetacellerItem >> repositoriesFrom: aMetacelloMVRepositorySpecs ignoreOverrides: ignoreOverrides [

	| repositories repos |
	repositories := MCRepositoryGroup default repositories.
	repos := OrderedCollection new.
	aMetacelloMVRepositorySpecs do: [:aSpec | | description repo |
		description := aSpec description.
		(repo := repositories detect: [:rep | rep description = description ] ifNone: [ aSpec createRepository ]) ~~ nil
			ifTrue: [ repos add: repo ]].
	^repos
]

{ #category : #'accessing spec' }
GTMetacellerItem >> requires [
	^self propertyAt: #requires ifAbsent: [ self referenceSpec requires asSet ]
]

{ #category : #'accessing spec' }
GTMetacellerItem >> requires: aString [ 
	self propertyAt: #requires put: (self arrayFrom: self requires with: aString)
]

{ #category : #'accessing spec' }
GTMetacellerItem >> resetProperties [
	self parent
		ifNil: [ 
			self specAccessors do: [ :each | 
				self propertyAt: each put: nil ] ]
		ifNotNilDo: [ :parent |
			self specAccessors do: [ :each | 
				self propertyAt: each put: (parent dataFor: each) ] ].

]

{ #category : #actions }
GTMetacellerItem >> resetValidated [
	warnings := nil.
	errors := nil.
	isValidated := false
]

{ #category : #actions }
GTMetacellerItem >> saveVersion [
	self version saveWithItem: self
]

{ #category : #actions }
GTMetacellerItem >> saveWithSpecString: aString [ 
	" create a copy "
	| specModifier |
	specModifier := GTSpecModifier on: (self copy resetProperties; yourself).
	" and perform the string "
	(nil class compiler
		source: aString;
		context: specModifier;
		receiver: specModifier;
		requestor: specModifier;
		evaluate).
	specModifier item saveVersion
]

{ #category : #'code generation' }
GTMetacellerItem >> specAccessors [
	^#( includes requires )
]

{ #category : #accessing }
GTMetacellerItem >> specName [
	^self referenceSpec name
]

{ #category : #'code generation' }
GTMetacellerItem >> specString [
	^String codeStreamContents: [ :s |
		s startCascade: 'aSpec'.
		(self version generatedItemFor: self itemName)
			ifNil: [ s currentOpenTag assign: self itemKindString value: self itemName ]
			ifNotNilDo: [ :gen | gen streamSpecOn: s specName: 'aSpec' ] ]
]

{ #category : #actions }
GTMetacellerItem >> testValid [
]

{ #category : #accessing }
GTMetacellerItem >> traceToRoot [
	^self traceToRoot: OrderedCollection new
]

{ #category : #accessing }
GTMetacellerItem >> traceToRoot: aCollection [ 
	self parentTrace ifNil: [ ^aCollection ].
	^(self parentTrace traceToRoot: aCollection)
		add: self parentTrace;
		yourself
]

{ #category : #actions }
GTMetacellerItem >> validate [
]

{ #category : #accessing }
GTMetacellerItem >> version [
	^version
]

{ #category : #accessing }
GTMetacellerItem >> warningText [
	self hasErrors
		ifTrue: [
			| retVal |
			retVal := Text string: self itemName attribute: TextColor red.
			self errors do: [ :each |
				retVal append: String cr; append: (Text string: each attribute: TextColor red) ].
			^retVal ].
	self hasWarnings ifTrue: [ 
		| retVal |
		retVal := Text string: self itemName attribute: TextColor orange.
			self warnings do: [ :each |
				retVal append: String cr; append: (Text string: each attribute: TextColor orange) ].
		^retVal ].
	^self itemName
	
]

{ #category : #accessing }
GTMetacellerItem >> warnings [
	^warnings ifNil: [ warnings := OrderedCollection new ]
]

{ #category : #tool }
GTMetacellerItem >> wrapperFor: aSpec version: aVersion [
	(self isProject: aSpec) ifTrue: [  ^GTMetacellerProjectReference on: aVersion spec: aSpec ].
	(self isGroup: aSpec) ifTrue: [  ^GTMetacellerGroup on: aVersion spec: aSpec ].
	(self isPackage: aSpec) ifTrue: [ ^GTMetacellerPackage on: aVersion spec: aSpec ].
	^aSpec
]
