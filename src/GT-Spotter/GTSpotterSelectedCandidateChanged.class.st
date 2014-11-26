Class {
	#name : #GTSpotterSelectedCandidateChanged,
	#superclass : #Announcement,
	#instVars : [
		'selected'
	],
	#category : #'GT-Spotter-Announcements'
}

{ #category : #accessing }
GTSpotterSelectedCandidateChanged >> selected [
	^ selected
]

{ #category : #accessing }
GTSpotterSelectedCandidateChanged >> selected: anObject [
	selected := anObject
]
