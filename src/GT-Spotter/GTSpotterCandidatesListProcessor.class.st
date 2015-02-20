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
GTSpotterCandidatesListProcessor >> doFilter: aStringQuery on: aStream [
	<todo: #filterRefactoring description: 'remove nil check - use default empty filter'>
	^ filterBlock isNil
		ifTrue: [ 
			Transcript show:'obsolete behaviour ??? '; show: aStringQuery; show: ' '; show: self class name; cr.
			super doFilter: aStringQuery on: aStream ]
		ifFalse: [ filterBlock value: aStringQuery value: aStream ]
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> filter: aBlockWithTwoArguments [
	filterBlock := aBlockWithTwoArguments 
]

{ #category : #private }
GTSpotterCandidatesListProcessor >> filter: aStringQuery on: aStream [
	<hack: 'is there a better way to debug gt/spotter? it is very hard to detect exceptions and to debug them - this is just a very dirty hack'>
	[ super filter: aStringQuery on: aStream ]
		on: Error 
		do: [ :e | ('[Spotter] Exception in processor <', self title asString, '>: ', e asString) logCr ]
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> filterUsing: aFilterObject [
	self filter: (aFilterObject model: self)
]

{ #category : #private }
GTSpotterCandidatesListProcessor >> is: anObject matching: aString [
	^ queryMatchingBlock 
		value: anObject
		value: aString
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
