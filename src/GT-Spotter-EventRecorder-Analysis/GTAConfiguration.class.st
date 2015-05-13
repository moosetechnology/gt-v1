Class {
	#name : #GTAConfiguration,
	#superclass : #Object,
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #accessing }
GTAConfiguration class >> developerUUIDs [
	"
	GTSpotterEventRecorderSettings ensureComputerID.
	GTSpotterEventRecorderSettings uniqueInstance computerUUID.
	"
	^ #( 	'58d42da6-c993-4ad1-8624-5fd628793610' 
			'8c7d33b4-1025-42b3-8dc4-4a2bb32c5a42'
			'4483f704-6909-45d7-9367-869a5850c3e8'
			'52fe7c39-9c98-4fa7-a883-a8b2cabe84db'
			'69202c73-b32f-4968-aaf1-0666d421ea57'
			'0cd69f50-ad08-8c47-84ec-329e2210a2f2'
		)
]

{ #category : #testing }
GTAConfiguration class >> isDeveloper: anUUID [
	^ self developerUUIDs includes: anUUID asString
]
