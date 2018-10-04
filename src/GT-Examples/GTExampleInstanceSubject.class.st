Class {
	#name : #GTExampleInstanceSubject,
	#superclass : #GTExampleSubject,
	#instVars : [
		'instance'
	],
	#category : #'GT-Examples-Subjects'
}

{ #category : #'instance creation' }
GTExampleInstanceSubject class >> fromObject: anObject [
	^ self new 
		instance: anObject;
		yourself
]

{ #category : #testing }
GTExampleInstanceSubject >> = anExampleSubject [
	^ self class = anExampleSubject class
		and: [ self instance = anExampleSubject instance ]
]

{ #category : #testing }
GTExampleInstanceSubject >> exists [
	^ self theClass notNil
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
