Class {
	#name : #GTAbstractExampleIcon,
	#superclass : #GTAbstractExampleObject,
	#traits : 'TGTExampleIcon',
	#classTraits : 'TGTExampleIcon classTrait',
	#category : #'GT-Examples-Organization'
}

{ #category : #testing }
GTAbstractExampleIcon class >> isAbstract [
	^ self == GTAbstractExampleIcon
]

{ #category : #private }
GTAbstractExampleIcon >> basicForm [
	^ self subclassResponsibility
]

{ #category : #'accessing-dynamic' }
GTAbstractExampleIcon >> form [
	^ self exists
		ifTrue: [ self basicForm ]
		ifFalse: [ nil ]
]

{ #category : #ui }
GTAbstractExampleIcon >> gtInspectorFormIn: composite [
	<gtInspectorPresentationOrder: 0>
	self exists ifFalse: [ ^ self ].
	
	self form gtInspectorFormIn: composite
]
