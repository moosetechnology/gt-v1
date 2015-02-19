Class {
	#name : #GTCacheableFilter,
	#superclass : #GTFilter,
	#category : #'GT-Spotter-Filters'
}

{ #category : #private }
GTCacheableFilter >> applyFilterCacheOn: aStream [
	<modifier: #final>
	self stream: aStream.
	self items do: [ :item |
		self addItem: item ].
	^ self items
]

{ #category : #private }
GTCacheableFilter >> applyFilterOn: aStream query: aQueryString [
	<modifier: #final>
	(self shouldApplyFilterForQuery: aQueryString) 
		ifFalse: [ ^ self applyFilterCacheOn: aStream ].
	^ super applyFilterOn: aStream query: aQueryString
]

{ #category : #testing }
GTCacheableFilter >> isCacheable [
	^ true
]

{ #category : #testing }
GTCacheableFilter >> shouldApplyFilterForQuery: aQueryString [
	<hack: 'try not to prepare the string twice'>
	^ (self prepareQuery: aQueryString) ~= self query
]
