Class {
	#name : #GTSpotterFilterPattern,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis'
}

{ #category : #'instance creation' }
GTSpotterFilterPattern class >> context: aGTSpotterFilter [ 
	^ self new context: aGTSpotterFilter; yourself.
]

{ #category : #accessing }
GTSpotterFilterPattern >> context [
	^ context
]

{ #category : #accessing }
GTSpotterFilterPattern >> context: anObject [
	context := anObject
]

{ #category : #accessing }
GTSpotterFilterPattern >> events [
	^ self context context
]

{ #category : #execute }
GTSpotterFilterPattern >> execute [
	self subclassResponsibility
]
