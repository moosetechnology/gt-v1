Class {
	#name : #GTSpotterCandidatesAmountChanged,
	#superclass : #Announcement,
	#instVars : [
		'amount',
		'category'
	],
	#category : #'GT-Spotter-Announcements'
}

{ #category : #accessing }
GTSpotterCandidatesAmountChanged >> amount [
	^ amount
]

{ #category : #accessing }
GTSpotterCandidatesAmountChanged >> amount: anObject [
	amount := anObject
]

{ #category : #accessing }
GTSpotterCandidatesAmountChanged >> category [
	^ category
]

{ #category : #accessing }
GTSpotterCandidatesAmountChanged >> category: anObject [
	category := anObject
]
