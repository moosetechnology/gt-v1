"
GTSnippets instance
"
Class {
	#name : #GTSnippets,
	#superclass : #Object,
	#instVars : [
		'instance',
		'snippets'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'GT-Inspector'
}

{ #category : #accessing }
GTSnippets class >> instance [
	^ instance ifNil: [ instance := self new ]
]

{ #category : #accessing }
GTSnippets class >> snippetAt: anObject [
	^ self instance snippetAt: anObject
]

{ #category : #accessing }
GTSnippets class >> snippetAt: anObject put: aString [
	^ self instance snippetAt: anObject put: aString
]

{ #category : #'as yet unclassified' }
GTSnippets >> snippetAt: anObject [
	^ self snippets 
		at: anObject 
		ifAbsent: [ 'self' ]
]

{ #category : #'as yet unclassified' }
GTSnippets >> snippetAt: anObject put: aString [
	^ self snippets 
		at: anObject 
		put: aString
]

{ #category : #'as yet unclassified' }
GTSnippets >> snippets [ 
	^ snippets ifNil: [ snippets := IdentityDictionary new ]
]
