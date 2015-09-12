Class {
	#name : #GTExampleTraverser,
	#superclass : #GTExampleProcessor,
	#instVars : [
		'action'
	],
	#category : #'GT-Inspector-Examples-Tools'
}

{ #category : #accessing }
GTExampleTraverser >> action [
	^ action
]

{ #category : #accessing }
GTExampleTraverser >> action: anObject [
	action := anObject
]

{ #category : #private }
GTExampleTraverser >> process: anExample withArguments: aBlock [
	| arguments |
	arguments := nil.
	anExample hasValidArguments 
		ifFalse: [ ^ self onArgumentError value: self value: anExample value: arguments ].
	[ arguments := aBlock value ]
		on: Error
		do: [ :exception | ^ self onDependencyError value: self value: anExample value: exception ].
	self action ifNotNil: [ self example == anExample ifFalse: [ self action value: anExample ] ]
]

{ #category : #accessing }
GTExampleTraverser >> reversed [
	self onProcess: [ :processor :anExample | 
		self action ifNotNil: [ self example == anExample ifFalse: [ self action value: anExample ] ].
		anExample dependents do: [ :each | processor process: each ] ]
]
