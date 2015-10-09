Class {
	#name : #GTDummyEvent,
	#superclass : #Object,
	#instVars : [
		'data'
	],
	#category : #'GT-EventRecorder-Tests'
}

{ #category : #comparing }
GTDummyEvent >> = aDummyEvent [
	^ self class = aDummyEvent class and: [ 
		self data = aDummyEvent data ]
]

{ #category : #accessing }
GTDummyEvent >> data [
	^ data
]

{ #category : #accessing }
GTDummyEvent >> data: anObject [
	data := anObject
]

{ #category : #comparing }
GTDummyEvent >> hash [
	^ self class hash bitXor: self data
]
