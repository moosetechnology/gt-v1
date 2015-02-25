Class {
	#name : #GTSpotterRecorderServerStorage,
	#superclass : #Object,
	#instVars : [
		'dataChunks'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'GT-Spotter-EventRecorder-Server'
}

{ #category : #'as yet unclassified' }
GTSpotterRecorderServerStorage class >> instance [

	^ instance ifNil: [ instance := self new ]
]

{ #category : #'as yet unclassified' }
GTSpotterRecorderServerStorage class >> reset [

	instance := nil
]

{ #category : #'as yet unclassified' }
GTSpotterRecorderServerStorage >> add: aDataChunck [

	dataChunks add: aDataChunck
]

{ #category : #'as yet unclassified' }
GTSpotterRecorderServerStorage >> initialize [
	super initialize.
	
	dataChunks := LinkedList new
]
