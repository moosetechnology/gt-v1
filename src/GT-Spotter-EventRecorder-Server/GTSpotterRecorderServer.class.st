Class {
	#name : #GTSpotterRecorderServer,
	#superclass : #Object,
	#instVars : [
		'server'
	],
	#category : #'GT-Spotter-EventRecorder-Server-Core'
}

{ #category : #accessing }
GTSpotterRecorderServer class >> start [
	"self start"
	(ZnServer startDefaultOn: 8080)
		delegate: GTSpotterRecorderServerDelegate new
]

{ #category : #accessing }
GTSpotterRecorderServer class >> stop [
	"self stop"
	ZnServer stopDefault
]
