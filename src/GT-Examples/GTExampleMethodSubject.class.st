Class {
	#name : #GTExampleMethodSubject,
	#superclass : #GTAbstractExampleSubject,
	#instVars : [
		'subjectClass',
		'subjectSelector'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTExampleMethodSubject >> hasLiteralThorough: aLiteral [
	^ self hasMethod
		and: [ self method hasLiteralThorough: aLiteral ]
]

{ #category : #testing }
GTExampleMethodSubject >> hasMethod [
	^ self subjectClass includesSelector: self subjectSelector
]

{ #category : #'accessing-dynamic' }
GTExampleMethodSubject >> method [
	^ self subjectClass >> self subjectSelector
]

{ #category : #accessing }
GTExampleMethodSubject >> subjectClass [
	^ subjectClass
]

{ #category : #accessing }
GTExampleMethodSubject >> subjectClass: anObject [
	subjectClass := anObject
]

{ #category : #accessing }
GTExampleMethodSubject >> subjectSelector [
	^ subjectSelector
]

{ #category : #accessing }
GTExampleMethodSubject >> subjectSelector: anObject [
	subjectSelector := anObject
]
