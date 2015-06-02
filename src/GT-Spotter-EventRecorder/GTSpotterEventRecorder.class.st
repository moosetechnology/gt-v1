"
A GTSpotterEventRecorder provides the main functionality for recording and sending usage data in Spotter. The collection and delivery works as follows:

- the recorder registers with Spotter every time Spotter is opened ;
- as long as the setting #sendUsageData is set to false all events received by the recorder are discarded;
- the first time an event is send to the recorder and the setting#sendUsageData is set to true a delivery process is started
- as long as the setting #sendUsageData is set to true all interesting events received by the recorder are stored
- at certain intervals the delivery process collects all data, compressed it, and places a payload to a delivery queue.
- the delivery process takes the next paylod from the queue and attepts to send it to a server; on sucsess the payload is removed from the queue.
- if the setting #sendUsageData is set to false, events are no longer collected and all recorded data is removed next time the delivery process resumes.

The delivery process is not stopped by default after creation. The class size method #cleanUp stops the delivery process and removes all data that still awaits delivery.

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
		'shouldDeliver',
		'postponedData'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'GT-Spotter-EventRecorder-Base'
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
	"self instance"
	^ instance ifNil: [ instance := self new ]
]

{ #category : #converting }
GTSpotterEventRecorder class >> materialize: aByteArray [
	| materializer stream gzstream materialization |
	stream := aByteArray readStream. 
	gzstream := GZipReadStream on: stream.
	materializer := FLMaterializer newDefault.
	materialization := materializer materializeFrom: gzstream.
	gzstream close.
	stream close.
	^ materialization root.
]

{ #category : #converting }
GTSpotterEventRecorder class >> materializeObjectsFromDirectory: aFileReference [
	"self materializeObjectsFromDirectory: './gt/events/' asFileReference"
	^ aFileReference asFileReference allFiles collect: [ :eachFile |
		self materializeObjectsFromFile: eachFile ]  
]

{ #category : #converting }
GTSpotterEventRecorder class >> materializeObjectsFromFile: aFileReference [ 
	"self materializeObjectsFromFile: './gt/events/' asFileReference allFiles any"
	^ self materialize: (aFileReference binaryReadStreamDo: #contents)
]

{ #category : #accessing }
GTSpotterEventRecorder class >> reset [
	instance := nil
]

{ #category : #converting }
GTSpotterEventRecorder class >> serialize: anObject [
	| serializer stream gzstream |
	stream := ByteArray new writeStream binary. 
	gzstream := GZipWriteStream on: stream.
	serializer := FLSerializer newDefault.
	serializer at: #recorderVersion putAdditionalObject: self version.
	serializer stream: gzstream.
	serializer serialize: anObject.
	gzstream close.
	stream close.
	^ stream contents.
]

{ #category : #accessing }
GTSpotterEventRecorder class >> version [
	^ 2
	
"Changes to version 2:
	- GTSpotterRecorderEvent>>timestamp keeps DateAndTime object. 
	  Before, it was an integer as unix time.
"
]

{ #category : #converting }
GTSpotterEventRecorder >> announcementFrom: oldRecordedData [
	^ GTSpotterRecorderDataAnnouncement new
			data: (self serialize: oldRecordedData);
			timestamp: DateAndTime now;
			imageHash: SmalltalkImage current imagePath hash;
			sessionCreationTime: SmalltalkImage current session creationTime;
			imageVersion: SystemVersion current version;
			latestUpdate: SystemVersion current highestUpdate;
			computerUUID: GTSpotterEventRecorderSettings uniqueInstance computerUUID asString;
			eventRecorderVersion: GTSpotterEventRecorder version;
			yourself
]

{ #category : #events }
GTSpotterEventRecorder >> buildAndStoreEventFrom: anAnnouncement withType: aClass [
	self storeEvent: (aClass fromAnnouncement: anAnnouncement)

	
 	
		

]

{ #category : #testing }
GTSpotterEventRecorder >> canSendUsageData [
	^ GTSpotterEventRecorderSettings sendUsageData
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
	deliveryDelay ifNotNil: [ :aDelay | aDelay delaySemaphore signal. aDelay unschedule. ]
]

{ #category : #delivery }
GTSpotterEventRecorder >> deliveryQueue [
	"for testing purpose only"
	^ deliveryQueue
]

{ #category : #accessing }
GTSpotterEventRecorder >> eventClassNameFor: aSpotterAnnouncementClass [

	^  'GTSpotterRecorder', 
		(aSpotterAnnouncementClass name 
			copyFrom: 'GTSpotter' size + 1
			to: aSpotterAnnouncementClass name size), 
		'Event'.
 	
		

]

{ #category : #delivery }
GTSpotterEventRecorder >> flushRecordedData [
	"For debugging purpose only. Remember that those data will not be published."
	| collection |
	collection := OrderedCollection new.
	recordedData flush: [ :eachItem | collection add: eachItem ].
	^ collection
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
						deliveryDelay := self standardDuration asDelay.
						deliveryDelay wait.
						deliveryDelay := nil.
						self shouldDeliver ifTrue: [ self deliverAndSignalProgress: false ] ] ] 
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

{ #category : #converting }
GTSpotterEventRecorder >> materialize: aByteArray [
	^ self class materialize: aByteArray
]

{ #category : #converting }
GTSpotterEventRecorder >> materializedAnnouncementFrom: aByteArray [ 
	^ self materialize: aByteArray
]

{ #category : #delivery }
GTSpotterEventRecorder >> newCollectionWithPostponedData [
	^ postponedData 
			ifNil: [ OrderedCollection new ]
			ifNotNil: [ :aCollection | postponedData := nil. aCollection ]
	
]

{ #category : #delivery }
GTSpotterEventRecorder >> postponeSomeData: aCollection [ 
	| lastExitIndex |
	lastExitIndex := aCollection findLast: [ :each | each isCloseSpotter ].
	lastExitIndex = aCollection size ifTrue: [ ^ aCollection ].
	postponedData := aCollection copyFrom: lastExitIndex + 1 to: aCollection size.
	^ aCollection first: lastExitIndex.
]

{ #category : #delivery }
GTSpotterEventRecorder >> postponedData [
	"For testing/debugging purpose."
	^ postponedData
]

{ #category : #delivery }
GTSpotterEventRecorder >> prepareDeliveryData [
	self canSendUsageData ifFalse: [ 
		recordedData removeAll.
		deliveryQueue removeAll.
		postponedData := nil.
		^ self ].
	recordedData isEmpty ifTrue: [ ^ self ].
	GTSpotterEventRecorderSettings ensureComputerID.
	self primitivePrepareDeliveryData
]

{ #category : #delivery }
GTSpotterEventRecorder >> primitivePrepareDeliveryData [
	| likelyDeliveredData toBeDeliveredData toBeDeliveredAnnouncement |
	likelyDeliveredData := self newCollectionWithPostponedData.
	recordedData flush: [ :eachRecord | likelyDeliveredData addLast: eachRecord ].
	toBeDeliveredData := self postponeSomeData: likelyDeliveredData.
	toBeDeliveredAnnouncement := self serializedAnnouncementFrom: toBeDeliveredData.
	deliveryQueue nextPut: toBeDeliveredAnnouncement.
]

{ #category : #events }
GTSpotterEventRecorder >> recordAccouncement: anAnnouncement [

	self canSendUsageData ifFalse: [ ^ self ].

	"recorderEventClassName := self eventClassNameFor: anAnnouncement class.
	(Smalltalk hasClassNamed: recorderEventClassName) ifFalse: [ ^ false ].
	self storeEvent: (recorderEventClassName asClass fromAnnouncement: anAnnouncement)"
	
	anAnnouncement class == GTSpotterActOn ifTrue: [ ^self buildAndStoreEventFrom: anAnnouncement withType: GTSpotterRecorderActOnEvent ].
	
	anAnnouncement class == GTSpotterCategorySelected ifTrue: [ ^self buildAndStoreEventFrom: anAnnouncement withType: GTSpotterRecorderCategorySelectedEvent ].
	
	anAnnouncement class == GTSpotterContextChanged ifTrue: [ ^self buildAndStoreEventFrom: anAnnouncement withType: GTSpotterRecorderContextChangedEvent ].
	
	anAnnouncement class == GTSpotterDiveInCategory ifTrue: [ ^self buildAndStoreEventFrom: anAnnouncement withType: GTSpotterRecorderDiveInCategoryEvent ].
	
	anAnnouncement class == GTSpotterDiveInElement ifTrue: [ ^self buildAndStoreEventFrom: anAnnouncement withType: GTSpotterRecorderDiveInElementEvent ].
	
	anAnnouncement class == GTSpotterDiveOut ifTrue: [ ^self buildAndStoreEventFrom: anAnnouncement withType: GTSpotterRecorderDiveOutEvent ].
	
	anAnnouncement class == GTSpotterExitAnnouncement ifTrue: [ ^self buildAndStoreEventFrom: anAnnouncement withType: GTSpotterRecorderExitAnnouncementEvent ].
	
	anAnnouncement class == GTSpotterHidePreview ifTrue: [ ^self buildAndStoreEventFrom: anAnnouncement withType: GTSpotterRecorderHidePreviewEvent ].
	
	anAnnouncement class == GTSpotterSelectedCandidateChanged ifTrue: [ ^self buildAndStoreEventFrom: anAnnouncement withType: GTSpotterRecorderSelectedCandidateChangedEvent ].
	
	anAnnouncement class == GTSpotterShowPreview ifTrue: [ ^self buildAndStoreEventFrom: anAnnouncement withType: GTSpotterRecorderShowPreviewEvent ].
	
	anAnnouncement class == GTSpotterSearchFinished ifTrue: [ ^self buildAndStoreEventFrom: anAnnouncement withType: GTSpotterRecorderSearchFinishedEvent ].
	

	
 	
		

]

{ #category : #events }
GTSpotterEventRecorder >> recordSpotterOpenEvent [

	self canSendUsageData ifFalse: [ ^ self ].

	self storeEvent: GTSpotterRecorderOpenEvent new
]

{ #category : #events }
GTSpotterEventRecorder >> recordedData [
	"For testing purpose only."
	^ recordedData
]

{ #category : #accessing }
GTSpotterEventRecorder >> remoteURL [
	^ GTSpotterEventRecorderSettings url
]

{ #category : #converting }
GTSpotterEventRecorder >> serialize: anObject [
	^ self class serialize: anObject
]

{ #category : #converting }
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
