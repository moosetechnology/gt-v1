Class {
	#name : #GTStringFilter,
	#superclass : #GTFilter,
	#instVars : [
		'caseSensitive',
		'query'
	],
	#category : #'GT-Spotter-Filters'
}

{ #category : #private }
GTStringFilter >> applyFilter [
	self hasQuery ifFalse: [ 
		self applyFilterWithoutQuery.
		^ self allItems. " return the unfiltered items (all) - used for divein (no filtering appied) "  ].
	self applyFilterWithQuery.
	^ self items " return the filtered items only "
]

{ #category : #private }
GTStringFilter >> applyFilterWithQuery [
	
]

{ #category : #private }
GTStringFilter >> applyFilterWithoutQuery [
	self items: (self allItems first: (self itemsLimit min: self allItems size)).
	self items do: [ :item |
		self addItem: item ]
]

{ #category : #accessing }
GTStringFilter >> caseSensitive [
	^ caseSensitive ifNil: [ caseSensitive := self defaultCaseSensitive ]
]

{ #category : #accessing }
GTStringFilter >> caseSensitive: anObject [
	caseSensitive := anObject
]

{ #category : #'accessing-defaults' }
GTStringFilter >> defaultCaseSensitive [
	^ false
]

{ #category : #testing }
GTStringFilter >> hasQuery [
	^ self query isEmptyOrNil not
]

{ #category : #private }
GTStringFilter >> prepareFilterInContext: aSpotterContext [
	super prepareFilterInContext: aSpotterContext.
	
	self query: (self caseSensitive
		ifTrue: [ self context textTrimmed ]
		ifFalse: [ self context textLowercase ])
]

{ #category : #accessing }
GTStringFilter >> query [
	^ query
]

{ #category : #accessing }
GTStringFilter >> query: anObject [
	query := anObject
]
