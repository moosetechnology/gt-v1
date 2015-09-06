Class {
	#name : #GTExampleDeclaredMethodMissing,
	#superclass : #GTExampleError,
	#instVars : [
		'methodClass',
		'selector'
	],
	#category : #'GT-Inspector-Examples-Exceptions'
}

{ #category : #accessing }
GTExampleDeclaredMethodMissing >> methodClass [
	^ methodClass
]

{ #category : #accessing }
GTExampleDeclaredMethodMissing >> methodClass: anObject [
	methodClass := anObject
]

{ #category : #accessing }
GTExampleDeclaredMethodMissing >> selector [
	^ selector
]

{ #category : #accessing }
GTExampleDeclaredMethodMissing >> selector: anObject [
	selector := anObject
]
