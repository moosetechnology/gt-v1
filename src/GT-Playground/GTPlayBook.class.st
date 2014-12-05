"
This class holds the pages that are loaded in the image.

At class initialization time, it loads pages from the cacheDirectory and then maintains the pages in memory.
"
Class {
	#name : #GTPlayBook,
	#superclass : #Object,
	#instVars : [
		'pages'
	],
	#classVars : [
		'instance'
	],
	#classInstVars : [
		'cacheDirectory'
	],
	#category : #'GT-Playground'
}

{ #category : #accessing }
GTPlayBook class >> cacheDirectory [
	^ cacheDirectory 
		ifNil: [cacheDirectory := self defaultCacheDirectory]
		ifNotNil: [ cacheDirectory exists 
			ifTrue: [ cacheDirectory ]
			ifFalse: [ cacheDirectory := self defaultCacheDirectory ] ]
]

{ #category : #accessing }
GTPlayBook class >> cacheDirectory: aString [ 
	cacheDirectory := aString asFileReference
]

{ #category : #protocol }
GTPlayBook class >> cleanUp [
	
	instance := nil
]

{ #category : #accessing }
GTPlayBook class >> defaultCacheDirectory [
	^ 'play-cache/' asFileReference ensureCreateDirectory
]

{ #category : #accessing }
GTPlayBook class >> instance [
	^ instance ifNil: [ instance := self new ]
]

{ #category : #protocol }
GTPlayBook class >> reset [
	
	instance := nil
]

{ #category : #accessing }
GTPlayBook >> addPage: aPage [
	self pages addFirst: aPage
]

{ #category : #accessing }
GTPlayBook >> addPageIfInteresting: aPage [
	aPage content asString trimBoth isEmpty ifTrue: [ ^ self ].
	self addPage: aPage
]

{ #category : #ui }
GTPlayBook >> gtPagesIn: composite [
	<gtInspectorPresentationOrder: 0>
	composite list 
		title: 'Pages';
		display: [ self pages ];
		format: #gtDisplayString;
		filterOn: [ :text :each | text match: each content]
]

{ #category : #accessing }
GTPlayBook >> initialize [
	|files|
	files := ((self class cacheDirectory files 
		select: [ :each | each extension = 'ph' ])).
	files size > 100 ifTrue: [files := files first: 100]. 
	pages := (files collect: [ :each | GTPlayPage new content: (each readStreamDo: #contents) ]) asOrderedCollection 
]

{ #category : #accessing }
GTPlayBook >> pages [
	^ pages
]

{ #category : #accessing }
GTPlayBook >> pages: anObject [
	pages := anObject
]

{ #category : #accessing }
GTPlayBook >> removePage: aPage [
	self pages remove: aPage
]
