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

{ #category : #accessing }
GTExampleClassSubject >> subjectClass [
	^ subjectClass
]

{ #category : #accessing }
GTExampleClassSubject >> subjectClass: anObject [
	subjectClass := anObject
]
