"
A GTERServerDelegateTest is a test class for testing the behavior of GTERServerDelegate
"
Class {
	#name : #GTEventRecorderPutHandlerTest,
	#superclass : #TestCase,
	#instVars : [
		'receivedContents',
		'receiverSemaphore',
		'handler',
		'delegate',
		'server',
		'url',
		'data',
		'client',
		'location',
		'storage',
		'entity'
	],
	#category : #'GT-EventRecorder-Server-Tests'
}

{ #category : #asserting }
GTEventRecorderPutHandlerTest >> assertReceiverSemaphore [
	self deny: (receiverSemaphore waitTimeoutMSecs: 200)
]

{ #category : #accessing }
GTEventRecorderPutHandlerTest >> atCategory: aString put: aByteArray [ 
	^ self put: aString -> aByteArray
]

{ #category : #accessing }
GTEventRecorderPutHandlerTest >> put: aByteArray [ 
	| key |
	key := (receivedContents size + 1) printString.
	receivedContents nextPut: key -> aByteArray.
	receiverSemaphore signal.
	^ key
]

{ #category : #accessing }
GTEventRecorderPutHandlerTest >> server [
	^ server
]

{ #category : #running }
GTEventRecorderPutHandlerTest >> setUp [
	super setUp.
	self setUpServer.
	client := ZnClient new
		url: url;
		followRedirects: false;
		numberOfRetries: 0;
		enforceHttpSuccess: true;
		logToTranscript;
		yourself.
]

{ #category : #running }
GTEventRecorderPutHandlerTest >> setUpServer [
	| subscription |
	receivedContents := WaitfreeQueue new.
	receiverSemaphore := Semaphore new.
	handler := GTEventRecorderPutHandler new.
	handler storage: self.
	delegate := ZnDispatcherDelegate new.
	delegate map: '/gt/events' to: handler.
	server := ZnServer on: 0.
	server delegate: delegate.
	server route: UUID new asString.
	subscription := ZnLogEvent announcer 
							when: ZnServerSocketBoundEvent 
							do: [ :announcement | announcement serverId = self server route 
										ifTrue: [ receiverSemaphore signal ] ]
							for: self.
	server start.
	self assertReceiverSemaphore.
	ZnLogEvent announcer removeSubscription: subscription.
	url := ZnUrl new
		scheme: #http;
		host: NetNameResolver loopBackName;
		port: server serverSocket port;
		addPathSegment: 'gt';
		addPathSegment: 'events';
		yourself.
]

{ #category : #accessing }
GTEventRecorderPutHandlerTest >> storage [
	storage ifNil: [ storage := Dictionary new ].
	receivedContents flush: [ :association |
		storage at: association key put: association value ].
	^ storage
]

{ #category : #running }
GTEventRecorderPutHandlerTest >> tearDown [
	super tearDown.
	server stop.
]

{ #category : #tests }
GTEventRecorderPutHandlerTest >> testPutByteArrayEntity [
	data := #[1 2 3 4].
	entity := ZnByteArrayEntity bytes: data.
	client
		entity: entity;
		put.
	self assert: client isSuccess.
	self assert: client isCreated.
	location := client response location asZnUrl.
	self assert: (self storage at: location lastPathSegment) equals: data.

]

{ #category : #tests }
GTEventRecorderPutHandlerTest >> testPutMultiPartFormDataEntity [
	data := #[1 2 3 4].
	entity := ZnMultiPartFormDataEntity new.
	entity 
		addPart: (ZnMimePart fieldName: 'category' value: 'category1');
		addPart: (ZnMimePart fieldName: 'data' value: data).
	client
		entity: entity;
		put.
	self assert: client isSuccess.
	self assert: client isCreated.
	location := client response location asZnUrl.
	self assert: client response location equals: '1'.
	self assert: (self storage at: '1') equals: 'category1' -> data.

]

{ #category : #tests }
GTEventRecorderPutHandlerTest >> testPutMultiPartFormDataEntity2 [
	| data2 data3 |
	data := #[1 2 3 4].
	data2 := #[5 6].
	data3 := #[7 8 9].
	entity := ZnMultiPartFormDataEntity new.
	entity 
		addPart: (ZnMimePart fieldName: 'category' value: 'category1');
		addPart: (ZnMimePart fieldName: 'data' value: data);
		addPart: (ZnMimePart fieldName: 'category' value: 'category2');
		addPart: (ZnMimePart fieldName: 'data' value: data2);
		addPart: (ZnMimePart fieldName: 'category' value: 'category1');
		addPart: (ZnMimePart fieldName: 'data' value: data3).
	client
		entity: entity;
		put.
	self assert: client isSuccess.
	self assert: client isCreated.
	location := client response location asZnUrl.
	self assert: client response location equals: '3'.
	self assert: (self storage at: '1') equals: 'category1' -> data.
	self assert: (self storage at: '2') equals: 'category2' -> data2.
	self assert: (self storage at: '3') equals: 'category1' -> data3.

]
