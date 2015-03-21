"
This class holds the pages that are loaded in the image.

At class initialization time, it loads pages from the cacheDirectory and then maintains the pages in memory.
"
Class {
	#name : #GTPlayBook,
	#superclass : #Object,
	#instVars : [
		'pages',
		'pagesLimit'
	],
	#classVars : [
		'instance'
	],
	#classInstVars : [
		'cacheDirectory',
		'customDirectory'
	],
	#category : #'GT-Playground'
}

{ #category : #accessing }
GTPlayBook class >> cacheDirectory [
	^ cacheDirectory 
		ifNil: [ cacheDirectory := self defaultCacheDirectory ]
		ifNotNil: [ cacheDirectory exists 
			ifTrue: [ cacheDirectory ]
			" the directory may be renamed/removed/moved at runtime - always fallback to the default directory "
			ifFalse: [ cacheDirectory := self defaultCacheDirectory ] ] 
]

{ #category : #accessing }
GTPlayBook class >> cacheDirectory: aStringOrFileReference [
	cacheDirectory := aStringOrFileReference ifNotNil: [ aStringOrFileReference asFileReference ].
]

{ #category : #protocol }
GTPlayBook class >> cleanUp [
	
	instance := nil
]

{ #category : #accessing }
GTPlayBook class >> customDirectory [
	^ customDirectory
]

{ #category : #accessing }
GTPlayBook class >> customDirectory: aStringOrFileReference [
	customDirectory := aStringOrFileReference ifNotNil: [ aStringOrFileReference asFileReference ].
	self initializeDirectories. " ugly side-effect, but we can't avoid it "
]

{ #category : #'accessing-defaults' }
GTPlayBook class >> defaultCacheDirectory [
	^ 'play-cache/' asFileReference ensureCreateDirectory
]

{ #category : #examples }
GTPlayBook class >> gtExampleEmpty [
	<example: 'Empty'>
	^ self new
]

{ #category : #initializing }
GTPlayBook class >> initialize [
	" we have to make sure the cached references are up-to-date after the image starts up "
	Smalltalk addToStartUpList: self
]

{ #category : #private }
GTPlayBook class >> initializeDirectories [
	" Recreate the cached file reference, init with setting if there is any and it is valid. This has to be failure/error-proof since it is performed during startup "
	" self initializeDirectories "
	cacheDirectory := nil.
	customDirectory isNil 
		ifTrue: [ ^ self ].
	customDirectory class = FileReference
		ifFalse: [ ^ self ].
	customDirectory exists 
		ifFalse: [ [ customDirectory ensureCreateDirectory ] on: PrimitiveFailed do: [ ^ self ] ].
	cacheDirectory := customDirectory
]

{ #category : #accessing }
GTPlayBook class >> instance [
	^ instance ifNil: [ instance := self new ]
]

{ #category : #protocol }
GTPlayBook class >> reset [
	
	instance := nil
]

{ #category : #private }
GTPlayBook class >> resetDirectories [
	" self resetDirectories "
	cacheDirectory := nil.
	customDirectory := nil
]

{ #category : #initializing }
GTPlayBook class >> startUp [
	self initializeDirectories
]

{ #category : #initializing }
GTPlayBook class >> startUp: resuming [
	self initializeDirectories
]

{ #category : #actions }
GTPlayBook >> addPage: aPage [
	self pages addFirst: aPage
]

{ #category : #actions }
GTPlayBook >> addPageIfInteresting: aPage [
	aPage isInteresting ifFalse: [ ^ self ].
	self addPage: aPage
]

{ #category : #'accessing-dynamic' }
GTPlayBook >> allFiles [
	^ self class cacheDirectory files select: [ :each | 
		each extension = GTPlayPage fileExtension ]
]

{ #category : #'accessing-dynamic' }
GTPlayBook >> allFilesSorted [
	^ self allFiles sorted: [ :a :b | 
		a modificationTime > b modificationTime ]
]

{ #category : #'accessing-defaults' }
GTPlayBook >> defaultPages [
	^ OrderedCollection new
]

{ #category : #'accessing-defaults' }
GTPlayBook >> defaultPagesLimit [
	" page list in ui might get too long / holding too many object might decrease performance "
	^ 100
]

{ #category : #'accessing-dynamic' }
GTPlayBook >> files [
	^ self allFilesSorted takeFirst: self pagesLimit
]

{ #category : #ui }
GTPlayBook >> gtPagesIn: composite [
	<gtInspectorPresentationOrder: 0>
	composite list 
		title: 'Pages';
		display: [ self pages ];
		format: #gtDisplayString;
		filterOn: [ :text :each | text match: each content ]
]

{ #category : #initializing }
GTPlayBook >> initialize [
	self flag: 'error handling'.
	
	self pages: self defaultPages.
	self files do: [ :each | 
		[ self pages add: (GTPlayPage fromFileReference: each) ] " bypass "
			on: Error 
			do: [ " unhandled exceptions are bad design - we should handle it somehow " ] ]
]

{ #category : #accessing }
GTPlayBook >> pages [
	^ pages ifNil: [ pages := self defaultPages ]
]

{ #category : #accessing }
GTPlayBook >> pages: anObject [
	pages := anObject
]

{ #category : #accessing }
GTPlayBook >> pagesLimit [
	^ pagesLimit ifNil: [ self defaultPagesLimit ]
]

{ #category : #accessing }
GTPlayBook >> pagesLimit: anObject [
	pagesLimit := anObject
]

{ #category : #'accessing-dynamic' }
GTPlayBook >> pagesSorted [
	^ self pages sorted: [ :a :b | 
		a modificationTime > b modificationTime ]
]

{ #category : #actions }
GTPlayBook >> removePage: aPage [
	self pages remove: aPage ifAbsent: [ " ignore if aPage is not registered " ]
]
