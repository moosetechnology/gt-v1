Class {
	#name : #GTEventCollector,
	#superclass : #Object,
	#instVars : [
		'url',
		'recordedEvents'
	],
	#category : #'GT-EventRecorder-Core'
}

{ #category : #adding }
GTEventCollector >> add: anEvent [ 
	^ recordedEvents nextPut: anEvent
]

{ #category : #accessing }
GTEventCollector >> bundle [
	| bundle |
	bundle := OrderedCollection new.
	recordedEvents flush: [ :eachEvent | bundle addLast: eachEvent ].
	^ bundle
]

{ #category : #accessing }
GTEventCollector >> flush [
	recordedEvents flush
]

{ #category : #initialization }
GTEventCollector >> initialize [
	super initialize.	
	recordedEvents := WaitfreeQueue new.

]

{ #category : #'as yet unclassified' }
GTEventCollector >> printOn: aStream [
	super printOn: aStream.
	aStream
		space;
		nextPut: $[;
		nextPutAll: (recordedEvents size pluralize: 'item');
		nextPut: $]
]

{ #category : #accessing }
GTEventCollector >> size [
	^ recordedEvents size
]

{ #category : #accessing }
GTEventCollector >> url [
	^ url
]

{ #category : #accessing }
GTEventCollector >> url: anObject [
	url := anObject
]
