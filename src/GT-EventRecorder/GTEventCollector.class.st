"
I represent a collection of data that should be sent to a specific URL. 

I am responsible for collecting data (#add: method) and for giving collected data to GTEventPacking object (#bundle method).

You should consider to set #category. This value is used for separating data on the server to directories. That way you will then easier receive your collected data. If you creates a subclass of me, you can override #defaultCategory method.

You should also consider set #occupant:. This could be an object that uses me and feeds me with data. I keep this occupant weakly. So, if the object is removed from the memory, GTEventRecorder knows that I can be removed too. 

I collaborate with GTEventPacking object that receives collected data and URL, serilize the collected data, and creates GTEventBundle object. My subclasses can handle differently what data to send together to server by rewritting #bundle method.

Public API and Key Messages

- bundle   
- url
- category
- occupant:
- register

Example for playing with me:
	GTEventCollector new
		category: #testingForFun;
		occupant: nil ""object that represents your application"";
		add: 42;
		add: 'Hallo Pharo user';
		yourself.

Example for serious use:
	GTEventCollector new
		category: #testingForReal;
		occupant: nil ""object that represents your application"";
		register; ""please do not register just for fun, because we collects those data""
		yourself
 
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
		'category',
		'recordedEvents',
		'registry',
		'creationTime'
	],
	#category : #'GT-EventRecorder-Core'
}

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
GTEventCollector >> category [
	^ category ifNil: [ category := self defaultCategory ]
]

{ #category : #accessing }
GTEventCollector >> category: aString [ 
	^ category := aString
]

{ #category : #accessing }
GTEventCollector >> creationTime [
	^ creationTime
]

{ #category : #configuration }
GTEventCollector >> defaultCategory [
	^ #unknown
]

{ #category : #accessing }
GTEventCollector >> flush [
	"Be careful when using it. You will lost all data."
	recordedEvents flush
]

{ #category : #initialization }
GTEventCollector >> initialize [
	super initialize.	
	recordedEvents := WaitfreeQueue new.
	creationTime := DateAndTime now.
]

{ #category : #testing }
GTEventCollector >> isLiberated [
	"When I answer true, I can be removed from a GTEventRecorder object."
	^ self registry isLiberated and: [ recordedEvents isEmpty ]
]

{ #category : #actions }
GTEventCollector >> liberate [
	"Liberate me from the occupant so I can be removed from GTEventRecorder object in the next delivery cycle."
	^ self registry liberate.
]

{ #category : #accessing }
GTEventCollector >> occupant: anObject [ 
	"anObject sends me data. I weakly keeps anObject and once it is released, I can be removed from GTEventRecorder object."
	self registry object: anObject
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

{ #category : #initialization }
GTEventCollector >> register [
	"Register to the global GTEventRecorder."
	GTEventRecorder uniqueInstance addCollector: self.
]

{ #category : #accessing }
GTEventCollector >> registry [
	^ registry ifNil: [ registry := GTEventRegistry new ]
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
