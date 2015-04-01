Class {
	#name : #GTFilterFileReference,
	#superclass : #GTFilterSubstring,
	#category : #'GT-SpotterExtensions-Core'
}

{ #category : #private }
GTFilterFileReference >> indexForItem: each [
	^ (self queryForItem: each) isEmpty
		ifTrue: [ 1 ] " if the modified query is empty, take all items -> index = 1 "
		ifFalse: [ super indexForItem: each ]
]

{ #category : #accessing }
GTFilterFileReference >> queryForItem: each [
	self flag: 'this is an ugly hack for #queryForFileReference. The iterator will manipulate the query being used for each item'.
	^ self context cacheAt: #queryForFileReference ifAbsent: [ query ] " performance optimization "
]
