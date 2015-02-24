Class {
	#name : #GTFilterStringMatch,
	#superclass : #GTUnorderedFilter,
	#category : #'GT-Spotter-Filters'
}

{ #category : #private }
GTFilterStringMatch >> isMatchedItem: anItem [
	^ self query match: (self itemNameFor: anItem)
]
