Class {
	#name : #GTEventRecorderTest,
	#superclass : #TestCase,
	#instVars : [
		'recorder',
		'server',
		'collector',
		'url',
		'event1',
		'event2',
		'delegate',
		'receivedContents',
		'semaphore',
		'receiverSemaphore'
	],
	#category : #'GT-EventRecorder-Tests-Core'
}

{ #category : #asserting }
GTEventRecorderTest >> assertReceiverSemaphore [
	self deny: (receiverSemaphore waitTimeoutMSecs: 200)
]

{ #category : #asserting }
GTEventRecorderTest >> assertSemaphore [
	self deny: (semaphore waitTimeoutMSecs: 200)
]

{ #category : #'server handling' }
GTEventRecorderTest >> handleRequest: request response: response [
	receivedContents nextPut: request contents.
	receiverSemaphore signal.
	^ response
]

{ #category : #running }
GTEventRecorderTest >> setUp [
	super setUp.
	self setUpServer.
	semaphore := Semaphore new.
	recorder := GTEventRecorder new.
	recorder offerPrivacy.
	collector := GTEventCollector new.
	collector url: url.
	event1 := GTDummyEvent new data: 'string1'.
	event2 := GTDummyEvent new data: 42
]

{ #category : #running }
GTEventRecorderTest >> setUpServer [
	receivedContents := WaitfreeQueue new.
	receiverSemaphore := Semaphore new.
	delegate := ZnDispatcherDelegate new.
	delegate
		map: '/'
		to:
			[ :request :response | self handleRequest: request response: response ].
	server := ZnServer on: 0.
	server delegate: delegate.
	server start.
	url := ZnUrl new
		scheme: #http;
		host: NetNameResolver loopBackName;
		port: server serverSocket port
]

{ #category : #running }
GTEventRecorderTest >> tearDown [
	super tearDown.
	recorder deactivateDelivery.
	server stop.
]

{ #category : #tests }
GTEventRecorderTest >> testAddCollector [
	recorder addCollector: GTEventCollector new.
	self assert: recorder numberOfCollectors equals: 1.
]

{ #category : #tests }
GTEventRecorderTest >> testAddCollector2 [
	recorder addCollector: GTEventCollector new.
	self assert: recorder isDeliveryActive.
]

{ #category : #tests }
GTEventRecorderTest >> testAddCollector3 [
	recorder addCollector: collector.
	collector add: event1.
	collector add: event2.
	recorder announcer 
		when: GTEventSuspendingDeliveryAnnouncement
		do: [ semaphore signal ].
	self assertSemaphore.
	recorder deliverNow.
	self assertReceiverSemaphore.
	self assert: collector size equals: 0.
	
]

{ #category : #tests }
GTEventRecorderTest >> testAddCollector4 [
	recorder addCollector: collector.
	collector add: event1.
	collector add: event2.
	recorder delivery packAndDeliver: false.
	"wait"
	self assert: collector size equals: 0.
	
]

{ #category : #tests }
GTEventRecorderTest >> testDeliverNow [
	"Just test that we can ask for delivering."
	recorder deliverNow
]

{ #category : #tests }
GTEventRecorderTest >> testIsDeliveryActive [
	self deny: recorder isDeliveryActive.
]

{ #category : #tests }
GTEventRecorderTest >> testPack [
	recorder addCollector: collector.
	collector add: event1.
	collector add: event2.
	recorder pack.
	self assert: collector size equals: 0.
	self assert: recorder delivery size equals: 1.
]
