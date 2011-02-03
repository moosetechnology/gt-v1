Class {
	#name : #GTPlaygroundPage,
	#superclass : #Object,
	#instVars : [
		'title',
		'content'
	],
	#category : #'GT-Tools'
}

{ #category : #accessing }
GTPlaygroundPage >> content [
	^ content
]

{ #category : #accessing }
GTPlaygroundPage >> content: anObject [
	content := anObject
]

{ #category : #accessing }
GTPlaygroundPage >> initialize [
	content := 'self'
]

{ #category : #accessing }
GTPlaygroundPage >> title [
	^ title
]

{ #category : #accessing }
GTPlaygroundPage >> title: anObject [
	title := anObject
]
