Class {
	#name : #GTSpotterRecorderObjectToFileStorage,
	#superclass : #Object,
	#instVars : [
		'directory'
	],
	#category : #'GT-Spotter-EventRecorder-Server-Core'
}

{ #category : #'instance creation' }
GTSpotterRecorderObjectToFileStorage class >> on: directory [
	^ self new
		directory: directory;
		yourself
]

{ #category : #accessing }
GTSpotterRecorderObjectToFileStorage >> at: key [
	^ self at: key ifAbsent: [ KeyNotFound signalFor: key ]
]

{ #category : #accessing }
GTSpotterRecorderObjectToFileStorage >> at: key ifAbsent: block [
	| fullPath |
	fullPath := self directory / (key first: 2) / key.
	fullPath exists
		ifFalse: [ ^ block value ].
	fullPath size isZero 
		ifTrue: [ ^ block value ].
	^ fullPath binaryReadStreamDo: [ :stream | 
			stream upToEnd ]
]

{ #category : #accessing }
GTSpotterRecorderObjectToFileStorage >> at: key put: aByteArray [
	| subDirectory file |
	self directory ensureCreateDirectory.
	subDirectory := self directory / (key first: 2).
	subDirectory ensureCreateDirectory.
	file := (subDirectory / key).
	file ensureDelete.
	file writeStreamDo: [ :stream | 
		stream nextPutAll: aByteArray ]

]

{ #category : #accessing }
GTSpotterRecorderObjectToFileStorage >> directory [
	^ directory
]

{ #category : #accessing }
GTSpotterRecorderObjectToFileStorage >> directory: aDirectory [
	directory := aDirectory
]
