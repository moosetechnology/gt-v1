Class {
	#name : #GTFilterSubstring,
	#superclass : #GTOrderedFilter,
	#category : #'GT-Spotter-Filters'
}

{ #category : #private }
GTFilterSubstring >> applyFilterWithQuery [
	| exactMatches prefixMatches otherMatches all |
	"we want to distinguish between exact matches"
	exactMatches := OrderedCollection new.
	"... results for which the query matches the prefix"
	prefixMatches := OrderedCollection new.	
	"... and the rest of the results"
	otherMatches := OrderedCollection new.

	self allItemsDo: [ :each | 
		| index queryString itemName |
		itemName := self itemFilterNameFor: each.
		queryString := self queryForItem: each.
		index := self indexForItemName: itemName andQuery: queryString.
		index >= 1 ifTrue: [
			index = 1 
				ifTrue: [ 
					itemName size = queryString size 
						ifTrue: [ exactMatches add: each ]
						ifFalse: [ prefixMatches add: each ] ]
				ifFalse: [ otherMatches add: each ] ] ].
	all := exactMatches, prefixMatches, otherMatches.
	(all size > self itemsLimit 
		ifTrue: [ all first: self itemsLimit ]
		ifFalse: [ all ]) 
		do: [ :each | self addItem: each ].
	self filteredItems: all
]

{ #category : #private }
GTFilterSubstring >> indexForItemName: aString andQuery: aQueryString [
	^ aString 
		findString: aQueryString
		startingAt: 1 
		caseSensitive: self caseSensitive
]

{ #category : #private }
GTFilterSubstring >> queryForItem: each [
	^ query " performance optimization "
]
