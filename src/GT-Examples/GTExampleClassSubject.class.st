Class {
	#name : #GTExampleClassSubject,
	#superclass : #GTAbstractExampleSubject,
	#instVars : [
		'subjectClass'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTExampleClassSubject >> exists [
	^ self subclassResponsibility
]

{ #category : #testing }
GTExampleClassSubject >> hasLiteralThorough: aLiteral [
	^ self subjectClass = aLiteral
		or: [ self subjectClass name = aLiteral
			or: [ self subjectClass methods anySatisfy: [ :method | 
						method selector = aLiteral
							or: [ 	method hasLiteralThorough: aLiteral ] ] ] ]
]

{ #category : #accessing }
GTExampleClassSubject >> subjectClass [
	^ subjectClass
]

{ #category : #accessing }
GTExampleClassSubject >> subjectClass: anObject [
	subjectClass := anObject
]
