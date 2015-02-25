Class {
	#name : #GTSpotterRecorderServerDelegate,
	#superclass : #Object,
	#category : #'GT-Spotter-EventRecorder-Server'
}

{ #category : #'as yet unclassified' }
GTSpotterRecorderServerDelegate >> handleGetRequest: request [

	^ ZnResponse ok: (ZnEntity text: 'OK')
	
]

{ #category : #'as yet unclassified' }
GTSpotterRecorderServerDelegate >> handlePostRequest: request [
	| badRequest |
	
	badRequest := [ ^ ZnResponse badRequest: request ].
	(request hasEntity and: [ request contentType matches: ZnMimeType applicationOctetStream ])
		ifFalse: badRequest.
	[ self saveDataFrom: request entity ] on: Error do: badRequest.
	^ ZnResponse ok: (ZnEntity text: 'OK')
	
]

{ #category : #'as yet unclassified' }
GTSpotterRecorderServerDelegate >> handleRequest: request [

	request method = #PUT
		ifTrue: [ 
			^ self handlePostRequest: request ].
	request method = #GET		
		ifTrue: [ 
			^ self handleGetRequest: request ].
	^ ZnResponse notFound: request uri
]

{ #category : #'as yet unclassified' }
GTSpotterRecorderServerDelegate >> saveDataFrom: aByteArray [
	|materialization|
	materialization := FLMaterializer newDefault materializeFrom: aByteArray readStream.
	self storage add: (GTSpotterRecorderServerDataChunk new
		imageHash: (materialization additionalObjectAt: #hash);
		content: materialization root)
]

{ #category : #'as yet unclassified' }
GTSpotterRecorderServerDelegate >> storage [

	^ GTSpotterRecorderServerStorage instance
]
