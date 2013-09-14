Class {
	#name : #GTMetacelloPlatform,
	#superclass : #MetacelloPlatform,
	#instVars : [
		'originalPlatform',
		'platformSelector'
	],
	#category : #'GT-Metaceller'
}

{ #category : #'instance creation' }
GTMetacelloPlatform class >> defaultPlatformSelector [
	(self current isKindOf: self) ifFalse: [ self initialize ].
	^self current platformSelector
]

{ #category : #'instance creation' }
GTMetacelloPlatform class >> defaultPlatformSelector: aSymbol [
	(self current isKindOf: self) ifFalse: [ self initialize ].
	self current platformSelector: aSymbol
]

{ #category : #initialization }
GTMetacelloPlatform class >> initialize [
	"
	GTMetacelloPlatform initialize
	"
	Current := self on: Current
]

{ #category : #'instance creation' }
GTMetacelloPlatform class >> new [
	" this platform should always be created with a default platform "
	^self shouldNotImplement
]

{ #category : #'instance creation' }
GTMetacelloPlatform class >> on: aPlatform [
	^self basicNew
		initialize: aPlatform;
		yourself
]

{ #category : #private }
GTMetacelloPlatform class >> platforms [
	(self current isKindOf: self) ifFalse: [ self initialize ].
	^self current platforms
]

{ #category : #accessing }
GTMetacelloPlatform >> defaultPlatformAttributes [
	self platformSelector ifNil: [ ^self originalPlatform defaultPlatformAttributes ].
	^self perform: self platformSelector
]

{ #category : #private }
GTMetacelloPlatform >> gemstone24Attributes [
	^#( #gemstone #'gs2.4.x' )
]

{ #category : #private }
GTMetacelloPlatform >> gemstone30Attributes [
	^#( #gemstone #'gs3.x' #'gs3.0.x' )
]

{ #category : #private }
GTMetacelloPlatform >> gemstone31Attributes [
	^#( #gemstone #'gs3.x' #'gs3.1.x' )
]

{ #category : #initialization }
GTMetacelloPlatform >> initialize: aPlatform [
	self initialize.
	originalPlatform := aPlatform
]

{ #category : #accessing }
GTMetacelloPlatform >> originalPlatform [
	^originalPlatform
]

{ #category : #private }
GTMetacelloPlatform >> pharo13Attributes [
	^#( #'squeakcommon' #'pharo' #'pharo1.x' #'pharo1.3' )
]

{ #category : #private }
GTMetacelloPlatform >> pharo14Attributes [
	^#( #'squeakcommon' #'pharo' #'pharo1.x' #'pharo1.4' )
]

{ #category : #private }
GTMetacelloPlatform >> pharo20Attributes [
	^#( #'squeakcommon' #'pharo' #'pharo2.x' #'pharo2.0' )
]

{ #category : #private }
GTMetacelloPlatform >> pharo30Attributes [
	^#( #'squeakcommon' #'pharo' #'pharo3.x' #'pharo3.0' )
]

{ #category : #private }
GTMetacelloPlatform >> platformSelector [
	^platformSelector
]

{ #category : #private }
GTMetacelloPlatform >> platformSelector: aSymbol [ 
	platformSelector := aSymbol
]

{ #category : #private }
GTMetacelloPlatform >> platforms [
	^#( #gemstone24 #gemstone30 #gemstone31 #squeak #pharo13 #pharo14 #pharo20 #pharo30 )
]

{ #category : #private }
GTMetacelloPlatform >> squeakAttributes [
	^#( #'squeakcommon' #'squeak' )
]
