Class {
	#name : #GTEventPacking,
	#superclass : #Object,
	#category : #'GT-EventRecorder-Core'
}

{ #category : #'instance creation' }
GTEventPacking class >> fuel [
	^ GTFuelPacking new
]

{ #category : #'instance creation' }
GTEventPacking class >> ston [
	^ GTStonPacking new
]

{ #category : #packing }
GTEventPacking >> announcementWith: aByteArray [
	^ GTEventAnnouncement new
			data: aByteArray;
			serializedBy: self class name;
			eventRecorderVersion: self version;
			timestamp: DateAndTime now;
			imageHash: SmalltalkImage current imagePath hash;
			imageVersion: SystemVersion current version;
			latestUpdate: SystemVersion current highestUpdate;
			computerUUID: GlobalIdentifier uniqueInstance computerUUID asString;
			sessionUUID: SmalltalkImage current session sid;
			sessionCreationTime: SmalltalkImage current session creationTime;
			yourself			
]

{ #category : #private }
GTEventPacking >> materialize: aByteArray [
	^ self subclassResponsibility
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
	^ self subclassResponsibility
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
		- FUEL engine is still available using GTFuelPacking object
Changes to version 2 (FUEL):
	- GTSpotterEventRecorder>>timestamp keeps DateAndTime object. 
	  Before, it was an integer as unix time.
"
]
