"
A GTSpotterRecorderServerDelegateTest is a test class for testing the behavior of GTSpotterRecorderServerDelegate
"
Class {
	#name : #GTSpotterRecorderServerDelegateTest,
	#superclass : #TestCase,
	#instVars : [
		'fileSystem',
		'storage',
		'delegate',
		'server',
		'client',
		'data',
		'location'
	],
	#category : #'GT-Spotter-EventRecorder-Server-Tests'
}

{ #category : #'as yet unclassified' }
GTSpotterRecorderServerDelegateTest >> setUp [
	super setUp.
	fileSystem := FileSystem memory.
	storage := GTSpotterRecorderObjectToFileStorage on: fileSystem workingDirectory.
	delegate := GTSpotterRecorderServerDelegate on: storage.
	server := ZnServer startOn: 1818 + 10 atRandom.
	server delegate: delegate.
	server debugMode: true; logToTranscript. 
	client := ZnClient new
		url: server localUrl;
		followRedirects: false;
		numberOfRetries: 0;
		enforceHttpSuccess: true;
		logToTranscript;
		yourself.
]

{ #category : #'as yet unclassified' }
GTSpotterRecorderServerDelegateTest >> tearDown [
	client close.
	server stop.
	fileSystem close.
	super tearDown.

]

{ #category : #'as yet unclassified' }
GTSpotterRecorderServerDelegateTest >> testHandleGetData [
	| contents |
	client
		path: '/gt/events/data';
		get.
	self assert: client isSuccess.
	contents := client response contents.
	self assert: contents isString.
	self assert: contents equals: 'TBD'.
]

{ #category : #'as yet unclassified' }
GTSpotterRecorderServerDelegateTest >> testHandleGetInfo [
	| contents |
	client
		path: '/gt/events/info';
		get.
	self assert: client isSuccess.
	contents := client response contents.
	self assert: contents isString.
	self deny: contents = 'OK'.
]

{ #category : #'as yet unclassified' }
GTSpotterRecorderServerDelegateTest >> testHandlePut [
	data := #[1 2 3 4].
	client
		entity: (ZnByteArrayEntity bytes: data);
		put.
	self assert: client isSuccess.
	self assert: client isCreated.
	location := client response location asZnUrl.
	self assert: (storage at: location lastPathSegment) equals: data.

]
