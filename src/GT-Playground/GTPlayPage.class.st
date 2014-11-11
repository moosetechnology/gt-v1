"
It holds one page of code. It is the model behind the Playground.

It also knows how to store itself on disk, and every time its content changes, it updates the corresponding file.
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

{ #category : #ui }
GTPlayPage >> gtDisplayOn: stream [
	stream nextPutAll: (self content asString copyReplaceAll: String cr with: String space)
]

{ #category : #ui }
GTPlayPage >> gtInspectorContentIn: composite [
	<gtInspectorPresentationOrder: 0>
	composite pharoPlayground 
		title: 'Content';
		display: #content;
		installGoAction;
		installDefaultSelectionActions
]

{ #category : #accessing }
GTPlayPage >> initialize [
	content := ''.
	title := (DateAndTime now asString copyReplaceAll: ':' with: '-') copyReplaceAll: '.' with: '-'
]

{ #category : #accessing }
GTPlayPage >> publishUrl [
	| url |
	self content ifEmpty: [ 
		self inform: 'Nothing was published because the playground is empty'.
		^ self ].
	url := GTUrlProvider new post: self content.
	Clipboard clipboardText: url asString.
	self inform: url asString , ' was published and the url was copied to clipboard'
]

{ #category : #accessing }
GTPlayPage >> silentContent: aString [
	content := aString
]

{ #category : #accessing }
GTPlayPage >> title [
	^ title
]

{ #category : #accessing }
GTPlayPage >> title: anObject [
	title := anObject
]
