"
GTPlayground open
"
Class {
	#name : #GTPlayPage,
	#superclass : #Object,
	#instVars : [
		'title',
		'content'
	],
	#category : #'GT-Playground'
}

{ #category : #'compatibility-tools' }
GTPlayPage >> acceptContents: aString [

	self flag: #TODO. "Need support for what lies in the comment down here"
	"self fileName ifNotNil: [ self saveString: aString toFile: self fileName ].

	acceptAction ifNotNil:[acceptAction value: aString]."
	self content: aString.
	^ true
]

{ #category : #accessing }
GTPlayPage >> cacheDirectory [
	^ GTPlayBook cacheDirectory
]

{ #category : #accessing }
GTPlayPage >> content [
	^ content
]

{ #category : #accessing }
GTPlayPage >> content: aString [
	content := aString.
	aString isEmpty 
		ifTrue: [ self fileReference ensureDelete ]
		ifFalse: [ self fileReference writeStreamDo: [ :s | s nextPutAll: aString ] ]
]

{ #category : #accessing }
GTPlayPage >> fileReference [

	^ self cacheDirectory / (self title, '.ph')
]

{ #category : #'as yet unclassified' }
GTPlayPage >> gtInspectorContentIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite pharoPlayground 
		title: 'Content';
		display: #content
]

{ #category : #accessing }
GTPlayPage >> initialize [
	content := ''.
	title := (DateAndTime now asString copyReplaceAll: ':' with: '-') copyReplaceAll: '.' with: '-'
]

{ #category : #accessing }
GTPlayPage >> title [
	^ title
]

{ #category : #accessing }
GTPlayPage >> title: anObject [
	title := anObject
]
