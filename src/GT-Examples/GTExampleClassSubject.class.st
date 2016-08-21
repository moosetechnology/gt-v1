Class {
	#name : #GTExampleClassSubject,
	#superclass : #GTExampleSubject,
	#instVars : [
		'theClassName',
		'theClass'
	],
	#category : #'GT-Examples-Subjects'
}

{ #category : #'instance creation' }
GTExampleClassSubject class >> fromClass: aClass [
	^ self new 
		theClass: aClass;
		theClassName: aClass name;
		yourself
]

{ #category : #'instance creation' }
GTExampleClassSubject class >> fromClassNamed: aString [
	^ self new 
		theClass: nil;
		theClassName: aString asString;
		yourself
]

{ #category : #testing }
GTExampleClassSubject >> = anExampleSubject [
	^ self class = anExampleSubject class
		and: [ self theClassName = anExampleSubject theClassName ]
]

{ #category : #'*GT-Examples-UI' }
GTExampleClassSubject >> addToSelectorEnvironment: aSelectorEnvironment [
	self exists ifFalse: [ ^ self ].
	
	aSelectorEnvironment addClass: self theClass
]

{ #category : #testing }
GTExampleClassSubject >> exists [
	^ self theClass notNil
]

{ #category : #'*GT-Examples-UI' }
GTExampleClassSubject >> forNautilus: aBlock [
	self exists ifFalse: [ ^ self ].
	
	aBlock 
		value: #'Browse subject Class ' ,  self theClassName 
		value: [ self theClass browse ]

]

{ #category : #'*GT-Examples-UI' }
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

{ #category : #private }
GTExampleClassSubject >> resetStub [
	" 1) reset -> 2) reinitialize "
	theClass := nil
]

{ #category : #accessing }
GTExampleClassSubject >> theClass [
	^ theClass ifNil: [ theClass := Smalltalk classNamed: theClassName ]
		
]

{ #category : #accessing }
GTExampleClassSubject >> theClass: anObject [
	anObject ifNotNil: [ self theClassName: anObject name ].
	theClass := anObject.
	
]

{ #category : #accessing }
GTExampleClassSubject >> theClassName [
	^ theClassName
]

{ #category : #accessing }
GTExampleClassSubject >> theClassName: anObject [
	theClassName := anObject
]
