Class {
	#name : #GTSpotterRecorderServerDelegate,
	#superclass : #Object,
	#instVars : [
		'storage',
		'prefix'
	],
	#category : #'GT-Spotter-EventRecorder-Server-Core'
}

{ #category : #'instance creation' }
GTSpotterRecorderServerDelegate class >> on: storage [
	^ self new
		storage: storage;
		yourself
]

{ #category : #private }
GTSpotterRecorderServerDelegate >> generateNewKey [
	^ UUID new asString
]

{ #category : #'request handling' }
GTSpotterRecorderServerDelegate >> handleGetRequest: request [

	^ ZnResponse ok: (ZnEntity text: 'OK')
	
]

{ #category : #'request handling' }
GTSpotterRecorderServerDelegate >> handlePutRequest: request [
	| badRequest key |
	badRequest := [ ^ ZnResponse badRequest: request ].
	(request hasEntity and: [ request contentType matches: ZnMimeType applicationOctetStream ])
		ifFalse: badRequest.
	[ key := self saveByteArray: request entity bytes ] on: Error do: badRequest.
	^ ZnResponse created: key
]

{ #category : #public }
GTSpotterRecorderServerDelegate >> handleRequest: request [

	request method = #PUT
		ifTrue: [ 
			^ self handlePutRequest: request ].
	request method = #GET		
		ifTrue: [ 
			^ self handleGetRequest: request ].
	^ ZnResponse notFound: request uri
]

{ #category : #initialization }
GTSpotterRecorderServerDelegate >> initialize [
	super initialize.
	storage := GTSpotterRecorderObjectToFileStorage on: 'gt/evets' asFileReference.
	prefix := #().
]

{ #category : #accessing }
GTSpotterRecorderServerDelegate >> prefix [
	^ prefix
]

{ #category : #accessing }
GTSpotterRecorderServerDelegate >> prefix: aCollectionOfStrings [
	prefix := aCollectionOfStrings
]

{ #category : #accessing }
GTSpotterRecorderServerDelegate >> prefixFromString: string [
	"Set the path prefix under which I should be handling request to string,
	interpreting each /-separated token as a path element"

	self prefix: (string findTokens: '/')
]

{ #category : #private }
GTSpotterRecorderServerDelegate >> saveByteArray: aByteArray [
	| key |
	key := self generateNewKey.
	self storage at: key put: aByteArray.
	^ key
]

{ #category : #accessing }
GTSpotterRecorderServerDelegate >> storage [
	^ storage
]

{ #category : #accessing }
GTSpotterRecorderServerDelegate >> storage: aStorage [
	storage := aStorage
]
