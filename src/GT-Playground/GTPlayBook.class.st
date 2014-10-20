Class {
	#name : #GTPlayBook,
	#superclass : #Object,
	#instVars : [
		'pages'
	],
	#classVars : [
		'instance'
	],
	#category : #'GT-Playground'
}

{ #category : #'as yet unclassified' }
GTPlayBook class >> cacheDirectory [
	^ 'play-cache/' asFileReference ensureCreateDirectory
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
