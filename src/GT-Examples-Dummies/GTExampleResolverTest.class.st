Class {
	#name : #GTExampleResolverTest,
	#superclass : #TestCase,
	#category : #'GT-Examples-Dummies-Tests'
}

{ #category : #asserting }
GTExampleResolverTest >> assertClass: aClassOrClassName meta: aBoolean resolvedAsClass: aClass [ 
	(GTExampleMethodResolver new 
		methodClassName: aClassOrClassName;
		meta: aBoolean;
		yourself) methodClassDo: [ :class | self assert: class == aClass ] ifNone: [ self assert: aClass isNil ].
	(GTExampleClassResolver new 
		theClassName: aClassOrClassName;
		meta: aBoolean;
		yourself) theClassDo: [ :class | self assert: class == aClass ] ifNone: [ self assert: aClass isNil ]
]

{ #category : #asserting }
GTExampleResolverTest >> testResolve [
	self assertClass: 'Object' meta: false resolvedAsClass: Object.
	self assertClass: 'Object' meta: true resolvedAsClass: Object class.
	
	self assertClass: #Object meta: false resolvedAsClass: Object.
	self assertClass: #Object meta: true resolvedAsClass: Object class.
]

{ #category : #asserting }
GTExampleResolverTest >> testResolveWithCompatibility [
	self assertClass: 'Object class' meta: false resolvedAsClass: Object class.
	self assertClass: 'Object class' meta: true resolvedAsClass: Object class.
	
	self assertClass: #'Object class' meta: false resolvedAsClass: Object class.
	self assertClass: #'Object class' meta: true resolvedAsClass: Object class.
	
]
