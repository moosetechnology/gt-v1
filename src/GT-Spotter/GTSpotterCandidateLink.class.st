Class {
	#name : #GTSpotterCandidateLink,
	#superclass : #DoubleLink,
	#instVars : [
		'processorLink',
		'weight'
	],
	#category : #'GT-Spotter-Utils'
}

{ #category : #comparing }
GTSpotterCandidateLink >> < anotherCandidateLink [

	^ self weight < anotherCandidateLink weight
]

{ #category : #comparing }
GTSpotterCandidateLink >> > anotherCandidateLink [

	^ self weight > anotherCandidateLink weight
]

{ #category : #converting }
GTSpotterCandidateLink >> asSpotterCandidateLink [

	^ self
]

{ #category : #accessing }
GTSpotterCandidateLink >> processor [

	^ self processorLink value key
]

{ #category : #accessing }
GTSpotterCandidateLink >> processorLink [
	^ processorLink
]

{ #category : #accessing }
GTSpotterCandidateLink >> processorLink: anObject [
	processorLink := anObject
]

{ #category : #accessing }
GTSpotterCandidateLink >> weight [

	^ weight
]

{ #category : #accessing }
GTSpotterCandidateLink >> weight: anObject [ 

	weight := anObject
]
