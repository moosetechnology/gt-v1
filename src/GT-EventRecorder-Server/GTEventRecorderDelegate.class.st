Class {
	#name : #GTEventRecorderDelegate,
	#superclass : #Object,
	#instVars : [
		'dispatcher',
		'putHandler'
	],
	#category : #'GT-EventRecorder-Server-Core'
}

{ #category : #public }
GTEventRecorderDelegate >> handleRequest: request [
	^ dispatcher handleRequest: request
]

{ #category : #initialization }
GTEventRecorderDelegate >> initialize [
	super initialize.
	putHandler := GTEventRecorderPutHandler new.
	putHandler storage: (GTEventRecorderFileStorage new
		directory: FileLocator home / 'gt' / 'events';
		yourself).
	dispatcher := ZnDispatcherDelegate new.
	self initializeDispatcher
]

{ #category : #initialization }
GTEventRecorderDelegate >> initializeDispatcher [
	| okResponse |
	okResponse := [ :request :response | ZnResponse ok: (ZnEntity text: 'OK') ].
	dispatcher 
		map: '/' to: okResponse;
		map: '/gt' to: okResponse;
		map: '/gt/' to: okResponse;
		map: '/gt/events' to: putHandler;
		map: '/gt/events/' to: putHandler;
		yourself
]

{ #category : #accessing }
GTEventRecorderDelegate >> putHandler [
	"for the testing purpose"
	^ putHandler
]
