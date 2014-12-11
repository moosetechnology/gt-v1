Class {
	#name : #GTSpotterCandidateLink,
	#superclass : #DoubleLink,
	#instVars : [
		'processorLink',
		'weight',
		'renderingProcessorLink'
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

	^ self processorLink value
]

{ #category : #accessing }
GTSpotterCandidateLink >> processorLink [
	^ processorLink
]

{ #category : #accessing }
GTSpotterCandidateLink >> processorLink: anObject [

	"we set rendering processor only if one is not set. it allows to have a collection of items,
	that have different rendering processors"
	
	processorLink ifNil: [ renderingProcessorLink := anObject ].
	processorLink := anObject.
	
]

{ #category : #accessing }
GTSpotterCandidateLink >> renderingProcessor [

	^ renderingProcessorLink value
]

{ #category : #accessing }
GTSpotterCandidateLink >> renderingProcessor: aProcessorLink [

	renderingProcessorLink := aProcessorLink
]

{ #category : #accessing }
GTSpotterCandidateLink >> weight [

	^ weight
]

{ #category : #accessing }
GTSpotterCandidateLink >> weight: anObject [ 

	weight := anObject
]
