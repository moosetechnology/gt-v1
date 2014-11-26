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

{ #category : #defaults }
GTSpotterCandidatesProcessor >> computeCandidates [

	^ OrderedCollection new
	
]

{ #category : #accessing }
GTSpotterCandidatesProcessor >> doFilter: aStringQuery on: aStream [
	| mResults|
	
	"if filter is empty we stream all candidates"
	aStringQuery isEmpty ifTrue: [ ^ self streamAllCandidatesOn: aStream ].
	
	mResults := OrderedCollection new.
	
	self allCandidates do: [ :each |
		(self is: each matching: aStringQuery) ifTrue: [
			mResults isEmpty ifTrue: [ Processor activeProcess priority: Processor userSchedulingPriority ].
			
			(mResults size >= self candidatesLimit)
				ifTrue: [ mResults size = self candidatesLimit ifTrue: [ Processor activeProcess priority: Processor userBackgroundPriority  ] ]
				ifFalse: [ aStream addValue: each value: self ].
				
			mResults add: each.
		] ].

	^ mResults
]

{ #category : #'filtering/searching' }
GTSpotterCandidatesProcessor >> is: anObject matching: aString [
	"Returns true if anObject matches a provided string, otherwise false.
	Default implementation matches string representation of an object with passed value"
	^ anObject asString includesSubstring: aString caseSensitive: false
]

{ #category : #'filtering/searching' }
GTSpotterCandidatesProcessor >> itemIconFor: anObject [
	^ anObject systemIcon
]

{ #category : #'filtering/searching' }
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

{ #category : #'filtering/searching' }
GTSpotterCandidatesProcessor >> render: anObject [
	^ GTSpotterItemBrick new
		icon: (self itemIconFor: anObject);
		text: (self itemNameFor: anObject)
]

{ #category : #private }
GTSpotterCandidatesProcessor >> streamAllCandidatesOn: aStream [
	(self allCandidates first: (self candidatesLimit min: self allCandidates size))
		do:[ :each |
			aStream
				addValue: each 
				value: self].	
	^ self allCandidates
]

{ #category : #'filtering/searching' }
GTSpotterCandidatesProcessor >> title [
	^ 'undefined'
]
