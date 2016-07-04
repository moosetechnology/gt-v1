Class {
	#name : #GTAbstractExampleSubject,
	#superclass : #Object,
	#category : #'GT-Examples-Utils'
}

{ #category : #converting }
GTAbstractExampleSubject >> asGTExampleSubject [
	^ self
]

{ #category : #testing }
GTAbstractExampleSubject >> exists [
	self subclassResponsibility
]

{ #category : #UI }
GTAbstractExampleSubject >> forNautilus: aBlock [
	
]

{ #category : #testing }
GTAbstractExampleSubject >> hasLiteralThorough: aLiteral [
	^ false
]
