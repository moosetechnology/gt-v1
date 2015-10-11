Class {
	#name : #GTEventCollector,
	#superclass : #Object,
	#instVars : [
		'url',
		'recordedEvents'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GT-EventRecorder-Core'
}

{ #category : #cleanup }
GTEventCollector class >> cleanUp [
	self reset.
]

{ #category : #initialization }
GTEventCollector class >> initializeUniqueInstance [
	uniqueInstance ifNotNil: [ self reset ].
	uniqueInstance := self new.
	GTEventRecorder uniqueInstance addCollector: uniqueInstance
]

{ #category : #accessing }
GTEventCollector class >> reset [
	uniqueInstance ifNil: [ ^ self ].
	GTEventRecorder uniqueInstance removeCollector: uniqueInstance.
	uniqueInstance := nil.
]

{ #category : #accessing }
GTEventCollector class >> uniqueInstance [
	uniqueInstance ifNil: [ self initializeUniqueInstance ].
	^ uniqueInstance
]

{ #category : #adding }
GTEventCollector >> add: anEvent [ 
	^ recordedEvents nextPut: anEvent
]

{ #category : #accessing }
GTEventCollector >> bundle [
	^ self bundle: OrderedCollection new.
]

{ #category : #accessing }
GTEventCollector >> bundle: aCollection [
	recordedEvents flush: [ :eachEvent | aCollection addLast: eachEvent ].
	^ aCollection
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

{ #category : #printing }
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
	^ url ifNil: [ url := GTEventRecorderSettings url ]
]

{ #category : #accessing }
GTEventCollector >> url: anObject [
	url := anObject
]
