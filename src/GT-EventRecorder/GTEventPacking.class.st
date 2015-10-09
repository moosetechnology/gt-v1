Class {
	#name : #GTEventPacking,
	#superclass : #Object,
	#category : #'GT-EventRecorder-Core'
}

{ #category : #packing }
GTEventPacking >> announcementWith: aByteArray [
	^ GTEventAnnouncement new
			data: aByteArray;
			timestamp: DateAndTime now;
			imageHash: SmalltalkImage current imagePath hash;
			imageVersion: SystemVersion current version;
			latestUpdate: SystemVersion current highestUpdate;
			computerUUID: GlobalIdentifier uniqueInstance computerUUID asString;
			sessionUUID: SmalltalkImage current session sid;
			sessionCreationTime: SmalltalkImage current session creationTime;
			eventRecorderVersion: self version;
			yourself			
]

{ #category : #private }
GTEventPacking >> materialize: aByteArray [
	| materializer stream gzstream materialization |
	stream := aByteArray readStream. 
	gzstream := GZipReadStream on: stream.
	materializer := FLMaterializer newDefault.
	materialization := materializer materializeFrom: gzstream.
	gzstream close.
	stream close.
	^ materialization root.
]

{ #category : #packing }
GTEventPacking >> pack: aGTEventCollector [
	^ GTEventBundle new
			url: aGTEventCollector url;
			data: (self packEvents: aGTEventCollector bundle);
			yourself
]

{ #category : #packing }
GTEventPacking >> packEvents: aCollectionOfEvents [
	^ self serialize: (self announcementWith: (self serialize: aCollectionOfEvents))
]

{ #category : #private }
GTEventPacking >> serialize: anObject [
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

{ #category : #packing }
GTEventPacking >> unpack: aByteArray [
	^ self materialize: aByteArray
]

{ #category : #accessing }
GTEventPacking >> version [
	^ 3
	
"Changes to version 3:
	- GTSpotterEventRecorder rewritten to GTEventRecorder.
	- It uses STON instead of FUEL serializing engine.
Changes to version 2:
	- GTSpotterEventRecorder>>timestamp keeps DateAndTime object. 
	  Before, it was an integer as unix time.
"
]
