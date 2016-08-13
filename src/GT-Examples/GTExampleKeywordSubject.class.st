Class {
	#name : #GTExampleKeywordSubject,
	#superclass : #GTAbstractExampleSubject,
	#instVars : [
		'keyword'
	],
	#category : #'GT-Examples-Subjects'
}

{ #category : #'instance creation' }
GTExampleKeywordSubject class >> fromString: aString [
	^ self new 
		keyword: aString;
		yourself
]

{ #category : #'instance creation' }
GTExampleKeywordSubject class >> fromSymbol: aSymbol [
	^ self new 
		keyword: aSymbol;
		yourself
]

{ #category : #testing }
GTExampleKeywordSubject >> = anExampleSubject [
	^ self class = anExampleSubject class
		and: [ self keyword = anExampleSubject keyword ]
]

{ #category : #testing }
GTExampleKeywordSubject >> exists [
	^ true
]

{ #category : #UI }
GTExampleKeywordSubject >> gtDisplayOn: aStream [
	self keyword gtDisplayOn: aStream
]

{ #category : #testing }
GTExampleKeywordSubject >> hasLiteralThorough: aLiteral [
	^ self keyword = aLiteral
		or: [ self keyword asString asLowercase = aLiteral asString asLowercase ]
]

{ #category : #testing }
GTExampleKeywordSubject >> hash [
	^ self class hash
		bitXor: self keyword hash
]

{ #category : #accessing }
GTExampleKeywordSubject >> keyword [
	^ keyword
]

{ #category : #accessing }
GTExampleKeywordSubject >> keyword: anObject [
	keyword := anObject
]
