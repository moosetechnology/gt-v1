Class {
	#name : #GTSpotterStreamMock,
	#superclass : #Object,
	#instVars : [
		'objects'
	],
	#category : #'GT-Spotter-Tests'
}

{ #category : #'as yet unclassified' }
GTSpotterStreamMock >> addObject: anObject inProcessor: aProcessor [
	objects add: anObject
]

{ #category : #'as yet unclassified' }
GTSpotterStreamMock >> initialize [
	super initialize.
	objects := OrderedCollection new.
]

{ #category : #accessing }
GTSpotterStreamMock >> objects [
	^ objects
]
