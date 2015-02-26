Class {
	#name : #GTSpotterEventRecorder,
	#superclass : #Object,
	#instVars : [
		'recordedData',
		'mutex',
		'process',
		'deliveryDelay',
		'deliveryQueue',
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
			data: (self serialize: oldRecordedData);
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

{ #category : #delivery }
GTSpotterEventRecorder >> deliverAndSignalProgress: aBoolean [
	self 
		prepareDeliveryData;
		deliverDataAndSignalProgress: aBoolean.

]

{ #category : #delivery }
GTSpotterEventRecorder >> deliverData: aByteArray signalProgress: aBoolean [
	^ (ZnClient new
			beOneShot;
			timeout: 5;
			signalProgress: aBoolean;
			numberOfRetries: 3;
  			retryDelay: 2;
			url: self remoteURL;
			enforceHttpSuccess: true;
			ifFail: [ :exception | deliveryQueue nextPut: aByteArray ];
			entity: (ZnByteArrayEntity bytes: aByteArray);
			put;
			response)
]

{ #category : #delivery }
GTSpotterEventRecorder >> deliverDataAndSignalProgress: aBoolean [
	deliveryQueue flush: [ :eachByteArray |
		self deliverData: eachByteArray signalProgress: aBoolean ]
]

{ #category : #delivery }
GTSpotterEventRecorder >> deliverNow [
	"for testing purpose"
	deliveryDelay ifNotNil: [ :aDelay | aDelay delaySemaphore signal. "aDelay unschedule." ]
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
	
	recordedData := WaitfreeQueue new.
	deliveryQueue := WaitfreeQueue new.
	mutex := Mutex new.
	self initializeDeliveryProcess.
]

{ #category : #initialization }
GTSpotterEventRecorder >> initializeDeliveryProcess [
	process := [ [ self shouldDeliver ] whileTrue: [ 
						self deliverAndSignalProgress: false.
						deliveryDelay := self standardDuration asDelay.
						deliveryDelay wait.
						deliveryDelay := nil. ] ] 
		forkAt: Processor userBackgroundPriority 
		named: self className, ' regular delivery process'
]

{ #category : #delivery }
GTSpotterEventRecorder >> lastDataDelivery [
	UIManager default informUserDuring: [ :bar |
	  	[ self deliverAndSignalProgress: true ]
	    on: HTTPProgress 
	    do: [ :progress |  
			progress isEmpty ifFalse: [ bar current: progress percentage ].
	      progress resume ] ]

]

{ #category : #initialization }
GTSpotterEventRecorder >> linkToSpotter: aSpotterModel [

	aSpotterModel announcer weak when: Announcement send: #recordAccouncement: to: self
]

{ #category : #'instance creation' }
GTSpotterEventRecorder >> newRecordedData [
	^ WaitfreeQueue new
]

{ #category : #delivery }
GTSpotterEventRecorder >> prepareDeliveryData [
	| toBeDeliveredData toBeDeliveredAnnouncement |
	recordedData isEmpty ifTrue: [ ^ self ].
	toBeDeliveredData := OrderedCollection new.
	recordedData flush: [ :eachRecord | toBeDeliveredData addLast: eachRecord ].
	toBeDeliveredAnnouncement := self serializedAnnouncementFrom: toBeDeliveredData.
	deliveryQueue nextPut: toBeDeliveredAnnouncement.
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

{ #category : #converting }
GTSpotterEventRecorder >> serialize: anObject [
	^ FLSerializer serializeToByteArray: anObject
]

{ #category : #delivery }
GTSpotterEventRecorder >> serializedAnnouncementFrom: oldRecordedData [
	^ self serialize: (self announcementFrom: oldRecordedData)
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
	recordedData nextPut: anEvent asRecordedData.
	mutex critical: [ 
		process isTerminated ifTrue: [ self initializeDeliveryProcess ] ]
]
