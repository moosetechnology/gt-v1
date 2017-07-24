Class {
	#name : #GTExampleWithResult,
	#superclass : #Object,
	#instVars : [
		'example',
		'result'
	],
	#category : #'GT-Examples-UI'
}

{ #category : #public }
GTExampleWithResult >> debug [
	self result: self example debug
]

{ #category : #accessing }
GTExampleWithResult >> example [
	^ example
]

{ #category : #accessing }
GTExampleWithResult >> example: anObject [
	example := anObject
]

{ #category : #printing }
GTExampleWithResult >> gtDisplayOn: stream [
	self example gtDisplayOn: stream
]

{ #category : #testing }
GTExampleWithResult >> hasResult [
	^ result notNil
]

{ #category : #ui }
GTExampleWithResult >> icon [
	self isSuccess ifTrue: [ ^ ThemeIcons current iconNamed: #testGreen ].
	(self isError or: [ self isFailure ]) ifTrue: [ ^ ThemeIcons current iconNamed: #testRed ].
	^ ThemeIcons current iconNamed: #testNotRun
]

{ #category : #testing }
GTExampleWithResult >> isError [
	^ self hasResult and: [ self result isError ]
]

{ #category : #testing }
GTExampleWithResult >> isFailure [
	^ self hasResult and: [ self result isFailure ]
]

{ #category : #testing }
GTExampleWithResult >> isSuccess [
	^ self hasResult and: [ self result isSuccess ]
]

{ #category : #accessing }
GTExampleWithResult >> result [
	^ result
]

{ #category : #accessing }
GTExampleWithResult >> result: anObject [
	result := anObject
]

{ #category : #public }
GTExampleWithResult >> run [
	^ self result: self example run
]
