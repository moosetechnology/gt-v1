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

{ #category : #'as yet unclassified' }
GTPlayBook class >> cacheDirectory [
	^ cacheDirectory ifNil: [cacheDirectory := 'play-cache/' asFileReference ensureCreateDirectory]
]

{ #category : #accessing }
GTPlayBook class >> cacheDirectory: aString [ 
	cacheDirectory := aString asFileReference
]

{ #category : #'as yet unclassified' }
GTPlayBook class >> instance [
	^ instance ifNil: [ instance := self new ]
]

{ #category : #'as yet unclassified' }
GTPlayBook class >> reset [
	
	instance := nil
]

{ #category : #accessing }
GTPlayBook >> addPage: aPage [
	self pages addFirst: aPage
]

{ #category : #accessing }
GTPlayBook >> addPageIfInteresting: aPage [
	aPage content asString trimBoth isEmpty
		ifFalse: [ self addPage: aPage ]
]

{ #category : #accessing }
GTPlayBook >> initialize [
	pages := (self class cacheDirectory files 
		select: [ :each | each extension = 'ph' ] 
		thenCollect: [ :each | GTPlayPage new content: (each readStreamDo: #contents) ]) asOrderedCollection 
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
