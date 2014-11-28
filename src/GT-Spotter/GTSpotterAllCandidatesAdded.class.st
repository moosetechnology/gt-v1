Class {
	#name : #GTSpotterAllCandidatesAdded,
	#superclass : #Announcement,
	#instVars : [
		'candidateLinks',
		'category'
	],
	#category : #'GT-Spotter-Announcements'
}

{ #category : #accessing }
GTSpotterAllCandidatesAdded >> candidateLinks [
	^ candidateLinks
]

{ #category : #accessing }
GTSpotterAllCandidatesAdded >> candidateLinks: anObject [
	candidateLinks := anObject
]

{ #category : #accessing }
GTSpotterAllCandidatesAdded >> category [
	^ category
]

{ #category : #accessing }
GTSpotterAllCandidatesAdded >> category: anObject [
	category := anObject
]
