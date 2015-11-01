Class {
	#name : #GTSpotterEventInfo,
	#superclass : #Object,
	#instVars : [
		'directory',
		'data'
	],
	#category : #'GT-Spotter-EventRecorder-Server-Core'
}

{ #category : #accessing }
GTSpotterEventInfo >> data [
	^ data ifNil: [ data := GTEventUnpacking default unpackDirectory: self directory ]
]

{ #category : #accessing }
GTSpotterEventInfo >> directory [
	^ directory
]

{ #category : #accessing }
GTSpotterEventInfo >> directory: aFileReference [ 
	directory := aFileReference
]

{ #category : #requesting }
GTSpotterEventInfo >> get [
	^ String streamContents: [ :aStream |
		aStream
			nextPutAll: 'Number of packages: ';
			print: self data size;
			cr;
			nextPutAll: 'Number of computers: ';
			print: self numberOfComputers;
			cr
		 ]
]

{ #category : #accessing }
GTSpotterEventInfo >> numberOfComputers [
	^ self perComputer size
]

{ #category : #accessing }
GTSpotterEventInfo >> perComputer [
	^ self data groupedBy: #computerUUID
]
