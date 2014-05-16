Class {
	#name : #GTMetacellerPackage,
	#superclass : #GTMetacellerItem,
	#instVars : [
		'isNewer',
		'isOlder'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #accessing }
GTMetacellerPackage >> blessing [
	^self version blessing
]

{ #category : #testing }
GTMetacellerPackage >> calculateIsNewer [
	self file ifNil: [  ^false ].
	(self referenceSpec currentVersionInfo name = self file) ifTrue: [ ^false ].
	self referenceSpec currentVersionInfo allAncestorsDo: [ :each |
		(each name = self file) ifTrue: [ ^false ] ].
	^true
]

{ #category : #testing }
GTMetacellerPackage >> calculateIsOlder [
	(self file = self referenceSpec name) ifTrue: [  ^false ].	" no version specified "
	(self referenceSpec currentVersionInfo name = self file) ifTrue: [ ^false ].
	self referenceSpec currentVersionInfo allAncestorsDo: [ :each |
		(each name = self file) ifTrue: [ ^true ] ].
	^false
]

{ #category : #testing }
GTMetacellerPackage >> checkExistsIn: aRepositorySpecs [
	| references gofer |
	gofer := MetacelloGofer new.
	gofer disablePackageCache.
	(self repositoriesFrom: aRepositorySpecs ignoreOverrides: true) 
		do: [:repo | gofer repository: repo ].
	references := self referenceSpec goferPackage resolveAllWith: gofer.
	references ifEmpty: [ ^false ].
	references size > 1 ifTrue: [
		self hasStableBlessing ifTrue: [
			self addWarning: 'Version not unique. Assuming version ', references last name, ' is the correct version.' ] ].
	^true

]

{ #category : #'code generation' }
GTMetacellerPackage >> compare: aPackage toLoadList: aLoadList [
	(self file = aPackage file) ifTrue: [ ^self ].
	aLoadList addError: 'Incompatible versions' myValue: self file asString otherValue: aPackage file asString between: self and: aPackage.
	^nil
]

{ #category : #'code generation' }
GTMetacellerPackage >> defaultItemKindString [
	^'package'
]

{ #category : #'accessing spec' }
GTMetacellerPackage >> file [
	^self propertyAt: #file ifAbsent: [ self fileReference ]
]

{ #category : #'accessing spec' }
GTMetacellerPackage >> file: aString [ 
	self propertyAt: #file put: aString
]

{ #category : #'accessing spec' }
GTMetacellerPackage >> fileReference [
	| retVal |
	retVal := self referenceSpec file.
	(retVal = self referenceSpec name) ifTrue: [ ^nil ].
	^retVal
]

{ #category : #testing }
GTMetacellerPackage >> isCompatibleWith: anItem [
	(super isCompatibleWith: anItem) ifFalse: [ ^false ].
	^self name = anItem name
]

{ #category : #testing }
GTMetacellerPackage >> isLoaded [
	^self packageSpec isPackageLoaded
]

{ #category : #testing }
GTMetacellerPackage >> isNewer [
	^isNewer ifNil: [ isNewer := self calculateIsNewer ]
]

{ #category : #testing }
GTMetacellerPackage >> isOlder [
	^isOlder ifNil: [ isOlder := self calculateIsOlder ]
]

{ #category : #testing }
GTMetacellerPackage >> isPackage [
	^true
]

{ #category : #testing }
GTMetacellerPackage >> isValidated [
	^isValidated ifNil: [ false ]
]

{ #category : #accessing }
GTMetacellerPackage >> label [
	^self file ifNil: [ self packageSpec name ]
]

{ #category : #display }
GTMetacellerPackage >> labelAsText [
	| prefix |
	prefix := ''.
	self needsSaving ifTrue: [ prefix := '* ' ].
	^(Text fromString: prefix), (Text string: self label attributes: self textAttributes)
]

{ #category : #accessing }
GTMetacellerPackage >> loadedVersionName [
	self referenceSpec workingCopy ifNotNil: [
		^self referenceSpec workingCopy ancestry ancestorString ].
	^self referenceSpec file
]

{ #category : #'code generation' }
GTMetacellerPackage >> mergeWith: aPackage loadList: aLoadList [
	(self file = aPackage file) ifTrue: [ ^self ].
	aLoadList addError: 'Incompatible versions' myValue: self file asString otherValue: aPackage file asString between: self for: aPackage.
	^nil
]

{ #category : #testing }
GTMetacellerPackage >> needsSaving [
	self packageSpec workingCopy ifNotNilDo: [ :copy | ^copy needsSaving ].
	^false
]

{ #category : #accessing }
GTMetacellerPackage >> packageSpec [
	^self referenceSpec
]

{ #category : #'accessing spec' }
GTMetacellerPackage >> postLoadDoIt [
	^self propertyAt: #postLoadDoIt ifAbsent: [ self referenceSpec postLoadDoIt ]
]

{ #category : #'accessing spec' }
GTMetacellerPackage >> preLoadDoIt [
	^self propertyAt: #preLoadDoIt ifAbsent: [ self referenceSpec preLoadDoIt ]
]

{ #category : #printing }
GTMetacellerPackage >> printVersionOn: aStream [ 
	aStream nextPutAll: 'package: '''; nextPutAll: self name; nextPutAll: ''' with: '''; nextPutAll: self loadedVersionName; nextPutAll: ''''
]

{ #category : #accessing }
GTMetacellerPackage >> repositorySpecs [
	self referenceSpec hasRepository ifTrue: [ ^self referenceSpec repositorySpecs ].
	^self version repositorySpecs
]

{ #category : #'code generation' }
GTMetacellerPackage >> specAccessors [
	^#( file includes requires postLoadDoIt preLoadDoIt supplyingAnswers )
]

{ #category : #'accessing spec' }
GTMetacellerPackage >> supplyingAnswers [
	^self propertyAt: #supplyingAnswers ifAbsent: [ self referenceSpec answers ]
]

{ #category : #display }
GTMetacellerPackage >> textAttributes [
	| retVal |
	retVal := OrderedCollection new.
	self isLoaded ifTrue: [ 
		retVal add: TextEmphasis underlined.
		self isNewer ifTrue: [ retVal add: TextEmphasis bold ].
		self isOlder ifTrue: [  retVal add: TextColor gray ] ].
	^retVal
]

{ #category : #actions }
GTMetacellerPackage >> updateToCurrent [
	self isLoaded
		ifTrue: [ self file: self referenceSpec currentVersionInfo name ]
]

{ #category : #actions }
GTMetacellerPackage >> validate [
	self isValidated ifTrue: [ ^self ].
	isValidated := true.
	" check if the repository is correct "
	(self checkExistsIn: self repositorySpecs) 
		ifFalse: [ self addError: 'No valid repository for self ', self itemName, '.', String cr, 'Expected this package in one of the following repostories: ', self repositorySpecs asString ].
	self hasStableBlessing ifTrue: [ 
		" explicit filename should be provided"
		self file ifNil: [ self addWarning: 'No explicit filename in a stable version.' ] ].
	self hasBaselineBlessing ifTrue: [ 
		" explicit filename should not be provided"
		self file ifNotNil: [ self addWarning: 'Explicit filename in a baseline version.' ] ].
	" check the dependencies "
	self version validateDependencies: self.
	^self
]
