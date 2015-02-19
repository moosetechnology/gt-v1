Class {
	#name : #GTFilterAlike,
	#superclass : #GTCacheableFilter,
	#instVars : [
		'lowerThreshold',
		'upperThreshold'
	],
	#category : #'GT-Spotter-Filters'
}

{ #category : #private }
GTFilterAlike >> applyFilterWithQuery [
	| allItemsPrepocessed allItemsPrepocessedAndSorted alikeMatches otherMatches upper lower |
	alikeMatches := OrderedCollection  new.
	otherMatches := OrderedCollection new.				
	allItemsPrepocessed := OrderedCollection streamContents: [ :allItems | 
		lower := self lowerThreshold * query size.
		self allItems do: [ :each | 
			| weight |
			(weight :=  (self itemNameFor: each) alike: self query) > lower ifTrue: [
				allItems nextPut: (Array with: weight with: each) ] ] ].
	upper := allItemsPrepocessed isEmpty 
		ifTrue: [ self upperThreshold ]
		ifFalse: [
			allItemsPrepocessedAndSorted := allItemsPrepocessed asSortedCollection: [ :a :b | a first > b first ].
			(allItemsPrepocessedAndSorted collect: [ :each | each first ]) median " try an adaptive threshold (slow) " ].
	allItemsPrepocessedAndSorted do: [ :each | 
		each first >= upper 
			ifTrue: [
				alikeMatches add: each last.
				alikeMatches size > self itemsLimit ifFalse: [ 
					self addItem: each ] ]
			ifFalse:[ otherMatches add: each last ] ].
	(alikeMatches size < self itemsLimit) ifTrue: [ 
		(otherMatches first: ((self itemsLimit - alikeMatches size) min: otherMatches size)) do: [ :each |
			self addItem: each ] ].
	self items: alikeMatches , otherMatches 
]

{ #category : #'accessing-defaults' }
GTFilterAlike >> defaultLowerThreshold [
	<magicNumber: 0.33 description: 'lower threshold: to cut off the large irrelevent chunk before sorting/filtering is appplied' author: 'StefanReichhart'>
	^ 0.33
]

{ #category : #'accessing-defaults' }
GTFilterAlike >> defaultUpperThreshold [
	<magicNumber: 0.45 description: 'upper threshold: to keep a reasonably sized set of interesting matches' author: 'StefanReichhart'>
	^ 0.45
]

{ #category : #accessing }
GTFilterAlike >> lowerThreshold [
	^ lowerThreshold ifNil: [ lowerThreshold := self defaultLowerThreshold ]
]

{ #category : #accessing }
GTFilterAlike >> lowerThreshold: anObject [
	lowerThreshold := anObject
]

{ #category : #accessing }
GTFilterAlike >> upperThreshold [
	^ upperThreshold ifNil: [ upperThreshold := self defaultUpperThreshold ]
]

{ #category : #accessing }
GTFilterAlike >> upperThreshold: anObject [
	upperThreshold := anObject
]
