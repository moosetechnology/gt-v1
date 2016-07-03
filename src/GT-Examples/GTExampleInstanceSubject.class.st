Class {
	#name : #GTExampleInstanceSubject,
	#superclass : #GTAbstractExampleSubject,
	#instVars : [
		'instance'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTExampleInstanceSubject >> hasLiteralThorough: aLiteral [
	^ (self instance class name = aLiteral)
		or: [ self instance class methods anySatisfy: [ :method | 
					method selector = aLiteral
						or: [ 	method hasLiteralThorough: aLiteral ] ] ]
]

{ #category : #accessing }
GTExampleInstanceSubject >> instance [
	^ instance
]

{ #category : #accessing }
GTExampleInstanceSubject >> instance: anObject [
	instance := anObject
]
