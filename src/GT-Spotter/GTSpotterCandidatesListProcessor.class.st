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

{ #category : #scripting }
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
	^ candidatesLimit ifNil: [ self defaultCandidatesLimit ]
]

{ #category : #accessing }
GTSpotterCandidatesListProcessor >> candidatesLimit: anInteger [
	candidatesLimit := anInteger
]

{ #category : #private }
GTSpotterCandidatesListProcessor >> computeCandidates [
	^ allCandidatesBlock cull: self origin
]

{ #category : #'accessing-defaults' }
GTSpotterCandidatesListProcessor >> defaultCandidatesLimit [
	^ 5
]

{ #category : #private }
GTSpotterCandidatesListProcessor >> doFilterInContext: aSpotterContext [
	^ filterBlock gtFilter value: aSpotterContext
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> filter: aBlockWithOneArgument [
	filterBlock := aBlockWithOneArgument 
]

{ #category : #private }
GTSpotterCandidatesListProcessor >> filterInContext: aSpotterContext [
	[ super filterInContext: aSpotterContext ]
		on: Error 
		do: [ :e | ('[Spotter] Exception in processor <', self title asString, '>: ', e asString) logCr ]
]

{ #category : #compatibility }
GTSpotterCandidatesListProcessor >> filterUsing: aFilter [
	self filter: aFilter
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> itemIcon: aBlockWithOneArgument [
	itemIconBlock := aBlockWithOneArgument
]

{ #category : #private }
GTSpotterCandidatesListProcessor >> itemIconFor: anObject [
	^ itemIconBlock isNil
		ifTrue: [ super itemIconFor: anObject ]
		ifFalse: [ itemIconBlock cull: anObject ]
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> itemName: aBlockWithOneArgument [
	itemNameBlock := aBlockWithOneArgument
]

{ #category : #private }
GTSpotterCandidatesListProcessor >> itemNameFor: anObject [
	^ itemNameBlock isNil
		ifTrue: [ super itemNameFor: anObject ]
		ifFalse: [ itemNameBlock cull: anObject ]
]

{ #category : #convenience }
GTSpotterCandidatesListProcessor >> match: aBlockWithTwoArguments [
	self filter: (GTFilterBlock new 
		matcher: aBlockWithTwoArguments;
		yourself)
]

{ #category : #convenience }
GTSpotterCandidatesListProcessor >> matchAlike [
	self filter: GTFilterAlike
]

{ #category : #convenience }
GTSpotterCandidatesListProcessor >> matchRegex [
	self filter: GTFilterRegex
]

{ #category : #convenience }
GTSpotterCandidatesListProcessor >> matchString [
	self filter: GTFilterStringMatch
]

{ #category : #convenience }
GTSpotterCandidatesListProcessor >> matchSubstring [
	self filter: GTFilterSubstring
]

{ #category : #convenience }
GTSpotterCandidatesListProcessor >> matchSubstrings [
	self filter: GTFilterSubstrings
]

{ #category : #accessing }
GTSpotterCandidatesListProcessor >> title [
	^ title ifNil: [ super title ]
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> title: aString [
	title := aString
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> wantsToDisplayOnEmptyQuery [
	^ wantsToDisplayOnEmptyQuery ifNil: [ super wantsToDisplayOnEmptyQuery ]
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> wantsToDisplayOnEmptyQuery: anObject [
	wantsToDisplayOnEmptyQuery := anObject
]
