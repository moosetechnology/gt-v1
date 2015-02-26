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

	(ZnServer startDefaultOn: 8080)
		delegate: GTSpotterRecorderServerDelegate new
]

{ #category : #accessing }
GTSpotterRecorderServer class >> stop [

	ZnServer stopDefault
]
