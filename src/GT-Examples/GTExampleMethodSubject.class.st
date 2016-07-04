Class {
	#name : #GTExampleMethodSubject,
	#superclass : #GTAbstractExampleMethod,
	#category : #'GT-Examples-Utils'
}

{ #category : #'accessing-dynamic' }
GTExampleMethodSubject >> asGTExampleSubject [
	^ self
]

{ #category : #UI }
GTExampleMethodSubject >> forNautilus: aBlock [
	aBlock
		value: #'Browse method ' ,  self method gtDisplayString
		value: [ self method browse ]
]

{ #category : #testing }
GTExampleMethodSubject >> hasLiteralThorough: aLiteral [
	^ self selector = aLiteral
		or: [ self hasMethod
			and: [ self method hasLiteralThorough: aLiteral ] ]
]
