Class {
	#name : #GTMetacellerItemDifference,
	#superclass : #Object,
	#instVars : [
		'item',
		'parents'
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
	^self parents add: aParent
]

{ #category : #'code generation' }
GTMetacellerItemDifference >> differenceWith: anItem [ 
	(self item isDifferentFrom: anItem) ifFalse: [ ^nil ].
	self parents add: anItem.
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
GTMetacellerItemDifference >> parents [
	^ parents ifNil: [ parents := OrderedCollection new ]
]

{ #category : #'code generation' }
GTMetacellerItemDifference >> streamSpecOn: aStream indent: anIndent specName: aString [ 
	self item streamSpecOn: aStream indent: anIndent specName: aString
]
