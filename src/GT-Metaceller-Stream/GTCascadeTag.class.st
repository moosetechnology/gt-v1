Class {
	#name : #GTCascadeTag,
	#superclass : #GTCodeTag,
	#instVars : [
		'first'
	],
	#category : #'GT-Metaceller-Stream'
}

{ #category : #generating }
GTCascadeTag >> assign: aKey value: aValue [
	self first ifFalse:[ self stream nextPut: $; ].
	first := false.
	self nextLine.
	self stream nextPutAll: aKey; nextPutAll: ': '.
	aValue asCodeStringOn: self stream
]

{ #category : #accessing }
GTCascadeTag >> first [
	^first ifNil: [ true ]
]

{ #category : #generating }
GTCascadeTag >> receiver: aString [
	self stream nextPutAll: aString
]

{ #category : #generation }
GTCascadeTag >> withBlock: aBlock [
	| blockTag |
	self stream nextPutAll: ' with: '.
	blockTag := GTBlockTag on: self codeStream.
	self open: blockTag.
	aBlock value.
	self close
]

{ #category : #generating }
GTCascadeTag >> withValue: aString [ 
	self stream nextPutAll: ' with: '.
	aString asCodeStringOn: self stream
]
