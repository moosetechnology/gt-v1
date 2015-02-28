"
A GTSpotterEventRecorder provides the main functionality for recording and sending usage data in Spotter.

Instance Variables
	deliveryDelay:		<Object>
	deliveryQueue:		<Object>
	mutex:		<Object>
	process:		<Object>
	recordedData:		<Object>
	shouldDeliver:		<Object>

deliveryDelay
	- xxxxx

deliveryQueue
	- xxxxx

mutex
	- xxxxx

process
	- xxxxx

recordedData
	- xxxxx

shouldDeliver
	- xxxxx

"
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
	#classInstVars : [
		'instance'
	],
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #accessing }
GTSpotterEventRecorder class >> cleanUp [
	"Stop and remove the process for sending usage data. Delete all recorder that from the queue."
	
	instance ifNotNil: [ 
		instance stopDelivering ifNotNil: [ :aProcess | 
			[ aProcess terminate ] on: Error do: [ "ignore error" ] ].
		instance := nil ]

]

{ #category : #accessing }
GTSpotterEventRecorder class >> instance [

	^ instance ifNil: [ instance := self new ]
]

{ #category : #accessing }
GTSpotterEventRecorder class >> reset [
	instance := nil
]

{ #category : #delivery }
GTSpotterEventRecorder >> announcementFrom: oldRecordedData [
	^ GTSpotterRecorderDataAnnouncement new
			data: (self serialize: oldRecordedData);
			timestamp: DateAndTime now;
			imageHash: SmalltalkImage current imageName hash;
			sessionCreationTime: SmalltalkImage current session creationTime;
			imageVersion: SystemVersion current version;
			latestUpdate: SystemVersion current highestUpdate;
			computerUUID: GTSpotterEventRecorderSettings uniqueInstance computerUUID;
			yourself
]

{ #category : #testing }
GTSpotterEventRecorder >> canSendUsageData [
	^ GTSpotterEventRecorderSettings uniqueInstance sendUsageData
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
			numberOfRetries: 0;
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

	self canSendUsageData ifFalse: [ ^ self ].

	recorderEventClassName := self eventClassNameFor: anAnnouncement class.
	(Smalltalk hasClassNamed: recorderEventClassName) ifFalse: [ ^ false ].
	
	self storeEvent: (recorderEventClassName asClass fromAnnouncement: anAnnouncement)

	
 	
		

]

{ #category : #events }
GTSpotterEventRecorder >> recordSpotterOpenEvent [

	self canSendUsageData ifFalse: [ ^ self ].

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
	^ 20 minutes
]

{ #category : #delivery }
GTSpotterEventRecorder >> stopDelivering [
	^ mutex critical: [ | oldProcess |
		shouldDeliver := false.
		deliveryDelay ifNotNil: [ :aDelay | aDelay delaySemaphore signal ].
		oldProcess := process.
		process := nil.
		oldProcess ]
]

{ #category : #events }
GTSpotterEventRecorder >> storeEvent: anEvent [
	recordedData nextPut: anEvent.
	mutex critical: [ 
		(process isNil or: [ process isTerminated ]) ifTrue: [ self initializeDeliveryProcess ] ]
]
