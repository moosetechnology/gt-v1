Class {
	#name : #GTFilterSubstrings,
	#superclass : #GTCacheableFilter,
	#instVars : [
		'separators'
	],
	#category : #'GT-Spotter-Filters'
}

{ #category : #private }
GTFilterSubstrings >> applyFilterWithQuery [
	| matches otherMatches |
	matches := OrderedCollection  new.
	otherMatches := OrderedCollection new.
	self allItems do: [ :each | 
		| itemName |
		itemName := self itemNameFor: each.
		(self query allSatisfy: [ :fragment | itemName includesSubstring: fragment  caseSensitive: self caseSensitive ])
				ifTrue: [ 
						matches add: each.
						matches size > self itemsLimit ifFalse: [ 
							self addItem: each ] ]
				ifFalse: [ otherMatches add: each ] ].
	(matches size < self itemsLimit) ifTrue: [ 
		(otherMatches first: ((self itemsLimit - matches size) min: otherMatches size)) do: [ :each |
			self addItem: each ] ].
	self items: matches , otherMatches 
]

{ #category : #'accessing-defaults' }
GTFilterSubstrings >> defaultSeparators [
	^ ' '
]

{ #category : #private }
GTFilterSubstrings >> prepareQuery: anObject [
	^ (super prepareQuery: anObject) substrings: self separators
]

{ #category : #accessing }
GTFilterSubstrings >> separators [
	^ separators ifNil: [ separators := self defaultSeparators ]
]

{ #category : #accessing }
GTFilterSubstrings >> separators: anObject [
	separators := anObject
]
