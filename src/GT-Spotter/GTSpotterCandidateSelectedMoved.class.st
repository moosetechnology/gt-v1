Class {
	#name : #GTSpotterCandidateSelectedMoved,
	#superclass : #Announcement,
	#instVars : [
		'candidateBrick'
	],
	#category : #'GT-Spotter-Announcements'
}

{ #category : #accessing }
GTSpotterCandidateSelectedMoved >> candidateBrick [
	^ candidateBrick
]

{ #category : #accessing }
GTSpotterCandidateSelectedMoved >> candidateBrick: anObject [
	candidateBrick := anObject
]
