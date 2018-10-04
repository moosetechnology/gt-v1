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

{ #category : #printing }
GTExampleWithResult >> resultOrErrorClassName [
	self hasResult
		ifTrue: [ self isSuccess
				ifTrue: [ ^ self result returnValue class name asString ]
				ifFalse: [ self isError
						ifTrue: [ self result unexpectedError ifNotNil: [ ^ self result unexpectedError class name asString ] ]
						ifFalse: [ self isFailure
								ifTrue: [ self result expectedError ifNotNil: [ ^ self result expectedError class name asString ] ] ] ] ]
		ifFalse: [ ^ 'N/A' ]
]

{ #category : #public }
GTExampleWithResult >> run [
	^ self example ignoreTest ifFalse: [self result: self example run]
]

{ #category : #printing }
GTExampleWithResult >> statusText [
	self hasResult
		ifTrue: [ self isSuccess
				ifTrue: [ ^ 'Success' ]
				ifFalse: [ self isError
						ifTrue: [ ^ 'Error' ].
					self isFailure
						ifTrue: [ ^ 'Failure' ] ] ]
		ifFalse: [ ^ 'N/A' ]
]

{ #category : #printing }
GTExampleWithResult >> statusTextWithResultValueClassName [
	| status resultOrErrorClassName |
	status := self statusText.
	resultOrErrorClassName := self resultOrErrorClassName.
	resultOrErrorClassName ifNotNil: [ status := status , ': ' , resultOrErrorClassName ].
	^ status
]
