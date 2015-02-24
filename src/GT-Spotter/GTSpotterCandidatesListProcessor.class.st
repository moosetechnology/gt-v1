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
	<magicNumber: 5 description: 'default size of candidates' author: '?'>
	^ candidatesLimit ifNil: [ 5 ]
]

{ #category : #accessing }
GTSpotterCandidatesListProcessor >> candidatesLimit: anInteger [
	candidatesLimit := anInteger
]

{ #category : #private }
GTSpotterCandidatesListProcessor >> computeCandidates [
	^ allCandidatesBlock cull: self origin
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
