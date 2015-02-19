Class {
	#name : #GTFilter,
	#superclass : #Object,
	#instVars : [
		'caseSensitive',
		'items',
		'model',
		'originalQuery',
		'query',
		'serializedItemsCache',
		'stream'
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
	self hasQuery ifFalse: [ ^ self applyFilterWithoutQuery ].
	self applyFilterWithQuery
]

{ #category : #private }
GTFilter >> applyFilterOn: aStream query: aQueryString [
	self stream: aStream.
	self originalQuery: aQueryString.
	self query: aQueryString.
	self items: self defaultItems.
	self prepareFilter.
	self applyFilter.
	^ self items
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
		self addItem: item ]
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
GTFilter >> defaultCache [
	^ Dictionary new
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
	<critical: 'is a dictionary safe to cache any object to its string?'>
	^ self serializedItemsCache 
		at: anItem 
		ifAbsentPut: [ self model itemNameFor: anItem ]
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

{ #category : #accessing }
GTFilter >> serializedItemsCache [
	^ serializedItemsCache ifNil: [ serializedItemsCache := self defaultCache ]
]

{ #category : #testing }
GTFilter >> shouldApplyFilterForQuery: aQueryString [
	^ true
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
