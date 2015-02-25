Class {
	#name : #GTSpotterEventRecorder,
	#superclass : #Object,
	#instVars : [
		'recordedData'
	],
	#classVars : [
		'SaveDataOnImageQuit'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #'class initialization' }
GTSpotterEventRecorder class >> initialize [
	
	Smalltalk 
		addToShutDownList: self
]

{ #category : #accessing }
GTSpotterEventRecorder class >> instance [

	^ instance ifNil: [ instance := self new ]
]

{ #category : #accessing }
GTSpotterEventRecorder class >> reset [
	instance := nil
]

{ #category : #preferences }
GTSpotterEventRecorder class >> saveDataOnImageQuit [

	^ SaveDataOnImageQuit ifNil: [ true ]
]

{ #category : #preferences }
GTSpotterEventRecorder class >> saveDataOnImageQuit: aBoolean [

	SaveDataOnImageQuit := aBoolean
]

{ #category : #'system startup' }
GTSpotterEventRecorder class >> shutDown: quitting [

	(quitting not or: [self saveDataOnImageQuit not]) ifTrue: [ ^ self ].
	self instance initiateDataDelivery.
]

{ #category : #converting }
GTSpotterEventRecorder >> dataAsBinaryStream [
	| stream serializer |
	
	stream := ByteArray new writeStream binary.
	serializer := FLSerializer newDefault.
	serializer at: #hash putAdditionalObject: SmalltalkImage current imageName hash. 
	serializer 
		stream: stream.
	serializer serialize: recordedData.
	^ stream
]

{ #category : #accessing }
GTSpotterEventRecorder >> eventClassNameFor: aSpotterAnnouncementClass [

	^  'GTSpotterRecorder', 
		(aSpotterAnnouncementClass name 
			copyFrom: 'GTSpotter' size + 1
			to: aSpotterAnnouncementClass name size), 
		'Event'.
 	
		

]

{ #category : #initialization }
GTSpotterEventRecorder >> initialize [
	super initialize.
	
	recordedData := OrderedCollection new.
]

{ #category : #delivery }
GTSpotterEventRecorder >> initiateDataDelivery [

	UIManager default informUserDuring: [ :bar |
  	[ ^ (ZnClient new
			beOneShot;
			timeout: 5;
			signalProgress: true;
			numberOfRetries: 3;
  			retryDelay: 2;
			url: self remoteURL;
			enforceHttpSuccess: true;
			ifFail: [ :exception |   ];
			entity: (ZnByteArrayEntity bytes: self dataAsBinaryStream originalContents);
			put;
			response) ]
    on: HTTPProgress 
    do: [ :progress |  
		progress isEmpty ifFalse: [ bar current: progress percentage ].
      progress resume ] ]

]

{ #category : #initialization }
GTSpotterEventRecorder >> linkToSpotter: aSpotterModel [

	aSpotterModel announcer when: Announcement send: #recordAccouncement: to: self
]

{ #category : #events }
GTSpotterEventRecorder >> recordAccouncement: anAnnouncement [
	| recorderEventClassName |

	recorderEventClassName := self eventClassNameFor: anAnnouncement class.
	(Smalltalk hasClassNamed: recorderEventClassName) ifFalse: [ ^ false ].
	
	self storeEvent: (recorderEventClassName asClass fromAnnouncement: anAnnouncement)

	
 	
		

]

{ #category : #events }
GTSpotterEventRecorder >> recordSpotterOpenEvent [

	self storeEvent: GTSpotterRecorderOpenEvent new
]

{ #category : #accessing }
GTSpotterEventRecorder >> remoteURL [
	^ 'http://127.0.0.1:1828'
]

{ #category : #events }
GTSpotterEventRecorder >> storeEvent: anEvent [

	recordedData add: anEvent asRecordedData
]
