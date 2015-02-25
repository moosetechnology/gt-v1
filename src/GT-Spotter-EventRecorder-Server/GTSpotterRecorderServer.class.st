Class {
	#name : #GTSpotterRecorderServer,
	#superclass : #Object,
	#instVars : [
		'server'
	],
	#category : #'GT-Spotter-EventRecorder-Server'
}

{ #category : #'as yet unclassified' }
GTSpotterRecorderServer class >> start [

	(ZnServer startDefaultOn: 1828)
		delegate: GTSpotterRecorderServerDelegate new
]

{ #category : #'as yet unclassified' }
GTSpotterRecorderServer class >> stop [

	ZnServer stopDefault
]
