Class {
	#name : #GTExampleSelectorSubject,
	#superclass : #GTAbstractExampleSubject,
	#instVars : [
		'selector',
		'theClasses'
	],
	#category : #'GT-Examples-Subjects'
}

{ #category : #'instance creation' }
GTExampleSelectorSubject class >> fromString: aString [
	^ self fromSymbol: aString asSymbol
]

{ #category : #'instance creation' }
GTExampleSelectorSubject class >> fromSymbol: aSymbol [
	^ self new
		selector: aSymbol;
		yourself
]

{ #category : #testing }
GTExampleSelectorSubject >> = anExampleSubject [
	^ self class = anExampleSubject class
		and: [ self selector = anExampleSubject selector ]
]

{ #category : #UI }
GTExampleSelectorSubject >> addToSelectorEnvironment: aSelectorEnvironment [
	self selector ifNil: [ ^ self ].
	
	self theClasses do: [ :class | 
		aSelectorEnvironment addClass: class selector: self selector ]
]

{ #category : #testing }
GTExampleSelectorSubject >> exists [
	^ self theClasses isEmptyOrNil not
]

{ #category : #UI }
GTExampleSelectorSubject >> forNautilus: aBlock [
	self exists ifFalse: [ ^ self ].
	
	aBlock 
		value: #'Browse subject Selector ' ,  self selector
		value: [ 
			| env |
			self addToSelectorEnvironment: (env := RBSelectorEnvironment new).
			env browse ]
]

{ #category : #UI }
GTExampleSelectorSubject >> gtDisplayOn: aStream [
	self selector gtDisplayOn: aStream.
	self gtDisplayValidityOn: aStream
]

{ #category : #testing }
GTExampleSelectorSubject >> hasLiteralThorough: aLiteral [
	^ self selector = aLiteral
		or: [ self theClasses anySatisfy: [ :class |
			(class >> self selector) asGTExampleSubject hasLiteralThorough: aLiteral ] ]
]

{ #category : #testing }
GTExampleSelectorSubject >> hash [
	^ self class hash
		bitXor: self selector hash
]

{ #category : #private }
GTExampleSelectorSubject >> resetStub [
	theClasses := nil
]

{ #category : #accessing }
GTExampleSelectorSubject >> selector [
	^ selector
]

{ #category : #accessing }
GTExampleSelectorSubject >> selector: anObject [
	selector := anObject
]

{ #category : #private }
GTExampleSelectorSubject >> theClasses [
	theClasses ifNil: [ 
		theClasses := Array streamContents: [ :stream |
			Smalltalk allClassesAndTraitsDo: [ :class |
				(class includesSelector: self selector) ifTrue: [ 
					stream nextPut: class ] ] ] ].
	^ theClasses
]
