Class {
	#name : #GTMetacellerPackage,
	#superclass : #GTMetacellerItem,
	#instVars : [
		'isNewer',
		'isOlder'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #testing }
GTMetacellerPackage >> calculateIsNewer [
	(self file = self referenceSpec name) ifTrue: [  ^false ].
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
		self addWarning: 'Assuming version ', references last name, ' is the correct version.' ].
	^true

]

{ #category : #'accessing spec' }
GTMetacellerPackage >> file [
	^self propertyAt: #file ifAbsent: [ self fileReference ]
]

{ #category : #'accessing spec' }
GTMetacellerPackage >> fileReference [
	| retVal |
	retVal := self referenceSpec file.
	(retVal = self referenceSpec name) ifTrue: [ ^nil ].
	^retVal
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

{ #category : #'code generation' }
GTMetacellerPackage >> itemKindString [
	^'package'
]

{ #category : #accessing }
GTMetacellerPackage >> label [
	^self file ifEmpty: [ self packageSpec name ]
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
GTMetacellerPackage >> validate [
	self isValidated ifTrue: [ ^self ].
	isValidated := true.
	" check if the repository is correct "
	(self checkExistsIn: self repositorySpecs) 
		ifFalse: [ self addError: 'No valid repository for self ', self itemName, '.', String cr, 'Expected this package in one of the following repostories: ', self repositorySpecs asString ].
	" check the dependencies "
	self version validateDependencies: self
	
]
