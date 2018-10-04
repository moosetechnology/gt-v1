Class {
	#name : #GTExampleMethodResolver,
	#superclass : #GTExampleAspectResolver,
	#instVars : [
		'methodClass',
		'methodClassName',
		'selector'
	],
	#category : #'GT-Examples-Organization'
}

{ #category : #actions }
GTExampleMethodResolver class >> resolve: anAspectClass example: anExample className: aClassOrString meta: meta selector: aStringOrSelector [
	^ (self new 
		aspectClass: anAspectClass;
		example: anExample;
		methodClassName: aClassOrString;
		meta: meta;
		selector: aStringOrSelector;
		yourself) resolve
]

{ #category : #actions }
GTExampleMethodResolver class >> resolve: anAspectClass example: anExample selector: aStringOrSelector [
	^ (self new 
		aspectClass: anAspectClass;
		example: anExample;
		methodClassName: anExample methodClass;
		meta: anExample methodClass isMeta;
		selector: aStringOrSelector;
		yourself) resolve
]

{ #category : #private }
GTExampleMethodResolver >> methodClass [
	^ self methodClassName isClass 
		ifTrue: [ self methodClassName ]
		ifFalse: [ Smalltalk classNamed: self methodClassName asString ]
]

{ #category : #private }
GTExampleMethodResolver >> methodClassDo: aBlock [
	^ self methodClassDo: aBlock ifNone: [ 
		(GTExampleDeclaredClassMissing new
			example: self example;
			classNamed: self methodClassName;
			meta: self meta;
			yourself) signal ]
]

{ #category : #private }
GTExampleMethodResolver >> methodClassDo: aBlock1 ifNone: aBlock2 [
	^ self methodClass
		ifNotNil: [ :class | aBlock1 value: (self ensureClass: class) ]
		ifNil: aBlock2
	
]

{ #category : #accessing }
GTExampleMethodResolver >> methodClassName [
	^ methodClassName
]

{ #category : #accessing }
GTExampleMethodResolver >> methodClassName: anObject [
	methodClassName := anObject
]

{ #category : #actions }
GTExampleMethodResolver >> resolve [
	^ self methodClassDo: [ :class | self resolveByClass: class ] 
		ifNone: [ self resolveByName ]
]

{ #category : #private }
GTExampleMethodResolver >> resolveByClass: aClass [
	^ self aspectClass new
		methodClass: aClass;
		methodClassName: aClass name;
		meta: aClass isMeta;
		selector: self selector asSymbol;
		yourself
]

{ #category : #private }
GTExampleMethodResolver >> resolveByName [
	^ self aspectClass new
		methodClass: nil;
		methodClassName: self methodClassName asSymbol;
		meta: self meta;
		selector: self selector asSymbol;
		yourself
]

{ #category : #accessing }
GTExampleMethodResolver >> selector [
	^ selector
]

{ #category : #accessing }
GTExampleMethodResolver >> selector: anObject [
	selector := anObject
]
