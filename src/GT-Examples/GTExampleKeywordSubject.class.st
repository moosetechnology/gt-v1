Class {
	#name : #GTExampleKeywordSubject,
	#superclass : #GTAbstractExampleSubject,
	#instVars : [
		'keyword'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTExampleKeywordSubject >> = anExampleSubject [
	^ super = anExampleSubject
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
	^ super hash
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
