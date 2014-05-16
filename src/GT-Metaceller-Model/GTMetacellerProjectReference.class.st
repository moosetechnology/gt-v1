Class {
	#name : #GTMetacellerProjectReference,
	#superclass : #GTMetacellerItem,
	#instVars : [
		'children'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #accessing }
GTMetacellerProjectReference >> buildChildren [
	" here we return the 'labels' referenced by this project "
	| projectVersion |
	self isLoaded ifFalse: [ ^#() ].
	projectVersion := self projectReference versionOrNil.
	projectVersion ifNil: [  ^#() ].
	(self projectReference loads) ifNil: [ ^projectVersion spec packages packageSpecsInLoadOrder
		collect: [ :each | self wrapperFor: each version: projectVersion ] ].
	" here we need to resolve what loads means ... since metacello does not have an easy way to determin this. "
	^self calculateProjectReferences
	
]

{ #category : #accessing }
GTMetacellerProjectReference >> calculateProjectReferences [
	" calculate all packages and such from the referred project "
	| projectVersion retVal |
	projectVersion := self projectReference versionOrNil.
	retVal := OrderedCollection new.
	self projectReference loads do: [ :each |
		self addAll: each to: retVal version: projectVersion ].
	^retVal collect: [ :each | self wrapperFor: each version: projectVersion ]
]

{ #category : #accessing }
GTMetacellerProjectReference >> children [
	" here we return the 'labels' referenced by this project "
	^children ifNil: [ children := self buildChildren ]
]

{ #category : #'accessing spec' }
GTMetacellerProjectReference >> className [
	^self propertyAt: #className ifAbsent: [ self projectReference className ]
]

{ #category : #'accessing spec' }
GTMetacellerProjectReference >> className: aString [
	^self propertyAt: #className put: aString
]

{ #category : #'code generation' }
GTMetacellerProjectReference >> compare: aProjectRef toLoadList: aLoadList [
	(self versionString = aProjectRef versionString) ifFalse: [
		aLoadList addError: 'Incompatible versions' myValue: self versionString asString otherValue: aProjectRef versionString asString between: self and: aProjectRef.
		^nil ].
	(self repositoriesEqualTo: aProjectRef repositories) ifFalse: [
		aLoadList addWarning: 'Incompatible versions' myValue: self repositories asString otherValue: aProjectRef repositories asString between: self and: aProjectRef ]
]

{ #category : #accessing }
GTMetacellerProjectReference >> configForProject [
	self configNameForProject
		ifNil: [ ^nil ]
		ifNotNilDo: [ :configName |
			^Smalltalk at: configName ifAbsent: [ nil ] ]
]

{ #category : #accessing }
GTMetacellerProjectReference >> configNameForProject [
	| projectReference |
	projectReference := self projectReference.
	projectReference ifNil: [  ^nil ].
	projectReference className ifNil: [  ^nil ].
	^projectReference className asSymbol
]

{ #category : #'code generation' }
GTMetacellerProjectReference >> defaultItemKindString [
	^'project'
]

{ #category : #'accessing spec' }
GTMetacellerProjectReference >> file [
	^self propertyAt: #file ifAbsent: [ self fileReference ]
]

{ #category : #'accessing spec' }
GTMetacellerProjectReference >> file: aString [
	^self propertyAt: #file put: aString
]

{ #category : #'accessing spec' }
GTMetacellerProjectReference >> fileReference [
	| retVal |
	retVal := self referenceSpec file.
	(retVal = self referenceSpec className) ifTrue: [ ^nil ].
	^retVal
]

{ #category : #testing }
GTMetacellerProjectReference >> isCompatibleWith: anItem [
	(super isCompatibleWith: anItem) ifFalse: [ ^false ].
	^(self configNameForProject = anItem configNameForProject)
]

{ #category : #testing }
GTMetacellerProjectReference >> isLoaded [
	^self configForProject notNil
]

{ #category : #testing }
GTMetacellerProjectReference >> isProject [
	^true
]

{ #category : #accessing }
GTMetacellerProjectReference >> label [
	^self project label
]

{ #category : #display }
GTMetacellerProjectReference >> labelAsText [
	| attributes |
	attributes := OrderedCollection new.
	(self isLoaded) ifTrue: [ attributes add: TextEmphasis underlined ].
	attributes add: TextColor blue.
	self versionString 
		ifNil: [ ^(Text string: self  label attributes: attributes), (Text string: ' No version' attribute: TextColor red) ]
		ifNotNil: [ ^(Text string: self label attributes: attributes), (Text string: (' ', self versionString) attribute: TextColor blue) ].
	
]

{ #category : #actions }
GTMetacellerProjectReference >> loadConfiguration [
	[ :job |
		job title: 'Ensuring configuration of ', self projectReference name,' loaded.'.
		self projectReference ensureProjectLoaded ] asJob run
]

{ #category : #'accessing spec' }
GTMetacellerProjectReference >> loads [
	^self propertyAt: #loads ifAbsent: [ ^self projectReference loads ]
]

{ #category : #'accessing spec' }
GTMetacellerProjectReference >> loads: aString [
	^self propertyAt: #loads put: aString
]

{ #category : #'code generation' }
GTMetacellerProjectReference >> mergeSpec: anItem [
	^self projectReference mergeSpec: anItem projectReference
]

{ #category : #'accessing spec' }
GTMetacellerProjectReference >> postLoadDoIt [
	^self propertyAt: #preLoadDoIt ifAbsent: [ self referenceSpec preLoadDoIt ]
]

{ #category : #'accessing spec' }
GTMetacellerProjectReference >> postLoadDoIt: aString [
	^self propertyAt: #preLoadDoIt put: aString
]

{ #category : #'accessing spec' }
GTMetacellerProjectReference >> preLoadDoIt [
	^self propertyAt: #preLoadDoIt ifAbsent: [ self referenceSpec preLoadDoIt ]
]

{ #category : #'accessing spec' }
GTMetacellerProjectReference >> preLoadDoIt: aString [
	^self propertyAt: #preLoadDoIt put: aString
]

{ #category : #printing }
GTMetacellerProjectReference >> printVersionOn: aStream [
	| configClass |
	self referenceSpec projectReference className
		ifNil: [ configClass := nil. ]
		ifNotNil: [ configClass := Smalltalk at: self referenceSpec projectReference className asSymbol ifAbsent: [ nil ] ].
	aStream nextPutAll: 'project: '''; nextPutAll: self name; nextPutAll: ''' with: '.
	configClass
		ifNil: [ aStream nextPutAll: self referenceSpec projectReference versionString printString ]
		ifNotNil: [ aStream nextPut: $';
			nextPutAll: (configClass project version: self referenceSpec projectReference versionString) versionNumber printString;
			nextPut: $' ]
]

{ #category : #'accessing spec' }
GTMetacellerProjectReference >> project [
	^self referenceSpec
]

{ #category : #'accessing spec' }
GTMetacellerProjectReference >> projectReference [
	self referenceSpec ifNil: [  ^nil ].
	(self referenceSpec isKindOf: MetacelloProjectReferenceSpec)
		ifTrue: [ ^self referenceSpec projectReference ]
		ifFalse: [ ^self referenceSpec ]
]

{ #category : #testing }
GTMetacellerProjectReference >> repositoriesEqualTo: aList [
	^aList repositoryDescriptions asSet = (self repositories repositoryDescriptions) asSet
]

{ #category : #actions }
GTMetacellerProjectReference >> resetValidated [
	super resetValidated.
	children := nil
]

{ #category : #'code generation' }
GTMetacellerProjectReference >> specAccessors [
	^#( versionString className file postLoadDoIt preLoadDoIt loads )
]

{ #category : #'accessing spec' }
GTMetacellerProjectReference >> supplyingAnswers [
	^self propertyAt: #supplyingAnswers ifAbsent: [ self referenceSpec answers ]
]

{ #category : #'accessing spec' }
GTMetacellerProjectReference >> supplyingAnswers: aString [
	^self propertyAt: #supplyingAnswers put: aString
]

{ #category : #actions }
GTMetacellerProjectReference >> testValid [
	self loadConfiguration.
	^super testValid
]

{ #category : #actions }
GTMetacellerProjectReference >> validate [
	| loadList |
	loadList := self loadList.
	self errors addAll: loadList errors.
	self warnings addAll: loadList warnings.
	^loadList
]

{ #category : #'accessing spec' }
GTMetacellerProjectReference >> versionString [
	^self propertyAt: #versionString ifAbsent: [ self referenceSpec versionString ]
]

{ #category : #'accessing spec' }
GTMetacellerProjectReference >> versionString: aString [
	^self propertyAt: #versionString put: aString
]

{ #category : #tool }
GTMetacellerProjectReference >> wrapperFor: aSpec version: aVersion [
	| retVal |
	retVal := super wrapperFor: aSpec version: aVersion.
	retVal parentTrace: self.
	^retVal
]
