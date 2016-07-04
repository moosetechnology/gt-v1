Class {
	#name : #GTExampleInstanceSubject,
	#superclass : #GTAbstractExampleSubject,
	#instVars : [
		'instance'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTExampleInstanceSubject >> exists [
	^ self theClass notNil
]

{ #category : #testing }
GTExampleInstanceSubject >> hasLiteralThorough: aLiteral [
	^ (self theClass name = aLiteral)
		or: [ self theClass methods anySatisfy: [ :method | 
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

{ #category : #'accessing-dynamic' }
GTExampleInstanceSubject >> theClass [
	^ self instance class
]
