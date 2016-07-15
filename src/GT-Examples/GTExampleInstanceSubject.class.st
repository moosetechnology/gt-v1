Class {
	#name : #GTExampleInstanceSubject,
	#superclass : #GTAbstractExampleSubject,
	#instVars : [
		'instance'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTExampleInstanceSubject >> = anExampleSubject [
	^ self class = anExampleSubject class
		and: [ self instance = anExampleSubject instance ]
]

{ #category : #testing }
GTExampleInstanceSubject >> exists [
	^ self theClass notNil
]

{ #category : #UI }
GTExampleInstanceSubject >> forNautilus: aBlock [
	aBlock
		value: #'Inspect subject Instance ' ,  self instance gtDisplayString
		value: [ self instance inspect ]
]

{ #category : #UI }
GTExampleInstanceSubject >> gtDisplayOn: aStream [
	self instance gtDisplayOn: aStream.
	self gtDisplayValidityOn: aStream
]

{ #category : #testing }
GTExampleInstanceSubject >> hasLiteralThorough: aLiteral [
	^ self exists
		and: [ self theClass methods anySatisfy: [ :method | 
			method selector = aLiteral
				or: [ 	method hasLiteralThorough: aLiteral ] ] ]
]

{ #category : #testing }
GTExampleInstanceSubject >> hash [
	^ self class hash
		bitXor: self instance hash
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
