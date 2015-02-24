Class {
	#name : #GTUnorderedFilter,
	#superclass : #GTFilter,
	#category : #'GT-Spotter-Filters'
}

{ #category : #private }
GTUnorderedFilter >> applyFilterWithQuery [
	| unorderedMatchedItems |
	unorderedMatchedItems := OrderedCollection  new.
	self allItems do: [ :each | 
		(self isMatchedItem: each)
				ifTrue: [ 
					unorderedMatchedItems add: each.
					unorderedMatchedItems size > self itemsLimit ifFalse: [ 
						self addItem: each ] ] ].
	self items: unorderedMatchedItems
]

{ #category : #private }
GTUnorderedFilter >> isMatchedItem: anItem [
	^ false
]
