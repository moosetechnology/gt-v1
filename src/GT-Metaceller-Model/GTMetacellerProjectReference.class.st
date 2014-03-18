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

{ #category : #accessing }
GTMetacellerProjectReference >> configForProject [
	| projectReference |
	projectReference := self projectReference.
	projectReference ifNil: [  ^nil ].
	projectReference className ifNil: [  ^nil ].
	^Smalltalk at: (projectReference className asSymbol) ifAbsent: [ nil ]
]

{ #category : #accessing }
GTMetacellerProjectReference >> file [
	^self project file
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

{ #category : #accessing }
GTMetacellerProjectReference >> project [
	^self referenceSpec
]

{ #category : #accessing }
GTMetacellerProjectReference >> projectReference [
	self project ifNil: [  ^nil ].
	(self project isKindOf: MetacelloProjectReferenceSpec)
		ifTrue: [ ^self project projectReference ]
		ifFalse: [ ^self project ]
]

{ #category : #actions }
GTMetacellerProjectReference >> testValid [
	self fetchConfiguration.
	^super testValid
]

{ #category : #actions }
GTMetacellerProjectReference >> validate [
	self halt.
]

{ #category : #accessing }
GTMetacellerProjectReference >> versionString [
	^self project versionString
]
