Class {
	#name : #GTStatementListTag,
	#superclass : #GTCodeTag,
	#instVars : [
		'first'
	],
	#category : #'GT-Metaceller-Stream'
}

{ #category : #generating }
GTStatementListTag >> beforeOpenSubTag [
	super beforeOpenSubTag.
	self first ifFalse:[ self stream nextPut: $. ].
	self nextLine.
	first := false
]

{ #category : #accessing }
GTStatementListTag >> first [
	^first ifNil: [ true ]
]
