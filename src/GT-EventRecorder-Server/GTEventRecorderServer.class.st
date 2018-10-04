"
I know how to start and stop default Event Recorder server.
Check my two start and stop methods on the class side.
"
Class {
	#name : #GTEventRecorderServer,
	#superclass : #Object,
	#category : #'GT-EventRecorder-Server-Core'
}

{ #category : #accessing }
GTEventRecorderServer class >> start [
	"self start"
	(ZnServer startDefaultOn: 8080)
		route: 'Default GT-EventRecorder-Server';
		delegate: GTEventRecorderDelegate new.
]

{ #category : #accessing }
GTEventRecorderServer class >> stop [
	"self stop"
	ZnServer stopDefault
]

{ #category : #'see class side' }
GTEventRecorderServer >> seeClassSide [
]
