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
