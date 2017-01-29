Class {
	#name : #GTAbstractExampleMethod,
	#superclass : #GTExampleAspect,
	#traits : 'TGTExampleMethod',
	#classTraits : 'TGTExampleMethod classTrait',
	#instVars : [
		'methodClassName',
		'methodClass',
		'meta',
		'selector'
	],
	#category : #'GT-Examples-Organization'
}

{ #category : #'instance creation' }
GTAbstractExampleMethod class >> fromClass: aClass selector: aSelector [
	^ self new 
		methodClass: aClass;
		methodClassName: aClass name;
		meta: aClass isMeta;
		selector: aSelector;
		yourself
]

{ #category : #'instance creation' }
GTAbstractExampleMethod class >> fromClassNamed: aString selector: aSelector [
	^ self new 
		methodClass: nil;
		methodClassName: aString asString;
		meta: false;
		selector: aSelector;
		yourself
]

{ #category : #'instance creation' }
GTAbstractExampleMethod class >> fromMetaClassNamed: aString selector: aSelector [
	^ self new 
		methodClass: nil;
		methodClassName: aString asString;
		meta: true;
		selector: aSelector;
		yourself
]

{ #category : #testing }
GTAbstractExampleMethod class >> isAbstract [
	^ self == GTAbstractExampleMethod
]

{ #category : #testing }
GTAbstractExampleMethod >> = anExampleMethod [
	^ self class = anExampleMethod class 
		and: [ self methodClassName = anExampleMethod methodClassName 
			and: [ self selector = anExampleMethod selector ] ]
]

{ #category : #testing }
GTAbstractExampleMethod >> exists [
	^ self methodClassName notNil
		and: [ self methodClass notNil
			and: [ self methodClass includesSelector: self selector ] ]
]

{ #category : #testing }
GTAbstractExampleMethod >> hasLiteralThorough: aLiteral [
	^ self methodClassName = aLiteral 
		or: [ self selector = aLiteral
			or: [ self exists 
				and: [ self method hasLiteralThorough: aLiteral ] ] ]
]

{ #category : #testing }
GTAbstractExampleMethod >> hash [
	^ (self class hash 
		bitXor: self methodClassName hash)
			bitXor: self selector hash
]

{ #category : #testing }
GTAbstractExampleMethod >> matchesMethod: aCompiledMethod [
	^ self exists
		and: [ self methodClass = aCompiledMethod methodClass
			and: [ self selector = aCompiledMethod selector ] ]
]

{ #category : #accessing }
GTAbstractExampleMethod >> meta [
	^ meta ifNil: [ meta := false ]
]

{ #category : #accessing }
GTAbstractExampleMethod >> meta: anObject [
	meta := anObject
]

{ #category : #'accessing-dynamic' }
GTAbstractExampleMethod >> method [
	^ self exists 
		ifTrue: [ self methodClass >> self selector ]
		ifFalse: [ nil ]
]

{ #category : #'accessing-dynamic' }
GTAbstractExampleMethod >> methodArgumentNames [
	^ self exists
		ifTrue: [ self method argumentNames ]
		ifFalse: [ #() ]
]

{ #category : #accessing }
GTAbstractExampleMethod >> methodClass [
	^ methodClass ifNil: [ methodClass := self resolveMethodClass ]
		
]

{ #category : #accessing }
GTAbstractExampleMethod >> methodClass: anObject [
	methodClass := anObject
]

{ #category : #accessing }
GTAbstractExampleMethod >> methodClassName [
	^ methodClassName
]

{ #category : #accessing }
GTAbstractExampleMethod >> methodClassName: anObject [
	methodClassName := anObject
]

{ #category : #private }
GTAbstractExampleMethod >> methodClassResolver [
	^ GTExampleMethodResolver new 
		methodClassName: self methodClassName;
		meta: self meta;
		selector: self selector;
		yourself
]

{ #category : #'accessing-dynamic' }
GTAbstractExampleMethod >> provider [ 
	self exists ifFalse: [ ^ nil ].
	^ self methodClass isMeta
		ifTrue: [ self methodClass theNonMetaClass ]
		ifFalse: [ self methodClass theNonMetaClass new ]
]

{ #category : #private }
GTAbstractExampleMethod >> resetStub [
	" 1) reset -> 2) reinitialize  "
	methodClass := nil
]

{ #category : #private }
GTAbstractExampleMethod >> resolveMethodClass [
	" an aspect might reference a class not being present in the system - it has to be resolved again in this case "
	^ self methodClassResolver methodClassDo: [ :class | class ] ifNone: [ nil ]
]

{ #category : #accessing }
GTAbstractExampleMethod >> selector [
	^ selector
]

{ #category : #accessing }
GTAbstractExampleMethod >> selector: anObject [
	selector := anObject
]
