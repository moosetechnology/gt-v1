Class {
	#name : #GTSTMethod,
	#superclass : #GTSTNamedModel,
	#instVars : [
		'glmCategory'
	],
	#category : #'GT-Model'
}

{ #category : #'as yet unclassified' }
GTSTMethod class >> fromMethodReference: aMethodReference [
	| cls cat |
	cls := GTSTClass new.
	cls stBehavior: (Smalltalk at: aMethodReference classSymbol).
	cat := GTSTProtocol new.
	cat name: aMethodReference category.
	cat glmBehavior: cls.
	^ GTSTMethod new
		name: aMethodReference methodSymbol;
		glmCategory: cat;
		yourself
]

{ #category : #accessing }
GTSTMethod >> glmBehavior [ 
	^ self glmCategory glmBehavior 
]

{ #category : #accessing }
GTSTMethod >> glmCategory [
	^ glmCategory
]

{ #category : #accessing }
GTSTMethod >> glmCategory: anObject [
	glmCategory := anObject
]

{ #category : #accessing }
GTSTMethod >> implementors [
	^ (self systemNavigation allImplementorsOf:	self name) collect: [:each | 
			GTSTMethod fromMethodReference: each ]
]

{ #category : #testing }
GTSTMethod >> isMethod [
	^ true
]

{ #category : #accessing }
GTSTMethod >> senders [
	^ (self systemNavigation allSendersOf:	self name) collect: [:each | 
			GTSTMethod fromMethodReference: each ]
]

{ #category : #accessing }
GTSTMethod >> sourceCode [
	^ self glmCategory glmBehavior sourceCodeAt: self name
]
