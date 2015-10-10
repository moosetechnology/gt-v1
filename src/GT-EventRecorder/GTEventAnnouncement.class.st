Class {
	#name : #GTEventAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'dictionary'
	],
	#category : #'GT-EventRecorder-Announcements'
}

{ #category : #examples }
GTEventAnnouncement class >> gtExampleAnnouncement [
	<gtExample>
	^ self new
			data: #[ 1 2 3 4 ];
			timestamp: DateAndTime now;
			imageHash: SmalltalkImage current imagePath hash;
			sessionCreationTime: SmalltalkImage current session creationTime;
			imageVersion: SystemVersion current version;
			latestUpdate: SystemVersion current highestUpdate;
			computerUUID: GTSpotterEventRecorderSettings uniqueInstance computerUUID asString;
			eventRecorderVersion: GTSpotterEventRecorder version;
			yourself
]

{ #category : #examples }
GTEventAnnouncement class >> gtExampleEmptyAnnouncement [
	<gtExample>
	^ self new
]

{ #category : #updating }
GTEventAnnouncement >> addInfoFor: aGTSpotterRecorderEvent [ 
	dictionary keysAndValuesDo: [ :key :value |
		key = #data ifFalse: [ 
			aGTSpotterRecorderEvent infoAt: key put: value ] ]
]

{ #category : #converting }
GTEventAnnouncement >> associations [
	^ dictionary 
			ifNil: [ #() ]
			ifNotNil: [ dictionary associations ]
]

{ #category : #accessing }
GTEventAnnouncement >> at: key [
	^ self dictionary at: key ifAbsent: [ nil ]
]

{ #category : #accessing }
GTEventAnnouncement >> at: key put: value [
	^ self dictionary at: key put: value
]

{ #category : #accessing }
GTEventAnnouncement >> computerUUID [
	^ self at: #computerUUID
]

{ #category : #accessing }
GTEventAnnouncement >> computerUUID: anObject [
	self at: #computerUUID put: anObject
]

{ #category : #accessing }
GTEventAnnouncement >> data [
	^ self at: #data
]

{ #category : #accessing }
GTEventAnnouncement >> data: aByteArray [ 
	self at: #data put: aByteArray
]

{ #category : #accessing }
GTEventAnnouncement >> dictionary [
	^ dictionary ifNil: [ dictionary := Dictionary new ]
]

{ #category : #accessing }
GTEventAnnouncement >> eventRecorderVersion [
	^ self at: #eventRecorderVersion
]

{ #category : #accessing }
GTEventAnnouncement >> eventRecorderVersion: anObject [
	self at: #eventRecorderVersion put: anObject
]

{ #category : #accessing }
GTEventAnnouncement >> events [
	| events |
	events := self materializedData.
	events do: [ :each | self addInfoFor: each ].
	^ events
]

{ #category : #'gt-inspector-extension' }
GTEventAnnouncement >> gtInspectorItems [
	^ OrderedCollection withAll: self associations
]

{ #category : #'gt-inspector-extension' }
GTEventAnnouncement >> gtInspectorItemsIn: composite [
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
GTEventAnnouncement >> imageHash [
	^ self at: #imageHash
]

{ #category : #accessing }
GTEventAnnouncement >> imageHash: anObject [
	self at: #imageHash put: anObject
]

{ #category : #accessing }
GTEventAnnouncement >> imageVersion [
	^ self at: #imageVersion
]

{ #category : #accessing }
GTEventAnnouncement >> imageVersion: anObject [
	self at: #imageVersion put: anObject
]

{ #category : #accessing }
GTEventAnnouncement >> latestUpdate [
	^ self at: #latestUpdate
]

{ #category : #accessing }
GTEventAnnouncement >> latestUpdate: anObject [
	self at: #latestUpdate put: anObject
]

{ #category : #accessing }
GTEventAnnouncement >> serializedBy [
	^ self dictionary at: #serializedBy ifAbsent: [ GTFuelPacking name ]
]

{ #category : #accessing }
GTEventAnnouncement >> serializedBy: anObject [
	self at: #serializedBy put: anObject
]

{ #category : #accessing }
GTEventAnnouncement >> sessionCreationTime [
	^ self at: #sessionCreationTime
]

{ #category : #accessing }
GTEventAnnouncement >> sessionCreationTime: anObject [
	self at: #sessionCreationTime put: anObject
]

{ #category : #accessing }
GTEventAnnouncement >> sessionUUID [
	^ self at: #sessionUUID
]

{ #category : #accessing }
GTEventAnnouncement >> sessionUUID: anObject [
	self at: #sessionUUID put: anObject
]

{ #category : #accessing }
GTEventAnnouncement >> timestamp [
	^ self at: #timestamp
]

{ #category : #accessing }
GTEventAnnouncement >> timestamp: anObject [
	self at: #timestamp put: anObject
]

{ #category : #accessing }
GTEventAnnouncement >> unpackedData [
	^ self data ifNotNil: [ :aData | 	self serializedBy asClass new materialize: aData ]
]