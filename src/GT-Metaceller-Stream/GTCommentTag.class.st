Class {
	#name : #GTCommentTag,
	#superclass : #GTCodeTag,
	#category : #'GT-Metaceller-Stream'
}

{ #category : #generating }
GTCommentTag >> assign: aKey value: aValue [
	self nextLine.
	self stream nextPutAll: aKey; nextPutAll: ': '.
	aValue asCodeStringOn: self stream.
	self stream nextPut: $;.

]

{ #category : #generating }
GTCommentTag >> closeTag [
	self nextLine.
	self stream nextPut: $"
]

{ #category : #generating }
GTCommentTag >> openTag [
	self stream nextPut: $"
]

{ #category : #generating }
GTCommentTag >> string: aString [
	self open.
	self stream nextPutAll: aString.
	self stream nextLine
]
