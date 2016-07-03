Class {
	#name : #GTExampleMethodSubject,
	#superclass : #GTAbstractExampleSubject,
	#instVars : [
		'subjectClass',
		'subjectSelector'
	],
	#category : #'GT-Examples-Utils'
}

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
