Class {
	#name : #GTExampleClassSubject,
	#superclass : #GTAbstractExampleSubject,
	#instVars : [
		'theClassName',
		'theClass'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTExampleClassSubject >> = anExampleSubject [
	^ self class = anExampleSubject class
		and: [ self theClassName = anExampleSubject theClassName ]
]

{ #category : #UI }
GTExampleClassSubject >> addToSelectorEnvironment: aSelectorEnvironment [
	self exists ifFalse: [ ^ self ].
	
	aSelectorEnvironment addClass: self theClass
]

{ #category : #private }
GTExampleClassSubject >> ensureInitialized [
	" 1) reset -> 2) reinitialize "
	theClass ifNotNil: [ theClass isObsolete ifTrue: [ theClass := nil ] ].
	theClass ifNil: [ theClass := Smalltalk classNamed: theClassName ]
		
]

{ #category : #testing }
GTExampleClassSubject >> exists [
	^ self theClass notNil
]

{ #category : #UI }
GTExampleClassSubject >> forNautilus: aBlock [
	self exists ifFalse: [ ^ self ].
	
	aBlock 
		value: #'Browse subject Class ' ,  self theClassName 
		value: [ self theClass browse ]

]

{ #category : #UI }
GTExampleClassSubject >> gtDisplayOn: aStream [
	self theClassName gtDisplayOn: aStream.
	self gtDisplayValidityOn: aStream
]

{ #category : #testing }
GTExampleClassSubject >> hasLiteralThorough: aLiteral [
	^ self theClassName = aLiteral
		or: [ self exists 
			and: [ self theClass = aLiteral
				or: [ self theClass methods anySatisfy: [ :method | 
							method selector = aLiteral
								or: [ 	method hasLiteralThorough: aLiteral ] ] ] ] ]
]

{ #category : #testing }
GTExampleClassSubject >> hash [
	^ self class hash
		bitXor: self theClassName hash
]

{ #category : #accessing }
GTExampleClassSubject >> theClass [
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
