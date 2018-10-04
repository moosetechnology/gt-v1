Class {
	#name : #GTExampleIcon,
	#superclass : #GTExampleAspect,
	#traits : 'TGTExampleIcon',
	#classTraits : 'TGTExampleIcon classTrait',
	#category : #'GT-Examples-Organization'
}

{ #category : #testing }
GTExampleIcon class >> isAbstract [
	^ self == GTExampleIcon
]

{ #category : #private }
GTExampleIcon >> basicForm [
	^ self subclassResponsibility
]

{ #category : #'accessing-dynamic' }
GTExampleIcon >> form [
	^ self exists
		ifTrue: [ self basicForm ]
		ifFalse: [ nil ]
]
