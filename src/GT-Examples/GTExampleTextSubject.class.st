"
I describe a plain text as a subject of an example.
"
Class {
	#name : #GTExampleTextSubject,
	#superclass : #GTExampleSubject,
	#instVars : [
		'text'
	],
	#category : #'GT-Examples-Subjects'
}

{ #category : #'instance creation' }
GTExampleTextSubject class >> fromString: aString [
	^ self new 
		text: aString;
		yourself
]

{ #category : #'instance creation' }
GTExampleTextSubject class >> fromText: aText [
	^ self fromString: aText asString
]

{ #category : #testing }
GTExampleTextSubject >> = anExampleSubject [
	^ self class = anExampleSubject class
		and: [ self text = anExampleSubject text ]
]

{ #category : #testing }
GTExampleTextSubject >> exists [
	^ true
]

{ #category : #testing }
GTExampleTextSubject >> hasLiteralThorough: aLiteral [
	^ self text = aLiteral
		or: [ self text includesSubstring: aLiteral asString caseSensitive: false ]
]

{ #category : #testing }
GTExampleTextSubject >> hash [
	^ self class hash
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
