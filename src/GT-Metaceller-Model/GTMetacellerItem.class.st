Class {
	#name : #GTMetacellerItem,
	#superclass : #GTMetacellerSpec,
	#instVars : [
		'version',
		'referenceSpec',
		'isValidated',
		'errors',
		'warnings',
		'properties'
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
GTMetacellerItem >> addError: aString [
	(self errors includes: aString)
		ifFalse: [ self errors add: aString ]
]

{ #category : #accessing }
GTMetacellerItem >> addWarning: aString [
	(self warnings includes: aString)
		ifFalse: [ self warnings add: aString ]
]

{ #category : #accessing }
GTMetacellerItem >> asString [
	^self referenceSpec asString 
]

{ #category : #accessing }
GTMetacellerItem >> children [
	^#()
]

{ #category : #'accessing spec' }
GTMetacellerItem >> dataFor: aSymbol [
	| retVal |
	retVal := self perform: aSymbol.
	retVal isCollection ifTrue: [ retVal ifEmpty: [ ^nil ] ].
	^retVal
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
GTMetacellerItem >> isDifferentFrom: anItem [
	self itemName = anItem itemName ifFalse: [ ^true ].
	self specAccessors do: [ :each |
		(self perform: each) = (anItem perform: each) ifFalse: [ ^true ] ].
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

{ #category : #accessing }
GTMetacellerItem >> itemName [
	^self referenceSpec name
]

{ #category : #accessing }
GTMetacellerItem >> labelAsText [
	^self referenceSpec label
]

{ #category : #'code generation' }
GTMetacellerItem >> mergeWith: anItem [
	| retVal |
	(self class == anItem class) ifFalse: [ GTMetacellerStateError signal: 'Cannot merge two items of different class.' ].
	retVal := self copy.
	retVal referenceSpec: (self referenceSpec mergeSpec: anItem referenceSpec).
	^retVal
]

{ #category : #accessing }
GTMetacellerItem >> name [
	^self referenceSpec name
]

{ #category : #accessing }
GTMetacellerItem >> platforms [
	^self version platformsFor: self
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

{ #category : #accessing }
GTMetacellerItem >> resetValidated [
	warnings := nil.
	errors := nil.
	isValidated := false
]

{ #category : #'code generation' }
GTMetacellerItem >> specAccessors [
	^#( includes requires )
]

{ #category : #accessing }
GTMetacellerItem >> specName [
	^self referenceSpec name
]

{ #category : #actions }
GTMetacellerItem >> testValid [
	" by default we should only need to validate "
	self validate
]

{ #category : #actions }
GTMetacellerItem >> validate [
	self subclassResponsibility
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
