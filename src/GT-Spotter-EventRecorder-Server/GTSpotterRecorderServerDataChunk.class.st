Class {
	#name : #GTSpotterRecorderServerDataChunk,
	#superclass : #Object,
	#instVars : [
		'content',
		'imageHash',
		'time'
	],
	#category : #'GT-Spotter-EventRecorder-Server'
}

{ #category : #accessing }
GTSpotterRecorderServerDataChunk >> content [

	^ content
]

{ #category : #accessing }
GTSpotterRecorderServerDataChunk >> content: aCollection [

	content := aCollection
]

{ #category : #accessing }
GTSpotterRecorderServerDataChunk >> imageHash [

	^ imageHash
]

{ #category : #accessing }
GTSpotterRecorderServerDataChunk >> imageHash: anInteger [

	imageHash := anInteger
]

{ #category : #accessing }
GTSpotterRecorderServerDataChunk >> initialize [
	super initialize.
	
	time := DateAndTime now
]
