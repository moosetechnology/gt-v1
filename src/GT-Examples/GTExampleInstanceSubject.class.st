Class {
	#name : #GTExampleInstanceSubject,
	#superclass : #GTAbstractExampleSubject,
	#instVars : [
		'instance'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #accessing }
GTExampleInstanceSubject >> instance [
	^ instance
]

{ #category : #accessing }
GTExampleInstanceSubject >> instance: anObject [
	instance := anObject
]
