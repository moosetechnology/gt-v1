Class {
	#name : #GTFilterRegex,
	#superclass : #GTCacheableFilter,
	#instVars : [
		'regex'
	],
	#category : #'GT-Spotter-Filters'
}

{ #category : #private }
GTFilterRegex >> applyFilterWithQuery [
	| regexMatches otherMatches |
	regexMatches := OrderedCollection  new.
	otherMatches := OrderedCollection new.
	self allItems do: [ :each | 
		(regex matches: (self itemNameFor: each))
				ifTrue: [ 
						regexMatches add: each.
						regexMatches size > self itemsLimit ifFalse: [ 
							self addItem: each ]]
				ifFalse: [ otherMatches add: each ] ].
	(regexMatches size < self itemsLimit) ifTrue: [ 
		(otherMatches first: ((self itemsLimit - regexMatches size) min: otherMatches size)) do: [ :each |
			self addItem: each ] ].
	self items: regexMatches , otherMatches
]

{ #category : #'accessing-defaults' }
GTFilterRegex >> defaultRegex [
	^ self caseSensitive 
		ifTrue: [ self query asRegex ] 
		ifFalse: [ self query asRegexIgnoringCase ]
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
