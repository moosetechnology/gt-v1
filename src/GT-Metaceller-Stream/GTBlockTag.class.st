Class {
	#name : #GTBlockTag,
	#superclass : #GTStatementListTag,
	#category : #'GT-Metaceller-Stream'
}

{ #category : #generating }
GTBlockTag >> closeTag [
	self stream space; nextPut: $]
]

{ #category : #generating }
GTBlockTag >> openTag [
	super openTag.
	self stream nextPut: $[

]
