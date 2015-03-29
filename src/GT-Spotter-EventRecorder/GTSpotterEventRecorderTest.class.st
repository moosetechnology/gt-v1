"
A GTSpotterEventRecorderTest is a test class for testing the behavior of GTSpotterEventRecorder
"
Class {
	#name : #GTSpotterEventRecorderTest,
	#superclass : #TestCase,
	#instVars : [
		'recorder'
	],
	#category : #'GT-Spotter-EventRecorder-Tests'
}

{ #category : #accessing }
GTSpotterEventRecorderTest >> recordedData [
	^ GTSpotterRecorderEvent allSubclasses collect: #new
]

{ #category : #running }
GTSpotterEventRecorderTest >> setUp [
	super setUp.
	recorder := GTSpotterEventRecorder new.
	recorder stopDelivering.
]

{ #category : #tests }
GTSpotterEventRecorderTest >> testPostponeSomeDataOnAct [
	| maybeDeliveredData toBeDeliveredData postponedData |
	self assert: recorder postponedData isNil.
	maybeDeliveredData := recorder newCollectionWithPostponedData.
	self assert: maybeDeliveredData size equals: 0.
	maybeDeliveredData 
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new;
		add: GTSpotterRecorderExitAnnouncementEvent new;
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new;
		add: GTSpotterRecorderActOnEvent new;
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new.
	toBeDeliveredData := recorder postponeSomeData: maybeDeliveredData.
	postponedData := recorder postponedData.
	self assert: toBeDeliveredData size equals: 6.
	self assert: postponedData size equals: 2.
	1 to: 6 do: [ :index |
		self assert: (maybeDeliveredData at: index) == (toBeDeliveredData at: index) ].
	7 to: 8 do: [ :index |
		self assert: (maybeDeliveredData at: index) == (postponedData at: index - 6) ].
	"second delivery"
	maybeDeliveredData := recorder newCollectionWithPostponedData.
	self assert: recorder postponedData isNil.
	self assert: maybeDeliveredData size equals: 2.
	1 to: 2 do: [ :index |
		self assert: (maybeDeliveredData at: index) == (postponedData at: index) ].
	self assert: recorder postponedData isNil.
	maybeDeliveredData
		add: GTSpotterRecorderActOnEvent new.
	toBeDeliveredData := recorder postponeSomeData: maybeDeliveredData.
	postponedData := recorder postponedData.
	self assert: toBeDeliveredData size equals: 3.
	self assert: postponedData isNil.
	1 to: 3 do: [ :index |
		self assert: (maybeDeliveredData at: index) == (toBeDeliveredData at: index) ].

]

{ #category : #tests }
GTSpotterEventRecorderTest >> testPostponeSomeDataOnExit [
	| maybeDeliveredData toBeDeliveredData postponedData |
	self assert: recorder postponedData isNil.
	maybeDeliveredData := recorder newCollectionWithPostponedData.
	self assert: maybeDeliveredData size equals: 0.
	maybeDeliveredData 
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new;
		add: GTSpotterRecorderExitAnnouncementEvent new;
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new;
		add: GTSpotterRecorderExitAnnouncementEvent new;
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new.
	toBeDeliveredData := recorder postponeSomeData: maybeDeliveredData.
	postponedData := recorder postponedData.
	self assert: toBeDeliveredData size equals: 6.
	self assert: postponedData size equals: 2.
	1 to: 6 do: [ :index |
		self assert: (maybeDeliveredData at: index) == (toBeDeliveredData at: index) ].
	7 to: 8 do: [ :index |
		self assert: (maybeDeliveredData at: index) == (postponedData at: index - 6) ].
	"second delivery"
	maybeDeliveredData := recorder newCollectionWithPostponedData.
	self assert: recorder postponedData isNil.
	self assert: maybeDeliveredData size equals: 2.
	1 to: 2 do: [ :index |
		self assert: (maybeDeliveredData at: index) == (postponedData at: index) ].
	self assert: recorder postponedData isNil.
	maybeDeliveredData
		add: GTSpotterRecorderExitAnnouncementEvent new.
	toBeDeliveredData := recorder postponeSomeData: maybeDeliveredData.
	postponedData := recorder postponedData.
	self assert: toBeDeliveredData size equals: 3.
	self assert: postponedData isNil.
	1 to: 3 do: [ :index |
		self assert: (maybeDeliveredData at: index) == (toBeDeliveredData at: index) ].

]

{ #category : #tests }
GTSpotterEventRecorderTest >> testPrimitivePrepareDeliveryData [
	| maybeDeliveredData  postponedData bytes announcement events |
	self assert: recorder postponedData isNil.
	maybeDeliveredData := OrderedCollection new.
	maybeDeliveredData 
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new;
		add: GTSpotterRecorderExitAnnouncementEvent new;
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new;
		add: GTSpotterRecorderExitAnnouncementEvent new;
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new.
	maybeDeliveredData do: [ :each | recorder recordedData nextPut: each ].
	recorder primitivePrepareDeliveryData.
	postponedData := recorder postponedData.
	self assert: postponedData size equals: 2.
	7 to: 8 do: [ :index |
		self assert: (maybeDeliveredData at: index) == (postponedData at: index - 6) ].
	"second delivery"
	recorder recordedData nextPut: GTSpotterRecorderExitAnnouncementEvent new.
	recorder primitivePrepareDeliveryData.
	postponedData := recorder postponedData.
	self assert: postponedData isNil.
	self assert: recorder deliveryQueue size equals: 2.
	"first delivered data"
	bytes := recorder deliveryQueue nextOrNil.
	self assert: bytes notNil.
	announcement := recorder materialize: bytes.
	events := announcement materializedData.
	self assert: events size equals: 6.
	events withIndexDo: [ :eachEvent :index |
		self assert: (maybeDeliveredData at: index) class = eachEvent class ].
	"second delivered data"
	bytes := recorder deliveryQueue nextOrNil.
	self assert: bytes notNil.
	announcement := recorder materialize: bytes.
	events := announcement materializedData.
	self assert: events size equals: 3.
	self assert: (maybeDeliveredData at: 7) class = events first class.
	self assert: (maybeDeliveredData at: 8) class = events second class.
	self assert: events third class = GTSpotterRecorderExitAnnouncementEvent.
]

{ #category : #tests }
GTSpotterEventRecorderTest >> testSerializedAnnouncementFrom [
	| byteArray announcement |
	byteArray := recorder serializedAnnouncementFrom: self recordedData.
	announcement := recorder materializedAnnouncementFrom: byteArray.
	self assert: announcement class equals: GTSpotterRecorderDataAnnouncement.
	self assert: announcement materializedData isCollection.
	self assert: announcement materializedData size equals: self recordedData size.
]
