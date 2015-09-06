Class {
	#name : #RTExampleFinder,
	#superclass : #GTExampleFinder,
	#category : #'GT-InspectorExtensions-CoreRoassal'
}

{ #category : #private }
RTExampleFinder >> class: aClass selector: aSelector method: aMethod to: examples [
	(aSelector beginsWith: 'example') ifFalse: [ ^ self ].
	(aSelector endsWith: 'Icon') ifTrue: [ ^ self ].
	
	self example: (self class: aClass selector: aSelector method: aMethod pragma: (GTExampleImpostorPragma new
		method: aMethod;
		yourself)) to: examples
]

{ #category : #private }
RTExampleFinder >> newExample [
	^ RTExampleSelection new
]
