Class {
	#name : #GTFilterRegex,
	#superclass : #GTUnorderedFilter,
	#instVars : [
		'regex'
	],
	#category : #'GT-Spotter-Filters'
}

{ #category : #private }
GTFilterRegex >> applyFilterOn: aStream query: aQueryString error: exception [
	<todo: 'better way to define fallbacks, maybe multiple?'>
	super applyFilterOn: aStream query: aQueryString error: exception.
	^ (GTFilterSubstrings new
		model: self model;
		caseSensitive: self caseSensitive;
		yourself) value: aQueryString value: aStream
]

{ #category : #'accessing-defaults' }
GTFilterRegex >> defaultRegex [
	^ self caseSensitive 
		ifTrue: [ self query asRegex ] 
		ifFalse: [ self query asRegexIgnoringCase ]
]

{ #category : #private }
GTFilterRegex >> isMatchedItem: anItem [
	^ self regex matches: (self itemNameFor: anItem)
]

{ #category : #private }
GTFilterRegex >> prepareFilter [
	super prepareFilter.
	
	self regex: nil.
]

{ #category : #accessing }
GTFilterRegex >> regex [
	^ regex ifNil: [ regex := self defaultRegex ]
]

{ #category : #accessing }
GTFilterRegex >> regex: anObject [
	regex := anObject
]
