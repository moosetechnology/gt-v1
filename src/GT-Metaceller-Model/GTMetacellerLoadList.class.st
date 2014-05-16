Class {
	#name : #GTMetacellerLoadList,
	#superclass : #Object,
	#instVars : [
		'items',
		'errorMap'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #adding }
GTMetacellerLoadList >> add: anItem [ 
	^self add: anItem children: anItem children
]

{ #category : #adding }
GTMetacellerLoadList >> add: anItem children: aList [
	self items add: anItem.
	(self findItems: anItem) do: [ :each |
			anItem compare: each toLoadList: self ]
]

{ #category : #accessing }
GTMetacellerLoadList >> addError: aString for: anItem trace: aTrace startingAt: anIndex in: anErrorDict [ 
	| err |
	err := anErrorDict.
	self halt.
	1 to: aTrace size do: [ :index |
		err at: #'error' put: aString.
		err := err at: (aTrace at: index) ifAbsentPut: [ Dictionary new ] ].
	((err at: anItem ifAbsentPut: [ Dictionary new ]) 
		at: #'error' ifAbsentPut: [ OrderedCollection new ])
			add: aString
]

{ #category : #accessing }
GTMetacellerLoadList >> addError: aString myValue: originalValue otherValue: otherValue between: originalItem and: otherItem [ 
	| originalTrace otherTrace index err |
	originalTrace := originalItem traceToRoot.
	otherTrace := otherItem traceToRoot.
	" test where we need to store this error "
	index := 1.
	err := self errorMap.
	[ (originalTrace size < index) or: [ (otherTrace size < index) or: [ (originalTrace at: index) ~= (otherTrace at: index) ] ] ]
		whileFalse: [
			err := err at: (originalTrace at: index) ifAbsentPut: [ Dictionary new ].
			index := index +1 ].
	self halt.
	(err at: #errors ifAbsentPut: [ OrderedCollection new ])
		add: (aString, ' between ', originalItem fullTrace, ' and ', otherItem fullTrace, '(', originalValue, ' ~= ', otherValue, ')').
	self
		addError: (aString, ' with: ', otherItem fullTrace, '.', originalValue, ' ~= ', otherValue)
		for: originalItem trace: originalTrace startingAt: index in: err.
	self
		addError: (aString, ' with: ', originalItem fullTrace, '.', otherValue, ' ~= ', originalValue)
		for: otherItem trace: otherTrace startingAt: index in: err.

]

{ #category : #accessing }
GTMetacellerLoadList >> addWarning: aString myValue: anOriginal otherValue: aDiff between: anItem and: aReference [ 
	self halt.
]

{ #category : #accessing }
GTMetacellerLoadList >> addWarning: aString trace: aList [
	self addError: aString trace: aList category: #'warning' to: self errorMap
]

{ #category : #accessing }
GTMetacellerLoadList >> errorMap [
	^errorMap ifNil: [ errorMap := Dictionary new ]
]

{ #category : #accessing }
GTMetacellerLoadList >> findItems: anItem [ 
	^self items select: [ :each |
		each isCompatibleWith: anItem ]
]

{ #category : #accessing }
GTMetacellerLoadList >> items [
	^items ifNil: [ items := OrderedCollection new ]
]
