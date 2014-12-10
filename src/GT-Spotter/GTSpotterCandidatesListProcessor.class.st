"
This is a candidates processor that can be parameterized via blocks.
"
Class {
	#name : #GTSpotterCandidatesListProcessor,
	#superclass : #GTSpotterCandidatesProcessor,
	#instVars : [
		'allCandidatesBlock',
		'candidatesLimit',
		'queryMatchingBlock',
		'title',
		'itemNameBlock',
		'itemIconBlock',
		'actBlock',
		'wantsToDisplayOnEmptyQuery',
		'filterBlock'
	],
	#category : #'GT-Spotter-Processors'
}

{ #category : #accessing }
GTSpotterCandidatesListProcessor >> actLogic: aBlockWithTwoArguments [

	actBlock := aBlockWithTwoArguments
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> actOn: anObject for: aStep [
	
	actBlock
		ifNil: [ super actOn: anObject for: aStep ]
		ifNotNil: [ actBlock cull: anObject cull: aStep ]
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> allCandidates: aBlockWithOneArgument [
	allCandidatesBlock := aBlockWithOneArgument 
]

{ #category : #accessing }
GTSpotterCandidatesListProcessor >> candidatesLimit [
	^ candidatesLimit ifNil: [ 5 ]
]

{ #category : #accessing }
GTSpotterCandidatesListProcessor >> candidatesLimit: anInteger [
	candidatesLimit := anInteger
]

{ #category : #accessing }
GTSpotterCandidatesListProcessor >> computeCandidates [
	^ allCandidatesBlock cull: self origin
]

{ #category : #accessing }
GTSpotterCandidatesListProcessor >> doFilter: aStringQuery on: aStream [
	^ filterBlock isNil
		ifTrue: [ super doFilter: aStringQuery on: aStream ]
		ifFalse: [ filterBlock value: aStringQuery value: aStream ]
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> filter: aBlockWithTwoArguments [
	filterBlock := aBlockWithTwoArguments 
]

{ #category : #accessing }
GTSpotterCandidatesListProcessor >> is: anObject matching: aString [
	^ queryMatchingBlock 
		value: anObject
		value: aString
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> itemIcon: aBlockWithOneArgument [
	itemIconBlock := aBlockWithOneArgument
]

{ #category : #accessing }
GTSpotterCandidatesListProcessor >> itemIconFor: anObject [
	^ itemIconBlock isNil
		ifTrue: [ super itemIconFor: anObject ]
		ifFalse: [ itemIconBlock cull: anObject ]
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> itemName: aBlockWithOneArgument [
	itemNameBlock := aBlockWithOneArgument
]

{ #category : #accessing }
GTSpotterCandidatesListProcessor >> itemNameFor: anObject [
	^ itemNameBlock isNil
		ifTrue: [ super itemNameFor: anObject ]
		ifFalse: [ itemNameBlock cull: anObject ]
]

{ #category : #accessing }
GTSpotterCandidatesListProcessor >> matchLogic: aBlockWithTwoArguments [
	queryMatchingBlock := aBlockWithTwoArguments
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> matchSubstring [
	self filter: [ :originalQuery :stream |
		| prefixMatchers rest query |
		"if filter is empty we stream all candidates"
		query := originalQuery trimBoth asLowercase.
		query isEmpty 
			ifTrue: [ self streamAllCandidatesOn: stream ]
			ifFalse: [
				prefixMatchers := OrderedCollection  new.
				rest := OrderedCollection new.
				self allCandidates do: [:each | 
					| index |
					index := (self itemNameFor: each) findString: query startingAt: 1 caseSensitive: false.
					index >= 1 ifTrue: [
						index = 1 
							ifTrue: [ 
									prefixMatchers add: each.
									prefixMatchers size > self candidatesLimit ifFalse: [ 
										stream addObject: each inProcessor: self ]]
							ifFalse: [ rest add: each ]]].
				(prefixMatchers size < self candidatesLimit) ifTrue: [ 
					(rest first: ((self candidatesLimit - prefixMatchers size) min: rest size)) do: [ :each |
						stream addObject: each inProcessor: self ] ].
				prefixMatchers , rest ] ]
]

{ #category : #accessing }
GTSpotterCandidatesListProcessor >> title [
	^ title ifNil: [ super title ]
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> title: aString [
	title := aString
]

{ #category : #accessing }
GTSpotterCandidatesListProcessor >> wantsToDisplayOnEmptyQuery [
	^ wantsToDisplayOnEmptyQuery ifNil: [ super wantsToDisplayOnEmptyQuery ]
]

{ #category : #accessing }
GTSpotterCandidatesListProcessor >> wantsToDisplayOnEmptyQuery: anObject [
	wantsToDisplayOnEmptyQuery := anObject
]
