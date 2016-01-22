"
I am the root class of the hierarchy of filter objects  that can be used by Spotter. 

The main entry point is the #value method that performs and returns the list of filtered items.
Subclasses should return the list of filtered elements in sorted order based on the filtering criteria.
"
Class {
	#name : #GTFilter,
	#superclass : #Object,
	#instVars : [
		'context',
		'filteredItems',
		'streamedItems',
		'streamed'
	],
	#category : #'GT-Spotter-Filters'
}

{ #category : #public }
GTFilter class >> gtFilter [
	^ self new
]

{ #category : #public }
GTFilter class >> gtListFilter [
	^ self new
]

{ #category : #'private-model' }
GTFilter >> addItem: anItem [
	self streamedItems add: anItem.
	self context addItem: anItem
]

{ #category : #'private-model' }
GTFilter >> addItems: aCollection [
	self streamedItems addAll: aCollection.
	self context addItems: aCollection
]

{ #category : #'private-model' }
GTFilter >> allItems [
	| allItems |
	allItems := self processor allItemsIn: self context.
	^ (self context continuing and: [ self streamedItems isEmptyOrNil not ])
		ifTrue: [ allItems " might be a block or iterator " value fasterDifferencePreservingOrder: self streamedItems ]
		ifFalse: [ allItems ]
]

{ #category : #'private-model' }
GTFilter >> allItemsDo: aBlock [
	self allItems do: aBlock
]

{ #category : #private }
GTFilter >> applyFilter [
	^ self filteredItems
]

{ #category : #private }
GTFilter >> applyFilterInContext: aSpotterContext [
	self prepareFilterInContext: aSpotterContext.
	^ self applyFilter
]

{ #category : #private }
GTFilter >> applyFilterInContext: aSpotterContext error: anException [
	('[Spotter] Exception in filter <', self class name, '>: ', anException asString) logCr.
	^ self defaultFilteredItems
]

{ #category : #accessing }
GTFilter >> context [
	^ context
]

{ #category : #accessing }
GTFilter >> context: anObject [
	context := anObject
]

{ #category : #'accessing-defaults' }
GTFilter >> defaultFilteredItems [
	^ OrderedCollection new: 100
]

{ #category : #'accessing-defaults' }
GTFilter >> defaultStreamed [
	^ true
]

{ #category : #'accessing-defaults' }
GTFilter >> defaultStreamedItems [
	^ OrderedCollection new: 1000
]

{ #category : #'private-model' }
GTFilter >> exceptionHandler [
	self flag: 'Bloc -> overrides doesNotUnderstand discarding the current exception context'.
	^ GTCurrentSpotterExceptionHandler value ifNil: [ self context exceptionHandler ]
]

{ #category : #accessing }
GTFilter >> filteredItems [
	^ filteredItems
]

{ #category : #accessing }
GTFilter >> filteredItems: aCollection [
	filteredItems := aCollection
]

{ #category : #public }
GTFilter >> gtFilter [
	^ self
]

{ #category : #public }
GTFilter >> gtListFilter [
	^ self
]

{ #category : #testing }
GTFilter >> hasFilteredItems [
	^ self filteredItems isEmptyOrNil not
]

{ #category : #initializing }
GTFilter >> initialize [
	super initialize.
	
	self filteredItems: self defaultFilteredItems.
	self streamedItems: self defaultStreamedItems.
]

{ #category : #'private-model' }
GTFilter >> itemFilterNameFor: anItem [
	"I return the string/text representation of an item used by the filter."
	
	^ self processor itemFilterNameFor: anItem
]

{ #category : #'private-model' }
GTFilter >> itemsLimit [
	^ self context itemsLimit
]

{ #category : #private }
GTFilter >> prepareFilterInContext: aSpotterContext [
	"I provide a hook for preprocessing the query once before performing a search."
	
	self context: aSpotterContext.
]

{ #category : #'private-model' }
GTFilter >> processor [
	^ self context processor
]

{ #category : #'private-model' }
GTFilter >> step [
	^ self context step
]

{ #category : #accessing }
GTFilter >> streamed [
	^ streamed ifNil: [ streamed := self defaultStreamed ]
]

{ #category : #accessing }
GTFilter >> streamed: anObject [
	streamed := anObject
]

{ #category : #accessing }
GTFilter >> streamedItems [
	^ streamedItems
]

{ #category : #accessing }
GTFilter >> streamedItems: aCollection [
	streamedItems := aCollection
]

{ #category : #public }
GTFilter >> value: aSpotterContext [
	"I provide an entry point for performing a search that is 
	polymorphic with BlockClosure>>value:. I return the list of
	filtered items."
	
	^ [ [ self applyFilterInContext: aSpotterContext ]
		on: Error
		do: [ :exception | 
			self exceptionHandler 
				handleException: exception 
				do: [ self applyFilterInContext: aSpotterContext error: exception ] ] ] 
		ensure: [ context := nil " release the context after search is completed " ] 
]
