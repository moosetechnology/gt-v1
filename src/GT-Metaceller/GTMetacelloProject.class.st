Class {
	#name : #GTMetacelloProject,
	#superclass : #MetacelloMCProject,
	#instVars : [
		'platformSelector'
	],
	#classInstVars : [
		'defaultPlatformSelector'
	],
	#category : #'GT-Metaceller'
}

{ #category : #'instance creation' }
GTMetacelloProject class >> defaultPlatformSelector [
	^defaultPlatformSelector
]

{ #category : #'instance creation' }
GTMetacelloProject class >> defaultPlatformSelector: aSymbol [
	defaultPlatformSelector := aSymbol
]

{ #category : #private }
GTMetacelloProject class >> platforms [
	^#( #gemstone #squeak #pharo13 #pharo14 #pharo20 #pharo30 )
]

{ #category : #'instance creation' }
GTMetacelloProject class >> template [
	^self basicNew
		platformSelector: self defaultPlatformSelector;
		yourself
]

{ #category : #private }
GTMetacelloProject >> attributes [
	^(OrderedCollection with: #common)
		addAll: (self perform: self platformSelector);
		yourself
]

{ #category : #private }
GTMetacelloProject >> gemstoneAttributes [
	^#( gemstone )
]

{ #category : #private }
GTMetacelloProject >> pharo13Attributes [
	^#( #'squeakcommon' #'pharo' #'pharo1.x' #'pharo1.3' )
]

{ #category : #private }
GTMetacelloProject >> pharo14Attributes [
	^#( #'squeakcommon' #'pharo' #'pharo1.x' #'pharo1.4' )
]

{ #category : #private }
GTMetacelloProject >> pharo20Attributes [
	^#( #'squeakcommon' #'pharo' #'pharo2.x' #'pharo2.0' )
]

{ #category : #private }
GTMetacelloProject >> pharo30Attributes [
	^#( #'squeakcommon' #'pharo' #'pharo3.x' #'pharo3.0' )
]

{ #category : #private }
GTMetacelloProject >> platformSelector [
	^platformSelector ifNil: [ #platformAttributes ]
]

{ #category : #private }
GTMetacelloProject >> platformSelector: aSymbol [ 
	platformSelector := aSymbol
]

{ #category : #private }
GTMetacelloProject >> squeakAttributes [
	^#( #'squeakcommon' #'squeak' )
]
