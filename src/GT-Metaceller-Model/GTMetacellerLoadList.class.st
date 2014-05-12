Class {
	#name : #GTMetacellerLoadList,
	#superclass : #Object,
	#instVars : [
		'items',
		'errors',
		'warnings'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #adding }
GTMetacellerLoadList >> add: anItem [ 
	^self add: anItem children: anItem children
]

{ #category : #adding }
GTMetacellerLoadList >> add: anItem children: aList [
	(self findItem: anItem)
		ifNil: [ 
			self items add: anItem.
			aList do: [ :each | self add: each ] ]
		ifNotNilDo: [ :existing |
			| merged |
			merged := existing mergeWith: anItem errors: self errors warnings: self warnings.
			merged ifNil: [ self items add: anItem ]
				ifNotNil: [
					self items remove: existing.
					self items add: merged.
					aList do: [ :each | self add: each children: each children ] ] ]
]

{ #category : #accessing }
GTMetacellerLoadList >> errors [
	^errors ifNil: [ errors := OrderedCollection new ]
]

{ #category : #accessing }
GTMetacellerLoadList >> findItem: anItem [ 
	^self items detect: [ :each |
		each isCompatibleWith: anItem ] ifNone: [ nil ]
]

{ #category : #accessing }
GTMetacellerLoadList >> items [
	^items ifNil: [ items := OrderedCollection new ]
]

{ #category : #accessing }
GTMetacellerLoadList >> warnings [
	^warnings ifNil: [ warnings := OrderedCollection new ]
]
