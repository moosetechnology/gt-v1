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

{ #category : #private }
GTEventRecorderDelegateTest >> compress: aFileReference [
	^ (aFileReference basename, '.zip')
]

{ #category : #running }
GTEventRecorderDelegateTest >> setUp [
	super setUp.
	serverSemaphore := Semaphore new.
	fileSystem := FileSystem memory.
	delegate := GTEventRecorderDelegate new.
	delegate putHandler directory: fileSystem workingDirectory / 'files'.
	delegate zipHandler 
		fileDirectory: fileSystem workingDirectory / 'files';
		zipRootUrl: 'http://localhost/gt/zip' asZnUrl;
		archiver: self.
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
GTEventRecorderDelegateTest >> testHandleGetFromZip [
	"It returns 204 if a category does not exist."
	client path: '/gt/zip'; queryAt: 'category' put: 'categoryOne'; get.
	self assert: client isSuccess.
	self assert: client response code equals: 204.
]

{ #category : #tests }
GTEventRecorderDelegateTest >> testHandleGetFromZip2 [
	"It returns 200 if a category does exist."
	| directory |
	directory := (fileSystem workingDirectory / 'files' / 'categoryOne').
	directory ensureCreateDirectory.
	client 
		followRedirects: false;
		path: '/gt/zip'; queryAt: 'category' put: 'categoryOne'; 
		get.
	self assert: client isRedirect.
	self assert: client response code equals: 302.
	self assert: client response location equals: 'http://localhost/gt/zip/categoryOne.zip'.
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
	self assertLocation: 'files/' , client response location input: data
	
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
	self assertLocation: 'files/' , client response location input: data

]
