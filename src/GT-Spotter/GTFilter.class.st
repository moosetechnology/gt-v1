Class {
	#name : #GTFilter,
	#superclass : #Object,
	#instVars : [
		'context',
		'items'
	],
	#category : #'GT-Spotter-Filters'
}

{ #category : #public }
GTFilter class >> gtFilter [
	^ self new
]

{ #category : #'private-model' }
GTFilter >> addItem: anItem [
	self context addItem: anItem
]

{ #category : #'private-model' }
GTFilter >> addItems: aCollection [
	self context addItems: aCollection
]

{ #category : #'private-model' }
GTFilter >> allItems [
	^ self processor allCandidates
]

{ #category : #private }
GTFilter >> applyFilter [
	^ self items
]

{ #category : #private }
GTFilter >> applyFilterInContext: aSpotterContext [
	self prepareFilterInContext: aSpotterContext.
	^ self applyFilter
]

{ #category : #private }
GTFilter >> applyFilterInContext: aSpotterContext error: anException [
	('[Spotter] Exception in filter <', self class name, '>: ', anException asString) logCr.
	^ self defaultItems
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
GTFilter >> defaultItems [
	^ OrderedCollection new
]

{ #category : #public }
GTFilter >> gtFilter [
	^ self
]

{ #category : #testing }
GTFilter >> hasItems [
	^ self items isEmptyOrNil not
]

{ #category : #'private-model' }
GTFilter >> itemNameFor: anItem [
	^ self processor itemNameFor: anItem
]

{ #category : #accessing }
GTFilter >> items [
	^ items
]

{ #category : #accessing }
GTFilter >> items: aCollection [
	items := aCollection
]

{ #category : #'private-model' }
GTFilter >> itemsLimit [
	^ self context itemsLimit
]

{ #category : #private }
GTFilter >> prepareFilterInContext: aSpotterContext [
	self context: aSpotterContext.
	self items: self defaultItems.
]

{ #category : #'private-model' }
GTFilter >> processor [
	^ self context processor
]

{ #category : #public }
GTFilter >> value: aSpotterContext [
	^ [ self applyFilterInContext: aSpotterContext ]
		on: Error
		do: [ :exception | self applyFilterInContext: aSpotterContext error: exception ]
]
