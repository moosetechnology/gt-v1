Class {
	#name : #GTSpotterSelectedCandidateChanged,
	#superclass : #Announcement,
	#instVars : [
		'eventType',
		'selected'
	],
	#category : #'GT-Spotter-Announcements'
}

{ #category : #accessing }
GTSpotterSelectedCandidateChanged >> eventType [
	^ eventType
]

{ #category : #accessing }
GTSpotterSelectedCandidateChanged >> eventType: anObject [
	eventType := anObject
]

{ #category : #accessing }
GTSpotterSelectedCandidateChanged >> selected [
	^ selected
]

{ #category : #accessing }
GTSpotterSelectedCandidateChanged >> selected: anObject [
	selected := anObject
]
