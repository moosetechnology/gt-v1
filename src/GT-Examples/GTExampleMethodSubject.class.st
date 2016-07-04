Class {
	#name : #GTExampleMethodSubject,
	#superclass : #GTAbstractExampleMethod,
	#category : #'GT-Examples-Utils'
}

{ #category : #'accessing-dynamic' }
GTExampleMethodSubject >> asGTExampleSubject [
	^ self
]

{ #category : #testing }
GTExampleMethodSubject >> hasLiteralThorough: aLiteral [
	^ self selector = aLiteral
		or: [ self hasMethod
			and: [ self method hasLiteralThorough: aLiteral ] ]
]
