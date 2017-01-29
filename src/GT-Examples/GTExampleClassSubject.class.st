"
I describe a class subject of an example.
"
Class {
	#name : #GTExampleClassSubject,
	#superclass : #GTExampleSubject,
	#instVars : [
		'theClassName',
		'theClass',
		'meta'
	],
	#category : #'GT-Examples-Subjects'
}

{ #category : #'instance creation' }
GTExampleClassSubject class >> fromClass: aClass [
	^ self new 
		theClass: aClass;
		theClassName: aClass name;
		meta: aClass isMeta;
		yourself
]

{ #category : #'instance creation' }
GTExampleClassSubject class >> fromClassNamed: aString [
	^ self new 
		theClass: nil;
		theClassName: aString asString;
		meta: false;
		yourself
]

{ #category : #'instance creation' }
GTExampleClassSubject class >> fromMetaClassNamed: aString [
	^ self new 
		theClass: nil;
		theClassName: aString asString;
		meta: true;
		yourself
]

{ #category : #testing }
GTExampleClassSubject >> = anExampleSubject [
	^ self class = anExampleSubject class
		and: [ self theClassName = anExampleSubject theClassName ]
]

{ #category : #private }
GTExampleClassSubject >> classResolver [
	^ GTExampleClassResolver new 
		theClassName: self theClassName;
		meta: self meta;
		yourself
]

{ #category : #testing }
GTExampleClassSubject >> exists [
	^ self theClass notNil
]

{ #category : #testing }
GTExampleClassSubject >> hasLiteralThorough: aLiteral [
	^ self theClassName = aLiteral
		or: [ self exists 
			and: [ self theClass = aLiteral ] ]
]

{ #category : #testing }
GTExampleClassSubject >> hash [
	^ self class hash
		bitXor: self theClassName hash
]

{ #category : #accessing }
GTExampleClassSubject >> meta [
	^ meta
]

{ #category : #accessing }
GTExampleClassSubject >> meta: anObject [
	meta := anObject
]

{ #category : #private }
GTExampleClassSubject >> resetStub [
	" 1) reset -> 2) reinitialize "
	theClass := nil
]

{ #category : #private }
GTExampleClassSubject >> resolveClass [
	" an aspect might reference a class not being present in the system - it has to be resolved again in this case "
	^ self classResolver theClassDo: [ :class | class ] ifNone: [ nil ]
]

{ #category : #accessing }
GTExampleClassSubject >> theClass [
	^ theClass ifNil: [ theClass := self resolveClass ]
		
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
