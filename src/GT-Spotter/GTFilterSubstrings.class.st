Class {
	#name : #GTFilterSubstrings,
	#superclass : #GTUnorderedFilter,
	#instVars : [
		'separators'
	],
	#category : #'GT-Spotter-Filters'
}

{ #category : #'accessing-defaults' }
GTFilterSubstrings >> defaultSeparators [
	^ ' '
]

{ #category : #private }
GTFilterSubstrings >> isMatchedItem: anItem [
	| itemName |
	itemName := self itemNameFor: anItem.
	^ self query allSatisfy: [ :fragment | 
		itemName includesSubstring: fragment  caseSensitive: self caseSensitive ]
]

{ #category : #private }
GTFilterSubstrings >> prepareQuery: anObject [
	^ ((super prepareQuery: anObject) substrings: self separators) asSet asArray
]

{ #category : #accessing }
GTFilterSubstrings >> separators [
	^ separators ifNil: [ separators := self defaultSeparators ]
]

{ #category : #accessing }
GTFilterSubstrings >> separators: anObject [
	separators := anObject
]
