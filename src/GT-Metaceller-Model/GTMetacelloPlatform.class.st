Class {
	#name : #GTMetacelloPlatform,
	#superclass : #MetacelloPlatform,
	#instVars : [
		'originalPlatform',
		'platformDescription'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #private }
GTMetacelloPlatform class >> defaultPlatformDescription [
	(self current isKindOf: self) ifFalse: [ self initialize ].
	^self current platformDescription
]

{ #category : #private }
GTMetacelloPlatform class >> defaultPlatformDescription: aGTPlatformDescription [ 
	(self current isKindOf: self) ifFalse: [ self initialize ].
	^self current platformDescription: aGTPlatformDescription 
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

{ #category : #utilities }
GTMetacelloPlatform >> authorName [
	^self originalPlatform authorName
]

{ #category : #utilities }
GTMetacelloPlatform >> authorName: aValue [
	^self originalPlatform authorName: aValue
]

{ #category : #accessing }
GTMetacelloPlatform >> bypassGoferLoadUpdateCategories [
	^self originalPlatform bypassGoferLoadUpdateCategories
]

{ #category : #accessing }
GTMetacelloPlatform >> bypassGoferLoadUpdateCategories: anObject [
	^self originalPlatform bypassGoferLoadUpdateCategories: anObject
]

{ #category : #accessing }
GTMetacelloPlatform >> bypassProgressBars [
	^self originalPlatform bypassProgressBars
]

{ #category : #accessing }
GTMetacelloPlatform >> bypassProgressBars: anObject [
	^self originalPlatform bypassProgressBars: anObject
]

{ #category : #caching }
GTMetacelloPlatform >> clearCurrentVersionCache [
	^self originalPlatform clearCurrentVersionCache
]

{ #category : #notification }
GTMetacelloPlatform >> collection: aCollection do: aBlock displaying: aString [
	^self originalPlatform collection: aCollection do: aBlock displaying: aString
]

{ #category : #'user interaction' }
GTMetacelloPlatform >> confirm: aString [
	^self originalPlatform confirm: aString
]

{ #category : #reflection }
GTMetacelloPlatform >> copyClass: oldClass as: newName inCategory: newCategoryName [
	^self originalPlatform copyClass: oldClass as: newName inCategory: newCategoryName
]

{ #category : #'repository creation' }
GTMetacelloPlatform >> createRepository: aRepositorySpec [
	^self originalPlatform createRepository: aRepositorySpec
]

{ #category : #'file system' }
GTMetacelloPlatform >> defaultDirectory [
	^self originalPlatform defaultDirectory
]

{ #category : #accessing }
GTMetacelloPlatform >> defaultPlatformAttributes [
	self platformDescription ifNil: [ ^self originalPlatform defaultPlatformAttributes ].
	^self platformDescription attributes
]

{ #category : #tests }
GTMetacelloPlatform >> defaultTimeout [
	^self originalPlatform defaultTimeout
]

{ #category : #'file system' }
GTMetacelloPlatform >> directoryFromPath: adirectoryPath relativeTo: anotherDirectoryPath [
	^ self originalPlatform directoryFromPath: adirectoryPath relativeTo: anotherDirectoryPath
]

{ #category : #notification }
GTMetacelloPlatform >> do: aBlock displaying: aString [
	^self originalPlatform do: aBlock displaying: aString
]

{ #category : #'github support' }
GTMetacelloPlatform >> downloadFile: url to: outputFileName [
	^ self originalPlatform downloadFile: url to: outputFileName
]

{ #category : #'file system' }
GTMetacelloPlatform >> ensureDirectoryExists: aDirectoryHandle [
	^self originalPlatform ensureDirectoryExists: aDirectoryHandle
]

{ #category : #'github support' }
GTMetacelloPlatform >> extractRepositoryFrom: zipFile to: directory [
	^self originalPlatform extractRepositoryFrom: zipFile to: directory
]

{ #category : #'repository creation' }
GTMetacelloPlatform >> extractTypeFromDescription: description [

	^self originalPlatform extractTypeFromDescription: description

]

{ #category : #'github support' }
GTMetacelloPlatform >> fileDirectoryClass [
	^self originalPlatform fileDirectoryClass
]

{ #category : #'file system' }
GTMetacelloPlatform >> fileHandleOn: aPath [
	^self originalPlatform fileHandleOn: aPath
]

{ #category : #reflection }
GTMetacelloPlatform >> globalNamed: globalName [

	^self originalPlatform globalNamed: globalName
]

{ #category : #reflection }
GTMetacelloPlatform >> globalNamed: globalName ifAbsent: absentBlock [

	^self originalPlatform globalNamed: globalName ifAbsent: absentBlock
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

{ #category : #'file system' }
GTMetacelloPlatform >> parentDirectoryOf: aFileHandler [
	^self originalPlatform parentDirectoryOf: aFileHandler
]

{ #category : #accessing }
GTMetacelloPlatform >> platformDescription [
	^platformDescription
]

{ #category : #accessing }
GTMetacelloPlatform >> platformDescription: aGTPlatformDescription [ 
	platformDescription := aGTPlatformDescription
]

{ #category : #caching }
GTMetacelloPlatform >> primeStackCacheFor: cacheName doing: noArgBlock defaultDictionary: aDictionary [
	^self originalPlatform primeStackCacheFor: cacheName doing: noArgBlock defaultDictionary: aDictionary
]

{ #category : #caching }
GTMetacelloPlatform >> primeStackCacheWith: aDictionary doing: noArgBlock [
	^self originalPlatform primeStackCacheWith: aDictionary doing: noArgBlock
]

{ #category : #'file system' }
GTMetacelloPlatform >> readStreamOn: aFileHandle do: aBlock [
	^self originalPlatform readStreamOn: aFileHandle do: aBlock
]

{ #category : #'file system' }
GTMetacelloPlatform >> recursiveDelete: aDirectory [
	^self originalPlatform recursiveDelete: aDirectory
]

{ #category : #caching }
GTMetacelloPlatform >> stackCacheFor: cacheName at: key doing: aBlock [
	^self originalPlatform stackCacheFor: cacheName at: key doing: aBlock
]

{ #category : #caching }
GTMetacelloPlatform >> stackCacheFor: cacheName cacheClass: cacheClass at: key doing: aBlock [

	^self originalPlatform stackCacheFor: cacheName cacheClass: cacheClass at: key doing: aBlock

]

{ #category : #utilities }
GTMetacelloPlatform >> timestamp [

	^self originalPlatform timestamp
]

{ #category : #transactions }
GTMetacelloPlatform >> transact: aBlock [

	^self originalPlatform transact: aBlock
]

{ #category : #caching }
GTMetacelloPlatform >> useStackCacheDuring: aBlock defaultDictionary: defaultDictionary [
	^self originalPlatform useStackCacheDuring: aBlock defaultDictionary: defaultDictionary
]
