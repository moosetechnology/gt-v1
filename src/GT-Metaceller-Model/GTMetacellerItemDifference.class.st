Class {
	#name : #GTMetacellerItemDifference,
	#superclass : #Object,
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

{ #category : #'code generation' }
GTMetacellerItemDifference >> streamSpecOn: aStream indent: anIndent specName: aString [ 
	self item streamSpecOn: aStream indent: anIndent specName: aString
]
