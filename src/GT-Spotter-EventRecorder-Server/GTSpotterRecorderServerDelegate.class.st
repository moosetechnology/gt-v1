Class {
	#name : #GTSpotterRecorderServerDelegate,
	#superclass : #Object,
	#instVars : [
		'compressedEventFile',
		'prefix',
		'storage'
	],
	#category : #'GT-Spotter-EventRecorder-Server-Core'
}

{ #category : #'instance creation' }
GTSpotterRecorderServerDelegate class >> on: storage [
	^ self new
		storage: storage;
		yourself
]

{ #category : #accessing }
GTSpotterRecorderServerDelegate >> compressedEventFile [
	^ compressedEventFile
]

{ #category : #accessing }
GTSpotterRecorderServerDelegate >> compressedEventFile: anObject [
	compressedEventFile := anObject
]

{ #category : #private }
GTSpotterRecorderServerDelegate >> generateNewKey [
	^ UUID new asString
]

{ #category : #'request handling' }
GTSpotterRecorderServerDelegate >> handleGetDataRequest: request [ 
	^ self handleGetDataRequest: request fromFile: compressedEventFile
]

{ #category : #'request handling' }
GTSpotterRecorderServerDelegate >> handleGetDataRequest: request fromFile: filename [
	| file entry size time mimeType fileStream entity response modified |
	file := filename asFileReference.
	entry := file entry.
	size := entry size.
	time := entry modificationTime.
	modified := true.
	request headers
		at: 'If-Modified-Since'
		ifPresent: [ modified := time > (ZnUtils parseHttpDate: (request headers at: 'If-Modified-Since')) ].
	modified
		ifTrue: [ 
			mimeType := ZnMimeType forFilenameExtension: file extension.
			fileStream := file readStream.
			fileStream binary.
			(entity := ZnStreamingEntity type: mimeType length: size) 
				stream: fileStream.
			(response := ZnResponse ok: entity) 
				headers at: 'Modification-Date' put: (ZnUtils httpDate: time) ]
		ifFalse: [ response := ZnResponse notModified ].
	^ response
]

{ #category : #'request handling' }
GTSpotterRecorderServerDelegate >> handleGetInfoRequest: request [ 
	^ ZnResponse ok: (ZnEntity text: (
		GTSpotterEventInfo new 
			directory: self storage directory;
			get))
]

{ #category : #'request handling' }
GTSpotterRecorderServerDelegate >> handleGetRequest: request [

	(request uri segments endsWith: #('gt' 'events' 'info')) 
		ifTrue: [ ^ self handleGetInfoRequest: request ].

	(request uri segments endsWith: #('gt' 'events' 'data')) 
		ifTrue: [ ^ self handleGetDataRequest: request ].

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
	storage := GTSpotterRecorderObjectToFileStorage on: FileLocator home / 'gt' / 'events'.
	compressedEventFile := FileLocator home / 'public_html' / 'gt-events.tgz'.
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
