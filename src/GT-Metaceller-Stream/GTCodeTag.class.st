Class {
	#name : #GTCodeTag,
	#superclass : #Object,
	#instVars : [
		'codeStream',
		'parent',
		'currentTag',
		'closed',
		'isOpen'
	],
	#category : #'GT-Metaceller-Stream'
}

{ #category : #'instance creation' }
GTCodeTag class >> on: aStream [
	^self new
		codeStream: aStream;
		yourself
]

{ #category : #generating }
GTCodeTag >> afterOpenSubTag [
]

{ #category : #generating }
GTCodeTag >> beforeOpenSubTag [
	self open
]

{ #category : #generating }
GTCodeTag >> close [
	self closed ifFalse: [ 
		self currentTag ifNotNilDo: [ :tag | tag close ].
		self closeTag.
		closed := true ]
]

{ #category : #generating }
GTCodeTag >> closeTag [
]

{ #category : #generating }
GTCodeTag >> closeTag: aTag [
	aTag = self currentTag ifTrue: [ 
		self currentTag close.
		currentTag := nil ]
]

{ #category : #accessing }
GTCodeTag >> closed [
	^closed ifNil: [ false ]
]

{ #category : #accessing }
GTCodeTag >> codeStream [
	^ codeStream
]

{ #category : #accessing }
GTCodeTag >> codeStream: anObject [
	codeStream := anObject.
	parent := codeStream currentOpenTag
]

{ #category : #accessing }
GTCodeTag >> currentOpenTag [
	self currentTag ifNil: [ ^self ].
	^self currentTag currentOpenTag
]

{ #category : #accessing }
GTCodeTag >> currentTag [
	currentTag ifNil: [ ^nil ].
	currentTag closed ifTrue: [ currentTag := nil ].
	^ currentTag
]

{ #category : #generating }
GTCodeTag >> currentTag: aTag [
	self openSubTag.
	currentTag := aTag

]

{ #category : #accessing }
GTCodeTag >> isOpen [
	^isOpen ifNil: [ false ]
]

{ #category : #generating }
GTCodeTag >> nextLine [
	self parent
		ifNil: [ 
			self stream cr.
			self putTabs ]
		ifNotNil: [ self parent nextLine ]
]

{ #category : #generating }
GTCodeTag >> open [
	self isOpen ifFalse: [ self openTag ].
	isOpen := true.
]

{ #category : #generating }
GTCodeTag >> open: aTag [
	self open.
	self currentTag ifNil: [ self currentTag: aTag. ^aTag ].
	^self currentTag open: aTag
]

{ #category : #generating }
GTCodeTag >> openSubTag [
	self beforeOpenSubTag.
	self afterOpenSubTag
]

{ #category : #generating }
GTCodeTag >> openTag [
]

{ #category : #accessing }
GTCodeTag >> parent [
	^ parent
]

{ #category : #generating }
GTCodeTag >> putTabs [
	self stream tab.
	self currentTag ifNotNilDo: [ :tag | tag putTabs ]
]

{ #category : #accessing }
GTCodeTag >> stream [
	^ codeStream stream
]

{ #category : #generating }
GTCodeTag >> with: aBlock [
	aBlock value.
	self close
]
