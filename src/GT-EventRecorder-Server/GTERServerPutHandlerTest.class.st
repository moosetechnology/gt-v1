"
A GTERServerDelegateTest is a test class for testing the behavior of GTERServerDelegate
"
Class {
	#name : #GTERServerPutHandlerTest,
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
		'location'
	],
	#category : #'GT-EventRecorder-Server-Tests'
}

{ #category : #'as yet unclassified' }
GTERServerPutHandlerTest >> assertReceiverSemaphore [
	self deny: (receiverSemaphore waitTimeoutMSecs: 200)
]

{ #category : #accessing }
GTERServerPutHandlerTest >> server [
	^ server
]

{ #category : #running }
GTERServerPutHandlerTest >> setUp [
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
GTERServerPutHandlerTest >> setUpServer [
	| subscription |
	receivedContents := WaitfreeQueue new.
	receiverSemaphore := Semaphore new.
	handler := GTERServerPutHandler new.
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
		port: server serverSocket port.
]

{ #category : #running }
GTERServerPutHandlerTest >> tearDown [
	super tearDown.
	server stop.
]

{ #category : #tests }
GTERServerPutHandlerTest >> testPutByteArrayEntity [
	data := #[1 2 3 4].
	client
		entity: (ZnByteArrayEntity bytes: data);
		put.
	self assert: client isSuccess.
	self assert: client isCreated.
	location := client response location asZnUrl.
	self assert: (self storage at: location lastPathSegment) equals: data.

]
