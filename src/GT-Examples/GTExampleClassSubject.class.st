Class {
	#name : #GTExampleClassSubject,
	#superclass : #GTAbstractExampleSubject,
	#instVars : [
		'theClassName',
		'theClass',
		'meta'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #UI }
GTExampleClassSubject >> addToSelectorEnvironment: aSelectorEnvironment [
	aSelectorEnvironment addClass: self theClass
]

{ #category : #private }
GTExampleClassSubject >> ensure [
	" 1) reset "
	theClass ifNotNil: [ theClass isObsolete ifTrue: [ theClass := nil ] ].
	
	" 2) reinitialize "
	theClass ifNil: [ theClass := self meta 
			ifTrue: [ (Smalltalk classNamed: self theClassName) class ] 
			ifFalse: [ Smalltalk classNamed: self theClassName ] ]
		
]

{ #category : #testing }
GTExampleClassSubject >> exists [
	^ self theClass notNil
]

{ #category : #UI }
GTExampleClassSubject >> forNautilus: aBlock [
	self exists ifFalse: [ ^ self ].
	
	aBlock 
		value: #'Browse class ' ,  self theClassName 
		value: [ self theClass browse ]

]

{ #category : #testing }
GTExampleClassSubject >> hasLiteralThorough: aLiteral [
	^ self theClass = aLiteral
		or: [ self theClass name = aLiteral
			or: [ self theClass methods anySatisfy: [ :method | 
						method selector = aLiteral
							or: [ 	method hasLiteralThorough: aLiteral ] ] ] ]
]

{ #category : #accessing }
GTExampleClassSubject >> meta [
	^ meta
]

{ #category : #accessing }
GTExampleClassSubject >> meta: anObject [
	meta := anObject
]

{ #category : #accessing }
GTExampleClassSubject >> theClass [
	self ensure.
	^ theClass
]

{ #category : #accessing }
GTExampleClassSubject >> theClass: anObject [
	theClass := anObject
]

{ #category : #accessing }
GTExampleClassSubject >> theClassName [
	^ theClassName
]

{ #category : #accessing }
GTExampleClassSubject >> theClassName: anObject [
	theClassName := anObject
]
