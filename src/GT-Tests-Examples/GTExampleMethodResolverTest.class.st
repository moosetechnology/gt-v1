Class {
	#name : #GTExampleMethodResolverTest,
	#superclass : #TestCase,
	#category : #'GT-Tests-Examples'
}

{ #category : #utils }
GTExampleMethodResolverTest >> assert: aGTExampleMethod class: aClass classNamed: aClassName meta: aBoolean selector: aSelector [

	self assert: aGTExampleMethod methodClass == aClass.
	self assert: aGTExampleMethod methodClassName = aClassName.
	self assert: aGTExampleMethod meta = aBoolean.
	self assert: aGTExampleMethod selector = aSelector.
	self assert: aGTExampleMethod selector isSymbol.
	
	self assert: aGTExampleMethod exists.
	
	self shouldnt: [ aGTExampleMethod resetStub ] raise: Exception.
	self assert: (aGTExampleMethod instVarNamed: 'methodClass') isNil.
	
	self assert: aGTExampleMethod methodClass == aClass.
	self assert: aGTExampleMethod methodClassName = aClassName.
	self assert: aGTExampleMethod meta = aBoolean.
	self assert: aGTExampleMethod selector = aSelector.
	self assert: aGTExampleMethod selector isSymbol.
	
	self assert: aGTExampleMethod exists.
]

{ #category : #'tests-convenience' }
GTExampleMethodResolverTest >> testResolveByName [
	| method |
	method := GTExampleMethodResolver resolve: GTExampleMethod example: nil className: #GTExampleMethodResolver meta: false selector: #selector.
	
	self assert: method class: GTExampleMethodResolver classNamed: #GTExampleMethodResolver meta: false selector: #selector.
	self assert: method class: GTExampleMethodResolver classNamed: 'GTExampleMethodResolver' meta: false selector: #selector.
	
	method := GTExampleMethodResolver resolve: GTExampleMethod example: nil className: 'GTExampleMethodResolver' meta: false selector: 'selector'.
	
	self assert: method class: GTExampleMethodResolver classNamed: #GTExampleMethodResolver meta: false selector: #selector.
	self assert: method class: GTExampleMethodResolver classNamed: 'GTExampleMethodResolver' meta: false selector: #selector.
]

{ #category : #'tests-convenience' }
GTExampleMethodResolverTest >> testResolveMetaByName [
	| method |
	method := GTExampleMethodResolver resolve: GTExampleMethod example: nil className: #GTExampleMethodResolver meta: true selector: #resolve:example:selector:.
	
	self assert: method class: GTExampleMethodResolver class classNamed: 'GTExampleMethodResolver class' meta: true selector: #resolve:example:selector:.
	self assert: method class: GTExampleMethodResolver class classNamed: 'GTExampleMethodResolver class' meta: true selector: #resolve:example:selector:.
	
	method := GTExampleMethodResolver resolve: GTExampleMethod example: nil className: 'GTExampleMethodResolver' meta: true selector: #resolve:example:selector:.
	
	self assert: method class: GTExampleMethodResolver class classNamed: 'GTExampleMethodResolver class' meta: true selector: #resolve:example:selector:.
	self assert: method class: GTExampleMethodResolver class classNamed: 'GTExampleMethodResolver class' meta: true selector: #resolve:example:selector:.
]

{ #category : #'tests-convenience' }
GTExampleMethodResolverTest >> testResolveMetaByNameWithSystemCompatibility [
	| method |
	method := GTExampleMethodResolver resolve: GTExampleMethod example: nil className: 'GTExampleMethodResolver class' meta: true selector: #resolve:example:selector:.
	
	self assert: method class: GTExampleMethodResolver class classNamed: 'GTExampleMethodResolver class' meta: true selector: #resolve:example:selector:.
	self assert: method class: GTExampleMethodResolver class classNamed: 'GTExampleMethodResolver class' meta: true selector: #resolve:example:selector:.
	
	method := GTExampleMethodResolver resolve: GTExampleMethod example: nil className: 'GTExampleMethodResolver class' meta: false selector: 'resolve:example:selector:'.
	
	self assert: method class: GTExampleMethodResolver class classNamed: 'GTExampleMethodResolver class' meta: true selector: #resolve:example:selector:.
	self assert: method class: GTExampleMethodResolver class classNamed: 'GTExampleMethodResolver class' meta: true selector: #resolve:example:selector:.
]
