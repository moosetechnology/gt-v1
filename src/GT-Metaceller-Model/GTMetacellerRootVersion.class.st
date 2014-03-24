Class {
	#name : #GTMetacellerRootVersion,
	#superclass : #Object,
	#instVars : [
		'method'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #'instance creation' }
GTMetacellerRootVersion class >> on: aMethod [ 
	^self new
		method: aMethod;
		yourself
]

{ #category : #accessing }
GTMetacellerRootVersion >> method [
	^ method
]

{ #category : #accessing }
GTMetacellerRootVersion >> method: aMethod [ 
	method := aMethod
]
