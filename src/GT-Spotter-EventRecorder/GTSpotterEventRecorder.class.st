Class {
	#name : #GTSpotterEventRecorder,
	#superclass : #Object,
	#instVars : [
		'recordedData',
		'mutex',
		'proxy',
		'process',
		'deliveryDelay',
		'shouldDeliver'
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
	self instance lastDataDelivery.
]

{ #category : #delivery }
GTSpotterEventRecorder >> announcementFrom: oldRecordedData [
	^ GTSpotterRecorderDataAnnouncement new
			data: (self dataAsBinaryStream: oldRecordedData) originalContents;
			timestamp: DateAndTime now;
			imageHash: SmalltalkImage current imageName hash;
			sessionCreationTime: SmalltalkImage current session creationTime;
			yourself
]

{ #category : #converting }
GTSpotterEventRecorder >> dataAsBinaryStream [
	^ self dataAsBinaryStream: recordedData
]

{ #category : #converting }
GTSpotterEventRecorder >> dataAsBinaryStream: aRecordedData [
	| stream serializer |
	
	stream := ByteArray new writeStream binary.
	serializer := FLSerializer newDefault.
	serializer 
		stream: stream.
	serializer serialize: aRecordedData.
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
	
	recordedData := self newRecordedData.
	proxy := self newProxy.
	mutex := Mutex new.
	self initializeDeliveryProcess.
]

{ #category : #initialization }
GTSpotterEventRecorder >> initializeDeliveryProcess [
	process := [ [ self shouldDeliver ] whileTrue: [ 
						self sendChunk.
						deliveryDelay := self standardDuration asDelay.
						deliveryDelay wait.
						deliveryDelay := nil. ] ] 
		forkAt: Processor userBackgroundPriority 
		named: self className, ' regular delivery process'
]

{ #category : #delivery }
GTSpotterEventRecorder >> initiateDataDelivery [
	"To be deleted"
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

{ #category : #delivery }
GTSpotterEventRecorder >> lastDataDelivery [
	"Maybe we could do nothing. 
	The data can be send next time or never.
	Otherwise I have to wait for sometime. To send it to server.
	Now it is async-operation."
	self sendChunk.
]

{ #category : #initialization }
GTSpotterEventRecorder >> linkToSpotter: aSpotterModel [

	aSpotterModel announcer weak when: Announcement send: #recordAccouncement: to: self
]

{ #category : #'instance creation' }
GTSpotterEventRecorder >> newProxy [
	| newProxy |
	newProxy := RAProxy new.
	newProxy url: self remoteURL.
	newProxy useAutoConnection.
	newProxy useRetryStrategy sendEvery: self standardDuration.
	newProxy useSilentBroker.
	^ newProxy
]

{ #category : #'instance creation' }
GTSpotterEventRecorder >> newRecordedData [
	^ OrderedCollection new
]

{ #category : #accessing }
GTSpotterEventRecorder >> proxy [
	^ proxy
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
	^ GTSpotterEventRecorderSettings url
]

{ #category : #delivery }
GTSpotterEventRecorder >> sendChunk [
	| oldRecordedData |
	mutex
		critical: [ 
			recordedData ifEmpty: [ ^ self ].
			oldRecordedData := recordedData.
			recordedData := self newRecordedData ].
	self proxy announce: (self announcementFrom: oldRecordedData)
]

{ #category : #accessing }
GTSpotterEventRecorder >> shouldDeliver [
	^ shouldDeliver ifNil: [ shouldDeliver := true ]
]

{ #category : #accessing }
GTSpotterEventRecorder >> standardDuration [
	^ 5 minutes
]

{ #category : #delivery }
GTSpotterEventRecorder >> stopDelivering [
	mutex critical: [ 
		shouldDeliver := false.
		deliveryDelay ifNotNil: [ :aDelay | aDelay delaySemaphore signal ] ]
]

{ #category : #events }
GTSpotterEventRecorder >> storeEvent: anEvent [
	mutex critical: [ 
		recordedData add: anEvent asRecordedData.
		process isTerminated ifTrue: [ self initializeDeliveryProcess ] ]
]
