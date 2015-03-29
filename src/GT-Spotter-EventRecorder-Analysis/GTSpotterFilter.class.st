Class {
	#name : #GTSpotterFilter,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis'
}

{ #category : #'as yet unclassified' }
GTSpotterFilter class >> executeOn: aCollection [ 
	^ (self on: aCollection) execute
]

{ #category : #'as yet unclassified' }
GTSpotterFilter class >> on: aCollection [ 
	^ self new context: aCollection; yourself
]

{ #category : #accessing }
GTSpotterFilter >> context [
	^ context
]

{ #category : #accessing }
GTSpotterFilter >> context: aCollection [ 
	context := aCollection
]

{ #category : #execute }
GTSpotterFilter >> execute [
	self patterns do: [ :eachPattern |
		eachPattern execute ].
	^ self context.
]

{ #category : #accessing }
GTSpotterFilter >> patterns [
	^ GTSpotterFilterPattern allSubclasses collect: [ :eachFilterClass |
		eachFilterClass context: self ]
]
