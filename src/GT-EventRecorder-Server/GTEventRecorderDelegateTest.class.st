"
A GTEventRecorderDelegateTest is a test class for testing the behavior of GTEventRecorderDelegate
"
Class {
	#name : #GTEventRecorderDelegateTest,
	#superclass : #TestCase,
	#instVars : [
		'serverSemaphore',
		'delegate',
		'server',
		'client',
		'fileSystem'
	],
	#category : #'GT-EventRecorder-Server-Tests'
}

{ #category : #converting }
GTEventRecorderDelegateTest >> assertLocation: location input: input [
	| file output |
	file := fileSystem workingDirectory resolveString: location.
	self assert: file exists.
	output := file binaryReadStreamDo: [ :stream | stream upToEnd ].
	self assert: output equals: input
]

{ #category : #running }
GTEventRecorderDelegateTest >> setUp [
	super setUp.
	serverSemaphore := Semaphore new.
	fileSystem := FileSystem memory.
	delegate := GTEventRecorderDelegate new.
	delegate putHandler directory: fileSystem workingDirectory.
	server := GTEventRecorderTestServer new.
	server initializeUsingDelegate: delegate semaphore: serverSemaphore.
	client := ZnClient new
		url: server url;
		followRedirects: false;
		numberOfRetries: 0;
		enforceHttpSuccess: true;
		logToTranscript;
		yourself.
]

{ #category : #running }
GTEventRecorderDelegateTest >> tearDown [
	super tearDown.
	server stop.
	server unsubscribeAll.
]

{ #category : #tests }
GTEventRecorderDelegateTest >> testHandleGetFromEvents [
	| contents |
	client path: '/gt/events'; get.
	self assert: client isSuccess.
	contents := client response contents.
	self assert: contents isString.
	self assert: contents equals: 'OK'.
]

{ #category : #tests }
GTEventRecorderDelegateTest >> testHandleGetFromEvents2 [
	| contents |
	client path: '/gt/events/'; get.
	self assert: client isSuccess.
	contents := client response contents.
	self assert: contents isString.
	self assert: contents equals: 'OK'.
]

{ #category : #tests }
GTEventRecorderDelegateTest >> testHandleGetFromGT [
	| contents |
	client path: '/gt'; get.
	self assert: client isSuccess.
	contents := client response contents.
	self assert: contents isString.
	self assert: contents equals: 'OK'.
]

{ #category : #tests }
GTEventRecorderDelegateTest >> testHandleGetFromGT2 [
	| contents |
	client path: '/gt/'; get.
	self assert: client isSuccess.
	contents := client response contents.
	self assert: contents isString.
	self assert: contents equals: 'OK'.
]

{ #category : #tests }
GTEventRecorderDelegateTest >> testHandleGetFromRoot [
	| contents |
	client get.
	self assert: client isSuccess.
	contents := client response contents.
	self assert: contents isString.
	self assert: contents equals: 'OK'.
]

{ #category : #tests }
GTEventRecorderDelegateTest >> testHandleGetFromRoot2 [
	| contents |
	client path: '//'; get.
	self assert: client isSuccess.
	contents := client response contents.
	self assert: contents isString.
	self assert: contents equals: 'OK'.
]

{ #category : #tests }
GTEventRecorderDelegateTest >> testHandlePut [
	| data entity |
	data := #[1 2 3 4].
	entity := ZnByteArrayEntity bytes: data.
	client
		addPathSegment: 'gt';
		addPathSegment: 'events';
		entity: entity;
		put.
	self assert: client isSuccess.
	self assert: client isCreated.
	self assertLocation: client response location input: data
	
]

{ #category : #tests }
GTEventRecorderDelegateTest >> testHandlePut2 [
	| data entity |
	data := #[1 2 3 4].
	entity := ZnByteArrayEntity bytes: data.
	client
		path: 'gt/events/';
		entity: entity;
		put.
	self assert: client isSuccess.
	self assert: client isCreated.
	self assertLocation: client response location input: data

]

{ #category : #tests }
GTEventRecorderDelegateTest >> testHandlePutOfEventRecorder [
	| recorder collector semaphore files contents unpackedData |
	semaphore := Semaphore new.
	server when: ZnConnectionAcceptedEvent do: [ :announcement | semaphore signal ].
	server when: ZnServerConnectionClosedEvent do: [ :announcement | semaphore signal ].
	recorder := GTEventRecorder new.
	recorder deliveryPreSuspendingAction: [ recorder deliveryPreSuspendingAction: []. semaphore signal ].
	recorder offerPrivacy.
	collector := GTEventCollector new.
	collector url: (server url
		addPathSegment: 'gt';
		addPathSegment: 'events';
		yourself).
	collector category: #testingCategory.
	recorder addCollector: collector.
	collector add: 42.
	[	self deny: (semaphore waitTimeoutMSecs: 200).
		recorder deliverNow.	
		self deny: (semaphore waitTimeoutMSecs: 200).
		self deny: (semaphore waitTimeoutMSecs: 200) ] ensure: [ recorder deactivateDelivery ].
	files := (fileSystem workingDirectory / 'testingCategory') allFiles.
	self assert: files size equals: 1.
	contents := GTEventUnpacking default unpackFile: files first.
	self assert: (contents isKindOf: GTEventAnnouncement).
	unpackedData := contents unpackedData.
	self assert: unpackedData isCollection.
	self assert: unpackedData size equals: 1.
	self assert: unpackedData first equals: 42.
	
]
