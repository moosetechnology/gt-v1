Class {
	#name : #GTExampleTextSubject,
	#superclass : #GTAbstractExampleSubject,
	#instVars : [
		'text'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTExampleTextSubject >> = anExampleSubject [
	^ super = anExampleSubject
		and: [ self text = anExampleSubject text ]
]

{ #category : #testing }
GTExampleTextSubject >> exists [
	^ true
]

{ #category : #UI }
GTExampleTextSubject >> gtDisplayOn: aStream [
	self text gtDisplayOn: aStream
]

{ #category : #testing }
GTExampleTextSubject >> hasLiteralThorough: aLiteral [
	^ self text = aLiteral
		or: [ self text includesSubstring: aLiteral asString caseSensitive: false ]
]

{ #category : #testing }
GTExampleTextSubject >> hash [
	^ super hash
		bitXor: self text hash
]

{ #category : #accessing }
GTExampleTextSubject >> text [
	^ text
]

{ #category : #accessing }
GTExampleTextSubject >> text: anObject [
	text := anObject
]
