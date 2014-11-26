Class {
	#name : #GTSpotterCandidateSelected,
	#superclass : #Announcement,
	#instVars : [
		'candidateBrick'
	],
	#category : #'GT-Spotter-Announcements'
}

{ #category : #accessing }
GTSpotterCandidateSelected >> candidateBrick [
	^ candidateBrick
]

{ #category : #accessing }
GTSpotterCandidateSelected >> candidateBrick: anObject [
	candidateBrick := anObject
]
