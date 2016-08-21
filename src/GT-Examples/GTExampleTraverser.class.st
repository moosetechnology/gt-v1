"
I am an example processor that can traverse examples and execute an action on each of them.
"
Class {
	#name : #GTExampleTraverser,
	#superclass : #GTExampleProcessor,
	#instVars : [
		'action'
	],
	#category : #'GT-Examples-Runtime'
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
	anExample hasValidDependencies
		ifFalse: [ ^ self handleDependencyErrorFor: anExample ].
	self action ifNotNil: [ self example == anExample ifFalse: [ self action value: anExample ] ]
]

{ #category : #accessing }
GTExampleTraverser >> reversed [
	self onProcess: [ :processor :anExample | 
		self action ifNotNil: [ self example == anExample ifFalse: [ self action value: anExample ] ].
		anExample directDependents do: [ :each | processor process: each ] ]
]
