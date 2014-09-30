"
GTPlayground open
"
Class {
	#name : #GTPlaygroundPage,
	#superclass : #Object,
	#instVars : [
		'title',
		'content'
	],
	#category : #'GT-Playground'
}

{ #category : #'compatibility-tools' }
GTPlaygroundPage >> acceptContents: aString [

	self flag: #TODO. "Need support for what lies in the comment down here"
	"self fileName ifNotNil: [ self saveString: aString toFile: self fileName ].

	acceptAction ifNotNil:[acceptAction value: aString]."
	self content: aString.
	^ true
]

{ #category : #accessing }
GTPlaygroundPage >> content [
	^ content
]

{ #category : #accessing }
GTPlaygroundPage >> content: anObject [
	content := anObject
]

{ #category : #'as yet unclassified' }
GTPlaygroundPage >> gtInspectorContentIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite pharoPlayground 
		title: 'Content';
		display: #content
]

{ #category : #accessing }
GTPlaygroundPage >> initialize [
	content := ''.
	title := 'Playground'
]

{ #category : #accessing }
GTPlaygroundPage >> title [
	^ title
]

{ #category : #accessing }
GTPlaygroundPage >> title: anObject [
	title := anObject
]
