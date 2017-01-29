Class {
	#name : #GTExampleClassResolver,
	#superclass : #GTExampleAspectResolver,
	#instVars : [
		'theClassName'
	],
	#category : #'GT-Examples-Organization'
}

{ #category : #actions }
GTExampleClassResolver class >> resolve: anAspectClass example: anExample className: aClassOrString meta: meta [
	^ (self new 
		aspectClass: anAspectClass;
		example: anExample;
		theClassName: aClassOrString;
		meta: meta;
		yourself) resolve
]

{ #category : #actions }
GTExampleClassResolver >> resolve [
	^ self theClassDo: [ :class | self resolveByClass: class ]
		ifNone: [ self resolveByName ]
]

{ #category : #private }
GTExampleClassResolver >> resolveByClass: aClass [
	^ self aspectClass new
		theClass: aClass;
		theClassName: aClass name;
		meta: aClass isMeta;
		yourself
]

{ #category : #private }
GTExampleClassResolver >> resolveByName [
	^ self aspectClass new
		theClass: nil;
		theClassName: self theClassName;
		meta: self meta;
		yourself
]

{ #category : #private }
GTExampleClassResolver >> theClass [
	^ self theClassName isClass 
		ifTrue: [ self theClassName ]
		ifFalse: [ Smalltalk classNamed: self theClassName asString ]
]

{ #category : #private }
GTExampleClassResolver >> theClassDo: aBlock [
	^ self theClassDo: aBlock ifNone: [ 
		(GTExampleDeclaredClassMissing new
			example: self example;
			classNamed: self theClassName;
			meta: self meta;
			yourself) signal ]
]

{ #category : #private }
GTExampleClassResolver >> theClassDo: aBlock1 ifNone: aBlock2 [
	^ self theClass
		ifNotNil: [ :class | aBlock1 value: (self ensureClass: class) ]
		ifNil: aBlock2
	
]

{ #category : #accessing }
GTExampleClassResolver >> theClassName [
	^ theClassName
]

{ #category : #accessing }
GTExampleClassResolver >> theClassName: anObject [
	theClassName := anObject
]
