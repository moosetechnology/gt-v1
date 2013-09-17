Class {
	#name : #GTMetacellerPackage,
	#superclass : #GTMetacellerItem,
	#instVars : [
		'isNewer',
		'isOlder'
	],
	#category : #'GT-Metaceller'
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

{ #category : #accessing }
GTMetacellerPackage >> file [
	^self packageSpec file
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

{ #category : #printing }
GTMetacellerPackage >> printVersionOn: aStream [ 
	aStream nextPutAll: 'package: '''; nextPutAll: self name; nextPutAll: ''' with: '''; nextPutAll: self loadedVersionName; nextPutAll: ''''
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
