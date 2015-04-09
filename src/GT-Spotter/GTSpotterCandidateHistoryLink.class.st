Class {
	#name : #GTSpotterCandidateHistoryLink,
	#superclass : #GTSpotterCandidateLink,
	#category : #'GT-Spotter-Utils'
}

{ #category : #converting }
GTSpotterCandidateHistoryLink >> asSpotterCandidateLink [
	" we don't want to manipulate the object in the history -> multiple spotter instances, ... "
	^ self copy
]

{ #category : #converting }
GTSpotterCandidateHistoryLink >> asSpotterHistoryCandidate [
	^ self
]

{ #category : #accessing }
GTSpotterCandidateHistoryLink >> processor [
	" this kind of link wants the rendering processor instead of the processor "
	^ self renderingProcessor
]
