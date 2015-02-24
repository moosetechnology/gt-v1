"
This processor adds the ability of computing and caching all possible candidates. It is useful when we know all candidates upfront.
"
Class {
	#name : #GTSpotterCandidatesProcessor,
	#superclass : #GTSpotterProcessor,
	#instVars : [
		'origin',
		'allCandidates'
	],
	#category : #'GT-Spotter-Processors'
}

{ #category : #'instance creation' }
GTSpotterCandidatesProcessor class >> on: anObject [

	^ self new origin: anObject
]

{ #category : #accessing }
GTSpotterCandidatesProcessor >> allCandidates [

	^ allCandidates ifNil: [ allCandidates := self computeCandidates copy ].
]

{ #category : #accessing }
GTSpotterCandidatesProcessor >> candidatesLimit [
	"Return the maximal number of elements that can be found during search.
	Default implementation returns infinity, so the number of element is not limited."
	^ Float infinity
]

{ #category : #private }
GTSpotterCandidatesProcessor >> computeCandidates [

	^ OrderedCollection new
	
]

{ #category : #private }
GTSpotterCandidatesProcessor >> doFilterInContext: aSpotterContext [
	^ GTFilterBlock gtFilter value: aSpotterContext
]

{ #category : #private }
GTSpotterCandidatesProcessor >> itemIconFor: anObject [
	^ nil
]

{ #category : #private }
GTSpotterCandidatesProcessor >> itemNameFor: anObject [
	^ anObject gtDisplayString
]

{ #category : #accessing }
GTSpotterCandidatesProcessor >> origin [

	^ origin
]

{ #category : #accessing }
GTSpotterCandidatesProcessor >> origin: anObject [

	origin := anObject
]

{ #category : #private }
GTSpotterCandidatesProcessor >> render: anObject [
	^ GTSpotterItemBrick new
		icon: (self itemIconFor: anObject);
		text: (self itemNameFor: anObject)
]

{ #category : #private }
GTSpotterCandidatesProcessor >> streamAllCandidatesOn: aStream [
	aStream
		addObjects: (self allCandidates first: (self candidatesLimit min: self allCandidates size))
		inProcessor: self.
	^ self allCandidates
]

{ #category : #accessing }
GTSpotterCandidatesProcessor >> title [
	^ 'undefined'
]
