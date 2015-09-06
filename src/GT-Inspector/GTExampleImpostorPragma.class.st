Class {
	#name : #GTExampleImpostorPragma,
	#superclass : #Object,
	#instVars : [
		'method'
	],
	#category : #'GT-Inspector-Examples-Utils'
}

{ #category : #comparing }
GTExampleImpostorPragma >> = aImpostorPragma [
	^ self class = aImpostorPragma class
		and: [ self method = aImpostorPragma method ]
]

{ #category : #'accessing-method' }
GTExampleImpostorPragma >> arguments [
	^ #()
]

{ #category : #comparing }
GTExampleImpostorPragma >> hash [
	^ self method hash
]

{ #category : #testing }
GTExampleImpostorPragma >> isGTExamplePragma [
	^ true
]

{ #category : #'accessing-method' }
GTExampleImpostorPragma >> keyword [
	^ #gtExample
]

{ #category : #'accessing-method' }
GTExampleImpostorPragma >> method [
	^ method
]

{ #category : #'accessing-method' }
GTExampleImpostorPragma >> method: anObject [
	method := anObject
]

{ #category : #'accessing-method' }
GTExampleImpostorPragma >> methodClass [
	^ method methodClass
]

{ #category : #'accessing-method' }
GTExampleImpostorPragma >> selector [
	^ method selector
]
