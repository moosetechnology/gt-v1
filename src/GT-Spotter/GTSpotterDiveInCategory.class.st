Class {
	#name : #GTSpotterDiveInCategory,
	#superclass : #Announcement,
	#instVars : [
		'category',
		'eventType'
	],
	#category : #'GT-Spotter-Announcements'
}

{ #category : #accessing }
GTSpotterDiveInCategory >> category [
	^ category
]

{ #category : #accessing }
GTSpotterDiveInCategory >> category: anObject [
	category := anObject
]

{ #category : #accessing }
GTSpotterDiveInCategory >> eventType [
	^ eventType
]

{ #category : #accessing }
GTSpotterDiveInCategory >> eventType: anObject [
	eventType := anObject
]
