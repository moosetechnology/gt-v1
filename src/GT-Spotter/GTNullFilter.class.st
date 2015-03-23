Class {
	#name : #GTNullFilter,
	#superclass : #GTStringFilter,
	#category : #'GT-Spotter-Filters'
}

{ #category : #public }
GTNullFilter class >> gtListFilter [
	^ GTFilterSubstring new
]

{ #category : #private }
GTNullFilter >> applyFilterWithQuery [
	self items: self allItems.
	self addItems: (self allItems first: (self itemsLimit min: self allItems size))
]

{ #category : #public }
GTNullFilter >> gtListFilter [
	^ GTFilterSubstring new
]
