Class {
	#name : #GTEventRecorderDelegate,
	#superclass : #Object,
	#instVars : [
		'dispatcher',
		'putHandler',
		'zipHandler'
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
	zipHandler := GTEventRecorderZipHandler new.
	zipHandler 
		fileDirectory: FileLocator home / 'gt' / 'events';
		zipRootUrl: 'http://gc.dcc.uchile.cl/' asZnUrl;
		archiver: GTEventRecorderExternalZipScript new.
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
		map: '/gt/zip' to: zipHandler;
		map: '/gt/zip/' to: zipHandler;
		map: '/gt/events' to: putHandler;
		map: '/gt/events/' to: putHandler;
		yourself
]

{ #category : #accessing }
GTEventRecorderDelegate >> putHandler [
	"for the testing purpose"
	^ putHandler
]

{ #category : #accessing }
GTEventRecorderDelegate >> zipHandler [
	"for the testing purpose"
	^ zipHandler
]
