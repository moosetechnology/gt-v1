Class {
	#name : #GTExampleTraverser,
	#superclass : #GTExampleProcessor,
	#instVars : [
		'action'
	],
	#category : #'GT-Examples-Utils'
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
	anExample hasValidDependencies
		ifFalse: [ ^ self onDependencyError value: self value: anExample value: arguments ].
	arguments := aBlock value.
	self action ifNotNil: [ self example == anExample ifFalse: [ self action value: anExample ] ]
]

{ #category : #accessing }
GTExampleTraverser >> reversed [
	self onProcess: [ :processor :anExample | 
		self action ifNotNil: [ self example == anExample ifFalse: [ self action value: anExample ] ].
		anExample directDependents do: [ :each | processor process: each ] ]
]
