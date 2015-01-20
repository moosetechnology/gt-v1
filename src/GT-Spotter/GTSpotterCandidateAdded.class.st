Class {
	#name : #GTSpotterCandidateAdded,
	#superclass : #Announcement,
	#instVars : [
		'candidateLink',
		'category'
	],
	#category : #'GT-Spotter-Announcements'
}

{ #category : #accessing }
GTSpotterCandidateAdded >> candidate [
	^ candidateLink value
]

{ #category : #accessing }
GTSpotterCandidateAdded >> candidateLink [

	^ candidateLink
]

{ #category : #accessing }
GTSpotterCandidateAdded >> candidateLink: anObject [
	candidateLink := anObject
]

{ #category : #accessing }
GTSpotterCandidateAdded >> category [
	^ category
]

{ #category : #accessing }
GTSpotterCandidateAdded >> category: anObject [
	category := anObject
]
