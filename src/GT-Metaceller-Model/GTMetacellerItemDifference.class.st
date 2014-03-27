Class {
	#name : #GTMetacellerItemDifference,
	#superclass : #GTMetacellerSpec,
	#instVars : [
		'item',
		'parent'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #'instance creation' }
GTMetacellerItemDifference class >> on: anItem parent: aParent [
	^self new
		item: anItem;
		addParent: aParent;
		yourself
]

{ #category : #accessing }
GTMetacellerItemDifference >> addParent: aParent [
	self parent ifNil: [ self parent: aParent ].
	self parent: (self parent mergeWith: aParent)
]

{ #category : #accessing }
GTMetacellerItemDifference >> dataFor: aString [ 
	| retVal |
	retVal := self item dataFor: aString.
	(retVal isString not and: [ retVal isCollection ])
		ifTrue: [
			| parentData |
			parentData := (self parent dataFor: aString).
			parentData ifNil: [ ^retVal ].
			retVal := retVal reject: [ :each | parentData includes: each ].
			retVal ifEmpty: [ ^nil ] ]
		ifFalse: [
			(self parent dataFor: aString) = retVal ifTrue: [ ^nil ] ].
	^retVal
]

{ #category : #'code generation' }
GTMetacellerItemDifference >> differenceWith: anItem [ 
	(self item isDifferentFrom: anItem) ifFalse: [ ^nil ].
	self addParent: anItem.
	(self item isDifferentFrom: self parent) ifFalse: [ ^nil ].
	^self
]

{ #category : #accessing }
GTMetacellerItemDifference >> item [
	^ item
]

{ #category : #accessing }
GTMetacellerItemDifference >> item: anObject [
	item := anObject
]

{ #category : #accessing }
GTMetacellerItemDifference >> itemKindString [
	^self item itemKindString
]

{ #category : #accessing }
GTMetacellerItemDifference >> itemName [
	^self item itemName
]

{ #category : #accessing }
GTMetacellerItemDifference >> parent [
	^ parent
]

{ #category : #accessing }
GTMetacellerItemDifference >> parent: anItem [
	parent := anItem
]

{ #category : #accessing }
GTMetacellerItemDifference >> repositories [
	| retVal parentRepos |
	retVal := self item repositories.
	parentRepos := (self parent repositories).
	retVal := retVal reject: [ :each |
		parentRepos includes: each ].
	^retVal
]

{ #category : #accessing }
GTMetacellerItemDifference >> specAccessors [
	^self item specAccessors
]
