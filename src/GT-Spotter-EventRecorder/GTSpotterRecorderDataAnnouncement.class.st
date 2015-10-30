"
A GTSpotterRecorderDataAnnouncement is an announcement that  groups  all  usage data  that is send over the network.  Appart from the actual recorded data in includes some meta-data about the image and the UUID of the computer.

Instance Variables
	computerUUID:		<Object>
	data:		<Object>
	imageHash:		<Object>
	imageVersion:		<Object>
	latestUpdate:		<Object>
	sessionCreationTime:		<Object>
	timestamp:		<Object>

computerUUID
	- xxxxx

data
	- xxxxx

imageHash
	- xxxxx

imageVersion
	- xxxxx

latestUpdate
	- xxxxx

sessionCreationTime
	- xxxxx

timestamp
	- xxxxx

"
Class {
	#name : #GTSpotterRecorderDataAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'dictionary'
	],
	#category : #'GT-Spotter-EventRecorder-Announcements'
}

{ #category : #examples }
GTSpotterRecorderDataAnnouncement class >> gtExampleAnnouncement [
	<gtExample>
	^ self new
			data: #[ 1 2 3 4 ];
			timestamp: DateAndTime now;
			imageHash: SmalltalkImage current imagePath hash;
			sessionCreationTime: SmalltalkImage current session creationTime;
			imageVersion: SystemVersion current version;
			latestUpdate: SystemVersion current highestUpdate;
			computerUUID: GTSpotterEventRecorderSettings uniqueInstance computerUUID asString;
			eventRecorderVersion: 2;
			yourself
]

{ #category : #examples }
GTSpotterRecorderDataAnnouncement class >> gtExampleEmptyAnnouncement [
	<gtExample>
	^ self new
]

{ #category : #updating }
GTSpotterRecorderDataAnnouncement >> addInfoFor: aGTSpotterRecorderEvent [ 
	dictionary keysAndValuesDo: [ :key :value |
		key = #data ifFalse: [ 
			aGTSpotterRecorderEvent infoAt: key put: value ] ]
]

{ #category : #converting }
GTSpotterRecorderDataAnnouncement >> associations [
	^ dictionary 
			ifNil: [ #() ]
			ifNotNil: [ dictionary associations ]
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> at: key [
	^ self dictionary at: key ifAbsent: [ nil ]
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> at: key put: value [
	^ self dictionary at: key put: value
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> computerUUID [
	^ self at: #computerUUID
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> computerUUID: anObject [
	self at: #computerUUID put: anObject
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> data [
	^ self at: #data
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> data: aByteArray [ 
	self at: #data put: aByteArray
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> dictionary [
	^ dictionary ifNil: [ dictionary := Dictionary new ]
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> eventRecorderVersion [
	^ self at: #eventRecorderVersion
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> eventRecorderVersion: anObject [
	self at: #eventRecorderVersion put: anObject
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> events [
	| events |
	events := self materializedData.
	events do: [ :each | self addInfoFor: each ].
	^ events
]

{ #category : #'gt-inspector-extension' }
GTSpotterRecorderDataAnnouncement >> gtInspectorItems [
	^ OrderedCollection withAll: self associations
]

{ #category : #'gt-inspector-extension' }
GTSpotterRecorderDataAnnouncement >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: -1>  
	^ (composite table)
		title: 'Info';
		display: [ :anEvent | anEvent gtInspectorItems ];
		children: [ :each | 
			(each value isDictionary) 
				ifTrue: [ each value associations ] 
				ifFalse: [ (each value isArray and: [ each value allSatisfy: #isDictionary ])
						ifTrue: [ each value collectWithIndex: [:x :i | i -> x ] ]
						ifFalse: [ #() ] ] ];
		column: 'Key' 
			evaluated: [:each | GTObjectPrinter new asTruncatedTextFrom: each key ];
		column: 'Value' 
			evaluated: [:each | GTObjectPrinter new asTruncatedTextFrom: each value ];
		showOnly: 50
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> imageHash [
	^ self at: #imageHash
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> imageHash: anObject [
	self at: #imageHash put: anObject
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> imageVersion [
	^ self at: #imageVersion
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> imageVersion: anObject [
	self at: #imageVersion put: anObject
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> latestUpdate [
	^ self at: #latestUpdate
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> latestUpdate: anObject [
	self at: #latestUpdate put: anObject
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> materializedData [
	^ self data ifNotNil: [ :aData | GTEventUnpacking default unpack: aData ]
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> sessionCreationTime [
	^ self at: #sessionCreationTime
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> sessionCreationTime: anObject [
	self at: #sessionCreationTime put: anObject
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> timestamp [
	^ self at: #timestamp
]

{ #category : #accessing }
GTSpotterRecorderDataAnnouncement >> timestamp: anObject [
	self at: #timestamp put: anObject
]
