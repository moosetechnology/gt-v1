"
I represent a collection of data that should be sent to a specific URL. 

I am responsible for collecting data (#add: method) and for handing collected data to GTEventPacking object (#bundle method). If convenient, someone can consider me (or any of my subclasses) as singleton. That way could be favorable to send me data from other parts of the Pharo system.

I collaborate with GTEventPacking object that receives collected data and URL, serilize the collected data, and creates GTEventBundle object. My subclasses can handle differently what data to send together to server by rewritting #bundle method.

Public API and Key Messages

- bundle   
- url
 
Internal Representation and Key Implementation Points.

    Instance Variables
	recordedEvents:		<WaitfreeQueue>
	url:		<ZnUrl>

"
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
		print: recordedEvents size;
		space;
		nextPutAll: ('item' asPluralBasedOn: recordedEvents size);
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
