Class {
	#name : #GTERServerPutHandler,
	#superclass : #Object,
	#instVars : [
		'storage'
	],
	#category : #'GT-EventRecorder-Server-Core'
}

{ #category : #private }
GTERServerPutHandler >> saveByteArray: aByteArray [
	"storage is responsible for storing aByteArray.
	It returns location."
	^ self storage put: aByteArray.
]

{ #category : #accessing }
GTERServerPutHandler >> storage [
	^ storage
]

{ #category : #accessing }
GTERServerPutHandler >> storage: anObject [
	storage := anObject
]

{ #category : #evaluating }
GTERServerPutHandler >> value: aZnRequest value: aZnResponse [
	| badRequest key |
	badRequest := [ ^ ZnResponse badRequest: aZnRequest ].
	(aZnRequest hasEntity and: [ aZnRequest contentType matches: ZnMimeType applicationOctetStream ])
		ifTrue: [ 
			[ key := self saveByteArray: aZnRequest entity bytes ] on: Error do: badRequest.
			^ ZnResponse created: key ].
	badRequest value.
]
