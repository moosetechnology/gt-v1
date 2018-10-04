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

{ #category : #running }
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

{ #category : #running }
GTSpotterRecorderServerDelegateTest >> tearDown [
	client close.
	server stop.
	fileSystem close.
	super tearDown.

]

{ #category : #tests }
GTSpotterRecorderServerDelegateTest >> testHandleGetData [
	| contents file  |
	file := fileSystem workingDirectory / 'file.bin'.
	data := #[ 1 2 3 4 ].
	file ensureDelete.
	file writeStreamDo: [ :aStream |
		data do: [ :each | aStream nextPut: each ] ].
	delegate compressedEventFile: file.
	client
		path: '/gt/events/data';
		get.
	self assert: client isSuccess.
	contents := client response contents.
	self assert: contents equals: data.
	self 
		assert: (client response headers at: 'content-disposition') 
		equals: 'attachment; filename=file.bin'.
]

{ #category : #tests }
GTSpotterRecorderServerDelegateTest >> testHandleGetFromEvents [
	| contents |
	client
		path: '/gt/events/';
		get.
	self assert: client isSuccess.
	contents := client response contents.
	self assert: contents isString.
	self assert: contents equals: 'OK'.
]

{ #category : #tests }
GTSpotterRecorderServerDelegateTest >> testHandleGetFromGT [
	| contents |
	client
		path: '/gt';
		get.
	self assert: client isSuccess.
	contents := client response contents.
	self assert: contents isString.
	self assert: contents equals: 'OK'.
]

{ #category : #tests }
GTSpotterRecorderServerDelegateTest >> testHandleGetFromRoot [
	| contents |
	client
		get.
	self assert: client isSuccess.
	contents := client response contents.
	self assert: contents isString.
	self assert: contents equals: 'OK'.
]

{ #category : #tests }
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

{ #category : #tests }
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
