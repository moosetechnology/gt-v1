Class {
	#name : #GTSpotterRecorderCategorySelectedEvent,
	#superclass : #GTSpotterRecorderEvent,
	#instVars : [
		'categoryLabel',
		'elementCount'
	],
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #'as yet unclassified' }
GTSpotterRecorderCategorySelectedEvent class >> eventCode [

	^ 3
]

{ #category : #'as yet unclassified' }
GTSpotterRecorderCategorySelectedEvent >> asRecordedData [

	^ self
]

{ #category : #'as yet unclassified' }
GTSpotterRecorderCategorySelectedEvent >> fromAnnouncement: anAnnouncement [

	categoryLabel := anAnnouncement category title.
	elementCount := anAnnouncement category allFilteredCandidates size.
]
