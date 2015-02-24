Class {
	#name : #GTFilter,
	#superclass : #Object,
	#instVars : [
		'model',
		'originalQuery',
		'query',
		'caseSensitive',
		'stream',
		'items'
	],
	#category : #'GT-Spotter-Filters'
}

{ #category : #'instance creation' }
GTFilter class >> model: aModel [
	^ self new 
		model: aModel;
		yourself
]

{ #category : #'private-model' }
GTFilter >> addItem: anItem [
	self stream addObject: anItem inProcessor: self model.
]

{ #category : #'private-model' }
GTFilter >> allItems [
	^ self model allCandidates
]

{ #category : #private }
GTFilter >> applyFilter [
	self hasQuery ifFalse: [ 
		self applyFilterWithoutQuery.
		^ self allItems. " return the unfiltered items (all) - used for divein (no filtering appied) "  ].
	self applyFilterWithQuery.
	^ self items " return the filtered items only "
]

{ #category : #private }
GTFilter >> applyFilterOn: aStream query: aQueryString [
	self stream: aStream.
	self originalQuery: aQueryString.
	self query: aQueryString.
	self items: self defaultItems.
	self prepareFilter.
	^ self applyFilter
]

{ #category : #private }
GTFilter >> applyFilterOn: aStream query: aQueryString error: anException [
	('[Spotter] Exception in filter <', self class name, '>: ', anException asString) logCr.
	^ self defaultItems
]

{ #category : #private }
GTFilter >> applyFilterWithQuery [
	
]

{ #category : #private }
GTFilter >> applyFilterWithoutQuery [
	self items: (self allItems first: (self itemsLimit min: self allItems size)).
	self items do: [ :item |
		self addItem: item ].
	^ self allItems
]

{ #category : #accessing }
GTFilter >> caseSensitive [
	^ caseSensitive ifNil: [ caseSensitive := self defaultCaseSensitive ]
]

{ #category : #accessing }
GTFilter >> caseSensitive: anObject [
	caseSensitive := anObject
]

{ #category : #'accessing-defaults' }
GTFilter >> defaultCaseSensitive [
	^ false
]

{ #category : #'accessing-defaults' }
GTFilter >> defaultItems [
	^ OrderedCollection new
]

{ #category : #testing }
GTFilter >> hasItems [
	^ self items isEmpty not
]

{ #category : #testing }
GTFilter >> hasQuery [
	^ self query isEmptyOrNil not
]

{ #category : #testing }
GTFilter >> isCacheable [
	^ false
]

{ #category : #'private-model' }
GTFilter >> itemNameFor: anItem [
	^ self model itemNameFor: anItem
]

{ #category : #accessing }
GTFilter >> items [
	^ items ifNil: [ items := self defaultItems ]
]

{ #category : #accessing }
GTFilter >> items: anObject [
	items := anObject
]

{ #category : #'private-model' }
GTFilter >> itemsLimit [
	^ self model candidatesLimit
]

{ #category : #accessing }
GTFilter >> model [
	^ model
]

{ #category : #accessing }
GTFilter >> model: anObject [
	model := anObject
]

{ #category : #accessing }
GTFilter >> originalQuery [
	^ originalQuery
]

{ #category : #accessing }
GTFilter >> originalQuery: anObject [
	originalQuery := anObject
]

{ #category : #private }
GTFilter >> prepareFilter [
	self query: (self prepareQuery: self originalQuery)
]

{ #category : #private }
GTFilter >> prepareQuery: anObject [
	^ self caseSensitive
		ifTrue: [ anObject trimBoth ]
		ifFalse: [ anObject trimBoth asLowercase ]
]

{ #category : #accessing }
GTFilter >> query [
	^ query
]

{ #category : #accessing }
GTFilter >> query: anObject [
	query := anObject
]

{ #category : #testing }
GTFilter >> shouldApplyFilterForQuery: aQueryString [
	<hack: 'try not to prepare the string twice'>
	^ (self prepareQuery: aQueryString) ~= self query
]

{ #category : #accessing }
GTFilter >> stream [
	^ stream
]

{ #category : #accessing }
GTFilter >> stream: anObject [
	stream := anObject
]

{ #category : #public }
GTFilter >> value: aQueryString value: aStream [
	<modifier: #final>
	^ [ self applyFilterOn: aStream query: aQueryString ]
		on: Error
		do: [ :exception | self applyFilterOn: aStream query: aQueryString error: exception ]
]
