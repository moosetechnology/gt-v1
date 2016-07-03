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
GTAbstractExampleSubject >> hasLiteralThorough: aLiteral [
	^ false
]
