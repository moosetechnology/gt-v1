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
GTPlayPage >> content [
	^ content
]

{ #category : #accessing }
GTPlayPage >> content: anObject [
	content := anObject
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
	title := 'Playground'
]

{ #category : #accessing }
GTPlayPage >> title [
	^ title
]

{ #category : #accessing }
GTPlayPage >> title: anObject [
	title := anObject
]
